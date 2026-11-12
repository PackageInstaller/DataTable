#define LOG_DEBUG
using System;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13301;

internal class SkillScript_NormalAttack : SkillAdvancedBase
{
	private static readonly Dictionary<int, string> actionTagDic = new Dictionary<int, string>
	{
		[1] = "Atk1",
		[2] = "Atk2",
		[3] = "Atk3"
	};

	private static readonly Dictionary<string, string> bulletDic = new Dictionary<string, string>
	{
		["Bezier1"] = "Bullet_13301_Attack_3_Bezier1",
		["Bezier2"] = "Bullet_13301_Attack_3_Bezier2",
		["Bezier3"] = "Bullet_13301_Attack_3_Bezier3"
	};

	private readonly FP saveComboIndexTime = 1;

	private int _stage;

	private TSVector2 pos;

	private LogicEntity target;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		if (_actor.LogicTime > Parallel.normalComboTime + saveComboIndexTime)
		{
			_stage = 1;
		}
		else
		{
			_stage = (int)(long)_actor.logicVariable.GetLogicTagValue("SkillNormalAttackStage_133");
		}
	}

	public void OnStart()
	{
		string actionTag = GetActionTag();
		if (string.IsNullOrEmpty(actionTag))
		{
			OnFinish();
			return;
		}
		target = _actor.attackTarget;
		Action onAnticipationEnd = OnAnticipationEnd;
		Action onRecoveryBegin = OnRecoveryBegin;
		Action onComboFinish = OnFinish;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, onRecoveryBegin, onComboFinish, onInterrupt, onCustomEvent);
	}

	protected virtual void OnRecoveryBegin()
	{
	}

	private string GetActionTag()
	{
		if (actionTagDic.TryGetValue(_stage, out var value))
		{
			return value;
		}
		return null;
	}

	private void OnAnticipationEnd()
	{
		int num = ((_stage >= actionTagDic.Count) ? 1 : (_stage + 1));
		_actor.logicVariable.SetLogicTagValue("SkillNormalAttackStage_133", num);
	}

	protected void OnCustomEvent(string evt)
	{
		NovaLogger.Debug("_13301 SkillScript_Zhukong_Skill OnCustomEvent: " + evt);
		if (bulletDic.TryGetValue(evt, out var value) && _actor.attackTarget != null)
		{
			LogicEntity logicEntity = _actor.attackTarget;
			if (target != _actor.attackTarget && target is MonsterAdventureActor monsterAdventureActor && monsterAdventureActor.actorHealthInfo.isAlive)
			{
				logicEntity = monsterAdventureActor;
			}
			pos = _actor.tsTransform.TransformLocalPointToWorldSpace(new TSVector2(0, 1.5f));
			string bulletAlias = value;
			AdventureActor actor = _actor;
			FP range = 0;
			TSVector2 position = pos;
			FP positionY = 1.8;
			LogicEntity logicEntity2 = logicEntity;
			ILRuntimeAPI.Shoot(bulletAlias, actor, range, position, positionY, default, logicEntity2, AimType.Target, BulletDirectionType.BulletToTarget);
		}
	}

	public void OnUpdate()
	{
		if (_actor.attackTarget != null)
		{
			if (_actor.DistanceWithRadius(_actor.attackTarget) > CommonUtils.GetAttackRange(_actor))
			{
				comboAttack?.CancelAttack();
			}
		}
		else
		{
			comboAttack?.CancelAttack();
		}
		LockDirection();
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
		Parallel.normalComboTime = _actor.LogicTime;
	}
}
