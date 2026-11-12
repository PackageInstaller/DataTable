using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;
using UnityEngine;

namespace AIScript.Character._99901;

public class SkillScript_Support : SkillAdvancedBase
{
	private readonly string key_LoopCombo = "999_Support_2";

	private readonly FP loopDuration = 2;

	private readonly FP searchRadius = 100;

	private readonly FP clusterRadius = 2;

	private readonly int clusterThreshold = 3;

	private readonly int crowdCount = 5;

	private CoroutineNode corMain;

	private readonly List<LogicEntity> _enemyBuffer = new List<LogicEntity>();

	private readonly List<LogicEntity> _clusterBuffer = new List<LogicEntity>();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref corMain);
		_actor.ResumeMovementBlock();
	}

	public void OnStart()
	{
		StartCoroutine(ref corMain, DoMainLogic());
	}

	private void OnFinishOrInterrupt()
	{
		_skill?.Clear();
	}

	private IEnumerator DoMainLogic()
	{
		_actor.attackTarget = SelectBestTarget();
		_actor.PauseMovementBlock();
		SkillScript_Support skillScript_Support = this;
		string actionTag = key_LoopCombo;
		System.Action onInterrupt = OnFinishOrInterrupt;
		skillScript_Support.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, null, onInterrupt);
		yield return _actor.WaitTime(loopDuration);
		_actor.CancelAttack();
		_skill?.Clear();
	}

	private LogicEntity SelectBestTarget()
	{
		_enemyBuffer.Clear();
		CommonUtils.SearchNearTargetsByCircle(_actor, searchRadius, isConfront: true, includeSelf: false, _enemyBuffer);
		for (int num = _enemyBuffer.Count - 1; num >= 0; num--)
		{
			if (!(_enemyBuffer.get_Item(num) is AdventureActor adventureActor) || !adventureActor.actorHealthInfo.isAlive || adventureActor.IsSearchedImmunity())
			{
				_enemyBuffer.RemoveAt(num);
			}
		}
		int count = _enemyBuffer.Count;
		if (count == 0)
		{
			return null;
		}
		if (count < crowdCount)
		{
			return _enemyBuffer.get_Item(0);
		}
		int num2 = Mathf.Min(crowdCount, count);
		for (int i = 0; i < num2; i++)
		{
			LogicEntity logicEntity = _enemyBuffer.get_Item(i);
			if (CountOtherEnemiesAround(logicEntity) >= clusterThreshold)
			{
				return logicEntity;
			}
		}
		return _enemyBuffer.get_Item(0);
	}

	private int CountOtherEnemiesAround(LogicEntity center)
	{
		_clusterBuffer.Clear();
		CommonUtils.SearchNearTargetsByCircle(_actor, center.tsTransform.Position, clusterRadius, isConfront: true, includeSelf: false, _clusterBuffer);
		int num = 0;
		for (int i = 0; i < _clusterBuffer.Count; i++)
		{
			LogicEntity logicEntity = _clusterBuffer.get_Item(i);
			if (!(logicEntity == center) && logicEntity is AdventureActor adventureActor && adventureActor.actorHealthInfo.isAlive && !adventureActor.IsSearchedImmunity())
			{
				num++;
			}
		}
		return num;
	}
}
