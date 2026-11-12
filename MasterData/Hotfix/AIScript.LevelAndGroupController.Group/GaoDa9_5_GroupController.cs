namespace AIScript.LevelAndGroupController.Group;

public class GaoDa9_5_GroupController : GroupControllerBase
{
	private const string InteractiveID_HideAutoBattle = "InteractiveID_HideAutoBattle";

	private const string InteractiveID_ShowAutoBattle = "InteractiveID_ShowAutoBattle";

	private const string InteractiveID_HintFire2 = "InteractiveID_HintFire2";

	private const string InteractiveID_HintActorSwitch = "InteractiveID_HintActorSwitch";

	private const string InteractiveID_HintUltra = "InteractiveID_HintUltra";

	private const string luaEvt_CloseOrOpenAutoBattle = "CloseOrOpenAutoBattle";

	private const string luaEvt_HintButton = "HintButton";

	private const string luaEvt_HintUltraButton = "HintUltraButton";

	private const string btn_Fire2 = "Fire2";

	private const string btn_ActorSwitch = "ActorSwitch1+ActorSwitch2";

	private const string btn_Ultra = "Fire4";

	private const string btn_ALL = "ActorSwitch1+ActorSwitch2+Fire1+Fire2+Fire4+SwitchWithUltra1+SwitchWithUltra2";

	private PlayerAdventureActor mainActor => SceneSingleton<AdventurePlayerController>.Instance?.ActivedPlayerActor;

	protected override void OnStart()
	{
		base.OnStart();
		MonoSingleton<LuaManager>.Instance.FireEvent("EnableBtnControl", "ActorSwitch1+ActorSwitch2+Fire1+Fire2+Fire4+SwitchWithUltra1+SwitchWithUltra2", a2: false);
		SetAutoBattleEnable(enable: false);
		SetMainSkillEnable(enable: false);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("INTERACTIVEID", OnReceiveInterActiveMessage);
	}

	protected override void OnStop()
	{
		base.OnStop();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("INTERACTIVEID", OnReceiveInterActiveMessage);
	}

	protected override void OnUpdate()
	{
		base.OnUpdate();
	}

	private void OnReceiveInterActiveMessage(IEvent iEvt)
	{
		if (iEvt is AdventureInteractiveIDTrigger adventureInteractiveIDTrigger)
		{
			switch (adventureInteractiveIDTrigger.interactiveID)
			{
			case "InteractiveID_HideAutoBattle":
				MonoSingleton<LuaManager>.Instance.FireEvent("CloseOrOpenAutoBattle", a1: false);
				break;
			case "InteractiveID_ShowAutoBattle":
				MonoSingleton<LuaManager>.Instance.FireEvent("CloseOrOpenAutoBattle", a1: true);
				break;
			case "InteractiveID_HintFire2":
				MonoSingleton<LuaManager>.Instance.FireEvent("HintButton", "Fire2");
				SetMainSkillEnable(enable: true);
				break;
			case "InteractiveID_HintActorSwitch":
				MonoSingleton<LuaManager>.Instance.FireEvent("HintButton", "ActorSwitch1+ActorSwitch2");
				SetAutoBattleEnable(enable: true);
				break;
			case "InteractiveID_HintUltra":
				MonoSingleton<LuaManager>.Instance.FireEvent("HintUltraButton", "Fire4");
				break;
			}
		}
	}

	private void SetAutoBattleEnable(bool enable)
	{
		AdventurePlayerController instance = SceneSingleton<AdventurePlayerController>.Instance;
		if (!(instance == null))
		{
			EnableSupportSkill(instance.FirstSlotActorId, enable);
			EnableSupportSkill(instance.SecondSlotActorId, enable);
		}
	}

	private void EnableSupportSkill(int actorId, bool enable)
	{
		if (actorId != 0 && SceneSingleton<AdventurePlayerController>.Instance.ActorDicts.TryGetValue(actorId, out var value))
		{
			if (enable)
			{
				value.EnableCastSkill();
			}
			else
			{
				value.DisableCastSkill();
			}
		}
	}

	private void SetMainSkillEnable(bool enable)
	{
		if (enable)
		{
			mainActor.EnableCastSkill();
		}
		else
		{
			mainActor.DisableCastSkill();
		}
	}
}
