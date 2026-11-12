using UnityEngine;

[AddComponentMenu("触发器结果/玩家事件/角色切換动画组", 0)]
public class Task_SwitchAnimationGroup : TaskCellBase
{
	public int animGroupIndex;

	public int actorId;

	public AnimationClip switchClip;

	public AnimationClip resetClip;

	protected override void OnExecute()
	{
		if (SceneSingleton<AdventurePlayerController>.Instance.ActorDicts.TryGetValue(actorId, out var value))
		{
			if (animGroupIndex >= 0)
			{
				value.animatorController.PlayActionAnimation(switchClip, HybirdAnimatorController.ActionAnimationType.ActionOverride, 0.2f, 0.2f);
				value.ReplaceAnimationGroup(animGroupIndex);
			}
			else
			{
				value.animatorController.PlayActionAnimation(resetClip, HybirdAnimatorController.ActionAnimationType.ActionOverride, 0.2f, 0.2f);
				value.ResumeAnimationGroup();
			}
		}
		EndAction();
	}
}
