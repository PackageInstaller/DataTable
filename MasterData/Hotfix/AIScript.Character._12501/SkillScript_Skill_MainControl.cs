using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._12501;

public class SkillScript_Skill_MainControl : SkillAdvancedBase
{
	private bool _havePerk_P1;

	private bool _havePerk_P2;

	private bool _havePerk_P3;

	private bool _havePerk_P4;

	private bool _canCharge;

	private string _comboTag_Attack;

	private int _minLoopTimes_Attack;

	private int _chargeAddLoopTimes;

	private int _maxLoopTimes_Attack;

	private bool _isRunLoop;

	private bool _inCharge;

	private Dictionary<int, PlayFX> _chargeFxDic;

	private int _chargeStage;

	private FP _chargeInterval;

	private AimTarget _aimTarget;

	private int _attackLoopTimes;

	private int _curAttackLoopTimes;

	private FP _reduceCD_P2;

	private HashSet<int> _hittedSet_P4;

	private CoroutineNode _perkLogicCor_P10;

	private int _additionalAttrCount_P10;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_havePerk_P1 = ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512501, out var perkLevel);
		_havePerk_P2 = ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512502, out perkLevel);
		_havePerk_P3 = ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512503, out perkLevel);
		_havePerk_P4 = ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512504, out perkLevel);
		_canCharge = !_havePerk_P2;
		_comboTag_Attack = "125_Main_Skill_WhirlWind";
		if (_havePerk_P2)
		{
			_comboTag_Attack = (_havePerk_P4 ? "125_Main_Skill_P02P04_WhirlWind" : "125_Main_Skill_P02_WhirlWind");
		}
		else if (_havePerk_P4)
		{
			_comboTag_Attack = "125_Main_Skill_P04_WhirlWind";
		}
		_minLoopTimes_Attack = (_havePerk_P3 ? 4 : 2);
		_chargeAddLoopTimes = (_havePerk_P3 ? 4 : 2);
		_maxLoopTimes_Attack = (_havePerk_P3 ? 12 : 6);
		_inCharge = false;
		_attackLoopTimes = _minLoopTimes_Attack;
		_curAttackLoopTimes = 0;
		_chargeInterval = Config_MainControl.chargeInterval_Skill;
		if (_havePerk_P4)
		{
			_actor.EnableImmuneControl();
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512506, out perkLevel))
		{
			_actor.buffComponent?.AddBuff(12506011, _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512507, out perkLevel) && (_actor as PlayerAdventureActor).status == ActorStatus.Special)
		{
			_actor.buffComponent.AddBuff(12507011, _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512542, out perkLevel) && (_actor as PlayerAdventureActor).status == ActorStatus.Special)
		{
			_actor.buffComponent.AddBuff(12542011, _actor);
		}
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
	}

	public void OnStart()
	{
		if (_canCharge)
		{
			Action onActivationEnd = OnChargeActivationEnd;
			Action onComboFinish = OnFinish;
			Action onInterrupt = OnInterrupt;
			BeginAttack("125_Main_Charge_Start", flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, null, onActivationEnd);
		}
		else
		{
			Attack();
		}
	}

	private void OnChargeActivationEnd()
	{
		if (_actor.logicVariable.GetLogicTagToggle("OnButtonBPress"))
		{
			_inCharge = true;
			_chargeStage = 1;
			Action onComboFinish = OnFinish;
			Action onInterrupt = OnInterrupt;
			BeginAttack("125_Main_Charge_Idle_Loop", flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
			_isRunLoop = false;
			FP fP = 0;
			if (_chargeAddLoopTimes > 0)
			{
				fP = (_maxLoopTimes_Attack - _minLoopTimes_Attack) / _chargeAddLoopTimes * Config_MainControl.chargeInterval_Skill;
			}
			if (fP > 0)
			{
				MonoSingleton<LuaManager>.Instance?.FireEvent("SkillHintStart", _skill.skillId, fP.AsFloat());
			}
		}
		else
		{
			Attack();
		}
	}

	public void OnUpdate()
	{
		if (!_inCharge)
		{
			return;
		}
		if (_actor.logicVariable.GetLogicTagToggle("OnButtonBPress"))
		{
			bool flag = SceneSingleton<AdventurePlayerController>.Instance.HasMovementInput();
			if (_isRunLoop != flag)
			{
				_isRunLoop = flag;
				string actionTag = (flag ? "125_Main_Charge_Run_Loop" : "125_Main_Charge_Idle_Loop");
				Action onComboFinish = OnFinish;
				Action onInterrupt = OnInterrupt;
				BeginAttack(actionTag, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
			}
			if (_chargeInterval > 0)
			{
				_chargeInterval -= _actor.LogicDeltaTime;
				return;
			}
			_attackLoopTimes += _chargeAddLoopTimes;
			_attackLoopTimes = ((_attackLoopTimes > _maxLoopTimes_Attack) ? _maxLoopTimes_Attack : _attackLoopTimes);
			_actor.buffComponent?.AddBuff(12593001, _actor);
			PlayChargeFx();
			_chargeInterval = Config_MainControl.chargeInterval_Skill;
			_chargeStage++;
		}
		else
		{
			ChargeFinish();
		}
	}

	private void PlayChargeFx()
	{
		if (_chargeStage > 0 && Config_MainControl.chargeFxKeyDic_Skill.TryGetValue(_chargeStage, out var value) && !string.IsNullOrEmpty(value))
		{
			if (_chargeFxDic == null)
			{
				_chargeFxDic = new Dictionary<int, PlayFX>();
			}
			if (!_chargeFxDic.ContainsKey(_chargeStage))
			{
				_chargeFxDic.Add(_chargeStage, new PlayFX());
			}
			PlayFX playFX = _chargeFxDic.get_Item(_chargeStage);
			playFX.Stop(dontPlaySubFX: true);
			playFX.Clear();
			playFX.Play(_actor, _skill, value, 0, _actor.tsTransform.Position, TSVector2.zero);
		}
	}

	private void ChargeFinish()
	{
		_inCharge = false;
		MonoSingleton<LuaManager>.Instance?.FireEvent("SkillHintEnd", _skill.skillId);
		_actor.buffComponent?.RemoveBuffByBuffId(12593001);
		Attack();
	}

	private void Attack()
	{
		StopChargeFx();
		if (_aimTarget == null)
		{
			_aimTarget = new AimTarget();
		}
		_aimTarget.Aim(_actor, null, _actor.tsTransform.Forward);
		string comboTag_Attack = _comboTag_Attack;
		Action onAnticipationEnd = OnAttackAnticipationEnd;
		Action onComboLoop = OnAttackLoop;
		Action onRecoveryBegin = OnAttackRecoveryBegin;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(comboTag_Attack, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, onRecoveryBegin, onComboFinish, onInterrupt, onCustomEvent, null, fadeOutAnim: false, onComboLoop);
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512510, out var _))
		{
			if (_perkLogicCor_P10 != null)
			{
				_actor.StopLogicCoroutine(_perkLogicCor_P10);
			}
			_perkLogicCor_P10 = _actor.StartLogicCoroutine(PerkLogic_P10(), runImmediately: true);
		}
	}

	private void StopChargeFx(bool stopSubFx = false)
	{
		if (_chargeFxDic == null || _chargeFxDic.Count <= 0)
		{
			return;
		}
		foreach (PlayFX value in _chargeFxDic.Values)
		{
			value?.Stop(stopSubFx);
			value?.Clear();
		}
	}

	private IEnumerator PerkLogic_P10()
	{
		_actor.logicVariable.ToggleLogicTag("LockBerserkDuration", value: true);
		_additionalAttrCount_P10 = 0;
		FP checkInterval = Config_MainControl.increaseInterval_P10;
		while (true)
		{
			if (checkInterval > 0)
			{
				checkInterval -= _actor.LogicDeltaTime;
			}
			else
			{
				_additionalAttrCount_P10++;
				checkInterval = Config_MainControl.increaseInterval_P10;
			}
			yield return null;
		}
	}

	private void OnAttackAnticipationEnd()
	{
		FP fP = _attackLoopTimes * Config_MainControl.singleLoopTime_Skill_Attack;
		if (fP > 0)
		{
			MonoSingleton<LuaManager>.Instance?.FireEvent("SkillHintStart", _skill.skillId, fP.AsFloat(), a3: true);
		}
	}

	private void OnAttackLoop()
	{
		_curAttackLoopTimes++;
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512509, out var _))
		{
			string fxAlias = (_havePerk_P4 ? "AreaEffect_125_Main_P04P09_Axe" : "AreaEffect_125_Main_P09_Axe");
			if (_curAttackLoopTimes % 2 == 0)
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, _actor.tsTransform.Position);
			}
		}
		if (_curAttackLoopTimes >= _attackLoopTimes)
		{
			comboAttack?.CancelAttack();
		}
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "Add_IceFog") && _havePerk_P1)
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_125_B2P22_IceFog", _actor.tsTransform.Position);
		}
	}

	private void OnAttackRecoveryBegin()
	{
		MonoSingleton<LuaManager>.Instance?.FireEvent("SkillHintEnd", _skill.skillId);
		_aimTarget?.Cancel();
	}

	private void OnBeforeHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		if (!(adventureActorReceiveDamageBeforeHitEvent.from == _actor) || !(adventureActorReceiveDamageBeforeHitEvent.to is MonsterAdventureActor))
		{
			return;
		}
		if (_havePerk_P3 && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, Config_MainControl.damageTag_P3))
		{
			AdventureActor.AddFromAttr(12503011, _actor);
		}
		if (_havePerk_P4 && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, Config_MainControl.damageTag_P4))
		{
			int num = ((_hittedSet_P4 != null) ? _hittedSet_P4.Count : 0);
			int num2 = CommonUtils.GetScriptValue(_actor, 12504011).AsInt();
			num = ((num < num2) ? num : num2);
			if (num > 0)
			{
				AdventureActor.AddFromAttr(12504011, _actor, num);
			}
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512510, out var _) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, Config_MainControl.damageTag_P10))
		{
			int num3 = CommonUtils.GetScriptValue(_actor, 12510011).AsInt();
			int num4 = ((_additionalAttrCount_P10 < num3) ? _additionalAttrCount_P10 : num3);
			if (num4 > 0)
			{
				AdventureActor.AddFromAttr(12510001, _actor, num4);
			}
		}
	}

	protected override void OnReceiveAttack(IEvent evt)
	{
		base.OnReceiveAttack(evt);
		AdventureActorReceiveAttackEvent adventureActorReceiveAttackEvent = evt as AdventureActorReceiveAttackEvent;
		if (adventureActorReceiveAttackEvent.from == _actor && adventureActorReceiveAttackEvent.to is MonsterAdventureActor && _havePerk_P2 && CommonUtils.CheckHitByTag(adventureActorReceiveAttackEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P2))
		{
			_reduceCD_P2 += Config_MainControl.reduceCd_P2;
			_reduceCD_P2 = ((_reduceCD_P2 > Config_MainControl.maxReduceCd_P2) ? Config_MainControl.maxReduceCd_P2 : _reduceCD_P2);
		}
	}

	protected override void OnReceiveDamage(IEvent evt)
	{
		base.OnReceiveDamage(evt);
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (adventureActorReceiveDamageEvent.from == _actor && adventureActorReceiveDamageEvent.to is MonsterAdventureActor && _havePerk_P4 && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P4))
		{
			if (_hittedSet_P4 == null)
			{
				_hittedSet_P4 = new HashSet<int>();
			}
			_hittedSet_P4.Add(adventureActorReceiveDamageEvent.uniqueAttackId);
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

	private void Clear()
	{
		_isRunLoop = false;
		_havePerk_P1 = false;
		_havePerk_P2 = false;
		_havePerk_P3 = false;
		_havePerk_P4 = false;
		_curAttackLoopTimes = 0;
		_reduceCD_P2 = 0;
		_hittedSet_P4?.Clear();
		if (_perkLogicCor_P10 != null)
		{
			_actor.StopLogicCoroutine(_perkLogicCor_P10);
		}
		_perkLogicCor_P10 = null;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		StopChargeFx();
		_aimTarget?.Cancel();
		_aimTarget?.Clear();
		if (_havePerk_P2 && _reduceCD_P2 > 0)
		{
			(_actor as PlayerAdventureActor).playerSkillCd.ModifyResumeTimeAbs(-_reduceCD_P2, ActionKey.B);
		}
		if (_havePerk_P4)
		{
			_actor.DisableImmuneControl();
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512505, out var _))
		{
			_actor.buffComponent.AddBuff(12505001, _actor);
		}
		_actor.buffComponent?.RemoveBuffByBuffId(12593001);
		_actor.logicVariable.ToggleLogicTag("LockBerserkDuration", value: false);
		MonoSingleton<LuaManager>.Instance?.FireEvent("SkillHintEnd", _skill.skillId);
		Clear();
	}
}
