using System;
using System.ComponentModel;
using Sirenix.Serialization;
using UnityEngine;

namespace ACT.NPC.Animation;

[Serializable]
public class NpcAnimationCollection
{
	[OdinSerialize]
	[SerializeField]
	public bool dontUseAnimationSnap;

	[OdinSerialize]
	[SerializeField]
	private AnimatorSetType setType;

	[OdinSerialize]
	public AnimatorControllerParameterType paramType;

	[OdinSerialize]
	public string paramName;

	[OdinSerialize]
	public bool boolValue;

	[OdinSerialize]
	public int intValue;

	[OdinSerialize]
	public float floatValue;

	[OdinSerialize]
	public string stateName;

	[OdinSerialize]
	[DefaultValue(0f)]
	public float normalizedTransitionDuration;

	[OdinSerialize]
	[DefaultValue(-1)]
	public int layer = -1;

	[OdinSerialize]
	public float normalizedTimeOffset;

	[OdinSerialize]
	public float normalizedTransitionTime;

	[OdinSerialize]
	public NpcCondition condition = new NpcCondition();

	public void ApplyToAnimator(Animator animator)
	{
		if (!animator)
		{
			return;
		}
		if (setType == AnimatorSetType.Name)
		{
			animator.CrossFade(stateName, normalizedTransitionDuration, layer, normalizedTimeOffset, normalizedTransitionTime);
			return;
		}
		switch (paramType)
		{
		case AnimatorControllerParameterType.Trigger:
			animator.SetTrigger(paramName);
			break;
		case AnimatorControllerParameterType.Bool:
			animator.SetBool(paramName, boolValue);
			break;
		case AnimatorControllerParameterType.Int:
			animator.SetInteger(paramName, intValue);
			break;
		case AnimatorControllerParameterType.Float:
			animator.SetFloat(paramName, floatValue);
			break;
		}
	}

	public void ResetOnAnimator(Animator animator)
	{
		if ((bool)animator && setType != AnimatorSetType.Name)
		{
			switch (paramType)
			{
			case AnimatorControllerParameterType.Trigger:
				animator.ResetTrigger(paramName);
				break;
			case AnimatorControllerParameterType.Bool:
				animator.SetBool(paramName, !boolValue);
				break;
			case AnimatorControllerParameterType.Int:
				animator.SetInteger(paramName, 0);
				break;
			case AnimatorControllerParameterType.Float:
				animator.SetFloat(paramName, 0f);
				break;
			}
		}
	}
}
