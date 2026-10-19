using System.Threading;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.Battle;

public class TriggerActionPlayAnimation : TriggerActionBase
{
	public enum ParameterType
	{
		Int,
		Float,
		Bool,
		Trigger
	}

	public Animator animator;

	public string parameterName;

	public ParameterType parameterType;

	public int valueInt;

	public bool valueBool;

	public float valueFloat;

	public override UniTask Invoke(TriggerActionContext context, CancellationToken token)
	{
		switch (parameterType)
		{
		case ParameterType.Bool:
			animator.SetBool(parameterName, valueBool);
			break;
		case ParameterType.Float:
			animator.SetFloat(parameterName, valueFloat);
			break;
		case ParameterType.Int:
			animator.SetInteger(parameterName, valueInt);
			break;
		case ParameterType.Trigger:
			animator.SetTrigger(parameterName);
			break;
		}
		return UniTask.CompletedTask;
	}
}
