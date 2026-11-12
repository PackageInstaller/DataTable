using System.Collections;
using System.Collections.Generic;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._73001KuiLeiShi_Mainline;

public class Skill_NengLiangQiu : Skill_NengLiangQiuBase
{
	private const string combo_NengLiangQiu = "EnergyBall";

	private const string combo_Teleport = "Teleport";

	private TSVector2 bossTeleportPos = new TSVector2(0, 0);

	private bool skillend;

	private bool finished;

	protected override AdventureActor GetBossActor()
	{
		return _actor;
	}

	protected override void PlayDamageReductionAddedFx(AdventureActor boss)
	{
		if (!(boss == null))
		{
			PlayFx("fx_m72011_base_Shield", 1f, default, GetEntityPosition(boss), default);
		}
	}

	protected override void PlayDamageReductionRemovedFx(AdventureActor boss, AdventureActor player)
	{
		if (!(boss == null))
		{
			GameObject gameObject = boss.gameObject;
			GameObject gameObject2 = player?.gameObject;
			if (gameObject2 != null)
			{
				TSVector2 entityPosition = GetEntityPosition(player);
				TSVector sourcePosition = new TSVector(entityPosition.x, 0, entityPosition.y);
				PlayLinkFX("fx_m72012_base_shootline_1", useCustomSource: true, gameObject2, sourcePosition, FP.Zero, gameObject, TSVector.zero, FP.Zero, breakWhenLostSourceOrTarget: false);
			}
			PlayFx("fx_m72011_base_Shield_down", 1f, default, GetEntityPosition(boss), default);
		}
	}

	protected override AdventureActor GetEnergyTarget()
	{
		int dataID = (int)(long)GetLogicTagFpValue(_actor, Config_JuXingMoXiang.SelfDataIdTag);
		List<LogicEntity> targetByDataID = GetTargetByDataID(dataID);
		if (targetByDataID.Count <= 0)
		{
			return null;
		}
		return targetByDataID.get_Item(0) as AdventureActor;
	}

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		skillend = false;
		finished = false;
		if (ModuleController<AdventureModuleController>.Instance != null)
		{
			ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvt);
		}
	}

	protected override void OnSkillDisable()
	{
		if (ModuleController<AdventureModuleController>.Instance != null)
		{
			ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvt);
		}
		if (!finished)
		{
			ClearOwnerBullet();
			ClearActors(GetTargetByDataID(_orbId));
			ClearActors(GetTargetByDataID(_phantomId));
		}
		base.OnSkillDisable();
	}

	private void OnCustomEvt(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent { eventName: not null } adventureActorCustomEvent && adventureActorCustomEvent.eventName.Equals("StartPulling"))
		{
			skillend = true;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		InitNLQState();
		DispatchGiantGolemApproach();
		BeginAttack(1, "Teleport", flushInputedKeys: true);
		yield return WaitCustomEvent("TeleportStart");
		Teleport(bossTeleportPos);
		yield return WaitTime(0.1f);
		BeginLookAtCameraDir(DirectionType.Down, 0.2, 1000);
		yield return WaitTime(1f);
		BeginAttack(2, "EnergyBall", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("StartEnergyBall");
		while (!skillend)
		{
			yield return WaitTime(0.1f);
		}
		yield return WaitTime(5f);
		CancelAttack();
		InitNLQState();
		finished = true;
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void DispatchGiantGolemApproach()
	{
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _actor;
		adventureActorCustomEvent.actor = _actor;
		adventureActorCustomEvent.eventHashCode = Common_73001.evt_GiantGolemApproach;
		_actor.DispatchEvent(adventureActorCustomEvent);
	}
}
