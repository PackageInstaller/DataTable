using System;
using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._70001JuYuanMeiYing;

public class Skill_GravityField_Phase_2 : SkillSimpleBase
{
	private string key_Base1 = "Stage1_Skill06_1";

	private string key_Base2 = "Stage1_Skill06_2";

	private List<long> moveSummonIds = new List<long>();

	private int unmoveSummonId = 7010057;

	private string areaEffect_GravityField = "Area_70001_Skill06_Gravity_1";

	private string areaEffect_AccField = "Area_70001_Skill06_Gravity_2";

	private string areaEffect_BigAccField = "Area_70001_Skill06_Gravity_3";

	private string evt_Ultra = "evt_Ultra";

	private int liveCount;

	private List<string> summonPosList_Unmove = new List<string> { "Jin_01", "Jin_02", "Jin_03", "Jin_04" };

	private List<string> summonPosList_Move = new List<string> { "Zuo_01_01", "Zuo_02_01", "You_01_01", "You_02_01" };

	private TSVector2 center = new TSVector2(0, -7.5);

	private List<MonsterAdventureActor> summons = new List<MonsterAdventureActor>();

	private MonsterAdventureActor Actor => _actor as MonsterAdventureActor;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		moveSummonIds = GetLogicTagListLongValue(_actor, "MonsterSpawnList");
		Actor.monsterInfo.currentEnergy = 0;
		MonoSingleton<LuaManager>.Instance.FireEntityEvent("JointDrillBossEnergyChanged", _actor.Id, 0, a2: false);
		MonoSingleton<LuaManager>.Instance.FireEntityEvent("CastUltra", _actor.Id);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		summons.Clear();
	}

	protected override void OnInterrupt(int comboIndex)
	{
		GetSummons(ref summons, new List<int> { unmoveSummonId });
		liveCount = 0;
		for (int i = 0; i < summons.Count; i++)
		{
			if (!summons.get_Item(i).isDead)
			{
				liveCount++;
			}
			TSVector2 position = summons.get_Item(i).tsTransform.Position;
			summons.get_Item(i).ClearSelf();
			PlayEffect("fx_m70001_base_skill06_shunyi_out", 1f, 0.5, position);
		}
		liveCount = Math.Min(liveCount, summonPosList_Move.Count);
		for (int j = 0; j < liveCount; j++)
		{
			TSVector2 placeHolderPosition = GetPlaceHolderPosition(summonPosList_Move.get_Item(j));
			ILRuntimeAPI.SummonMonster(_actor, 0, (int)moveSummonIds.get_Item(j), placeHolderPosition, center - placeHolderPosition);
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, key_Base1, flushInputedKeys: true, forceInterruptAttack: true);
		StartCor(BookLogic());
		StartCor(AreaLogic());
		yield return WaitFrame(259);
		BeginAttack(2, key_Base2, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitFrame(101);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator BookLogic()
	{
		yield return WaitFrame(10);
		GetAllSummons(ref summons);
		foreach (MonsterAdventureActor summon in summons)
		{
			PlayEffect(position: summon.tsTransform.Position, fxAlias: "fx_m70001_base_skill06_shunyi_out", playbackSpeed: 1f, fxPositionY: 0.5);
			summon.ClearSelf();
		}
		yield return WaitFrame(3);
		for (int i = 0; i < summonPosList_Unmove.Count; i++)
		{
			TSVector2 placeHolderPosition = GetPlaceHolderPosition(summonPosList_Unmove.get_Item(i));
			ILRuntimeAPI.SummonMonster(_actor, 0, unmoveSummonId, placeHolderPosition, center - placeHolderPosition);
		}
		yield return WaitFrame(32);
		yield return WaitFrame(220);
		GetSummons(ref summons, new List<int> { unmoveSummonId });
		liveCount = 0;
		for (int j = 0; j < summons.Count; j++)
		{
			if (!summons.get_Item(j).isDead)
			{
				liveCount++;
			}
			TSVector2 position = summons.get_Item(j).tsTransform.Position;
			summons.get_Item(j).ClearSelf();
			PlayEffect("fx_m70001_base_skill06_shunyi_out", 1f, 0.5, position);
		}
		yield return WaitFrame(139);
		liveCount = Math.Min(liveCount, summonPosList_Move.Count);
		for (int k = 0; k < liveCount; k++)
		{
			TSVector2 placeHolderPosition2 = GetPlaceHolderPosition(summonPosList_Move.get_Item(k));
			ILRuntimeAPI.SummonMonster(_actor, 0, (int)moveSummonIds.get_Item(k), placeHolderPosition2, center - placeHolderPosition2);
		}
	}

	protected IEnumerator AreaLogic()
	{
		yield return WaitFrame(10);
		PlayAreaEffect(areaEffect_GravityField, center);
		PlayAreaEffect("Area_70001_Skill06_Tractor_1", center);
		yield return WaitFrame(254);
		GetAllSummons(ref summons);
		yield return WaitFrame(2);
		if (summons.Count > 0)
		{
			PlayAreaEffect(areaEffect_BigAccField, center);
		}
		else
		{
			PlayAreaEffect(areaEffect_AccField, center);
		}
		PlayAreaEffect("Area_70001_Skill06_Tractor_2", center);
	}

	private void GetSummons(ref List<MonsterAdventureActor> monsters, List<int> ids)
	{
		monsters.Clear();
		List<AdventureModuleController.MonsterSummonData> monsterSummonInfos = ModuleController<AdventureModuleController>.Instance.MonsterSummonInfos;
		for (int i = 0; i < monsterSummonInfos.Count; i++)
		{
			if (ids.Contains(monsterSummonInfos.get_Item(i).dataID))
			{
				LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(monsterSummonInfos.get_Item(i).entityID);
				if (logicEntity != null && logicEntity is MonsterAdventureActor item)
				{
					monsters.Add(item);
				}
			}
		}
	}

	private void GetAllSummons(ref List<MonsterAdventureActor> monsters)
	{
		monsters.Clear();
		List<AdventureModuleController.MonsterSummonData> monsterSummonInfos = ModuleController<AdventureModuleController>.Instance.MonsterSummonInfos;
		for (int i = 0; i < monsterSummonInfos.Count; i++)
		{
			if (monsterSummonInfos.get_Item(i).SummonActorID == _actor.Id)
			{
				LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(monsterSummonInfos.get_Item(i).entityID);
				if (logicEntity != null && logicEntity is MonsterAdventureActor item)
				{
					monsters.Add(item);
				}
			}
		}
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName.Equals(evt_Ultra))
		{
			DispatchCustomEvent(evt_Ultra, isSelfEvent: false);
		}
	}
}
