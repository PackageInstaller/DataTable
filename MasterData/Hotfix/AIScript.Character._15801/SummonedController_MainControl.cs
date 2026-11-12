using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15801;

public class SummonedController_MainControl : SummonedController
{
	private MonsterAdventureActor _soldier;

	private MonsterAdventureActor _warrior;

	private MonsterAdventureActor _queen;

	private FP _lastTriggerTime_P2;

	private FP _lastTriggerTime_P11;

	public SummonedController_MainControl(PlayerAdventureActor actor)
		: base(actor)
	{
		_actor = actor;
	}

	public override void OnEnable()
	{
		base.OnEnable();
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
	}

	public override void Init()
	{
		base.Init();
		bool.TryParse(_actor.GetLocalData("SummonedIsWarrior"), out var result);
		if (result)
		{
			SummonWarrior(_actor.tsTransform.Position, _actor.tsTransform.Forward);
		}
		else
		{
			SummoneSoldier(_actor.tsTransform.Position, _actor.tsTransform.Forward);
		}
	}

	private void SummoneSoldier(TSVector2 position, TSVector2 direction, bool isReturn = false)
	{
		if (!(_soldier != null))
		{
			_actor.logicVariable.ToggleLogicTag("SoldierReturn", isReturn);
			TSVector2 pos = ((position != _actor.tsTransform.Position) ? position : ILRuntimeAPI.GetRandomPointInShape(_actor, new DeterministicShape
			{
				shapeType = DeterministicShape.ShapeType.Circle,
				innerRadius = _actor.GetRadius(),
				radius = Config_MainControl.defaultSummonRadius_Soldier,
				position = _actor.tsTransform.Position
			}));
			ILRuntimeAPI.SummonMonster(_actor, 0, 15831011, pos, direction, Config_MainControl.summonCfg_Soldier, null, (MonsterAdventureActor monster) =>
			{
				_soldier = monster;
				_actor.SetLocalData("SummonedIsWarrior", bool.FalseString);
				UpdateToyCount(1);
			}, useTerrainHeight: true);
		}
	}

	private void SummonWarrior(TSVector2 position, TSVector2 direction, bool isPromotion = false)
	{
		if (!(_warrior != null))
		{
			TSVector2 pos = ((position != _actor.tsTransform.Position) ? position : ILRuntimeAPI.GetRandomPointInShape(_actor, new DeterministicShape
			{
				shapeType = DeterministicShape.ShapeType.Circle,
				innerRadius = _actor.GetRadius(),
				radius = Config_MainControl.defaultSummonRadius_Warrior,
				position = _actor.tsTransform.Position
			}));
			ILRuntimeAPI.SummonMonster(_actor, 0, 15831021, pos, direction, Config_MainControl.summonCfg_Warrior, null, (MonsterAdventureActor monster) =>
			{
				_warrior = monster;
				_actor.SetLocalData("SummonedIsWarrior", bool.TrueString);
				UpdateToyCount(1);
			}, useTerrainHeight: true);
		}
	}

	private void SummonQueen()
	{
		if (!(_queen != null))
		{
			TSVector2 summonPosition = GetSummonPosition(Config_MainControl.summonRadius_NoTarget_Queen, Config_MainControl.summonRadius_Queen, Config_MainControl.summonRandomRadius_Queen);
			Config_MainControl.summonCfg_Queen.leftTime = CommonUtils.GetScriptValue(_actor, 15802012);
			ILRuntimeAPI.SummonMonster(_actor, 0, 15831031, summonPosition, _actor.tsTransform.Forward, Config_MainControl.summonCfg_Queen, null, (MonsterAdventureActor monster) =>
			{
				_queen = monster;
			}, useTerrainHeight: true);
			UpdateToyCount(1);
		}
	}

	private void SummonCasemate()
	{
		TSVector2 summonPosition = GetSummonPosition(Config_MainControl.summonRadius_NoTarget_Casemate, Config_MainControl.summonRadius_Casemate, Config_MainControl.summonRandomRadius_Casemate);
		Config_MainControl.summonCfg_Casemate.leftTime = CommonUtils.GetScriptValue(_actor, 15811013);
		ILRuntimeAPI.SummonMonster(_actor, 0, 15831041, summonPosition, _actor.tsTransform.Forward, Config_MainControl.summonCfg_Casemate, null, null, useTerrainHeight: true);
	}

	private TSVector2 GetSummonPosition(FP radiusNoTarget, FP radius, FP randomRadius)
	{
		if (_actor.attackTarget != null)
		{
			TSVector2 normalized = (_actor.tsTransform.Position - _actor.attackTarget.tsTransform.Position).normalized;
			TSVector2 result = _actor.attackTarget.tsTransform.Position + normalized * radius;
			if (!_actor.QueryPositionWalkable(result))
			{
				_actor.QueryClosestPositionWalkable(result, out result);
			}
			return ILRuntimeAPI.GetRandomPointInShape(_actor, new DeterministicShape
			{
				shapeType = DeterministicShape.ShapeType.Circle,
				innerRadius = 0,
				radius = randomRadius,
				position = result
			});
		}
		return ILRuntimeAPI.GetRandomPointInShape(_actor, new DeterministicShape
		{
			shapeType = DeterministicShape.ShapeType.Circle,
			innerRadius = _actor.GetRadius(),
			radius = radiusNoTarget,
			position = _actor.tsTransform.Position
		});
	}

