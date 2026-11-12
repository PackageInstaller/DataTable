using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._72001ShuangZiQi;

public class Skill_Attack_General : SkillSimpleBase
{
	private bool isRed;

	private string Color;

	private string AttackFX_Start;

	private string DaoGuangFX;

	private string FirstAreaEffect;

	private string OtherAreaEffect;

	private string ChargeFX;

	private int phase;

	private int lv;

	private TSVector2 targetPosIndex;

	private LogicEntity Master;

	private Queue<LogicEntity> queue = new Queue<LogicEntity>();

	private int totalCount;

	private FP SoldierCountForEach;

	private int SummonBallID;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		isRed = GetLogicTagToggleValue(_actor, "Red");
		phase = GetLogicTagFpValue(_actor, "Phase").AsInt();
		lv = GetLogicTagFpValue(_actor, "Level").AsInt();
		SoldierCountForEach = GetLogicTagFpValue(_actor, "SoldierCount");
		if (phase <= 2)
		{
			List<LogicEntity> targetByTeammateIndex = GetTargetByTeammateIndex(0);
			if (targetByTeammateIndex.Count == 0)
			{
				InterruptSkill();
				return;
			}
			Master = targetByTeammateIndex.get_Item(0);
		}
		else
		{
			List<LogicEntity> targetByTeammateIndex2 = GetTargetByTeammateIndex(7);
			if (targetByTeammateIndex2.Count == 0)
			{
				InterruptSkill();
				return;
			}
			Master = targetByTeammateIndex2.get_Item(0);
		}
		ChessInitialize();
		SummonBallID = GetTeammateIdByIndex(5);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		queue.Clear();
	}

	protected override IEnumerator DoMainLogic()
	{
		if (phase < 3)
		{
			int curCount = 0;
			while (curCount < SoldierCountForEach)
			{
				if (queue.Count > 0)
				{
					LogicEntity target = queue.Dequeue();
					curCount++;
					SetLogicTagToggleValue(_actor, "SingleAttack", curCount % 2 != 0);
					TSVector2 curIndexByPos = Config.GetCurIndexByPos(target.tsTransform.Position);
					TSVector2 targetPos = Config.GetCellPosByIndex(curIndexByPos.x.AsInt(), curIndexByPos.y.AsInt());
					targetPosIndex = curIndexByPos;
					SetLogicTagTSVector2Value(_actor, "NextTargetPosition", targetPos);
					TSVector2 curIndexByPos2 = Config.GetCurIndexByPos(_actor.tsTransform.Position);
					TSVector2 cellPosByIndex = Config.GetCellPosByIndex(curIndexByPos2.x.AsInt(), curIndexByPos2.y.AsInt());
					FP distance = TSVector2.Distance(cellPosByIndex, targetPos);
					BeginAttack(1, "Attack", flushInputedKeys: true, forceInterruptAttack: true);
					Skill_Attack_General skill_Attack_General = this;
					string attackFX_Start = AttackFX_Start;
					TSVector2 position = GetPosition();
					FP angle = 0;
					skill_Attack_General.PlayEffect(attackFX_Start, 1f, default, position, angle);
					BeginLookAtByPos_NotWait(targetPos, 0.25, 999);
					yield return WaitCustomEvent("WarningFX");
					Skill_Attack_General skill_Attack_General2 = this;
					position = targetPos;
					angle = 0;
					skill_Attack_General2.PlayEarlyWarningEffect("fx_warning_square_4side_5x5", 1f, default, position, angle);
					yield return WaitCustomEvent("Jump");
					SetCloseBlockEnable();
					CrossJump(targetPos, distance / 0.55, 0);
					yield return WaitCustomEvent("DaoGuangFX");
					Skill_Attack_General skill_Attack_General3 = this;
					string daoGuangFX = DaoGuangFX;
					position = GetPosition();
					angle = GetRotation();
					skill_Attack_General3.PlayEffect(daoGuangFX, 1f, default, position, angle);
					yield return WaitCustomEvent("HitFrame");
					PlayAreaEffect(FirstAreaEffect, GetPosition(), 0);
					(target as AdventureActor)?.DestroySelf();
					yield return WaitTime(0.1);
					SetCloseBlockDisable();
					yield return WaitCombo(ComboAttackType.isComboFinish);
				}
				else
				{
					yield return null;
				}
			}
		}
		else
		{
			int curCount = 0;
			while (curCount < SoldierCountForEach)
			{
				while (!GetLogicTagToggleValue(_actor, "GeneralToAttackP3"))
				{
					yield return null;
				}
				SetLogicTagToggleValue(_actor, "GeneralToAttackP3", value: false);
				curCount++;
				SetLogicTagToggleValue(_actor, "SingleAttack", curCount % 2 != 0);
				TSVector2 targetPos = GetLogicTagTSVector2Value(_actor, "GeneralAttackPositionP3");
				TSVector2 curIndexByPos3 = Config.GetCurIndexByPos(_actor.tsTransform.Position);
				TSVector2 curPos = Config.GetCellPosByIndex(curIndexByPos3.x.AsInt(), curIndexByPos3.y.AsInt());
				FP distance = TSVector2.Distance(curPos, targetPos);
				targetPosIndex = Config.GetCurIndexByPos(targetPos);
				Skill_Attack_General skill_Attack_General4 = this;
				TSVector2 position = targetPos;
				FP angle = 0;
				skill_Attack_General4.PlayEarlyWarningEffect("fx_warning_square_4side_5x5", 2f, default, position, angle);
				BeginAttack(1, "Attack", flushInputedKeys: true, forceInterruptAttack: true);
				Skill_Attack_General skill_Attack_General5 = this;
				string attackFX_Start2 = AttackFX_Start;
				position = GetPosition();
				angle = 0;
				skill_Attack_General5.PlayEffect(attackFX_Start2, 1f, default, position, angle);
				yield return WaitTime(0.5);
				BeginLookAtByPos_NotWait(targetPos, 0.25, 999);
				yield return WaitCustomEvent("Jump");
				SetCloseBlockEnable();
				BeginDash(1, targetPos - curPos, distance / 0.55, distance, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
				yield return WaitCustomEvent("DaoGuangFX");
				Skill_Attack_General skill_Attack_General6 = this;
				string daoGuangFX2 = DaoGuangFX;
				position = GetPosition();
				angle = GetRotation();
				skill_Attack_General6.PlayEffect(daoGuangFX2, 1f, default, position, angle);
				yield return WaitCustomEvent("HitFrame");
				PlayAreaEffect(FirstAreaEffect, GetPosition(), 0);
				RanSe(Config.GetCurIndexByPos(GetPosition()));
				yield return WaitTime(0.1);
				SetCloseBlockDisable();
				yield return WaitCombo(ComboAttackType.isComboFinish);
			}
		}
		yield return WaitTime(0.5);
		_actor.DestroySelf();
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		base.OnCustomEvent(comboIndex, eventName);
		if (!eventName.Equals("HitFrame"))
		{
			return;
		}
		int num = targetPosIndex.x.AsInt();
		int num2 = targetPosIndex.y.AsInt();
		if (CheckTargetIsValid(Master))
		{
			List<long> logicTagListLongValue = GetLogicTagListLongValue(Master, "MapGrids_Color");
			int cellIndexByIndex = Config.GetCellIndexByIndex(num, num2);
			bool isSelfColor = (isRed ? (logicTagListLongValue.get_Item(cellIndexByIndex) == 1) : (logicTagListLongValue.get_Item(cellIndexByIndex) == 2));
			if (GetLogicTagToggleValue(_actor, "SingleAttack") || lv <= 2)
			{
				Attack_1(num, num2, isSelfColor);
			}
			else
			{
				Attack_2(num, num2, isSelfColor);
			}
		}
	}

	private void Attack_1(int curX, int curY, bool isSelfColor)
	{
		bool num = (lv >= 3 && phase < 3) & isSelfColor;
		int num2 = (num ? Config.cellCount : 3);
		int num3 = (num ? Config.cellCount : 3);
		int num4 = ((!num) ? (curX - 1) : 0);
		int num5 = ((!num) ? (curY - 1) : 0);
		ExtraAttack(new TSVector2(curX, curY));
		if (num)
		{
			string chargeFX = ChargeFX;
			TSVector2 position = GetPosition();
			FP angle = 0;
			PlayEffect(chargeFX, 1f, default, position, angle);
		}
		for (int i = num4; i < num4 + num2; i++)
		{
			for (int j = num5; j < num5 + num3; j++)
			{
				if (i != curX && j != curY)
				{
					int num6 = (j - curY) / (i - curX);
					int num7 = (j - curY) % (i - curX);
					if ((num6 == -1 || num6 == 1) && num7 == 0)
					{
						TSVector2 index = new TSVector2(i, j);
						ExtraAttack(index);
					}
				}
			}
		}
	}

	private void Attack_2(int curX, int curY, bool isSelfColor)
	{
		bool num = (lv >= 3 && phase < 3) & isSelfColor;
		int num2 = (num ? Config.cellCount : 3);
		int num3 = (num ? Config.cellCount : 3);
		int num4 = ((!num) ? (curX - 1) : 0);
		int num5 = ((!num) ? (curY - 1) : 0);
		ExtraAttack(new TSVector2(curX, curY));
		if (num)
		{
			string chargeFX = ChargeFX;
			TSVector2 position = GetPosition();
			FP angle = 0;
			PlayEffect(chargeFX, 1f, default, position, angle);
		}
		for (int i = num4; i < num4 + num2; i++)
		{
			for (int j = num5; j < num5 + num3; j++)
			{
				if ((i != curX || j != curY) && (i == curX || j == curY))
				{
					TSVector2 index = new TSVector2(i, j);
					ExtraAttack(index);
				}
			}
		}
	}

	private void ExtraAttack(TSVector2 index)
	{
		if (!Config.IsOutOfRange(index))
		{
			TSVector2 cellPosByIndex = Config.GetCellPosByIndex(index);
			PlayAreaEffect(OtherAreaEffect, cellPosByIndex);
			RanSe(index);
		}
	}

	private void OnCustomEvent(IEvent evt)
	{
		AdventureActorCustomEvent adventureActorCustomEvent = evt as AdventureActorCustomEvent;
		if (adventureActorCustomEvent.eventHashCode == Config.soldierSpawnEvt)
		{
			if (phase <= 2)
			{
				queue.Enqueue(adventureActorCustomEvent.target);
				totalCount = adventureActorCustomEvent.intParam;
			}
			else if (adventureActorCustomEvent.actor == _actor)
			{
				queue.Enqueue(adventureActorCustomEvent.target);
				totalCount = adventureActorCustomEvent.intParam;
			}
		}
	}

	private void ChessInitialize()
	{
		if (isRed)
		{
			Color = "red";
		}
		else
		{
			Color = "green";
		}
		AttackFX_Start = "fx_m72003_base_Attack_collect_" + Color;
		DaoGuangFX = "fx_m72006_base_attack_daoguang_" + Color;
		ChargeFX = "fx_m72006_base_attack_xuli02_" + Color;
		OtherAreaEffect = "AreaEffect_72006_AreaAttack_" + Color;
		FirstAreaEffect = "AreaEffect_72006_FirstAttack_" + Color;
	}

	private void RanSe(TSVector2 Index)
	{
		List<int> intParamList = new List<int> { Config.GetCellIndexByIndex(Index) };
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _actor;
		adventureActorCustomEvent.eventHashCode = Config.ranseEvt;
		adventureActorCustomEvent.intParamList = intParamList;
		adventureActorCustomEvent.intParam = (isRed ? 1 : 2);
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent);
	}
}
