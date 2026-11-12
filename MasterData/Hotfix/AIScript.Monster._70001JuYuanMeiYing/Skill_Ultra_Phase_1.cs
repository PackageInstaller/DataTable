using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._70001JuYuanMeiYing;

public class Skill_Ultra_Phase_1 : SkillSimpleBase
{
	private string key_Base1 = "Stage2_Skill13_1";

	private string key_Base2 = "Stage2_Skill13_2";

	private string evt_Ultra = "evt_Ultra";

	private List<TSVector2> SquareCenters = new List<TSVector2>();

	private List<MonsterAdventureActor> monsters = new List<MonsterAdventureActor>();

	private int unmoveSummonId = 7010027;

	private List<string> summonPosList = new List<string> { "Jin_05", "Jin_06", "Jin_07", "Jin_08" };

	private MonsterAdventureActor Actor => _actor as MonsterAdventureActor;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		Actor.monsterInfo.currentEnergy = 0;
		MonoSingleton<LuaManager>.Instance.FireEntityEvent("JointDrillBossEnergyChanged", _actor.Id, 0, a2: false);
		MonoSingleton<LuaManager>.Instance.FireEntityEvent("CastUltra", _actor.Id);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		monsters.Clear();
		_actor.logicVariable.ToggleLogicTag("guild", value: false);
	}

	protected override void OnInterrupt(int comboIndex)
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
		foreach (MonsterAdventureActor monster in monsters)
		{
			PlayEffect(position: monster.tsTransform.Position, fxAlias: "fx_m70001_base_skill06_shunyi_out", playbackSpeed: 1f, fxPositionY: 0.5);
			monster.ClearSelf();
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, key_Base1, flushInputedKeys: true, forceInterruptAttack: true);
		StartCor(ClearSummonAndSpawn());
		yield return WaitFrame(46);
		yield return WaitFrame(227);
		BeginAttack(2, key_Base2, flushInputedKeys: true, forceInterruptAttack: true);
		if (GetBuffNum(_actor, 700010015) >= 3)
		{
			RemoveBuffFromTarget(_actor, 700010015);
			yield return WaitFrame(37);
			StartCor(LargeBoom());
		}
		else if (GetBuffNum(_actor, 700010015) >= 1)
		{
			RemoveBuffFromTarget(_actor, 700010015);
			MapCutSquareTo6();
			PlayAreaEffect("Area_70001_Skill13_MediumWarn", new TSVector2(0, -6));
			yield return WaitFrame(37);
			StartCor(MediumBoom());
		}
		else
		{
			RemoveBuffFromTarget(_actor, 700010015);
			MapCutSquareTo18();
			PlayAreaEffect("Area_70001_Skill13_SmallWarn", new TSVector2(0, -6));
			yield return WaitFrame(37);
			StartCor(SmallBoom());
		}
		yield return WaitFrame(6);
		yield return WaitFrame(180);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private IEnumerator ClearSummonAndSpawn()
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
		foreach (MonsterAdventureActor monster in monsters)
		{
			PlayEffect(position: monster.tsTransform.Position, fxAlias: "fx_m70001_base_skill06_shunyi_out", playbackSpeed: 1f, fxPositionY: 0.5);
			monster.ClearSelf();
		}
		yield return WaitFrame(1);
		_actor.logicVariable.ToggleLogicTag("guild", value: true);
		for (int j = 0; j < summonPosList.Count; j++)
		{
			TSVector2 placeHolderPosition = GetPlaceHolderPosition(summonPosList.get_Item(j));
			ILRuntimeAPI.SummonMonster(_actor, 0, unmoveSummonId, placeHolderPosition, GetPosition() - placeHolderPosition);
		}
	}

	protected IEnumerator LargeBoom()
	{
		PlayAreaEffect("Area_70001_Skill13_HugeDot", new TSVector2(0, -6));
		yield return WaitFrame(90);
		PlayAreaEffect("Area_70001_Skill13_HugeBoom", new TSVector2(0, -6));
	}

	private void MapCutSquareTo6()
	{
		SquareCenters.Clear();
		for (int i = 0; i < 2; i++)
		{
			for (int j = 0; j < 3; j++)
			{
				int num = -12 + j * 8 + 4;
				int num2 = -12 + i * 6 + 3;
				SquareCenters.Add(new TSVector2(num, num2));
			}
		}
	}

	protected IEnumerator MediumBoom()
	{
		for (int i = 0; i < 5; i++)
		{
			if (i == 1 || i == 4)
			{
				TSVector2 tSVector = SquareCenters.get_Item(0);
				SquareCenters.get_Item(1);
				TSVector2 entityPosition = GetEntityPosition(GetCurrentPlayer());
				FP fP = Distance(entityPosition, tSVector);
				for (int j = 0; j < SquareCenters.Count; j++)
				{
					FP fP2 = Distance(entityPosition, SquareCenters.get_Item(j));
					if (fP2 <= fP)
					{
						fP = fP2;
						tSVector = SquareCenters.get_Item(j);
					}
				}
				List<TSVector2> list = new List<TSVector2>(SquareCenters);
				list.Remove(tSVector);
				TSVector2 position = list.get_Item(TSRandom.Range(0, list.Count));
				PlayAreaEffect("Area_70001_Skill13_MediumBoom", tSVector);
				PlayAreaEffect("Area_70001_Skill13_MediumBoom", position);
			}
			else
			{
				List<TSVector2> list2 = new List<TSVector2>();
				List<TSVector2> list3 = new List<TSVector2>();
				int num = 0;
				TSVector2 tSVector2;
				TSVector2 tSVector3;
				do
				{
					tSVector2 = SquareCenters.get_Item(TSRandom.Range(0, SquareCenters.Count));
					tSVector3 = SquareCenters.get_Item(TSRandom.Range(0, SquareCenters.Count));
					if (tSVector2 == tSVector3)
					{
						List<TSVector2> list4 = new List<TSVector2>(SquareCenters);
						list4.Remove(tSVector3);
						tSVector3 = list4.get_Item(TSRandom.Range(0, list4.Count));
					}
					list2.Clear();
					list2.Add(tSVector2);
					list2.Add(tSVector3);
					num++;
				}
				while (MediumBoomThanOneSame(list2, list3) && num <= 10);
				PlayAreaEffect("Area_70001_Skill13_MediumBoom", tSVector2);
				PlayAreaEffect("Area_70001_Skill13_MediumBoom", tSVector3);
				list3.Clear();
				list3.Add(tSVector2);
				list3.Add(tSVector3);
			}
			yield return WaitFrame(30);
		}
		PlayAreaEffect("Area_70001_Skill13_CenterBoom", new TSVector2(0, -6));
	}

	protected bool MediumBoomThanOneSame(List<TSVector2> New, List<TSVector2> Last)
	{
		int num = 0;
		foreach (TSVector2 item in New)
		{
			if (Last.Contains(item))
			{
				num++;
			}
		}
		return num > 1;
	}

	private void MapCutSquareTo18()
	{
		SquareCenters.Clear();
		for (int i = 0; i < 3; i++)
		{
			for (int j = 0; j < 6; j++)
			{
				int num = -12 + j * 4 + 2;
				int num2 = -12 + i * 4 + 2;
				SquareCenters.Add(new TSVector2(num, num2));
			}
		}
	}

	protected IEnumerator SmallBoom()
	{
		for (int i = 0; i < 5; i++)
		{
			List<TSVector2> list = new List<TSVector2>();
			List<TSVector2> list2 = new List<TSVector2>();
			int num = 0;
			do
			{
				List<TSVector2> list3 = new List<TSVector2>(SquareCenters);
				list.Clear();
				for (int j = 0; j < 14; j++)
				{
					TSVector2 item = SquareCenters.get_Item(TSRandom.Range(0, SquareCenters.Count));
					list3.Remove(item);
					list.Add(item);
				}
				num++;
			}
			while (SmallBoomThanOneSame(list, list2) && num <= 10);
			for (int k = 0; k < 14; k++)
			{
				PlayAreaEffect("Area_70001_Skill13_SmallBoom", list.get_Item(k));
			}
			list2.Clear();
			new List<TSVector2>(list);
			yield return WaitFrame(30);
		}
		PlayAreaEffect("Area_70001_Skill13_CenterBoom", new TSVector2(0, -6));
	}

	protected bool SmallBoomThanOneSame(List<TSVector2> New, List<TSVector2> Last)
	{
		int num = 0;
		foreach (TSVector2 item in New)
		{
			if (Last.Contains(item))
			{
				num++;
			}
		}
		return num > 8;
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName.Equals(evt_Ultra))
		{
			DispatchCustomEvent(evt_Ultra, isSelfEvent: false);
		}
	}
}
