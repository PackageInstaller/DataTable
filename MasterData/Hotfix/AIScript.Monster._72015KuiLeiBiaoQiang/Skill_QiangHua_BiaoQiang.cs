using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._72015KuiLeiBiaoQiang;

public class Skill_QiangHua_BiaoQiang : SkillSimpleBase
{
	private const string combo_Throw = "Skill1";

	private FP enhanceDuration = 20;

	private FP detonateCheckInterval = 0.3f;

	private FP detonateRange = 30;

	private FP playerNearTrapRadius = 5;

	private int loopCount = 1;

	private const string bulletAlias = "Actor/Monster/72015RenOu_BiaoQiang/Weapon/Bullet_72015RenOu_BiaoQiang_Throw";

	private FP fireHeight = 1.5f;

	private TSVector2 fireOffset = new TSVector2(0, 1f);

	private CoroutineNode _detonateCor;

	private LogicEntity _targetTrap;

	private int loopIndex;

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override void OnInterrupt(int comboIndex)
	{
		base.OnInterrupt(comboIndex);
	}

	private void StopDetonateCor()
	{
		if (_detonateCor != null)
		{
			StopCor(_detonateCor);
			_detonateCor = null;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		if (_detonateCor == null)
		{
			_detonateCor = StartCor(DetonateTrapLoop());
		}
		yield break;
	}

	private IEnumerator DetonateTrapLoop()
	{
		for (FP elapsed = FP.Zero; elapsed < enhanceDuration; elapsed += detonateCheckInterval)
		{
			if (GetBuffNum(_actor, 720140110) <= 0)
			{
				break;
			}
			List<LogicEntity> targetByDataID = GetTargetByDataID(1900707);
			if (targetByDataID != null && targetByDataID.Count > 0)
			{
				for (int i = 0; i < targetByDataID.Count; i++)
				{
					LogicEntity logicEntity = targetByDataID.get_Item(i);
					if (!(logicEntity == null) && PlayerNearTrap(logicEntity) && TrapInDetonateRange(logicEntity))
					{
						yield return DoDetonateTrap(logicEntity);
						break;
					}
				}
			}
			yield return WaitTime(detonateCheckInterval);
		}
		if (GetBuffNum(_actor, 720140110) > 0)
		{
			RemoveBuffFromTarget(_actor, 720140110);
		}
		_detonateCor = null;
	}

	private bool PlayerNearTrap(LogicEntity trap)
	{
		LogicEntity logicEntity = GetAttackTarget() ?? GetCurrentPlayer();
		if (logicEntity == null)
		{
			return false;
		}
		TSVector2 entityPosition = GetEntityPosition(trap);
		TSVector2 entityPosition2 = GetEntityPosition(logicEntity);
		return TSVector2.Distance(entityPosition, entityPosition2) <= playerNearTrapRadius;
	}

	private bool TrapInDetonateRange(LogicEntity trap)
	{
		TSVector2 entityPosition = GetEntityPosition(trap);
		return TSVector2.Distance(GetPosition(), entityPosition) <= detonateRange;
	}

	private IEnumerator DoDetonateTrap(LogicEntity trap)
	{
		if (trap == null)
		{
			yield break;
		}
		AdventureActor adventureActor = trap as AdventureActor;
		if (!(adventureActor == null) && adventureActor.actorHealthInfo.isAlive)
		{
			_targetTrap = trap;
			loopIndex = 0;
			try
			{
				BeginLookAt_NotWait(trap, 999, GetRotSpdInSkill());
				BeginAttack(1, "Skill1", flushInputedKeys: true);
			}
			catch (Exception arg)
			{
				Debug.LogError($"[标枪强化] DoDetonateTrap异常: {arg}");
				_targetTrap = null;
				yield break;
			}
			yield return WaitCombo(ComboAttackType.isComboFinish);
			_targetTrap = null;
		}
	}

	protected override void OnComboLoop(int comboIndex)
	{
		try
		{
			loopIndex++;
			if (loopIndex >= loopCount)
			{
				StopLookAt();
				CancelAttack();
				if (_targetTrap != null)
				{
					TSVector2 position = TransLocalPosToWorldPos(GetPosition(), GetForward(), fireOffset);
					FP positionY = fireHeight;
					TSVector2 entityPosition = GetEntityPosition(_targetTrap);
					FP range = 0;
					TSVector2 targetPosition = entityPosition;
					Shoot("Actor/Monster/72015RenOu_BiaoQiang/Weapon/Bullet_72015RenOu_BiaoQiang_Throw", position, positionY, range, default, AimType.Position, BulletDirectionType.BulletToTarget, targetPosition);
				}
			}
		}
		catch (Exception arg)
		{
			Debug.LogError($"[标枪强化] OnComboLoop异常: {arg}");
		}
	}
}
