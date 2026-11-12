#define LOG_ERROR
using System;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13401;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private List<string> _curComboTagList;

	private int _stage;

	private string _comboTag;

	protected bool IsStrength { get; private set; }

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		UpdateRootMotionState();
		UpdateStrengthState();
		_curComboTagList = GetComboTagList();
		_stage = GetStage();
		_stage = ((_stage >= 0) ? _stage : 0);
		_comboTag = ((_stage < _curComboTagList.Count) ? _curComboTagList.get_Item(_stage) : null);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
	}

	protected virtual void UpdateStrengthState()
	{
		IsStrength = _actor.ammoInfo.ammoType == HotfixEnum.AmmoType.Special1 && _actor.ammoInfo.GetAmmoCount(HotfixEnum.AmmoType.Special1) > 0;
	}

	protected virtual List<string> GetComboTagList()
	{
		if (IsStrength)
		{
			return Config.comboTagList_NormalAttack_Strength;
		}
		return Config.comboTagList_NormalAttack_Default;
	}

	protected virtual int GetStage()
	{
		if (IsStrength)
		{
			CommonUtils.TryParseStringParamToInt(((PlayerAdventureActor)_actor).GetLocalData("StrengthNormalAttackStage"), out var intValue);
			return intValue;
		}
		return _actor.logicVariable.GetLogicTagValue("NormalAttackStage").AsInt();
	}

	public void OnStart()
	{
		if (string.IsNullOrEmpty(_comboTag))
		{
			NovaLogger.Error($"该普攻段数未配置ActionTag,普攻段数:{_stage}");
			OnFinish();
			return;
		}
		string comboTag = _comboTag;
		LogicEntity attackTarget = _actor.attackTarget;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(comboTag, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: true, attackTarget, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnBeforeHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		if (adventureActorReceiveDamageBeforeHitEvent.from == _actor && adventureActorReceiveDamageBeforeHitEvent.to is MonsterAdventureActor)
		{
			if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, Config.damageTag_NormalAttack))
			{
				OnBeforeNormalAttackHit(adventureActorReceiveDamageBeforeHitEvent);
			}
			if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, Config.damageTag_StrengthNormalAttack))
			{
				OnBeforeStrengthNormalAttackHit(adventureActorReceiveDamageBeforeHitEvent);
			}
		}
	}

	protected virtual void OnBeforeNormalAttackHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
	}

	protected virtual void OnBeforeStrengthNormalAttackHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "Attack_End"))
		{
			int num = _stage + 1;
			num = ((num < _curComboTagList.Count) ? num : 0);
			RecordStage(num);
			if (IsStrength)
			{
				OnStrengthNormalAttackFinish();
			}
			else
			{
				OnNormalAttackFinish();
			}
		}
		else if (string.Equals(eventName, "Use_Bullet"))
		{
			int consumeAmmo = GetConsumeAmmo();
			if (consumeAmmo > 0)
			{
				_actor.ammoInfo.RefreshAmmoCost(-consumeAmmo);
			}
		}
	}

	protected virtual int GetConsumeAmmo()
	{
		return 1;
	}

	protected virtual void RecordStage(int nextStage)
	{
		if (IsStrength)
		{
			((PlayerAdventureActor)_actor).SetLocalData("StrengthNormalAttackStage", nextStage.ToString());
		}
		else
		{
			_actor.logicVariable.SetLogicTagValue("NormalAttackStage", nextStage);
		}
	}

	public void OnUpdate()
	{
		UpdateRootMotionState();
		LockDirection();
	}

	private void UpdateRootMotionState()
	{
		if (SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection() != TSVector2.zero)
		{
			_actor.movementFSM.runtimeIgonreRootMotion = true;
		}
		else
		{
			_actor.movementFSM.runtimeIgonreRootMotion = false;
		}
	}

	protected virtual void OnNormalAttackFinish()
	{
	}

	protected virtual void OnStrengthNormalAttackFinish()
	{
	}

	protected override void OnReceiveDamage(IEvent evt)
	{
		base.OnReceiveDamage(evt);
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (adventureActorReceiveDamageEvent.from == _actor && adventureActorReceiveDamageEvent.to is MonsterAdventureActor monsterAdventureActor && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, Config.damageTag_TriggerFanHit_NormalAttack))
		{
			TSVector2 normalized = (monsterAdventureActor.dtCollider.CenterPosition - _actor.tsTransform.Position).normalized;
			TSVector2 position = monsterAdventureActor.dtCollider.CenterPosition + (monsterAdventureActor.dtCollider.Radius + 0.1f) * normalized;
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_13401_Attack_Sector", position, normalized.GetAngle());
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
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		_actor.movementFSM.runtimeIgonreRootMotion = false;
		_stage = 0;
		_comboTag = null;
	}
}
