using System;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;

namespace ACT.NPC.Actions;

[Serializable]
public class ActionSetNpcAnimatorByName : NpcInteractAction
{
	public string animationName;

	public float normalizedTransitionDuration;

	public int layer = -1;

	public float normalizedTimeOffset;

	public float normalizedTransitionTime;

	public override int ActionId => NpcInteractActionIds.SetNpcAnimatorByName;

	protected override UniTask DoAction()
	{
		Context.Npc.GetCompNpc().Animator.CrossFade(animationName, normalizedTransitionDuration, layer, normalizedTimeOffset, normalizedTransitionTime);
		return UniTask.CompletedTask;
	}
}
