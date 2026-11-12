using System;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14101;

public class SkillScript_Skill_Support : SkillAdvancedBase
{
	private bool _inLoopStage;

	private FP _loopTime;

	private int _triggerLogicIndex;

	private bool _triggerBattleReady;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_inLoopStage = false;
		_loopTime = 0;
		_triggerLogicIndex = 0;
		_triggerBattleReady = false;
		ClearSummonBullet();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
	}

	public void OnStart()
	{
		PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as PlayerAdventureActor;
		if (playerAdventureActor != null)
		{
			if (playerAdventureActor.attackTarget != null)
			{
				_actor.LookAt(playerAdventureActor.attackTarget.tsTransform.Position, 0f);
			}
			else
			{
				_actor.LookAtDir(playerAdventureActor.tsTransform.Forward, 0f);
			}
		}
		Action onAnticipationEnd = OnAnticipationEnd;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onRecoveryBegin = OnRecoveryBegin;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("141_Support_Skill", flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, onRecoveryBegin, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnAnticipationEnd()
	{
		_inLoopStage = true;
		_loopTime = Config_Support.loopTime_Skill;
	}

	public void OnUpdate()
	{
		if (_inLoopStage)
		{
			if (_triggerBattleReady || _loopTime <= 0)
			{
				comboAttack.CancelAttack();
			}
			else
			{
				_loopTime -= _actor.LogicDeltaTime;
			}
		}
	}

	private void OnBattleReady(IEvent _)
	{
		_triggerBattleReady = true;
		ClearSummonBullet();
	}

	private void ClearSummonBullet()
	{
		List<AdventureBulletBase> list = new List<AdventureBulletBase>();
		_actor.QueryOwnedAliveBullets(list);
		foreach (AdventureBulletBase item in list)
		{
			if (item.CheckBulletTag(Config_Support.bulletTag_Summoned_Skill))
			{
				item.Finish(cancel: true);
			}
		}
	}

	private void OnRecoveryBegin()
	{
		_inLoopStage = false;
		_loopTime = 0;
	}

	private void OnCustomEvent(string eventName)
	{
		if (!string.Equals(eventName, "141_Summon"))
		{
			return;
		}
		LogicEntity assistantAttackTarget = CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514123, out var perkLevel))
		{
			if (_triggerLogicIndex > 0)
			{
				ShootAddBuffBulletToTiger();
			}
			else
			{
				ShootSummonedTigerBullet(assistantAttackTarget);
			}
		}
		else
		{
			ShootSummonedDragonBullet(assistantAttackTarget);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514121, out perkLevel))
		{
			ShootSummonedDragonBullet(assistantAttackTarget);
		}
		_triggerLogicIndex++;
	}

	private void ShootSummonedDragonBullet(LogicEntity target)
	{
		TSVector2 position = _actor.tsTransform.Position;
		if (target != null)
		{
			TSVector2 normalized = (target.tsTransform.Position - _actor.tsTransform.Position).normalized;
			FP fP = TSVector2.Distance(_actor.tsTransform.Position, target.tsTransform.Position);
			position += fP * normalized / 2;
		}
		DeterministicShape shape = new DeterministicShape
		{
			shapeType = DeterministicShape.ShapeType.Circle,
			innerRadius = 0,
			radius = Config_Support.randomRadius_Summoned_Skill,
			position = position
		};
		TSVector2 randomPointInShape = ILRuntimeAPI.GetRandomPointInShape(_actor, shape);
		TSVector2 position2 = _actor.tsTransform.Position + _actor.tsTransform.Left * Config_Support.shootOffset_Skill.x + _actor.tsTransform.Forward * Config_Support.shootOffset_Skill.y;
		ILRuntimeAPI.Shoot("Bullet_14101_Support_Skill_Throw", _actor, default, position2, Config_Support.shootPositionY_Skill, randomPointInShape, null, AimType.Position, BulletDirectionType.BulletToTarget);
	}

	private void ShootSummonedTigerBullet(LogicEntity target)
	{
		TSVector2 result = _actor.tsTransform.Position;
		if (target != null)
		{
			TSVector2 normalized = (target.tsTransform.Position - _actor.tsTransform.Position).normalized;
			FP fP = TSVector2.Distance(_actor.tsTransform.Position, target.tsTransform.Position);
			result += fP * normalized / 2 + Config_Support.offset_Summoned_P23 * normalized;
		}
		else
		{
			result += _actor.tsTransform.Forward * Config_Support.offset_Summoned_NoTarget_P23;
		}
		if (!_actor.QueryPositionWalkable(result))
		{
			_actor.QueryClosestPositionWalkable(result, out result);
		}
		TSVector2 position = _actor.tsTransform.Position + _actor.tsTransform.Left * Config_Support.shootOffset_Skill.x + _actor.tsTransform.Forward * Config_Support.shootOffset_Skill.y;
		ILRuntimeAPI.Shoot("Bullet_14101_Support_Skill_Throw_P23_Tiger", _actor, default, position, Config_Support.shootPositionY_Skill, result, null, AimType.Position, BulletDirectionType.BulletToTarget);
	}

	private void ShootAddBuffBulletToTiger()
	{
		List<LogicEntity> list = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntitiesByDataID(14102111);
		if (list != null && list.Count > 0)
		{
			TSVector2 position = _actor.tsTransform.Position + _actor.tsTransform.Left * Config_Support.shootOffset_Skill.x + _actor.tsTransform.Forward * Config_Support.shootOffset_Skill.y;
			for (int i = 0; i < list.Count; i++)
			{
				AdventureActor actor = _actor;
				FP shootPositionY_Skill = Config_Support.shootPositionY_Skill;
				LogicEntity target = list.get_Item(i);
				ILRuntimeAPI.Shoot("Bullet_14101_Support_Skill_Throw_P23_Buff", actor, default, position, shootPositionY_Skill, default, target, AimType.Target, BulletDirectionType.BulletToTarget);
			}
		}
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
		if (_triggerBattleReady)
		{
			((PlayerAdventureActor)_actor).playerSkillCd.ResetSkillCD(ActionKey.B);
		}
		_inLoopStage = false;
		_loopTime = 0;
		_triggerLogicIndex = 0;
		_triggerBattleReady = false;
	}
}
