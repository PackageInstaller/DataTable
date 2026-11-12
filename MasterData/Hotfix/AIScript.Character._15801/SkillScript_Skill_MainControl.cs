using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15801;

public class SkillScript_Skill_MainControl : SkillAdvancedBase
{
	private FP _hitOffset;

	private CommomAreaHitConfig _hitConfig;

	private FP _hitAngle;

	private FP _hitRadius;

	private FP _hitInnerRadius;

	private bool _addMoraleSuccessHitEnemy;

	private bool _addMoraleSuccessHitToys;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		if (_hitConfig == null)
		{
			_hitConfig = new CommomAreaHitConfig
			{
				hitFeatureData = new HitBox.HitBoxFeatureData
				{
					KnockOutForce = Config_MainControl.airBorneForce_Skill,
					StiffDuration = Config_MainControl.stiffDuration_Skill,
					hitStrenth = Config_MainControl.hitStrenth_Skill
				},
				hittedEffectAlias = "fx_15801_hit_Lash"
			};
		}
		_addMoraleSuccessHitEnemy = false;
		_addMoraleSuccessHitToys = false;
		DefaultLookAt();
	}

	public void OnStart()
	{
		string text = "158_Main_Skill";
		_hitOffset = Config_MainControl.hitOffset_Skill;
		_hitConfig.hitDamageId = 158310001;
		_hitAngle = Config_MainControl.hitAngle_Skill;
		_hitRadius = Config_MainControl.hitRadius_Skill;
		_hitInnerRadius = Config_MainControl.hitInnerRadius_Skill;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515803, out var perkLevel))
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 515809, out perkLevel))
			{
				text = "158_Main_Skill_P03P09";
				_hitOffset = Config_MainControl.hitOffset_Skill_P3_P9;
				_hitConfig.hitDamageId = 158503001;
				_hitAngle = Config_MainControl.hitAngle_Skill_P3_P9;
				_hitRadius = Config_MainControl.hitRadius_Skill_P3_P9;
				_hitInnerRadius = Config_MainControl.hitInnerRadius_Skill_P3_P9;
			}
			else
			{
				text = "158_Main_Skill_P03";
				_hitOffset = Config_MainControl.hitOffset_Skill_P3;
				_hitConfig.hitDamageId = 158503001;
				_hitAngle = Config_MainControl.hitAngle_Skill_P3;
				_hitRadius = Config_MainControl.hitRadius_Skill_P3;
				_hitInnerRadius = Config_MainControl.hitInnerRadius_Skill_P3;
			}
		}
		else if (CommonUtils.HavePersonalPerk(_actor.dataID, 515809, out perkLevel))
		{
			text = "158_Main_Skill_P09";
			_hitOffset = Config_MainControl.hitOffset_Skill_P9;
			_hitConfig.hitDamageId = 158310001;
			_hitAngle = Config_MainControl.hitAngle_Skill_P9;
			_hitRadius = Config_MainControl.hitRadius_Skill_P9;
			_hitInnerRadius = Config_MainControl.hitInnerRadius_Skill_P9;
		}
		string actionTag = text;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	public void OnUpdate()
	{
		LockDirection();
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "158_Main_Skill_Hurt"))
		{
			Hit();
		}
		else if (string.Equals(eventName, "158_Main_Skill_Hurt_Fly"))
		{
			Hit(withAirBorne: true);
		}
	}

	private void Hit(bool withAirBorne = false)
	{
		_hitConfig.hitFlags = (withAirBorne ? (HitBox.FeatureFlag.AirBorne | HitBox.FeatureFlag.Stiff) : HitBox.FeatureFlag.Stiff);
		_hitConfig.position = _actor.tsTransform.Position + _actor.tsTransform.Forward * _hitOffset;
		_hitConfig.direction = _actor.tsTransform.Forward;
		int num = ILRuntimeAPI.FanAreaHit(_actor, _hitConfig, _hitAngle, _hitRadius, _hitInnerRadius);
		if (!_addMoraleSuccessHitEnemy && num > 0)
		{
			_actor.buffComponent.AddBuffNum(15800002, 1, _actor);
			_addMoraleSuccessHitEnemy = true;
		}
		if (_addMoraleSuccessHitToys)
		{
			return;
		}
		foreach (LogicEntity item in ILRuntimeAPI.GetTargetsFromShape(new DeterministicShape
		{
			shapeType = DeterministicShape.ShapeType.Fan,
			innerRadius = _hitInnerRadius,
			radius = _hitRadius,
			angle = _hitAngle,
			position = _hitConfig.position,
			rotation = _hitConfig.direction.GetAngle()
		}))
		{
			if (item.IsPlayerMinion(out var summoner) && summoner == _actor)
			{
				MonsterAdventureActor monsterAdventureActor = item as MonsterAdventureActor;
				if ((monsterAdventureActor.dataID == 15831011 || monsterAdventureActor.dataID == 15831021) && monsterAdventureActor.state != ActorState.Death)
				{
					_actor.buffComponent.AddBuffNum(15800002, 1, _actor);
					_addMoraleSuccessHitToys = true;
					break;
				}
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
		_addMoraleSuccessHitEnemy = false;
		_addMoraleSuccessHitToys = false;
	}
}
