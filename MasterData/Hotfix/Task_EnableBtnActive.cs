using UnityEngine;

[AddComponentMenu("触发器结果/玩家事件/屏蔽按钮操作", 1)]
public class Task_EnableBtnActive : TaskCellBase
{
	public bool isActive;

	protected override void OnExecute()
	{
		if (isActive)
		{
			SceneSingleton<AdventurePlayerController>.Instance.EnableFire1();
			SceneSingleton<AdventurePlayerController>.Instance.EnableFire2();
			SceneSingleton<AdventurePlayerController>.Instance.EnableFire3();
			SceneSingleton<AdventurePlayerController>.Instance.EnableFire4();
			SceneSingleton<AdventurePlayerController>.Instance.EnableActorSwitch1();
			SceneSingleton<AdventurePlayerController>.Instance.EnableActorSwitch2();
			SceneSingleton<AdventurePlayerController>.Instance.EnableSwitchWithUltra1();
			SceneSingleton<AdventurePlayerController>.Instance.EnableSwitchWithUltra2();
			SceneSingleton<AdventurePlayerController>.Instance.EnableInteractive();
			SceneSingleton<AdventurePlayerController>.Instance.EnableTargetSwitch();
		}
		else
		{
			SceneSingleton<AdventurePlayerController>.Instance.CancelInput();
			SceneSingleton<AdventurePlayerController>.Instance.DisableFire1();
			SceneSingleton<AdventurePlayerController>.Instance.DisableFire2();
			SceneSingleton<AdventurePlayerController>.Instance.DisableFire3();
			SceneSingleton<AdventurePlayerController>.Instance.DisableFire4();
			SceneSingleton<AdventurePlayerController>.Instance.DisableActorSwitch1();
			SceneSingleton<AdventurePlayerController>.Instance.DisableActorSwitch2();
			SceneSingleton<AdventurePlayerController>.Instance.DisableSwitchWithUltra1();
			SceneSingleton<AdventurePlayerController>.Instance.DisableSwitchWithUltra2();
			SceneSingleton<AdventurePlayerController>.Instance.DisableInteractive();
			SceneSingleton<AdventurePlayerController>.Instance.DisableTargetSwitch();
		}
		CommonHelper.EnableSkillInput(isActive);
		EndAction();
	}
}
