using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._72001ShuangZiQi;

public class Skill_ParabolaArtillery : SkillSimpleBase
{
	private class MineInfo
	{
		public long effectId;

		public int mergeCount;

		public long mineBeginBlasteffectId;
	}

	private int maxMergeCount = 3;

	private List<string> mineFXName = new List<string> { "fx_m72004_loop_mine", "fx_m72004_loop_mine2", "fx_m72004_loop_mine3", "fx_m72004_loop_mine4", "fx_m72004_loop_mine5" };

	private List<string> mineBeginBlastFXName = new List<string> { "fx_m72004_loop_atk2_landmine_02_1", "fx_m72004_loop_atk2_landmine_02_2", "fx_m72004_loop_atk2_landmine_02_3", "fx_m72004_loop_atk2_landmine_02_4", "fx_m72004_loop_atk2_landmine_02_5" };

	private List<string> mineExplodeAreaEffect = new List<string> { "AreaEffect_72001_MineAttack", "AreaEffect_72001_MineAttack_Lv2", "AreaEffect_72001_MineAttack_Lv3" };

	private int bulletTag = CommonHelper.StringToHash("TriggerMine");

	private List<TSVector2> AttackExpansionList_1 = new List<TSVector2>
	{
		new TSVector2(0, 1),
		new TSVector2(0, -1),
		new TSVector2(1, 0),
		new TSVector2(-1, 0)
	};

	private List<TSVector2> AttackExpansionList_2 = new List<TSVector2>
	{
		new TSVector2(1, 1),
		new TSVector2(1, -1),
		new TSVector2(-1, -1),
		new TSVector2(-1, 1)
	};

	private FP FXExpansionPerMerge = 0.2;

	private bool isRed;

	private int phase;

	private int lv;

	private int spawnCount;

	private int summonCount;

	private int aliveBulletCount;

	private int SummonMonsterID;

	private string Color;

	private long AttackStart;

	private List<LogicEntity> monsters = new List<LogicEntity>();

	private List<LogicEntity> extraMonsters = new List<LogicEntity>();

	private Dictionary<int, MineInfo> _mineDict = new Dictionary<int, MineInfo>();

	private Dictionary<int, long> MineToWarningFX = new Dictionary<int, long>();

	private List<int> alreadyHitGrids = new List<int>();

