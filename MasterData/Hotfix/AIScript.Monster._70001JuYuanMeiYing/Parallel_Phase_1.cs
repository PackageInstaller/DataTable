using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Monster.Template;
using TrueSync;

namespace AIScript.Monster._70001JuYuanMeiYing;

public class Parallel_Phase_1 : Parallel
{
	private int buff_A = 700010012;

	private int buff_B = 700010016;

	private int count_A = 99;

	private int buff_1 = 700010010;

	private Dictionary<string, int> buffNum_1_1 = new Dictionary<string, int>
	{
		["Lv1"] = 20,
		["Lv2"] = 20,
		["Lv3"] = 20,
		["Lv4"] = 30,
		["Lv5"] = 40
	};

	private int buffNum_1_2;

	private int buff_2 = 700010013;

	private int buffNum_2 = 1;

	private FP interval = 1;

	private int energyDelta = 1;

	private string bossLv;

	private CoroutineNode corAddEnergy;

	private MonsterAdventureActor actor => _actor as MonsterAdventureActor;

	private PlayerAdventureActor mainCtrActor => SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;

	public override void OnStart()
	{
		base.OnStart();
		bossLv = actor.monsterInfo.Tag1;
		StartCoroutine(ref corAddEnergy, DoAddEnergy());
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_GET_BUFF", OnActorGetBuff);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REMOVE_BUFF", OnActorRemoveBuff);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_LOSTCONTROL", OnActorLostControl);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		StopCoroutine(ref corAddEnergy);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnActorGetBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REMOVE_BUFF", OnActorRemoveBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_LOSTCONTROL", OnActorLostControl);
	}

	private IEnumerator DoAddEnergy()
	{
		FP timer = 0;
		while (true)
		{
			if (timer > interval)
			{
				if (actor.monsterInfo.currentEnergy < actor.monsterInfo.maxEnergy)
				{
					actor.monsterInfo.currentEnergy = Math.Min(actor.monsterInfo.currentEnergy + energyDelta, actor.monsterInfo.maxEnergy);
					MonoSingleton<LuaManager>.Instance.FireEntityEvent("JointDrillBossEnergyChanged", _actor.Id, actor.monsterInfo.currentEnergy, a2: true);
				}
				timer = 0;
			}
			yield return null;
			timer += _actor.LogicDeltaTime;
		}
	}

	private void OnActorRemoveBuff(IEvent evt)
	{
		if (!(evt is AdventureActorRemoveBuff { sender: MonsterAdventureActor sender } adventureActorRemoveBuff) || sender.Id != _actor.Id)
		{
			return;
		}
		if (adventureActorRemoveBuff.eventInfo.buffId == buff_1)
		{
			int buffNumByID = _actor.buffComponent.GetBuffNumByID(buff_1);
			if (buffNumByID == buffNum_1_1.get_Item(bossLv) || buffNumByID == buffNum_1_2)
			{
				_actor.buffComponent.RemoveBuffByBuffId(buff_2, buffNum_2);
				if (buffNumByID == buffNum_1_2)
				{
					_actor.buffComponent.AddBuff(700010014, _actor);
				}
			}
		}
		else if (adventureActorRemoveBuff.eventInfo.buffId == buff_A && _actor.buffComponent.GetBuffNumByID(buff_A) < count_A && mainCtrActor.buffComponent.CheckBuffByBuffID(buff_B))
		{
			mainCtrActor.buffComponent.RemoveBuffByBuffId(buff_B);
		}
	}

	private void OnActorGetBuff(IEvent evt)
	{
		if (evt is AdventureActorGetBuff { sender: MonsterAdventureActor sender } adventureActorGetBuff && sender.Id == _actor.Id && adventureActorGetBuff.eventInfo.buffId == buff_A && _actor.buffComponent.GetBuffNumByID(buff_A) >= count_A && !mainCtrActor.buffComponent.CheckBuffByBuffID(buff_B))
		{
			mainCtrActor.buffComponent.AddBuff(buff_B, _actor);
		}
	}

	private void OnActorLostControl(IEvent ievent)
	{
		if (ievent is AdventureActorLostControlEvent adventureActorLostControlEvent && adventureActorLostControlEvent.actor == _actor)
		{
			_actor.tsTransform.Forward = new TSVector2(0, -1);
			_actor.SyncMovementLocation(_actor.tsTransform.Position, _actor.tsTransform.PositionY, _actor.tsTransform.Rotation);
		}
	}
}
