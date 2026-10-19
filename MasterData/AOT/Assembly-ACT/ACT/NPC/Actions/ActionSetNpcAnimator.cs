using System;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.NPC.Actions;

[Serializable]
public class ActionSetNpcAnimator : NpcInteractAction
{
	[SerializeField]
	private AnimatorControllerParameterType paramType;

	[SerializeField]
	private string paramName;

	[SerializeField]
	private bool boolValue;

	[SerializeField]
	private int intValue;

	[SerializeField]
	private float floatValue;

	public override int ActionId => NpcInteractActionIds.SetNpcAnimator;

	protected override UniTask DoAction()
	{
		Animator animator = Context.Npc.GetCompNpc().Animator;
		switch (paramType)
		{
		case AnimatorControllerParameterType.Bool:
			animator.SetBool(paramName, boolValue);
			break;
		case AnimatorControllerParameterType.Trigger:
			animator.SetTrigger(paramName);
			break;
		case AnimatorControllerParameterType.Int:
			animator.SetInteger(paramName, intValue);
			break;
		case AnimatorControllerParameterType.Float:
			animator.SetFloat(paramName, floatValue);
			break;
		}
		return UniTask.CompletedTask;
	}
}
