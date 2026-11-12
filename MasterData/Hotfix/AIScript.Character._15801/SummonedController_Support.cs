using System.Collections.Generic;
using System.Linq;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15801;

public class SummonedController_Support : SummonedController
{
	private List<MonsterAdventureActor> _soldierList;

	private MonsterAdventureActor _warrior;

	private long _lastSoldierId_P23;

	public SummonedController_Support(PlayerAdventureActor actor)
		: base(actor)
	{
		_actor = actor;
	}

	public override void OnEnable()
	{
		base.OnEnable();
		_lastSoldierId_P23 = 0L;
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
	}

	private void OnBulletFinish(IEvent evt)
	{
		if (evt is AdventureBulletFinishEvent adventureBulletFinishEvent && adventureBulletFinishEvent.owner == _actor)
		{
			AdventureBulletBase adventureBulletBase = adventureBulletFinishEvent.sender as AdventureBulletBase;
			if (adventureBulletBase.CheckBulletTag(Config_Support.bulletTag_Skill) && adventureBulletFinishEvent.finishReason != BulletFinishReason.Timeout && adventureBulletBase.CheckBulletTag(Config_Support.bulletTag_Skill))
			{
				SummoneSoldier(adventureBulletBase.tsTransform.Position);
			}
		}
	}

	public void AddBuffToSummoned(int buffId, int count = 1)
	{
		List<MonsterAdventureActor> soldierList = _soldierList;
		if (soldierList != null && soldierList.Count > 0)
		{
			foreach (MonsterAdventureActor soldier in _soldierList)
			{
				soldier.buffComponent.AddBuffNum(buffId, count, _actor);
			}
		}
		if (_warrior != null)
		{
			_warrior.buffComponent.AddBuffNum(buffId, count, _actor);
		}
	}

	private void SummoneSoldier(TSVector2 position)
	{
		if (!_actor.QueryPositionWalkable(position))
		{
			_actor.QueryClosestPositionWalkable(position, out position);
		}
		TSVector2 dir = _actor.tsTransform.Forward;
		if (_actor.attackTarget != null)
		{
			dir = (_actor.attackTarget.tsTransform.Position - position).normalized;
		}
		int parameterId = 15832001;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515829, out var _))
		{
			parameterId = 15829011;
		}
		Config_Support.summonCfg_Soldier.leftTime = CommonUtils.GetScriptValue(_actor, parameterId);
		TSVector2 randomPointInShape = ILRuntimeAPI.GetRandomPointInShape(_actor, new DeterministicShape
		{
			shapeType = DeterministicShape.ShapeType.Circle,
			innerRadius = 0,
			radius = Config_Support.summonRandomRadius_Soldier,
			position = position
		});
		ILRuntimeAPI.SummonMonster(_actor, 0, 15832011, randomPointInShape, dir, Config_Support.summonCfg_Soldier, null, OnSummoneSoldierFinish, useTerrainHeight: true);
	}

	private void OnSummoneSoldierFinish(MonsterAdventureActor soldier)
	{
		if (_soldierList == null)
		{
			_soldierList = new List<MonsterAdventureActor>();
		}
		_soldierList.Add(soldier);
		if (_soldierList.Count < 4)
		{
			return;
		}
		_soldierList.Sort((MonsterAdventureActor x, MonsterAdventureActor y) => x.monsterSummonInfo.LeftTime.CompareTo(y.monsterSummonInfo.LeftTime));
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515823, out var _))
		{
			MonsterAdventureActor monsterAdventureActor = _soldierList.Last();
			_lastSoldierId_P23 = monsterAdventureActor.Id;
			for (int num = _soldierList.Count - 1; num >= 0; num--)
			{
				_soldierList.get_Item(num).logicVariable.ToggleLogicTag("IsAbsorbDeath_Soldier", value: true);
				AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
				adventureActorCustomEvent.sender = _soldierList.get_Item(num);
				adventureActorCustomEvent.eventHashCode = Config_Support.eventHashCode_SummonedDestroySelf;
				_soldierList.get_Item(num).DispatchEvent(adventureActorCustomEvent);
			}
		}
		else if (_soldierList.Count > 4)
		{
			MonsterAdventureActor monsterAdventureActor2 = _soldierList.First();
			AdventureActorCustomEvent adventureActorCustomEvent2 = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent2.sender = monsterAdventureActor2;
			adventureActorCustomEvent2.eventHashCode = Config_Support.eventHashCode_SummonedDestroySelf;
			monsterAdventureActor2.DispatchEvent(adventureActorCustomEvent2);
		}
	}

	private void SummoneWarrior(TSVector2 position)
	{
		TSVector2 dir = _actor.tsTransform.Forward;
		if (_actor.attackTarget != null)
		{
			dir = (_actor.attackTarget.tsTransform.Position - position).normalized;
		}
		int parameterId = 15823011;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515829, out var _))
		{
			parameterId = 15829012;
		}
		Config_Support.summonCfg_Warrior.leftTime = CommonUtils.GetScriptValue(_actor, parameterId);
		ILRuntimeAPI.SummonMonster(_actor, 0, 15832021, position, dir, Config_Support.summonCfg_Warrior, null, OnSummoneWarriorFinish, useTerrainHeight: true);
	}

	private void OnSummoneWarriorFinish(MonsterAdventureActor warrior)
	{
		if (_warrior != null)
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = _warrior;
			adventureActorCustomEvent.eventHashCode = Config_Support.eventHashCode_SummonedDestroySelf;
			_warrior.DispatchEvent(adventureActorCustomEvent);
		}
		_warrior = warrior;
	}

	private void OnReceiveCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent adventureActorCustomEvent && adventureActorCustomEvent.eventHashCode == Config.eventHashCode_SummonedDeathFinish)
		{
			TSVector2 position = _actor.tsTransform.Position;
			int num = 0;
			long num2 = 0L;
			if (adventureActorCustomEvent.tsVector2ParamList.Count >= 3)
			{
				position = adventureActorCustomEvent.tsVector2ParamList.get_Item(0);
				num = adventureActorCustomEvent.tsVector2ParamList.get_Item(2).x.AsInt();
				num2 = adventureActorCustomEvent.tsVector2ParamList.get_Item(2).y.AsLong();
			}
			if (num == 15832011 && CommonUtils.HavePersonalPerk(_actor.dataID, 515823, out var _) && _lastSoldierId_P23 > 0 && _lastSoldierId_P23 == num2)
			{
				SummoneWarrior(position);
				_lastSoldierId_P23 = 0L;
			}
		}
	}

	protected override void OnSelfMinionDied(MonsterAdventureActor minion)
	{
		base.OnSelfMinionDied(minion);
		if (minion.dataID == 15832011)
		{
			_soldierList.Remove(minion);
		}
		else if (minion.dataID == 15832021)
		{
			_warrior = null;
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		_lastSoldierId_P23 = 0L;
		_actor = null;
	}
}
