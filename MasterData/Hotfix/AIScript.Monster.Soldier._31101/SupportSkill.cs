using System;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster.Soldier._31101;

public class SupportSkill : SkillAdvancedBase
{
	private const string actionKey = "SupportSkill";

	private const string fireEvent = "Fire";

	private const string endEvent = "End";

	private const int summonedChessId = 100009;

	private const int summonedChessId_Potential = 100014;

	private const int summonCount = 3;

	private static readonly FP fanInnerRadius = 2;

	private static readonly FP fanOuterRadius = 4;

	private static readonly FP fanAngleRange = 180;

	private int _potentialLv = 1;

	private readonly List<SoldierActor> _enemyBuffer = new List<SoldierActor>();

	private readonly List<SoldierActor> _distributePool = new List<SoldierActor>();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_potentialLv = (_actor as SoldierActor).GetPotentialLv();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.CancelAiming();
	}

	public void OnStart()
	{
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("SupportSkill", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		_skill.Clear();
	}

	public void OnUpdate()
	{
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
	}

	private void DoMainLogic()
	{
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("SupportSkill", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string evt)
	{
		if (evt.Equals("Fire"))
		{
			DoSummon();
		}
		else if (evt.Equals("End"))
		{
			_actor.CancelAttack();
		}
	}

	private void DoSummon()
	{
		if (!(ModuleController<AdventureModuleController>.Instance.levelInstance is SoldierLevelController soldierLevelController))
		{
			return;
		}
		SoldierActor soldierActor = _actor as SoldierActor;
		if (soldierActor == null)
		{
			return;
		}
		int num = ((_potentialLv >= 2) ? TSRandom.Range(0, 3) : (-1));
		TSVector2 position = _actor.tsTransform.Position;
		FP angle = _actor.tsTransform.Forward.GetAngle();
		LogicEntity logicEntity = _actor.attackTarget;
		if (logicEntity is AdventureActor adventureActor && (adventureActor.actorHealthInfo == null || !adventureActor.actorHealthInfo.isAlive))
		{
			logicEntity = null;
		}
		_enemyBuffer.Clear();
		SoldierActor soldierActor2 = (soldierActor.isEnemyCamp ? soldierLevelController.mainControlActor : soldierLevelController.enemyMainControlActor);
		if (soldierActor2 != null)
		{
			soldierLevelController.GetAllActors(soldierActor2, _enemyBuffer);
		}
		BuildDistributePool(_enemyBuffer, logicEntity, _distributePool);
		List<SoldierActor> list = ((_distributePool.Count > 0) ? _distributePool : _enemyBuffer);
		int num2 = 0;
		for (int i = 0; i < 3; i++)
		{
			TSVector2 result = TrueSyncExtensions.RandomPointInsideFan(position, fanInnerRadius, fanOuterRadius, angle, fanAngleRange);
			if (!_actor.QueryPositionWalkable(result))
			{
				_actor.QueryClosestPositionWalkable(result, out result);
			}
			bool flag = i == num;
			int chessId = (flag ? 100014 : 100009);
			TSVector2 normalized = ((_actor.attackTarget != null) ? (_actor.attackTarget.tsTransform.Position - result) : _actor.tsTransform.Forward).normalized;
			SoldierActor soldierActor3 = soldierLevelController.SpawnSoldierSummon(soldierActor, chessId, result, normalized.GetAngle());
			if (!(soldierActor3 == null))
			{
				LogicEntity logicEntity2;
				if (flag)
				{
					logicEntity2 = logicEntity;
				}
				else if (list.Count > 0)
				{
					logicEntity2 = list.get_Item(num2 % list.Count);
					num2++;
				}
				else
				{
					logicEntity2 = logicEntity;
				}
				if (IsAliveTarget(logicEntity2))
				{
					soldierActor3.attackTarget = logicEntity2;
					soldierActor3.soldierAttackTarget = logicEntity2;
				}
			}
		}
	}

	private static void BuildDistributePool(List<SoldierActor> source, LogicEntity excluded, List<SoldierActor> dest)
	{
		dest.Clear();
		if (source == null || source.Count == 0)
		{
			return;
		}
		for (int i = 0; i < source.Count; i++)
		{
			SoldierActor soldierActor = source.get_Item(i);
			if (!(soldierActor == null) && (!(excluded != null) || (object)soldierActor != excluded))
			{
				dest.Add(soldierActor);
			}
		}
	}

	private static bool IsAliveTarget(LogicEntity target)
	{
		if (target == null)
		{
			return false;
		}
		if (target is AdventureActor adventureActor && (adventureActor.actorHealthInfo == null || !adventureActor.actorHealthInfo.isAlive))
		{
			return false;
		}
		return !target.IsSearchedImmunity();
	}
}
