using TrueSync;
using UnityEngine;

[AddComponentMenu("触发器结果/玩家事件/控制角色移动", 1)]
public class Task_ControlMove : TaskCellBase
{
	public TSVector2 startPosition;

	public TSVector2 targetPosition;

	public AdventureActor.MovementMode moveMode = AdventureActor.MovementMode.Walk;

	public FP distance2fadeout = 1;

	public float fadeoutDuration;

	public float fadeoutTargetAlpha;

	protected override void OnExecute()
	{
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		PlayerAdventureActor player;
		if (!(null == activedPlayerActor) && !activedPlayerActor.IsDead())
		{
			AdventurePlayerController instance = SceneSingleton<AdventurePlayerController>.Instance;
			if (instance.inputEnabled)
			{
				instance.InputDisable();
			}
			player = activedPlayerActor as PlayerAdventureActor;
			player.InterruptAttack(force: true, fadeOutAnim: false);
			player.CancelAttack();
			player.Idle();
			if (startPosition.Equals(default))
			{
				Move2Target();
			}
			else if (!player.MoveTo(startPosition, 0.1f, enableNavigation: false, moveMode, () =>
			{
				Move2Target();
			}))
			{
				Complete();
			}
			EndAction();
		}
		static void Complete()
		{
		}
		void DoFadeOut()
		{
			player.TransparentSwichActorFadeIn(fadeoutDuration, 1f, fadeoutTargetAlpha);
			if (!player.MoveTo(targetPosition, 0.1f, enableNavigation: false, moveMode, Complete))
			{
				Complete();
			}
		}
		void Move2Target()
		{
			if (!player.MoveTo(targetPosition, distance2fadeout, enableNavigation: false, moveMode, () =>
			{
				DoFadeOut();
			}))
			{
				Complete();
			}
		}
	}
}
