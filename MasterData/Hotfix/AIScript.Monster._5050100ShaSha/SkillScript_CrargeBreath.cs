using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._5050100ShaSha;

public class SkillScript_CrargeBreath : SkillScript_SkillBase
{
	protected readonly ComboInputBuffer.ActionKey[] _actionKey_Water = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.E };

	protected readonly ComboInputBuffer.ActionKey[] _actionKey_Dark = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.T };

	protected FP RotateSpeed = 150;

	protected readonly int ReceiveDamageFEPre = 99;

	protected readonly string playEffect = "PlayEffect";

	protected readonly string stopEffect = "StopEffect";

	protected readonly string fx_water_1 = "fx_50501_loop_skill5_loop_01";

	protected readonly string fx_water_2 = "fx_50501_loop_skill5_loop_02";

	protected readonly string fx_dark_1 = "fx_50501_loop_skill5_loop_01_an";

	protected readonly string fx_dark_2 = "fx_50501_loop_skill5_loop_02_an";

	protected ComboInputBuffer.ActionKey[] _actionKey;

	protected long _receiveDamage;

	protected string _fx_1_path;

	protected string _fx_2_path;

	protected PlayFX _playFX_1;

	protected PlayFX _playFX_2;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_receiveDamage = 0L;
		_rotateSpeed = RotateSpeed;
		UpdateData();
	}

	protected void UpdateData()
	{
		if (_actor.buffComponent.CheckBuffByBuffID(_violentBuffId))
		{
			_actionKey = _actionKey_Dark;
			_fx_1_path = fx_dark_1;
			_fx_2_path = fx_dark_2;
		}
		else
		{
			_actionKey = _actionKey_Water;
			_fx_1_path = fx_water_1;
			_fx_2_path = fx_water_2;
		}
	}

	protected override void BeginSkill()
	{
		base.BeginSkill();
		ComboAttack comboAttack = _comboAttack;
		AdventureActor actor = _actor;
		AdventureSkill skill = _skill;
		ComboInputBuffer.ActionKey[] actionKey = _actionKey;
		int skillId = ((_skill != null) ? _skill.skillId : 0);
		Action<string> onCustomEvent = OnCustomEvent;
		System.Action onInterrupt = OnInterrupt;
		System.Action onComboFinish = OnFinish;
		comboAttack.BeginAttack(actor, skill, actionKey, flushInputedKeys: true, skillId, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	protected void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, playEffect))
		{
			if (_playFX_1 == null)
			{
				_playFX_1 = new PlayFX();
			}
			_playFX_1.Play(_actor, _skill, _fx_1_path, 0, _actor.tsTransform.Position, _actor.tsTransform.Forward);
			if (_playFX_2 == null)
			{
				_playFX_2 = new PlayFX();
			}
			_playFX_2.Play(_actor, _skill, _fx_2_path, 0, _actor.tsTransform.Position, _actor.tsTransform.Forward);
		}
		else if (string.Equals(eventName, stopEffect))
		{
			if (_playFX_1 != null)
			{
				_playFX_1.Stop(dontPlaySubFX: true);
				_playFX_1.Clear();
			}
			if (_playFX_2 != null)
			{
				_playFX_2.Stop(dontPlaySubFX: true);
				_playFX_2.Clear();
			}
		}
	}

	protected void OnFinish()
	{
		_skill?.Clear();
	}

	protected void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnReceiveDamage(IEvent evt)
	{
		base.OnReceiveDamage(evt);
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (!(adventureActorReceiveDamageEvent.to != _actor))
		{
			if (adventureActorReceiveDamageEvent.elementType == HotfixEnum.elementType.FE)
			{
				_receiveDamage += adventureActorReceiveDamageEvent.damageToShieldAndHp;
			}
			if (_receiveDamage * 100 / _actor.actorHealthInfo.hpMax > ReceiveDamageFEPre)
			{
				_comboAttack.InterruptAttack();
				_actor.logicVariable.ToggleLogicTag("5050100ShaShaSpecial", value: true);
				ILRuntimeAPI.CreateSkill(_skillId_whelmed, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: true, isBreakable: false);
				OnFinish();
			}
		}
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_playFX_1?.Clear();
		_playFX_2?.Clear();
	}
}
