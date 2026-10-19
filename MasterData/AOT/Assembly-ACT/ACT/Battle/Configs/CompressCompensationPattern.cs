using System.Collections.Generic;
using ACT.MultiPlayer;
using ACT.Utility;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

public class CompressCompensationPattern : CompensationPattern
{
	public enum CurveType
	{
		X,
		Y,
		Z
	}

	public CurveType curveType;

	public ConfigFindRangeTargets compressFindTargets;

	public ConfigFunction<Vector3> functionTarget;

	public Vector2 offest;

	public float minScale;

	public float maxScale;

	public string effectPosName;

	public bool useEnvCheck = true;

	private EntityId m_Target;

	private bool isFocusTarget;

	private bool m_EffectInit;

	private bool m_HasResolvedFunctionTargetPos;

	private bool m_HasFunctionTargetCompensation;

	private Vector3 m_CachedFunctionTargetPos;

	public override void CompensationHandle(SystemAbility systemAbility, Entity behave, float duration, FSMRuntimeState rState)
	{
		List<FindTargetResult> list = ListPool<FindTargetResult>.Get();
		Vector3 targetPos = Vector3.zero;
		_ = Vector3.zero;
		bool flag = false;
		if (m_HasResolvedFunctionTargetPos)
		{
			targetPos = m_CachedFunctionTargetPos;
			flag = m_HasFunctionTargetCompensation;
		}
		else if (functionTarget != null)
		{
			ActionMemory memory = new ActionMemory(behave, behave, behave);
			if (functionTarget is FunctionEntityPosition { useNewPreSet: not false, endPosType: PosSourceType.BodyBehind } functionEntityPosition)
			{
				flag = functionEntityPosition.TryEvaluateLaneBodyBehind(memory, out targetPos);
			}
			else
			{
				targetPos = functionTarget.Return(memory);
				flag = true;
			}
			m_HasResolvedFunctionTargetPos = true;
			m_HasFunctionTargetCompensation = flag;
			m_CachedFunctionTargetPos = targetPos;
		}
		else
		{
			WhereTargets whereTargets = new WhereTargets
			{
				alliance = (behave.GetAlliance() | Alliance.Netural).GetOp(),
				canBeAttack = true
			};
			compressFindTargets.FindTargets(behave, list);
			whereTargets.FindTargets(list, behave);
		}
		CompMotion compMotion = behave.GetCompMotion();
		AnimationCurve animationCurve = curveType switch
		{
			CurveType.X => compMotion.layer0PeakConfig.forwardCurve, 
			CurveType.Y => compMotion.layer0PeakConfig.upCurve, 
			CurveType.Z => compMotion.layer0PeakConfig.rightCurve, 
			_ => compMotion.layer0PeakConfig.forwardCurve, 
		};
		CompTransform compTransform = behave.GetCompTransform();
		if (!m_EffectInit)
		{
			CompEffect compEffect = behave.GetCompEffect();
			float num = animationCurve[animationCurve.length - 1].value - animationCurve[0].value;
			m_EffectInit = true;
			if (!string.IsNullOrEmpty(effectPosName))
			{
				if (!compEffect.customEffectTran.TryGetValue(effectPosName, out var value))
				{
					value = EffectTran.EffectTranPool.Get();
					compEffect.customEffectTran[effectPosName] = value;
				}
				value.pos = compTransform.physicsPosition + VectorUtility.HorizontalDirection(behave.IsFaceLeft(), new Vector2(offest.x + num, offest.y));
				value.rot = behave.GetModelTrans()?.rotation ?? behave.GetRootTransform().rotation;
			}
		}
		if (rState == compMotion.lastLayer0Peak)
		{
			animationCurve = curveType switch
			{
				CurveType.X => compMotion.lastLayer0PeakConfig.forwardCurve, 
				CurveType.Y => compMotion.lastLayer0PeakConfig.upCurve, 
				CurveType.Z => compMotion.lastLayer0PeakConfig.rightCurve, 
				_ => compMotion.lastLayer0PeakConfig.forwardCurve, 
			};
		}
		bool flag2 = false;
		for (int num2 = list.Count - 1; num2 >= 0; num2--)
		{
			Entity entity = list[num2].entity;
			if (entity.IsValid && (!isFocusTarget || !(entity.Id != m_Target)))
			{
				CompTransform compTransform2 = entity.GetCompTransform();
				Vector3 vector = compTransform2.physicsPosition + VectorUtility.HorizontalDirection(behave.IsFaceLeft(), offest) - compTransform.physicsPosition;
				if (!(behave.IsFaceRight() ? (vector.normalized.x < 0f) : (vector.normalized.x > 0f)))
				{
					m_Target = entity.Id;
					isFocusTarget = true;
					targetPos = compTransform2.physicsPosition;
					flag2 = true;
					break;
				}
			}
		}
		if (useEnvCheck)
		{
			Vector3 direction = ((targetPos != Vector3.zero) ? (targetPos - compTransform.physicsPosition) : (Vector3.right * (behave.IsFaceRight() ? 1 : (-1))));
			if (Physics.Raycast(compTransform.physicsPosition, direction, out var hitInfo, 20f, BattleConsts.enviromentMask))
			{
				MonoEntity mono = behave.GetMono();
				Vector3 sonCollidersCenterOffset = mono.SonCollidersCenterOffset;
				float x = mono.SonColliderBounds.size.x;
				Vector3 vector2 = new Vector3(hitInfo.point.x + ((compTransform.FaceDir == FaceDir.Left) ? (x / 2f + sonCollidersCenterOffset.x) : ((0f - x) / 2f - sonCollidersCenterOffset.x)), hitInfo.point.y, hitInfo.point.z);
				float num3 = ((targetPos != Vector3.zero) ? Vector2.Distance(compTransform.physicsPosition, targetPos) : float.MaxValue);
				if (Vector2.Distance(compTransform.physicsPosition, vector2) < num3)
				{
					targetPos = vector2;
					offest = Vector2.zero;
					flag2 = true;
				}
			}
		}
		if (flag2 | flag)
		{
			float num4 = 0f;
			switch (curveType)
			{
			case CurveType.X:
				num4 = Vector3.Project(targetPos + VectorUtility.HorizontalDirection(behave.IsFaceLeft(), offest) - compTransform.physicsPosition, Vector3.right).magnitude * (float)((compTransform.physicsPosition.x < targetPos.x) ? 1 : (-1));
				break;
			case CurveType.Y:
				num4 = targetPos.y + offest.y - compTransform.physicsPosition.y;
				break;
			case CurveType.Z:
			{
				int num5 = ((behave.GetCompTransform().physicsPosition.z > targetPos.z) ? 1 : (-1));
				num5 = (behave.IsFaceLeft() ? (num5 * -1) : num5);
				num4 = Vector3.Project(targetPos - compTransform.physicsPosition, Vector3.forward).magnitude * (float)num5;
				break;
			}
			}
			float num6 = animationCurve[animationCurve.length - 1].value - animationCurve.Evaluate(rState.length * rState.toLogicPercent);
			if (curveType == CurveType.X)
			{
				num6 *= (float)(behave.IsFaceRight() ? 1 : (-1));
			}
			float num7 = 0f;
			num7 = ((!Mathf.Approximately(0f, num6)) ? (num4 / num6) : 1f);
			if (num7 < minScale)
			{
				num7 = minScale;
			}
			if (num7 > maxScale)
			{
				num7 = maxScale;
			}
			float num8 = num7 * num6;
			switch (curveType)
			{
			case CurveType.X:
				rState.compensationForwardCurveRate = num7;
				break;
			case CurveType.Y:
				rState.compensationUpCurveRate = num7;
				break;
			case CurveType.Z:
				rState.compensationRightCurveRate = num7;
				break;
			}
			if (!string.IsNullOrEmpty(effectPosName))
			{
				CompEffect compEffect2 = behave.GetCompEffect();
				compEffect2.customEffectTran[effectPosName].pos = VectorUtility.HorizontalDirection(behave.IsFaceLeft(), new Vector2(offest.x, offest.y)) + compTransform.physicsPosition;
				compEffect2.customEffectTran[effectPosName].pos.x += num8;
				Vector3 down = Vector3.down;
				if (Physics.Raycast(new Ray(compEffect2.customEffectTran[effectPosName].pos, down), out var hitInfo2, 20f, BattleConsts.enviromentMask))
				{
					compEffect2.customEffectTran[effectPosName].pos = hitInfo2.point;
				}
			}
		}
		ListPool<FindTargetResult>.Release(list);
	}

	public override void Reset(Entity entity)
	{
		m_Target = default;
		m_EffectInit = false;
		isFocusTarget = false;
		m_HasResolvedFunctionTargetPos = false;
		m_HasFunctionTargetCompensation = false;
		m_CachedFunctionTargetPos = default;
	}
}
