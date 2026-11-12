using UnityEngine;

[AddComponentMenu("触发器结果/玩家事件/玩家显示或隐藏", 1)]
public class Task_HidePlayer : TaskCellBase
{
	public bool iShow;

	protected override void OnExecute()
	{
		PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance?.ActivedPlayerActor;
		if (playerAdventureActor != null)
		{
			if (!iShow)
			{
				SceneSingleton<AdventurePlayerController>.Instance.MainActorCanAttack = false;
				playerAdventureActor.EnableHideModel();
			}
			else
			{
				SceneSingleton<AdventurePlayerController>.Instance.MainActorCanAttack = true;
				playerAdventureActor.DisableHideModel();
			}
		}
		EndAction();
	}
}
