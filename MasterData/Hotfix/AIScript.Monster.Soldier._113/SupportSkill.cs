using System;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._113;

public class SupportSkill : SkillAdvancedBase
{
	private readonly string comboTag = "ComboSupport";

	private string evt_shoot = "SupSkill_ShuiJian";

	private string bullut_WaterArrow = "Bullet_SupSkill_Soldier";

	private readonly int fireCount = 10;

	private readonly int shootMod = 10;

	private readonly Dictionary<int, TSVector> dicShootPos = new Dictionary<int, TSVector>
	{
		[1] = new TSVector(-0.4, 2, 1.2),
		[2] = new TSVector(-0.2, 2, 1.2),
		[3] = new TSVector(0, 2, 1.2),
		[4] = new TSVector(0.2, 2, 1.2),
		[5] = new TSVector(0.4, 2, 1.2),
		[6] = new TSVector(0.4, 2, 1.2),
		[7] = new TSVector(0.2, 2, 1.2),
		[8] = new TSVector(0, 2, 1.2),
		[9] = new TSVector(-0.2, 2, 1.2),
		[0] = new TSVector(-0.4, 2, 1.2)
	};

	private const string logicTag_ShootIndex = "shootIndex";

	private int _curIndex;

	private int _firedCount;

	private bool _needCancel;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_curIndex = _actor.logicVariable?.GetLogicTagValue("shootIndex").AsInt() ?? 0;
		_firedCount = 0;
		_needCancel = false;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.logicVariable?.SetLogicTagValue("shootIndex", _curIndex);
		_firedCount = 0;
		_needCancel = false;
		_actor.CancelAiming();
	}

	public void OnStart()
	{
		if (_actor.attackTarget == null)
		{
			_actor.attackTarget = ((SoldierActor)_actor).soldierAI?.FindNearestConfrontTarget();
		}
		string actionTag = comboTag;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, evt_shoot) && _firedCount < fireCount)
		{
			_firedCount++;
			_curIndex = (_curIndex + 1) % shootMod;
			TSVector tSVector = dicShootPos.get_Item(_curIndex);
			TSVector2 position = _actor.tsTransform.TransformLocalPointToWorldSpace(new TSVector2(tSVector.x, tSVector.z));
			ILRuntimeAPI.Shoot(bullut_WaterArrow, _actor, default, position, tSVector.y, default, null, AimType.Forward);
			if (_firedCount >= fireCount)
			{
				_needCancel = true;
			}
		}
	}

	public void OnUpdate()
	{
		LockDirection();
		if (_needCancel)
		{
			comboAttack?.CancelAttack();
		}
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		_skill.Clear();
	}
}