	private List<long> alreadyHitFXs = new List<long>();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_STATE_SWITCH", OnActorStateSwitch);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_BORN", OnBulletBorn);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
		summonCount = 0;
		spawnCount = 0;
		aliveBulletCount = 0;
		alreadyHitGrids = new List<int>();
		monsters.Clear();
		extraMonsters.Clear();
		_mineDict.Clear();
		MineToWarningFX.Clear();
		isRed = GetLogicTagToggleValue(_actor, "Red");
		phase = GetLogicTagFpValue(_actor, "Phase").AsInt();
		lv = GetLogicTagFpValue(_actor, "Level").AsInt();
		if (isRed)
		{
			Color = "Red";
		}
		else
		{
			Color = "Green";
		}
		SummonMonsterID = GetTeammateIdByIndex(2);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_STATE_SWITCH", OnActorStateSwitch);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_BORN", OnBulletBorn);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		SetLogicTagToggleValue(_actor, Config.Skill_Artillery2_Finish, value: true);
		foreach (KeyValuePair<int, MineInfo> item in _mineDict)
		{
			StopEffect(item.Value.effectId);
		}
		foreach (long alreadyHitFX in alreadyHitFXs)
		{
			StopEffect(alreadyHitFX);
		}
		_mineDict.Clear();
		monsters.Clear();
		extraMonsters.Clear();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, "SummonArtillery", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("SummonStart");
		List<TSVector2> list = new List<TSVector2>();
		List<TSVector2> list2 = new List<TSVector2>();
		if (phase <= 2)
		{
			List<TSVector2> list3 = (isRed ? Config.RedArtillery1PositionList.get_Item(0) : Config.GreenArtillery1PositionList.get_Item(0));
			TSVector2 item = (isRed ? TSVector2.right : TSVector2.left);
			for (int i = 0; i < list3.Count; i++)
			{
				list.Add(list3.get_Item(i));
				list2.Add(item);
			}
			if (lv >= 3)
			{
				List<TSVector2> list4 = (isRed ? Config.RedArtillery1PositionList.get_Item(1) : Config.GreenArtillery1PositionList.get_Item(1));
				for (int j = 0; j < list4.Count; j++)
				{
					list.Add(list4.get_Item(j));
					list2.Add(item);
				}
			}
		}
		else
		{
			FP logicTagFpValue = GetLogicTagFpValue(_actor, "ArtilleryCastTime");
			List<TSVector2> list5 = (isRed ? Config.RedArtillery1PositionList_P3.get_Item(0) : Config.GreenArtillery1PositionList_P3.get_Item(0));
			TSVector2 item2 = (isRed ? TSVector2.right : TSVector2.left);
			for (int k = 0; k < list5.Count; k++)
			{
				list.Add(list5.get_Item(k));
				list2.Add(item2);
			}
			if (logicTagFpValue != 0)
			{
				List<TSVector2> list6 = (isRed ? Config.RedArtillery1PositionList_P3.get_Item(1) : Config.GreenArtillery1PositionList_P3.get_Item(1));
				TSVector2 item3 = (isRed ? TSVector2.left : TSVector2.right);
				for (int l = 0; l < list6.Count; l++)
				{
					list.Add(list6.get_Item(l));
					list2.Add(item3);
				}
			}
			SetLogicTagFpValue(_actor, "ArtilleryCastTime", logicTagFpValue + 1);
		}
		summonCount = list.Count;
		for (int m = 0; m < list.Count; m++)
		{
			TSVector2 cellPosByIndex = Config.GetCellPosByIndex(list.get_Item(m));
			TSVector2 dir = list2.get_Item(m);
			ILRuntimeAPI.SummonMonster(_actor, 0, SummonMonsterID, cellPosByIndex, dir, null, null, (MonsterAdventureActor monster) =>
			{
				SetLogicTagToggleValue(monster, "Red", isRed);
				SetLogicTagFpValue(monster, "Phase", phase);
				SetLogicTagFpValue(monster, "Level", lv);
				monsters.Add(monster);
			});
		}
		yield return WaitUntil(() => spawnCount >= summonCount);
		FP interval = ((phase >= 2) ? Config.Artillery1AttackInterval_P2 : Config.Artillery1AttackInterval);
		for (int i2 = 0; i2 < monsters.Count; i2++)
		{
			DispatchAtkCmd(monsters.get_Item(i2), Config.artillery1AtkEvt);
			yield return WaitTime(interval);
		}
		if (lv >= 3 && phase >= 2)
		{
			LogicEntity player = GetCurrentPlayer();
			yield return WaitTime(interval);
			Skill_ParabolaArtillery skill_ParabolaArtillery = this;
			Skill_ParabolaArtillery skill_ParabolaArtillery2 = this;
			TSVector2 position = GetPosition();
			FP rotation = GetRotation();
			skill_ParabolaArtillery.AttackStart = skill_ParabolaArtillery2.PlayEffect("Skill02_Start", 1f, default, position, rotation);
			yield return WaitTime(1);
			for (int i2 = 0; i2 < 3; i2++)
			{
				TSVector2 curIndexByPos = Config.GetCurIndexByPos(player.tsTransform.Position);
				TSVector2 cellPosByIndex2 = Config.GetCellPosByIndex(curIndexByPos.x.AsInt(), curIndexByPos.y.AsInt());
				Skill_ParabolaArtillery skill_ParabolaArtillery3 = this;
				TSVector2 position2 = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 5));
				FP positionY = 1.8;
				FP range = 0;
				position = cellPosByIndex2;
				skill_ParabolaArtillery3.Shoot("Weapon_72001ShuangZiQi_Parabola", position2, positionY, range, default, AimType.Position, BulletDirectionType.BulletToTarget, position);
				yield return WaitTime(1);
			}
			StopEffect(AttackStart);
		}
		yield return WaitUntil(() => summonCount <= 0 && aliveBulletCount <= 0);
		foreach (long alreadyHitFX in alreadyHitFXs)
		{
			StopEffect(alreadyHitFX);
		}
		foreach (KeyValuePair<int, MineInfo> item4 in _mineDict)
		{
			StartCor(MineBlast(item4));
		}
		foreach (int alreadyHitGrid in alreadyHitGrids)
		{
			PlayAreaEffect(mineExplodeAreaEffect.get_Item(_mineDict.get_Item(alreadyHitGrid).mergeCount), Config.GetCellPosByIndex(alreadyHitGrid));
		}
		_mineDict.Clear();
		alreadyHitFXs.Clear();
		yield return WaitTime(2);
	}

	protected override void OnActorDied(IEvent evt)
	{
		base.OnActorDied(evt);
		if (evt is AdventureActorDiedEvent adventureActorDiedEvent && adventureActorDiedEvent.actor.dataID == SummonMonsterID)
		{
			summonCount--;
		}
	}

	private void OnActorStateSwitch(IEvent evt)
	{
		if (evt is AdventureActorStateSwitchEvent adventureActorStateSwitchEvent && adventureActorStateSwitchEvent.dataId == SummonMonsterID && adventureActorStateSwitchEvent._acState == ActorState.Action)
		{
			spawnCount++;
		}
	}

	private void OnBulletBorn(IEvent evt)
	{
		if (evt is AdventureBulletBornEvent adventureBulletBornEvent && adventureBulletBornEvent.bulletHashCode == bulletTag)
		{
			aliveBulletCount++;
		}
	}

	private void OnBulletFinish(IEvent evt)
	{
		if (evt is AdventureBulletFinishEvent adventureBulletFinishEvent && adventureBulletFinishEvent.bulletHashCode == bulletTag)
		{
			aliveBulletCount--;
			if (adventureBulletFinishEvent.finishReason != BulletFinishReason.Kill)
			{
				int cellIndexByPos = Config.GetCellIndexByPos(adventureBulletFinishEvent.bulletPosition);
				AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
				adventureActorCustomEvent.sender = _actor;
				adventureActorCustomEvent.actor = _actor;
				adventureActorCustomEvent.eventHashCode = Config.artillery1BulletHitEvt;
				adventureActorCustomEvent.intParam = cellIndexByPos;
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent);
			}
		}
	}

	private void OnCustomEvent(IEvent evt)
	{
		if (!(evt is AdventureActorCustomEvent adventureActorCustomEvent) || adventureActorCustomEvent.eventHashCode != Config.artillery1BulletHitEvt || adventureActorCustomEvent.actor != _actor)
		{
			return;
		}
		int intParam = adventureActorCustomEvent.intParam;
		TSVector2 cellPosByIndex = Config.GetCellPosByIndex(intParam);
		if (_mineDict.TryGetValue(intParam, out var value))
		{
			if (value.mergeCount < maxMergeCount - 1)
			{
				StartCor(MineUpgradeFXplay(intParam, value.effectId));
				value.mergeCount++;
				MineInfo mineInfo = value;
				string fxAlias = mineFXName.get_Item(value.mergeCount);
				TSVector2 position = cellPosByIndex;
				float spawnSize = (float)(1 + (float)value.mergeCount * FXExpansionPerMerge);
				mineInfo.effectId = PlayEffect(fxAlias, 1f, default, position, default, spawnSize);
				StopEffect(MineToWarningFX.get_Item(intParam));
				double num = 0.83 * (1.0 + (double)value.mergeCount * 0.5);
				position = cellPosByIndex;
				spawnSize = (float)num;
				long num2 = PlayEffect("fx_m72004_loop_warning_1", 1f, default, position, default, spawnSize);
				MineToWarningFX.set_Item(intParam, num2);
				alreadyHitFXs.Add(num2);
			}
		}
		else
		{
			string fxAlias2 = mineFXName.get_Item(0);
			TSVector2 position = cellPosByIndex;
			long effectId = PlayEffect(fxAlias2, 1f, default, position);
			_mineDict.set_Item(intParam, new MineInfo
			{
				effectId = effectId,
				mergeCount = 0
			});
			alreadyHitGrids.Add(intParam);
			double num3 = 0.83;
			position = cellPosByIndex;
			float spawnSize = (float)num3;
			long num4 = PlayEffect("fx_m72004_loop_warning_1", 1f, default, position, default, spawnSize);
			MineToWarningFX.set_Item(intParam, num4);
			alreadyHitFXs.Add(num4);
		}
	}

	private void DispatchAtkCmd(LogicEntity target, int eventHash)
	{
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _actor;
		adventureActorCustomEvent.actor = _actor;
		adventureActorCustomEvent.eventHashCode = eventHash;
		adventureActorCustomEvent.target = target;
		_actor.DispatchEvent(adventureActorCustomEvent);
	}

	private IEnumerator MineUpgradeFXplay(int gridIndex, long effectid)
	{
		TSVector2 cellPosByIndex = Config.GetCellPosByIndex(gridIndex);
		Skill_ParabolaArtillery skill_ParabolaArtillery = this;
		TSVector2 position = cellPosByIndex;
		skill_ParabolaArtillery.PlayEffect("fx_m72004_base_atk2_landmine_level_up", 1f, default, position);
		yield return WaitFrame(3);
		StopEffect(effectid);
	}

	private IEnumerator MineBlast(KeyValuePair<int, MineInfo> kvp)
	{
		MineInfo value = kvp.Value;
		Skill_ParabolaArtillery skill_ParabolaArtillery = this;
		string fxAlias = mineBeginBlastFXName.get_Item(kvp.Value.mergeCount);
		TSVector2 cellPosByIndex = Config.GetCellPosByIndex(kvp.Key);
		float spawnSize = (float)(1 + (float)kvp.Value.mergeCount * FXExpansionPerMerge);
		value.mineBeginBlasteffectId = skill_ParabolaArtillery.PlayEffect(fxAlias, 1f, default, cellPosByIndex, default, spawnSize);
		StopEffect(kvp.Value.effectId);
		yield return WaitTime(1.4);
		StopEffect(kvp.Value.mineBeginBlasteffectId);
		Skill_ParabolaArtillery skill_ParabolaArtillery2 = this;
		cellPosByIndex = Config.GetCellPosByIndex(kvp.Key);
		spawnSize = (float)(1 + (float)kvp.Value.mergeCount * FXExpansionPerMerge);
		skill_ParabolaArtillery2.PlayEffect("fx_m72004_base_atk2_landmine_explosion", 1f, default, cellPosByIndex, default, spawnSize);
	}
}
