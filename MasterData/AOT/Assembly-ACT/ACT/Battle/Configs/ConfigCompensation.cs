using System;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

public class ConfigCompensation
{
	[Tooltip("默认可以设置朝向，只有少部分情况才不需要设置朝向")]
	[HideInInspector]
	public bool forceFaceDir = true;

	[HideInInspector]
	public bool inputPriority = true;

	public bool useXCompensation = true;

	public bool useYCompensation;

	public bool useZCompensation;

	[HideInInspector]
	public float duration;

	public UseCurve useCurve;

	public AnimationCurve customCurve;

	public void DoCompensation(Vector2 compensation, Entity target, Action hook = null)
	{
		if (!useXCompensation)
		{
			compensation.x = 0f;
		}
		if (!useYCompensation)
		{
			compensation.y = 0f;
		}
		SetCompensation(compensation, target, hook);
	}

	public void DoCompensation(Vector2 compensation, Entity target, float durationTime, Action hook = null)
	{
		if (!useXCompensation)
		{
			compensation.x = 0f;
		}
		if (!useYCompensation)
		{
			compensation.y = 0f;
		}
		SetCompensation(compensation, target, durationTime, hook);
	}

	public void DoCompensation(Vector3 compensation, Entity target, Action hook = null)
	{
		if (!useXCompensation)
		{
			compensation.x = 0f;
		}
		if (!useYCompensation)
		{
			compensation.y = 0f;
		}
		if (!useZCompensation)
		{
			compensation.z = 0f;
		}
		SetCompensation(compensation, target, hook);
	}

	public void DoCompensation(Vector3 compensation, Entity target, float durationTime, Action hook = null)
	{
		if (!useXCompensation)
		{
			compensation.x = 0f;
		}
		if (!useYCompensation)
		{
			compensation.y = 0f;
		}
		if (!useZCompensation)
		{
			compensation.z = 0f;
		}
		SetCompensation(compensation, target, durationTime, hook);
	}

	private void SetCompensation(Vector3 compensation, Entity target, Action hook)
	{
		CompMotion compMotion = target.GetCompMotion();
		CompTransform compTransform = target.GetCompTransform();
		float compensationDuration = duration;
		compTransform.SetCompensation(compensation, compensationDuration, useCurve switch
		{
			UseCurve.None => null, 
			UseCurve.RootMotion => compMotion.layer0PeakConfig.forwardCurve, 
			UseCurve.YMotion => compMotion.layer0PeakConfig.upCurve, 
			UseCurve.XMotion => compMotion.layer0PeakConfig.rightCurve, 
			UseCurve.Custom => customCurve, 
			_ => throw new NotImplementedException(), 
		}, hook);
	}

	private void SetCompensation(Vector3 compensation, Entity target, float durationTime, Action hook)
	{
		CompMotion compMotion = target.GetCompMotion();
		CompTransform compTransform = target.GetCompTransform();
		compTransform.SetCompensation(compensation, durationTime, useCurve switch
		{
			UseCurve.None => null, 
			UseCurve.RootMotion => compMotion.layer0PeakConfig.forwardCurve, 
			UseCurve.YMotion => compMotion.layer0PeakConfig.upCurve, 
			UseCurve.XMotion => compMotion.layer0PeakConfig.rightCurve, 
			UseCurve.Custom => customCurve, 
			_ => throw new NotImplementedException(), 
		}, hook);
	}
}
