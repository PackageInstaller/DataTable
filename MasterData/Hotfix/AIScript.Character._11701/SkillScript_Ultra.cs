#define LOG_DEBUG
using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11701;

public class SkillScript_Ultra : SkillAdvancedBase
{
	private const string _customEventName = "_Ultra";

	private readonly string _bulletAlias = "Bullet_11701_ultra";

	private readonly string _bulletAlias_destiny_6 = "Bullet_117_Ultra_H6";

	private readonly string _bulletAlias_destiny_6_p42 = "Bullet_117_Ultra_H6_42";

	private readonly string _bulletAlias_destiny_6_2 = "Bullet_117_Ultra_H6_2";

	private readonly string _bulletAlias_destiny_6_2_p42 = "Bullet_117_Ultra_H6_42_2";

	private readonly FP _bulletDistance = 1.5;

	protected ComboAttack _comboAttack;

	protected PlayTimeline _playTimeline;

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("_11701 Skill_Ultra OnDisable");
		base.OnSkillDisable();
		_comboAttack?.Clear();
		_actor.DisableInvincible();
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("_11701 Skill_Ultra OnEnable");
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		NovaLogger.Debug("_11701 Skill_Ultra OnStart");
		if (_skill != null)
		{
			SetSkillPhaseConfig(SkillPhaseFeatureFlag.None, null, SkillPhaseFeatureFlag.None, null);
			_actor.EnableInvincible();
			if (_comboAttack == null)
			{
				_comboAttack = new ComboAttack();
			}
			if (_playTimeline == null)
			{
				_playTimeline = new PlayTimeline();
			}
			_playTimeline.Play(_actor, () =>
			{
				ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.U };
				ComboAttack comboAttack = _comboAttack;
				AdventureActor actor = _actor;
				AdventureSkill skill = _skill;
				int skillId = ((_skill != null) ? _skill.skillId : 0);
				System.Action onComboFinish = OnFinish;
				System.Action onInterrupt = OnInterrupt;
				Action<string> onCustomEvent = OnCustomEvent;
				comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: true, skillId, forceInterruptAttack: true, autoLookAtTarget: true, null, null, default, null, null, null, onComboFinish, onInterrupt, onCustomEvent);
			}, () =>
			{
				ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.V };
				ComboAttack comboAttack = _comboAttack;
				AdventureActor actor = _actor;
				AdventureSkill skill = _skill;
				int skillId = ((_skill != null) ? _skill.skillId : 0);
				System.Action onComboFinish = OnFinish;
				System.Action onInterrupt = OnInterrupt;
				Action<string> onCustomEvent = OnCustomEvent;
				comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: true, skillId, forceInterruptAttack: true, autoLookAtTarget: true, null, null, default, null, null, null, onComboFinish, onInterrupt, onCustomEvent);
			});
		}
	}

	protected void OnFinish()
	{
		NovaLogger.Debug("_11701 Skill_Ultra onFinish");
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		NovaLogger.Debug("_11701 Skill_Ultra OnInterrupt");
		_skill.Clear();
	}

	protected void OnCustomEvent(string eventName)
	{
		NovaLogger.Debug("_11701 Skill_Ultra OnCustomEvent");
		TSVector2 position = _actor.tsTransform.Position + _actor.tsTransform.Forward.normalized * _bulletDistance;
		if (!(eventName == "_Ultra"))
		{
			return;
		}
		AdventureBulletBase adventureBulletBase = ILRuntimeAPI.Shoot(_bulletAlias, _actor, 1.5, position);
		if (adventureBulletBase != null)
		{
			_actor.logicVariable.ToggleLogicTag("117DazhaoKaishi", value: true);
		}
		if (adventureBulletBase != null)
		{
			if (GetPerk(Parallel.perk_41))
			{
				_actor.buffComponent.AddBuff(11741011, _actor);
			}
			if (CheckTalentLevel(1))
			{
				Singleton<BuffManager>.Instance.AddBufftoGroup(11796111, _actor);
			}
		}
	}
}
