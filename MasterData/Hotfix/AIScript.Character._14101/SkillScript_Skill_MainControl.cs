using System;
using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14101;

public class SkillScript_Skill_MainControl : SkillAdvancedBase
{
	private bool _searchAndAim;

	private bool _inLoopStage;

	private FP _searchUseInputDirectionInterval;

	private FP _loopTime;

	private AimTarget _aimTarget;

	private CoroutineNode _perkLogic_P2;

	private CoroutineNode _perkLogic_P4;

	private bool inSupArm;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		inSupArm = false;
		_searchAndAim = true;
		_inLoopStage = false;
		_loopTime = 0;
		_actor.buffComponent.AddBuff(14193011, _actor);
		_actor.attackTarget = _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: true, dontLostTarget: true);
		_searchUseInputDirectionInterval = Config_MainControl.interval_searchTargetUseInputDirection;
		AimDirection(forceLookAtTarget: true);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514110, out var _))
		{
			inSupArm = true;
			_actor.buffComponent?.AddBuff(14110011, _actor);
			_actor.actorShield.AddShield(14110001, _actor);
		}
	}

	public void OnStart()
	{
		string text = "141_Main_Skill";
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514104, out var perkLevel))
		{
			text = ((!CommonUtils.HavePersonalPerk(_actor.dataID, 514109, out perkLevel)) ? "141_Main_Skill_P04" : "141_Main_Skill_P04P09");
		}
		else if (CommonUtils.HavePersonalPerk(_actor.dataID, 514109, out perkLevel))
		{
			text = "141_Main_Skill_P09";
		}
		string actionTag = text;
		Action onAnticipationEnd = OnAnticipationEnd;
		Action onRecoveryBegin = OnRecoveryBegin;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, onRecoveryBegin, onComboFinish, onInterrupt);
	}

	private void OnAnticipationEnd()
	{
		_inLoopStage = true;
		_loopTime = Config_MainControl.loopTime_Skill;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514101, out var perkLevel))
		{
			_loopTime += Config_MainControl.addSkillLoopTime_P1;
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514102, out perkLevel))
		{
			_perkLogic_P2 = _actor.StartLogicCoroutine(PerkLogic_P2(), runImmediately: true);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514104, out perkLevel))
		{
			_perkLogic_P4 = _actor.StartLogicCoroutine(PerkLogic_P4(), runImmediately: true);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514107, out perkLevel))
		{
			foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
			{
				actorL.buffComponent.AddBuff(14107011, _actor);
			}
		}
		MonoSingleton<LuaManager>.Instance?.FireEvent("SkillHintStart", _skill.skillId, _loopTime.AsFloat(), a3: true);
	}

	private IEnumerator PerkLogic_P2()
	{
		FP interval = Config_MainControl.addInterval_SuperpositionBuff_P2;
		while (true)
		{
			interval -= _actor.LogicDeltaTime;
			if (interval <= 0)
			{
				if (_actor.buffComponent.CheckBuffByBuffID(14102012))
				{
					if (_actor.buffComponent.GetBuffNumByID(14102013) < 60)
					{
						_actor.buffComponent.AddBuff(14102013, _actor);
					}
				}
				else
				{
					_actor.buffComponent.AddBuff(14102011, _actor);
					if (_actor.buffComponent.GetBuffNumByID(14102011) >= 60)
					{
						_actor.logicVariable.SetLogicTagValue("NormalAttackStage_Special_P2", 0);
						_actor.buffComponent.RemoveBuffByBuffId(14102011);
						_actor.buffComponent.AddBuff(14102012, _actor);
						for (int i = 0; i < 60; i++)
						{
							_actor.buffComponent.AddBuff(14102013, _actor);
						}
					}
				}
				interval += Config_MainControl.addInterval_SuperpositionBuff_P2;
			}
			yield return null;
		}
	}

	private IEnumerator PerkLogic_P4()
	{
		for (int i = 0; i < 4; i++)
		{
			_actor.buffComponent.AddBuff(14104011, _actor);
		}
		FP interval = Config_MainControl.reduceBuffInterval_P4;
		while (true)
		{
			interval -= _actor.LogicDeltaTime;
			if (interval <= 0)
			{
				_actor.buffComponent.RemoveBuffByBuffId(14104011, 1);
				if (_actor.buffComponent.GetBuffNumByID(14104011) <= 0)
				{
					break;
				}
				interval += Config_MainControl.reduceBuffInterval_P4;
			}
			yield return null;
		}
	}

	public void OnUpdate()
	{
		if (_searchAndAim)
		{
			if (_searchUseInputDirectionInterval > 0)
			{
				_searchUseInputDirectionInterval -= _actor.LogicDeltaTime;
				if (!CommonUtils.CheckTargetIsValid(_actor.attackTarget, 0L))
				{
					_actor.attackTarget = _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: false, dontLostTarget: true);
				}
			}
			else
			{
				_searchUseInputDirectionInterval = Config_MainControl.interval_searchTargetUseInputDirection;
				bool useInputDirection = _actor.actorSearchTargetInfo.GetEnterVisionAlertActors(useInputDirection: true).Count > 0;
				_actor.attackTarget = _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection, dontLostTarget: true);
			}
			AimDirection();
		}
		if (_inLoopStage)
		{
			if (_loopTime > 0)
			{
				_loopTime -= _actor.LogicDeltaTime;
			}
			else
			{
				comboAttack.CancelAttack();
			}
		}
	}

	private void AimDirection(bool forceLookAtTarget = false)
	{
		if (_aimTarget == null)
		{
			_aimTarget = new AimTarget();
		}
		if (_actor.aimMode != AdventureActor.AimMode.LockDirection)
		{
			_aimTarget.Aim(_actor, null, _actor.tsTransform.Forward);
		}
		TSVector2 tSVector;
		if (_actor.attackTarget != null)
		{
			tSVector = (_actor.attackTarget.tsTransform.Position - _actor.tsTransform.Position).normalized;
			if (forceLookAtTarget)
			{
				_actor.tsTransform.Forward = tSVector;
				return;
			}
		}
		else
		{
			tSVector = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
		}
		if (!(tSVector == TSVector2.zero) && !(tSVector == _actor.tsTransform.Forward))
		{
			FP fP = TSVector2.SignedAngle(_actor.tsTransform.Forward, tSVector);
			FP fP2 = Config_MainControl.maxRotateSpeed_Skill * _actor.LogicDeltaTime;
			fP = ((TSMath.Abs(fP) < fP2) ? fP : (fP2 * TSMath.Sign(fP)));
			tSVector = TSVector2.Rotate(_actor.tsTransform.Forward, fP);
			_actor.tsTransform.Forward = tSVector;
		}
	}

	private void OnRecoveryBegin()
	{
		MonoSingleton<LuaManager>.Instance?.FireEvent("SkillHintEnd", _skill.skillId);
		_aimTarget?.Cancel();
		_searchAndAim = false;
		_inLoopStage = false;
		_loopTime = 0;
		ClearPerkLogic();
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	private void ClearPerkLogic()
	{
		if (_perkLogic_P2 != null)
		{
			_actor.StopLogicCoroutine(_perkLogic_P2);
		}
		_perkLogic_P2 = null;
		if (_perkLogic_P4 != null)
		{
			_actor.StopLogicCoroutine(_perkLogic_P4);
		}
		_perkLogic_P4 = null;
		_actor.buffComponent.RemoveBuffByBuffId(14104011);
		foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
		{
			actorL.buffComponent.RemoveBuffByBuffId(14107011);
		}
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.buffComponent.RemoveBuffByBuffId(14193011);
		ClearPerkLogic();
		MonoSingleton<LuaManager>.Instance?.FireEvent("SkillHintEnd", _skill.skillId);
		_aimTarget?.Cancel();
		_aimTarget?.Clear();
		if (inSupArm)
		{
			_actor.buffComponent?.RemoveBuffByBuffId(14110011);
		}
	}
}
