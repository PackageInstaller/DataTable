#define LOG_DEBUG
using System;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11701;

public class SkillScript_MainControl_Skill : SkillAdvancedBase
{
	private const string _customEventName = "117_B1_Shoot";

	private readonly FP bulletDistance = 4;

	private readonly FP bulletPositionRamdomRadius = 1;

	private readonly List<string> bulletAliasList1 = new List<string> { "Bullet_11701_B1P02_Skill_Thunder_AoE_Lv1_1", "Bullet_11701_B1P02_Skill_Thunder_AoE_Lv2_1", "Bullet_11701_B1P02_Skill_Thunder_AoE_Lv3_1", "Bullet_11701_B1P02_Skill_Thunder_AoE_Lv4_1" };

	private readonly List<string> bulletAliasList2 = new List<string> { "Bullet_11701_B1P02_Skill_Thunder_AoE_Lv1_2", "Bullet_11701_B1P02_Skill_Thunder_AoE_Lv2_2", "Bullet_11701_B1P02_Skill_Thunder_AoE_Lv3_2", "Bullet_11701_B1P02_Skill_Thunder_AoE_Lv4_2" };

	private readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[3]
	{
		(ComboInputBuffer.ActionKey)1768322159,
		(ComboInputBuffer.ActionKey)1918131320,
		(ComboInputBuffer.ActionKey)1701275497
	};

	private readonly string attackTag_p1 = "Skill_B1_Perk01Perk04";

	private readonly string attackTag_p4 = "Skill_B1_Perk04";

	private readonly string attackTag_p1_4 = "Skill_B1_Perk01Perk04";

	private PlayerSkillCd _playerSkillCd;

	private int currentIndex;

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("11701 Skill_2 OnDisable");
		base.OnSkillDisable();
		if (GetPerk(511706))
		{
			_actor.buffComponent?.RemoveBuffByBuffId(11706011);
		}
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = false;
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("11701 Skill_2 OnEnable");
		base.OnSkillEnable();
		currentIndex = 0;
		if (_playerSkillCd == null)
		{
			_playerSkillCd = (_actor as PlayerAdventureActor).playerSkillCd;
		}
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = true;
	}

	public void OnStart()
	{
		NovaLogger.Debug("11701 Skill_2 OnStart");
		if (!(_skill != null))
		{
			return;
		}
		SetSkillPhaseConfig(SkillPhaseFeatureFlag.None, null, SkillPhaseFeatureFlag.None, null);
		bool perk = GetPerk(511704);
		if (perk)
		{
			_actor.logicVariable.ToggleLogicTag("117p4SkillTrigger", value: true);
		}
		if (GetPerk(Parallel.perk_1))
		{
			string text = attackTag_p1;
			if (perk)
			{
				text = attackTag_p1_4;
			}
			string actionTag = text;
			Action<string> onCustomEvent = OnCustomEvent;
			System.Action onComboLoop = OnComboLoop;
			System.Action onComboFinish = OnFinish;
			System.Action onInterrupt = OnInterrupt;
			BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent, null, fadeOutAnim: false, onComboLoop);
		}
		else if (perk)
		{
			string actionTag2 = attackTag_p4;
			Action<string> onCustomEvent = OnCustomEvent;
			System.Action onInterrupt = OnFinish;
			System.Action onComboFinish = OnInterrupt;
			BeginAttack(actionTag2, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onInterrupt, onComboFinish, onCustomEvent);
		}
		else
		{
			ComboInputBuffer.ActionKey[] actionKeys = _actionKeys;
			System.Action onComboFinish = OnFinish;
			System.Action onInterrupt = OnInterrupt;
			Action<string> onCustomEvent = OnCustomEvent;
			BeginAttack(actionKeys, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
		}
	}

	private string GetBulletResName()
	{
		bool flag = TSRandom.Range(0, 100) < 50;
		if (GetPerk(Parallel.perk_2))
		{
			int index = Parallel.mainSkill_index % 4;
			Parallel.mainSkill_index++;
			if (!flag)
			{
				return bulletAliasList2.get_Item(index);
			}
			return bulletAliasList1.get_Item(index);
		}
		if (!flag)
		{
			return bulletAliasList2.get_Item(0);
		}
		return bulletAliasList1.get_Item(0);
	}

	private void OnComboLoop()
	{
	}

	private void OnCustomEvent(string eventName)
	{
		if (eventName.Equals("117_B1_Shoot"))
		{
			Shoot(GetBulletResName());
		}
		else if (eventName.Equals(Parallel.event_p1))
		{
			if (currentIndex > 0)
			{
				CommonUtils.ReduceSkillSection(_actor, _skill);
			}
			if (_playerSkillCd.GetSkillSection(_skill.skillId) <= 0)
			{
				comboAttack?.CancelAttack();
			}
			currentIndex++;
		}
	}

	protected void Shoot(string bulletAlias)
	{
		if (!string.IsNullOrEmpty(bulletAlias))
		{
			ILRuntimeAPI.Shoot(bulletAlias, _actor, default, _actor.tsTransform.Position, 1, GetShootPosition(), null, AimType.Position);
		}
	}

	private TSVector2 GetShootPosition()
	{
		TSVector2 zero = TSVector2.zero;
		if (_actor.aimLockedTarget == null)
		{
			zero = _actor.tsTransform.Position + _actor.tsTransform.Forward.normalized * bulletDistance;
			return ILRuntimeAPI.GetRandomPointInShape(_actor, CommonUtils.GetDeterministicCircleShape(bulletPositionRamdomRadius, 0, zero), isReachable: false);
		}
		return _actor.aimLockedTarget.tsTransform.Position;
	}

	private void OnFinish()
	{
		NovaLogger.Debug("11701 Skill_2 onFinish");
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		NovaLogger.Debug("11701 Skill_2 onInterrupt");
		_skill.Clear();
	}

	public void OnUpdate()
	{
		LockDirection();
	}
}
