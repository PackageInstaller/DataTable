using System;
using System.Collections.Generic;
using ACT.Utility;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

public class PeriodCompensationPattern : CompensationPattern
{
	public enum CurveType
	{
		Forward = 1,
		Up
	}

	public ConfigFindRangeTargets compressFindTargets;

	public float preStartTime;

	public float preEndTime;

	public float calculateStart;

	public float calculateEnd;

	public Vector2 offest;

	public float minScale;

	public float maxScale;

	public string effectPosName;

	public ConfigFunction<Vector3> functionTarget;

	public CurveType curveType = CurveType.Forward;

	private EntityId m_Target;

	private bool isFocusTarget;

	private bool m_EffectInit;

	private float compensationRate = 1f;

	private Vector3 m_TargetPos;

	private Vector3 endPos;

	private float realDis;

	public override void CompensationHandle(SystemAbility systemAbility, Entity behave, float duration, FSMRuntimeState rState)
	{
		List<FindTargetResult> temp = ListPool<FindTargetResult>.Get();
		preStartTime = MathF.Max(time, preStartTime);
		preEndTime = MathF.Min(MathF.Max(time, end), preEndTime);
		calculateStart = Mathf.Max(time, calculateStart);
		calculateEnd = Mathf.Min(calculateEnd, Mathf.Max(time, end));
		bool flag = rState.fromLogicPercent >= preStartTime && rState.fromLogicPercent <= preEndTime;
		bool flag2 = rState.fromLogicPercent >= calculateStart && rState.fromLogicPercent <= calculateEnd;
		if (flag | flag2)
		{
			CompMotion compMotion = behave.GetCompMotion();
			m_TargetPos = Vector3.zero;
			AnimationCurve animationCurve = null;
			switch (curveType)
			{
			case CurveType.Forward:
				animationCurve = compMotion.layer0PeakConfig.forwardCurve;
				break;
			case CurveType.Up:
				animationCurve = compMotion.layer0PeakConfig.upCurve;
				break;
			}
			bool flag3 = functionTarget != null;
			if (flag3)
			{
				m_TargetPos = functionTarget.Return(new ActionMemory(behave, behave, behave));
			}
			else
			{
				FindTarget(behave, ref temp);
			}
			if (rState == compMotion.lastLayer0Peak)
			{
				switch (curveType)
				{
				case CurveType.Forward:
					animationCurve = compMotion.lastLayer0PeakConfig.forwardCurve;
					break;
				case CurveType.Up:
					animationCurve = compMotion.lastLayer0PeakConfig.upCurve;
					break;
				}
			}
			CompTransform compTransform = behave.GetCompTransform();
			if (!m_EffectInit)
			{
				float num = animationCurve[animationCurve.length - 1].value - animationCurve[0].value;
				m_EffectInit = true;
				if (!string.IsNullOrEmpty(effectPosName) & flag)
				{
					CompEffect compEffect = behave.GetCompEffect();
					if (!compEffect.customEffectTran.TryGetValue(effectPosName, out var value))
					{
						value = EffectTran.EffectTranPool.Get();
						compEffect.customEffectTran[effectPosName] = value;
					}
					value.pos = compTransform.physicsPosition + VectorUtility.HorizontalDirection(behave.IsFaceLeft(), new Vector2(offest.x + num, offest.y));
					value.rot = behave.GetModelTrans()?.rotation ?? behave.GetRootTransform().rotation;
				}
			}
			bool flag4 = SelectTarget(behave, temp);
			if (flag && (flag4 | flag3))
			{
				float num2 = 0f;
				switch (curveType)
				{
				case CurveType.Forward:
					num2 = Vector3.Project(m_TargetPos - compTransform.physicsPosition, Vector3.right).magnitude;
					break;
				case CurveType.Up:
					num2 = Vector3.Project(m_TargetPos - compTransform.physicsPosition, Vector3.up).magnitude;
					break;
				}
				float num3 = animationCurve[animationCurve.length - 1].value - animationCurve.Evaluate(rState.length * calculateEnd);
				if (Mathf.Approximately(0f, num3))
				{
					compensationRate = 1f;
				}
				else
				{
					compensationRate = Mathf.Abs(num2 / num3);
				}
				compensationRate = Mathf.Clamp(compensationRate, minScale, maxScale);
				realDis = compensationRate * num3;
				if (!string.IsNullOrEmpty(effectPosName))
				{
					CompEffect compEffect2 = behave.GetCompEffect();
					compEffect2.customEffectTran[effectPosName].pos = m_TargetPos;
					Vector3 down = Vector3.down;
					if (Physics.Raycast(new Ray(compEffect2.customEffectTran[effectPosName].pos, down), out var hitInfo, 20f, BattleConsts.enviromentMask))
					{
						compEffect2.customEffectTran[effectPosName].pos = hitInfo.point;
					}
				}
				switch (curveType)
				{
				case CurveType.Forward:
					endPos = new Vector3(m_TargetPos.x, 0f, 0f);
					break;
				case CurveType.Up:
					endPos = new Vector3(0f, m_TargetPos.y, 0f);
					break;
				}
			}
			if (flag2)
			{
				switch (curveType)
				{
				case CurveType.Forward:
					if (!BoolUtility.IsInFront(behave.IsFaceLeft(), behave.GetCompTransform().physicsPosition.x, endPos.x))
					{
						compensationRate = 1f;
					}
					break;
				case CurveType.Up:
					if (Mathf.Abs(behave.GetCompTransform().physicsPosition.y - endPos.y) < 0.01f)
					{
						compensationRate = 1f;
					}
					break;
				}
				switch (curveType)
				{
				case CurveType.Forward:
					rState.frameCompensationRate = compensationRate;
					break;
				case CurveType.Up:
					rState.frameCompensationRateY = compensationRate;
					break;
				}
			}
		}
		else if (!flag2)
		{
			switch (curveType)
			{
			case CurveType.Forward:
				rState.frameCompensationRate = 1f;
				break;
			case CurveType.Up:
				rState.frameCompensationRateY = 1f;
				break;
			}
		}
		ListPool<FindTargetResult>.Release(temp);
	}

	protected void FindTarget(Entity behave, ref List<FindTargetResult> temp)
	{
		WhereTargets whereTargets = new WhereTargets
		{
			alliance = (behave.GetAlliance() | Alliance.Netural).GetOp(),
			canBeAttack = true
		};
		compressFindTargets.FindTargets(behave, temp);
		whereTargets.FindTargets(temp, behave);
	}

	protected bool SelectTarget(Entity behave, List<FindTargetResult> temp)
	{
		for (int num = temp.Count - 1; num >= 0; num--)
		{
			Entity entity = temp[num].entity;
			if (entity.IsValid && (!isFocusTarget || !(entity.Id != m_Target)))
			{
				Vector3 vector = entity.GetCompTransform().physicsPosition + VectorUtility.HorizontalDirection(behave.IsFaceLeft(), offest);
				Vector3 vector2 = vector - behave.GetCompTransform().physicsPosition;
				if (!(behave.IsFaceRight() ? (vector2.normalized.x < 0f) : (vector2.normalized.x > 0f)))
				{
					m_Target = entity.Id;
					m_TargetPos = vector;
					isFocusTarget = true;
					return true;
				}
			}
		}
		return false;
	}

	public override void Reset(Entity entity)
	{
		m_Target = default;
		m_EffectInit = false;
		isFocusTarget = false;
		compensationRate = 1f;
	}
}
