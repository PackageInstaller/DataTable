using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._72001ShuangZiQi;

public class Skill_Artillery : SkillSimpleBase
{
	private bool isRed;

	private bool isAtk;

	private int phase;

	private int lv;

	private int spawnCount;

	private int summonCount;

	private int SummonMonsterID;

	private int SummonBallID;

	private List<LogicEntity> monsters = new List<LogicEntity>();

	private long AttackStart;

	private string Color;

	private FP ShootAmount;

	private FP ShootAngle;

	private int BulletAmount;

	private bool IsUpgrade;

	private List<int> SuccessIndexes;

	private List<TSVector2> summonPosList;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_STATE_SWITCH", OnActorStateSwitch);
		summonCount = 0;
		spawnCount = 0;
		IsUpgrade = false;
		isRed = GetLogicTagToggleValue(_actor, "Red");
		phase = GetLogicTagFpValue(_actor, "Phase").AsInt();
		lv = GetLogicTagFpValue(_actor, "Level").AsInt();
		SuccessIndexes = new List<int>();
		summonPosList = new List<TSVector2>();
		SummonMonsterID = GetTeammateIdByIndex(2);
		SummonBallID = GetTeammateIdByIndex(5);
		BulletAmount = ((lv <= 2) ? Config.BulletAmountBase_ez : Config.BulletAmountBase_hd);
		ShootAngle = ((lv <= 2) ? Config.ShootAngle_ez : Config.ShootAngle_hd);
		ShootAmount = Config.ShootAmountBase;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_STATE_SWITCH", OnActorStateSwitch);
		SetLogicTagToggleValue(_actor, Config.Skill_Artillery_Finish, value: true);
		monsters.Clear();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, "SummonArtillery", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("SummonStart");
		if (phase == 3 && GetLogicTagFpValue(_actor, "ArtilleryCastTime") != 0)
		{
			summonPosList = (isRed ? Config.RedArtilleryPositionList.get_Item(4) : Config.GreenArtilleryPositionList.get_Item(4));
		}
		else
		{
			summonPosList = (isRed ? Config.RedArtilleryPositionList.get_Item(phase) : Config.GreenArtilleryPositionList.get_Item(phase));
		}
		summonCount = summonPosList.Count;
		for (int i = 0; i < summonPosList.Count; i++)
		{
			TSVector2 cellPosByIndex = Config.GetCellPosByIndex(summonPosList.get_Item(i));
			TSVector2 dir = (isRed ? TSVector2.right : TSVector2.left);
			if (phase >= 3 && ((isRed && summonPosList.get_Item(i).x == 4) || (!isRed && summonPosList.get_Item(i).x == 0)))
			{
				dir *= (FP)(-1);
			}
			ILRuntimeAPI.SummonMonster(_actor, 0, GetTeammateIdByIndex(2), cellPosByIndex, dir, null, null, (MonsterAdventureActor monster) =>
			{
				SetLogicTagToggleValue(monster, "Attack", isAtk);
				SetLogicTagToggleValue(monster, "Red", isRed);
				SetLogicTagFpValue(monster, "Phase", phase);
				SetLogicTagFpValue(monster, "Level", lv);
				monsters.Add(monster);
			});
		}
		yield return WaitUntil(() => spawnCount >= summonCount);
		DispatchAtkCmd(monsters.get_Item(0));
		DispatchAtkCmd(monsters.get_Item(1));
		if (phase >= 3 && GetLogicTagFpValue(_actor, "ArtilleryCastTime") != 0)
		{
			yield return WaitTime(Config.ArtilleryShootDurationBase);
			DispatchAtkCmd(monsters.get_Item(2));
			DispatchAtkCmd(monsters.get_Item(3));
		}
		if ((lv <= 2 && phase >= 2) || lv >= 3)
		{
			if (lv < 3 || phase < 2)
			{
				yield return WaitTime(Config.ArtilleryShootDurationBase + 1.3);
			}
			if (lv >= 3)
			{
				Skill_Artillery skill_Artillery = this;
				TSVector2 position = GetPosition();
				FP rotation = GetRotation();
				skill_Artillery.PlayEffect("skill02_scan", 1f, default, position, rotation, 1f, actorScale: true);
				int num = CalExtraShootCount();
				if (phase >= 3 && num < 2)
				{
					num = 2;
				}
				ShootAmount += (FP)num;
				yield return WaitTime(0.7);
				foreach (int successIndex in SuccessIndexes)
				{
					TSVector2 cellPosByIndex2 = Config.GetCellPosByIndex(successIndex);
					Skill_Artillery skill_Artillery2 = this;
					position = cellPosByIndex2;
					skill_Artillery2.PlayEffect("light_5x5", 1f, default, position);
				}
				yield return WaitTime(0.6);
				IsUpgrade = true;
			}
			else
			{
				yield return WaitTime(1.3);
			}
			if (IsUpgrade)
			{
				Skill_Artillery skill_Artillery3 = this;
				Skill_Artillery skill_Artillery4 = this;
				TSVector2 position = GetPosition();
				FP rotation = GetRotation();
				skill_Artillery3.AttackStart = skill_Artillery4.PlayEffect("Skill02_Start_Plus", 1f, default, position, rotation);
			}
			else
			{
				Skill_Artillery skill_Artillery5 = this;
				Skill_Artillery skill_Artillery6 = this;
				TSVector2 position = GetPosition();
				FP rotation = GetRotation();
				skill_Artillery5.AttackStart = skill_Artillery6.PlayEffect("Skill02_Start", 1f, default, position, rotation);
			}
			int shootCount = 0;
			while (shootCount < ShootAmount)
			{
				PlayMultiLineWarning(GetForward(), ShootAngle, BulletAmount);
				yield return WaitTime(0.75);
				FanMultipleShoot("Weapon_72001ShuangZiQi", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, BulletAmount, 0, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 5)), 1.8, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, ShootAngle, 0, 0);
				shootCount++;
				BulletAmount++;
				yield return WaitTime(0.45);
			}
			StopEffect(AttackStart);
		}
		if (phase != 2)
		{
			yield return WaitUntil(() => summonCount <= 0);
		}
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

	private void DispatchAtkCmd(LogicEntity target)
	{
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _actor;
		adventureActorCustomEvent.actor = _actor;
		adventureActorCustomEvent.eventHashCode = Config.artilleryAtkEvt;
		adventureActorCustomEvent.target = target;
		_actor.DispatchEvent(adventureActorCustomEvent);
	}

	private int CalExtraShootCount()
	{
		int num = 0;
		List<long> logicTagListLongValue = GetLogicTagListLongValue(_actor, "MapGrids_Color");
		GridColor gridColor = (isRed ? GridColor.Red : GridColor.Green);
		int y = (isRed ? Config.redBossPos : Config.greenBossPos).y.AsInt();
		for (int i = 1; i < Config.cellCount - 1; i++)
		{
			int num2 = ((!isRed) ? Config.GetCellIndexByIndex(4 - i, y) : Config.GetCellIndexByIndex(i, y));
			if (logicTagListLongValue.get_Item(num2) == (long)gridColor)
			{
				num++;
				SuccessIndexes.Add(num2);
			}
		}
		return num;
	}

	private void PlayMultiLineWarning(TSVector2 warningdirection, FP warningAngle, int warningCount)
	{
		FP tSVectToAngle = GetTSVectToAngle(warningdirection, warningAngle / 2);
		for (int i = 0; i < warningCount; i++)
		{
			TSVector2 position = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 4.5));
			FP angle = tSVectToAngle;
			PlayEarlyWarningEffect("fx_warning_dash_0_5x20", 0.75f, default, position, angle);
			tSVectToAngle -= warningAngle / (warningCount - 1);
		}
	}
}
