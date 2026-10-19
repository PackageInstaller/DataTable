using System.Threading;
using ACT.Battle;
using ACT.Battle.ECS.System.SystemNPC;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.DialogueSystem;

public class PlayNpcAnimationStepEventNodeProcessor : ChatStepEventNodeProcessor<PlayNpcAnimationStepEventNode>
{
	protected override UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		if (!Singleton<RuntimeNpcManager>.instance.InstantiatedNpcDictionary.TryGetValue(TData.npcId, out var value))
		{
			Debug.LogWarning($"Npc with id {TData.npcId} is not instantiated, cannot play animation.");
			return UniTask.FromResult(DialogueNodeResult.Continue);
		}
		if (!value.IsValid)
		{
			Debug.LogWarning($"Entity reference for npc with id {TData.npcId} is not valid, cannot play animation.");
			return UniTask.FromResult(DialogueNodeResult.Continue);
		}
		CompNpc compNpc = value.GetCompNpc();
		if (compNpc == null)
		{
			return UniTask.FromResult(DialogueNodeResult.Continue);
		}
		if (!compNpc.Animator)
		{
			return UniTask.FromResult(DialogueNodeResult.Continue);
		}
		switch (TData.type)
		{
		case PlayNpcAnimationStepEventNode.ActionType.AnimationName:
			compNpc.Animator.CrossFade(TData.animationName, 0.1f);
			break;
		case PlayNpcAnimationStepEventNode.ActionType.Bool:
			compNpc.Animator.SetBool(TData.animationName, TData.boolValue);
			break;
		case PlayNpcAnimationStepEventNode.ActionType.Int:
			compNpc.Animator.SetInteger(TData.animationName, TData.intValue);
			break;
		case PlayNpcAnimationStepEventNode.ActionType.Float:
			compNpc.Animator.SetFloat(TData.animationName, TData.floatValue);
			break;
		case PlayNpcAnimationStepEventNode.ActionType.Trigger:
			compNpc.Animator.SetTrigger(TData.animationName);
			break;
		}
		return UniTask.FromResult(DialogueNodeResult.Continue);
	}

	public override UniTask ExecuteStepEvent(ChatStep chatStep, DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		if (chatStep == ChatStep.None)
		{
			return UniTask.CompletedTask;
		}
		LuminDialogueContext luminDialogueContext = context as LuminDialogueContext;
		if (luminDialogueContext.Skipping)
		{
			return UniTask.CompletedTask;
		}
		return Execute(execution, luminDialogueContext, token);
	}
}
