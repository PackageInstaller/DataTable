using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._99901;

public class SkillScript_Support2 : SkillAdvancedBase
{
	private readonly string key_LoopCombo = "999_Support_1_Loop";

	private readonly string evt_Charge = "Charge";

	private readonly FP loopDuration = 1.5;

	private readonly FP dashSpeed = 30;

	private readonly FP dashTime = 1.5;

	private readonly FP searchRadius = 100;

	private Dash _dash;

	private CoroutineNode corMain;

	private bool _charging;

	private bool _dashFinished;

	private readonly List<LogicEntity> _searchBuffer = new List<LogicEntity>();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref corMain);
		_dash?.Interrupte();
		_dash?.Clear();
		_actor.ResumeMovementBlock();
		_charging = false;
		_dashFinished = false;
	}

	public void OnStart()
	{
		_charging = false;
		_dashFinished = false;
		StartCoroutine(ref corMain, DoMainLogic());
	}

	private void OnFinishOrInterrupt()
	{
		_skill?.Clear();
	}

	private IEnumerator DoMainLogic()
	{
		_actor.PauseMovementBlock();
		SkillScript_Support2 skillScript_Support = this;
		string actionTag = key_LoopCombo;
		Action<string> onCustomEvent = OnCustomEvent;
		System.Action onInterrupt = OnFinishOrInterrupt;
		skillScript_Support.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: true, null, null, default, null, null, null, onInterrupt, onCustomEvent);
		yield return _actor.WaitTime(loopDuration);
		_actor.CancelAttack();
		while (!_dashFinished)
		{
			yield return null;
		}
		_skill?.Clear();
	}

	private void OnCustomEvent(string eventName)
	{
		if (eventName.Equals(evt_Charge))
		{
			BeginCharge();
		}
	}

	private void BeginCharge()
	{
		if (!_charging)
		{
			_charging = true;
			LogicEntity farthestEnemy = GetFarthestEnemy();
			if (farthestEnemy != null)
			{
				_actor.LookAt(farthestEnemy.tsTransform.Position, 0);
			}
			if (_dash == null)
			{
				_dash = new Dash();
			}
			else
			{
				_dash.Clear();
			}
			_dash.BeginDash(_actor, _actor.tsTransform.Forward, dashSpeed, dashSpeed * dashTime, default, OnDashFinish, null, null, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		}
	}

	private void OnDashFinish()
	{
		_actor.CancelAttack();
		_dashFinished = true;
	}

	private LogicEntity GetFarthestEnemy()
	{
		_searchBuffer.Clear();
		CommonUtils.SearchNearTargetsByCircle(_actor, searchRadius, isConfront: true, includeSelf: false, _searchBuffer);
		for (int num = _searchBuffer.Count - 1; num >= 0; num--)
		{
			if (_searchBuffer.get_Item(num) is AdventureActor adventureActor && adventureActor.actorHealthInfo.isAlive && !adventureActor.IsSearchedImmunity())
			{
				return adventureActor;
			}
		}
		return null;
	}
}