	private void OnReceiveCustomEvent(IEvent evt)
	{
		if (!(evt is AdventureActorCustomEvent adventureActorCustomEvent))
		{
			return;
		}
		if (adventureActorCustomEvent.eventHashCode == Config.eventHashCode_SummonedDeathFinish)
		{
			TSVector2 position = _actor.tsTransform.Position;
			TSVector2 direction = _actor.tsTransform.Forward;
			int num = 0;
			if (adventureActorCustomEvent.tsVector2ParamList.Count >= 3)
			{
				position = adventureActorCustomEvent.tsVector2ParamList.get_Item(0);
				direction = adventureActorCustomEvent.tsVector2ParamList.get_Item(1);
				num = adventureActorCustomEvent.tsVector2ParamList.get_Item(2).x.AsInt();
			}
			if (_actor.logicVariable.GetLogicTagToggle("IsToyChange"))
			{
				switch (num)
				{
				case 15831011:
					SummonWarrior(position, direction, isPromotion: true);
					_actor.logicVariable.ToggleLogicTag("IsToyChange", value: false);
					break;
				case 15831021:
					SummoneSoldier(position, direction, isReturn: true);
					_actor.logicVariable.ToggleLogicTag("IsToyChange", value: false);
					break;
				}
			}
		}
		else if (adventureActorCustomEvent.eventHashCode == Config_MainControl.eventHashCode_QueenBeginNormalAttack)
		{
			if (_soldier != null)
			{
				SendCoordinateAttackSignal(_soldier);
			}
			else if (_warrior != null)
			{
				SendCoordinateAttackSignal(_warrior);
			}
		}
	}

	private void OnReceiveDamage(IEvent evt)
	{
		if (!(evt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent) || !(adventureActorReceiveDamageEvent.to is MonsterAdventureActor))
		{
			return;
		}
		int perkLevel;
		PlayerAdventureActor summoner;
		if (adventureActorReceiveDamageEvent.from == _actor)
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 515811, out perkLevel) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P11) && (_lastTriggerTime_P11 <= 0 || _actor.LogicTime - _lastTriggerTime_P11 > CommonUtils.GetScriptValue(_actor, 15811012)) && TSRandom.Range(FP.Zero, 100) <= CommonUtils.GetScriptValue(_actor, 15811011))
			{
				SummonCasemate();
				_lastTriggerTime_P11 = _actor.LogicTime;
			}
		}
		else if (adventureActorReceiveDamageEvent.from.IsPlayerMinion(out summoner) && CommonUtils.HavePersonalPerk(_actor.dataID, 515811, out perkLevel) && adventureActorReceiveDamageEvent.isCrit && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, Config_MainControl.damageTag_AddBuff_P11))
		{
			_actor.buffComponent.AddBuff(15811011, _actor);
			AddBuffToMinion(15811011);
		}
	}

	private void OnCastSkill(IEvent evt)
	{
		if (!(evt is AdventureActorCastSkillEvent { sender: PlayerAdventureActor sender } adventureActorCastSkillEvent) || !(sender == _actor) || adventureActorCastSkillEvent.skillEventInfo.skillSlotType != HotfixEnum.skillSlotType.B)
		{
			return;
		}
		if (_soldier != null)
		{
			SendCoordinateAttackSignal(_soldier);
		}
		else if (_warrior != null)
		{
			SendCoordinateAttackSignal(_warrior);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515802, out var _))
		{
			if (_queen != null)
			{
				SendCoordinateAttackSignal(_queen);
			}
			else if (_lastTriggerTime_P2 <= 0 || _actor.LogicTime - _lastTriggerTime_P2 > CommonUtils.GetScriptValue(_actor, 15802011))
			{
				SummonQueen();
				_actor.buffComponent.AddBuffNum(15800002, 2, _actor);
				_lastTriggerTime_P2 = _actor.LogicTime;
			}
		}
	}

	private void SendCoordinateAttackSignal(MonsterAdventureActor summoned)
	{
		if (!(summoned == null) && summoned.state == ActorState.Action)
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.eventHashCode = Config_MainControl.eventHashCode_SummonedCoordinateAttack;
			summoned.DispatchEvent(adventureActorCustomEvent);
		}
	}

	protected override void OnSelfMinionDied(MonsterAdventureActor minion)
	{
		base.OnSelfMinionDied(minion);
		if (minion == _soldier)
		{
			_soldier = null;
			UpdateToyCount(-1);
		}
		else if (minion == _warrior)
		{
			_warrior = null;
			UpdateToyCount(-1);
		}
		else if (minion == _queen)
		{
			_queen = null;
			UpdateToyCount(-1);
		}
	}

	private void UpdateToyCount(int changeCount)
	{
		if (changeCount != 0)
		{
			int num = _actor.logicVariable.GetLogicTagValue("ToySummonedCount").AsInt();
			num += changeCount;
			num = ((num >= 0) ? num : 0);
			_actor.logicVariable.SetLogicTagValue("ToySummonedCount", num);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		_actor = null;
		_soldier = null;
		_warrior = null;
		_queen = null;
		_lastTriggerTime_P2 = 0;
		_lastTriggerTime_P11 = 0;
	}
}
