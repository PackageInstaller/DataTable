using System.Collections.Generic;
using ACT.MultiPlayer;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

public class EnvironmentCompensationPattern : CompensationPattern
{
	public enum CurveType
	{
		X,
		Y,
		Z
	}

	public CurveType curveType;

	[Tooltip("这样time可以配0-1之间")]
	public bool useSerializeRanges;

	public override void CompensationHandle(SystemAbility systemAbility, Entity behave, float duration, FSMRuntimeState rState)
	{
		Vector3 vector = Vector3.zero;
		float num = 0f;
		CompMotion compMotion = behave.GetCompMotion();
		AnimationCurve animationCurve = curveType switch
		{
			CurveType.X => compMotion.layer0PeakConfig.forwardCurve, 
			CurveType.Y => compMotion.layer0PeakConfig.upCurve, 
			CurveType.Z => compMotion.layer0PeakConfig.rightCurve, 
			_ => compMotion.layer0PeakConfig.forwardCurve, 
		};
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
		if (useSerializeRanges)
		{
			bool flag = false;
			List<ConfigMotion.CurveTimeRange> upRanges = compMotion.layer0PeakConfig.upRanges;
			if ((upRanges == null || upRanges.Count == 0) && LuminApplication.LogEnabled)
			{
				Debug.LogError("请重新读取" + compMotion.layer0PeakConfig.name + "动画曲线！！");
			}
			if (upRanges.Count > 0)
			{
				foreach (ConfigMotion.CurveTimeRange item in upRanges)
				{
					if (rState.length * rState.toLogicPercent >= item.startTime && rState.length * rState.toLogicPercent <= item.endTime)
					{
						flag = true;
						num = item.endTime;
					}
				}
			}
			if (!flag)
			{
				return;
			}
		}
		Vector3 direction;
		if (curveType != CurveType.X)
		{
			direction = ((curveType == CurveType.Y) ? Vector3.up : Vector3.forward);
		}
		else
		{
			direction = Vector3.right * (behave.IsFaceRight() ? 1 : (-1));
		}
		CompTransform compTransform = behave.GetCompTransform();
		if (Physics.Raycast(compTransform.physicsPosition, direction, out var hitInfo, 20f, BattleConsts.enviromentMask))
		{
			MonoEntity mono = behave.GetMono();
			Vector3 sonCollidersCenterOffset = mono.SonCollidersCenterOffset;
			float x = mono.SonColliderBounds.size.x;
			Vector3 vector2 = new Vector3(hitInfo.point.x + ((compTransform.FaceDir == FaceDir.Left) ? (x / 2f + sonCollidersCenterOffset.x) : ((0f - x) / 2f - sonCollidersCenterOffset.x)), hitInfo.point.y, hitInfo.point.z);
			float num2 = float.MaxValue;
			if (Vector2.Distance(compTransform.physicsPosition, vector2) < num2)
			{
				vector = vector2;
			}
		}
		if (vector != Vector3.zero)
		{
			float num3 = 0f;
			switch (curveType)
			{
			case CurveType.X:
				num3 = Vector3.Project(vector - compTransform.physicsPosition, Vector3.right).magnitude * (float)((compTransform.physicsPosition.x < vector.x) ? 1 : (-1));
				break;
			case CurveType.Y:
				num3 = vector.y - compTransform.physicsPosition.y;
				break;
			case CurveType.Z:
				num3 = Vector3.Project(vector - compTransform.physicsPosition, Vector3.forward).magnitude * (float)((compTransform.physicsPosition.z > vector.z) ? 1 : (-1));
				break;
			}
			float num4 = ((num != 0f) ? num : end);
			float num5 = animationCurve.Evaluate(num4) - animationCurve.Evaluate(rState.length * rState.toLogicPercent);
			if (curveType == CurveType.X)
			{
				num5 *= (float)(behave.IsFaceRight() ? 1 : (-1));
			}
			float num6 = 0f;
			num6 = ((!Mathf.Approximately(0f, num5)) ? (num3 / num5) : 1f);
			num6 = Mathf.Clamp(num6, 0f, 1f);
			switch (curveType)
			{
			case CurveType.X:
				rState.compensationForwardCurveRate = num6;
				break;
			case CurveType.Y:
				rState.compensationUpCurveRate = num6;
				break;
			case CurveType.Z:
				rState.compensationRightCurveRate = num6;
				break;
			}
		}
	}

	public override void Reset(Entity entity)
	{
	}
}
