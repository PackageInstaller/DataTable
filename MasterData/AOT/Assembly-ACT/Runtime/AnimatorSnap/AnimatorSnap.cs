using System.Collections.Generic;
using UnityEngine;

namespace Runtime.AnimatorSnap;

public struct AnimatorSnap
{
	private Dictionary<string, object> parameters = new Dictionary<string, object>();

	private Dictionary<int, int> layerStates = new Dictionary<int, int>();

	public AnimatorSnap(Animator animator)
	{
		if (!animator)
		{
			return;
		}
		AnimatorControllerParameter[] array = animator.parameters;
		foreach (AnimatorControllerParameter animatorControllerParameter in array)
		{
			switch (animatorControllerParameter.type)
			{
			case AnimatorControllerParameterType.Float:
				parameters[animatorControllerParameter.name] = animator.GetFloat(animatorControllerParameter.name);
				break;
			case AnimatorControllerParameterType.Int:
				parameters[animatorControllerParameter.name] = animator.GetInteger(animatorControllerParameter.name);
				break;
			case AnimatorControllerParameterType.Bool:
				parameters[animatorControllerParameter.name] = animator.GetBool(animatorControllerParameter.name);
				break;
			case AnimatorControllerParameterType.Trigger:
				parameters[animatorControllerParameter.name] = animator.GetBool(animatorControllerParameter.name);
				break;
			}
		}
		for (int j = 0; j < animator.layerCount; j++)
		{
			AnimatorStateInfo currentAnimatorStateInfo = animator.GetCurrentAnimatorStateInfo(j);
			layerStates[j] = currentAnimatorStateInfo.fullPathHash;
		}
	}

	public void Apply(Animator animator)
	{
		if (!animator)
		{
			return;
		}
		foreach (KeyValuePair<string, object> parameter in parameters)
		{
			if (!animator.HasParameter(parameter.Key))
			{
				continue;
			}
			object value = parameter.Value;
			if (!(value is float value2))
			{
				if (!(value is int value3))
				{
					if (value is bool value4)
					{
						animator.SetBool(parameter.Key, value4);
					}
				}
				else
				{
					animator.SetInteger(parameter.Key, value3);
				}
			}
			else
			{
				animator.SetFloat(parameter.Key, value2);
			}
		}
		foreach (KeyValuePair<int, int> layerState in layerStates)
		{
			if (layerState.Value != 0)
			{
				animator.CrossFade(layerState.Value, 0.1f, layerState.Key);
			}
		}
	}

	public void ApplyLayerStatesInFixedTime(Animator animator, float transitionSeconds)
	{
		if (!animator)
		{
			return;
		}
		foreach (KeyValuePair<int, int> layerState in layerStates)
		{
			if (layerState.Value != 0)
			{
				animator.CrossFadeInFixedTime(layerState.Value, Mathf.Max(0f, transitionSeconds), layerState.Key);
			}
		}
	}
}
