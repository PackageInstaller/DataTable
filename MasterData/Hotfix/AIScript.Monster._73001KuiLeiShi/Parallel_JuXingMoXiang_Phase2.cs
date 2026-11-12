using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Monster.Template;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi;

public class Parallel_JuXingMoXiang_Phase2 : Parallel
{
	private readonly FP interval = 1;

	private const int energyDelta = 1;

	private CoroutineNode corAddEnergy;

	private PlayFX _shieldDownFx;

	private PlayFX _breakLineFx;

	private MonsterAdventureActor actor => _actor as MonsterAdventureActor;

	public override void OnStart()
	{
		base.OnStart();
		StartCoroutine(ref corAddEnergy, DoAddEnergy());
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
		StopCoroutine(ref corAddEnergy);
		ILRuntimeAPI.ClearPlayFX(_shieldDownFx);
		ILRuntimeAPI.ClearPlayFX(_breakLineFx);
	}

	private void OnGetBuff(IEvent iEvent)
	{
		if (iEvent is AdventureActorGetBuff adventureActorGetBuff && !(adventureActorGetBuff.sender as AdventureActor != _actor))
		{
			SyncBossBuffChangeIfMatch(adventureActorGetBuff.eventInfo.buffId);
		}
	}

	private void OnRemoveBuff(IEvent iEvent)
	{
		if (iEvent is AdventureActorRemoveBuff adventureActorRemoveBuff && !(adventureActorRemoveBuff.sender as AdventureActor != _actor))
		{
			SyncBossBuffChangeIfMatch(adventureActorRemoveBuff.eventInfo.buffId);
		}
	}

	private void SyncBossBuffChangeIfMatch(int buffId)
	{
		int level = (int)(long)CommonUtils_MonsterAPI.GetLogicTagFpValue(_actor, Common_73001.SummonLevel_Tag);
		int monsterIdByLevel = Common_73001.GetMonsterIdByLevel(level, Config_XiaoMoXiang.damageReductionBuffIds);
		int monsterIdByLevel2 = Common_73001.GetMonsterIdByLevel(level, Config_XiaoMoXiang.vulnerableBuffIds);
		if (buffId == monsterIdByLevel || buffId == monsterIdByLevel2)
		{
			Common_73001.SyncBossBuffChange(_actor, monsterIdByLevel, monsterIdByLevel2);
		}
	}

	private IEnumerator DoAddEnergy()
	{
		FP timer = 0;
		while (true)
		{
			if (timer > interval)
			{
				if (actor != null && actor.monsterInfo.currentEnergy < actor.monsterInfo.maxEnergy)
				{
					actor.monsterInfo.currentEnergy = Math.Min(actor.monsterInfo.currentEnergy + 1, actor.monsterInfo.maxEnergy);
					MonoSingleton<LuaManager>.Instance.FireEntityEvent("JointDrillBossEnergyChanged", _actor.Id, actor.monsterInfo.currentEnergy, a2: true);
				}
				timer = 0;
			}
			yield return null;
			timer += _actor.LogicDeltaTime;
		}
	}

	protected override void OnActorDied(IEvent e)
	{
		if (e is AdventureActorDiedEvent adventureActorDiedEvent)
		{
			if (adventureActorDiedEvent.actor == _actor)
			{
				CleanSummons(_actor as MonsterAdventureActor);
			}
			else
			{
				OnConduitDied(adventureActorDiedEvent);
			}
		}
		base.OnActorDied(e);
	}

	private void OnConduitDied(AdventureActorDiedEvent diedEvent)
	{
		MonsterAdventureActor monsterAdventureActor = diedEvent.actor as MonsterAdventureActor;
		if (monsterAdventureActor == null)
		{
			return;
		}
		MonsterSummonInfo logicComponent = monsterAdventureActor.GetLogicComponent<MonsterSummonInfo>();
		if (logicComponent == null || !(diedEvent.killer is PlayerAdventureActor))
		{
			return;
		}
		int level = (int)(long)CommonUtils_MonsterAPI.GetLogicTagFpValue(_actor, Common_73001.SummonLevel_Tag);
		int monsterIdByLevel = Common_73001.GetMonsterIdByLevel(level, Config_XiaoMoXiang.zhuNengKuiLeiMonsterIds);
		if (monsterAdventureActor.dataID != monsterIdByLevel || logicComponent.SummonActorId != _actor.Id)
		{
			return;
		}
		int monsterIdByLevel2 = Common_73001.GetMonsterIdByLevel(level, Config_XiaoMoXiang.damageBuffIds);
		List<PlayerAdventureActor> list = SceneSingleton<AdventurePlayerController>.Instance?.ActorLs;
		if (list == null)
		{
			return;
		}
		foreach (PlayerAdventureActor item in list)
		{
			item?.buffComponent?.AddBuffNum(monsterIdByLevel2, 2, _actor);
		}
	}

	private void CleanSummons(MonsterAdventureActor summoner)
	{
		if (summoner == null)
		{
			return;
		}
		List<AdventureModuleController.MonsterSummonData> monsterSummonInfos = ModuleController<AdventureModuleController>.Instance.MonsterSummonInfos;
		for (int num = monsterSummonInfos.Count - 1; num >= 0; num--)
		{
			if (monsterSummonInfos.get_Item(num).SummonActorID == summoner.Id)
			{
				LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(monsterSummonInfos.get_Item(num).entityID);
				if (logicEntity != null && logicEntity is MonsterAdventureActor monsterAdventureActor)
				{
					monsterAdventureActor.DestroySelf(forceDestory: true);
				}
			}
		}
	}
}
