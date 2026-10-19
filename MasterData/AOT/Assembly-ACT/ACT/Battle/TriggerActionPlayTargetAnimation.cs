using System.Threading;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.Battle;

public class TriggerActionPlayTargetAnimation : TriggerActionBase
{
	public bool includeChildren = true;

	public string parameterName;

	public TriggerActionPlayAnimation.ParameterType parameterType;

	public int valueInt;

	public bool valueBool;

	public float valueFloat;

	public override UniTask Invoke(TriggerActionContext context, CancellationToken token)
	{
		if (context.TargetObject == null || string.IsNullOrEmpty(parameterName))
		{
			return UniTask.CompletedTask;
		}
		Animator animator = (includeChildren ? context.TargetObject.GetComponentInChildren<Animator>() : context.TargetObject.GetComponent<Animator>());
		if (animator == null)
		{
			return UniTask.CompletedTask;
		}
		switch (parameterType)
		{
		case TriggerActionPlayAnimation.ParameterType.Bool:
			animator.SetBool(parameterName, valueBool);
			break;
		case TriggerActionPlayAnimation.ParameterType.Float:
			animator.SetFloat(parameterName, valueFloat);
			break;
		case TriggerActionPlayAnimation.ParameterType.Int:
			animator.SetInteger(parameterName, valueInt);
			break;
		case TriggerActionPlayAnimation.ParameterType.Trigger:
			animator.SetTrigger(parameterName);
			break;
		}
		return UniTask.CompletedTask;
	}
}
