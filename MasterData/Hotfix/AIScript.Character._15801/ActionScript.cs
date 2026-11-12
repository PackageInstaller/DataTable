using System;
using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15801;

public class ActionScript : ActorActionBase
{
	private CoroutineNode _transformLogicCor;

	private AimTarget _aimTarget;

	private CoroutineNode _perkLogicCor_P43;

	protected bool InTransformState
	{
		get
		{
			if (((PlayerAdventureActor)_actor).status == ActorStatus.Special)
			{
				return ((PlayerAdventureActor)_actor).specialStatusTime > 0;
			}
			return false;
		}
	}

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		if (InTransformState)
		{
			ChangeTransformState(isTransform: true);
			_actor.ActiveVariantModelGroup("toylaru");
			_actor.ReplaceAnimationGroup();
			if (_transformLogicCor != null)
			{
				_actor.StopLogicCoroutine(_transformLogicCor);
			}
			_transformLogicCor = _actor.StartLogicCoroutine(TransformLogic(((PlayerAdventureActor)_actor).specialStatusTime, ((PlayerAdventureActor)_actor).isAssist), runImmediately: true);
		}
	}

	public override void OnStart()
	{
		base.OnStart();
		if (_aimTarget == null)
		{
			_aimTarget = new AimTarget();
		}
		_aimTarget.Clear();
	}

	public virtual void OnUpdate()
	{
	}

	protected bool BeginTransfrom(Action finishCallBack = null)
	{
		if (ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.D), _actor, SkillPhaseFeatureFlag.Ultimate, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, (bool success) =>
		{
			TransfromFinish(success);
			finishCallBack?.Invoke();
		}))
		{
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 5))
			{
				foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
				{
					if (actorL.actorElementInfo.elementType == HotfixEnum.elementType.FE)
					{
						actorL.buffComponent.AddBuff(15896311, _actor);
					}
				}
			}
			ChangeTransformState(isTransform: true);
			return true;
		}
		return false;
	}

	private void ChangeTransformState(bool isTransform)
	{
		if (isTransform)
		{
			_actor.actorInfo.assistSkillRadius = Config.assistSkillRadius_Transform;
			_actor.actorSearchTargetInfo.AddSearchRange(Config.addAttackRange_Transform, ActorSearchTarget.SearchType.vAttackRange);
			_actor.actorSearchTargetInfo.AddSearchRange(Config.addAttackRange_Transform, ActorSearchTarget.SearchType.hAttackRange);
			_actor.actorSearchTargetInfo.aimRange = Config.aimRange_Transfrom;
			if (!_actor.disableCastDodge)
			{
				_actor.DisableCastDodge();
			}
			if (!_actor.forbiddenRush)
			{
				_actor.EnableForbiddenRush();
			}
			if (!_actor.disableCastUltra)
			{
				_actor.DisableCastUltra();
			}
			_actor.RefreshSkillUseable();
			_playerSkillCd.BindSkillIdToButton(ActionKey.Normal, 15810001);
			_playerSkillCd.BindSkillIdToButton(ActionKey.B, 15834001);
		}
		else
		{
			_actor.actorInfo.assistSkillRadius = _actor.actorInfo.originAssistSkillRadius;
			_actor.actorSearchTargetInfo.AddSearchRange(-Config.addAttackRange_Transform, ActorSearchTarget.SearchType.vAttackRange);
			_actor.actorSearchTargetInfo.AddSearchRange(-Config.addAttackRange_Transform, ActorSearchTarget.SearchType.hAttackRange);
			_actor.actorSearchTargetInfo.aimRange = _actor.actorSearchTargetInfo.originAimRange;
			if (_actor.disableCastDodge)
			{
				_actor.EnableCastDodge();
			}
			if (_actor.forbiddenRush)
			{
				_actor.DisableForbiddenRush();
			}
			if (_actor.disableCastUltra)
			{
				_actor.EnableCastUltra();
			}
			_actor.RefreshSkillUseable();
			_playerSkillCd.BindSkillIdToButton(ActionKey.Normal, 15810000);
			_playerSkillCd.BindSkillIdToButton(ActionKey.B, GetDefaultSkillId());
		}
	}

	private void TransfromFinish(bool success)
	{
		if (success)
		{
			OnTransfromFinish();
			if (_transformLogicCor != null)
			{
				_actor.StopLogicCoroutine(_transformLogicCor);
			}
			_transformLogicCor = _actor.StartLogicCoroutine(TransformLogic(CommonUtils.GetScriptValue(_actor, 15840001)), runImmediately: true);
		}
	}

	protected virtual void OnTransfromFinish()
	{
	}

	private bool BeginReturn()
	{
		if (ILRuntimeAPI.CreateSkill(15834002, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, ReturnFinish))
		{
			ChangeTransformState(isTransform: false);
			return true;
		}
		return false;
	}

	protected virtual int GetDefaultSkillId()
	{
		return 0;
	}

	private void ReturnFinish(bool success)
	{
		if (success)
		{
			_aimTarget.Cancel();
			OnReturnFinish();
		}
	}

	protected virtual void OnReturnFinish()
	{
	}

	private IEnumerator TransformLogic(FP durationTime, bool needAddShield = true)
	{
		((PlayerAdventureActor)_actor).status = ActorStatus.Special;
		((PlayerAdventureActor)_actor).specialStatusTime = durationTime;
		if (needAddShield)
		{
			_actor.actorShield.AddShield(15840011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515843, out var _))
		{
			if (_perkLogicCor_P43 != null)
			{
				_actor.StopLogicCoroutine(_perkLogicCor_P43);
			}
			_perkLogicCor_P43 = _actor.StartLogicCoroutine(PerkLogic_P43(), runImmediately: true);
		}
		while (((PlayerAdventureActor)_actor).specialStatusTime > 0)
		{
			OnTransformUpdate();
			((PlayerAdventureActor)_actor).specialStatusTime -= _actor.LogicDeltaTime;
			yield return null;
		}
		((PlayerAdventureActor)_actor).status = ActorStatus.Default;
		((PlayerAdventureActor)_actor).specialStatusTime = 0;
		while (!BeginReturn())
		{
			yield return null;
		}
		_actor.actorShield.RemoveShieldByShieldID(15840011);
		_transformLogicCor = null;
	}

	private IEnumerator PerkLogic_P43()
	{
		FP interval = Config.interval_AddBuff_P43;
		while (InTransformState)
		{
			interval -= _actor.LogicDeltaTime;
			if (interval <= 0)
			{
				foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
				{
					if (actorL.actorElementInfo.elementType == HotfixEnum.elementType.FE)
					{
						actorL.buffComponent.AddBuff(15843011, _actor);
					}
				}
				interval += Config.interval_AddBuff_P43;
			}
			yield return null;
		}
		foreach (PlayerAdventureActor actorL2 in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
		{
			if (actorL2.actorElementInfo.elementType == HotfixEnum.elementType.FE)
			{
				actorL2.buffComponent.RemoveBuffByBuffId(15843011);
			}
		}
		_perkLogicCor_P43 = null;
	}

	protected virtual void OnTransformUpdate()
	{
		_actor.attackTarget = GetTransformAttackTarget();
		if (_actor.attackTarget == null || IsObstacleBetweenActorAndTargetAndPreventNormalAttack)
		{
			if (_actor.aimMode != AdventureActor.AimMode.Forward)
			{
				_aimTarget.Cancel();
			}
			return;
		}
		FP fP = _actor.DistanceWithRadius(_actor.attackTarget);
		if (fP < CommonUtils.GetAimRange(_actor))
		{
			if (_actor.aimMode != AdventureActor.AimMode.AimAtAttackTarget)
			{
				_aimTarget.Aim(_actor, (AdventureActor)_actor.attackTarget, default, playStartAnim: true);
			}
			if (fP <= CommonUtils.GetAttackRange(_actor) && _actor.aimMode == AdventureActor.AimMode.AimAtAttackTarget && ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.Normal), _actor, SkillPhaseFeatureFlag.Normal, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false))
			{
				OnTransformNormalAttack();
			}
		}
		else if (_actor.aimMode != AdventureActor.AimMode.Forward)
		{
			_aimTarget.Cancel();
		}
	}

	protected virtual LogicEntity GetTransformAttackTarget()
	{
		return _actor.attackTarget;
	}

	protected virtual void OnTransformNormalAttack()
	{
	}

	public override void OnStop()
	{
		base.OnStop();
		_aimTarget?.Cancel();
		_aimTarget?.Clear();
		if (_transformLogicCor != null)
		{
			_actor.StopLogicCoroutine(_transformLogicCor);
		}
		_transformLogicCor = null;
		if (_perkLogicCor_P43 != null)
		{
			_actor.StopLogicCoroutine(_perkLogicCor_P43);
		}
		_perkLogicCor_P43 = null;
	}

	private void ClearTransformState()
	{
		_actor.actorInfo.assistSkillRadius = _actor.actorInfo.originAssistSkillRadius;
		_actor.actorSearchTargetInfo.ResetSearchRange(ActorSearchTarget.SearchType.allRange);
		_actor.actorSearchTargetInfo.aimRange = _actor.actorSearchTargetInfo.originAimRange;
		if (_actor.disableCastDodge)
		{
			_actor.EnableCastDodge();
		}
		if (_actor.forbiddenRush)
		{
			_actor.DisableForbiddenRush();
		}
		if (_actor.disableCastUltra)
		{
			_actor.EnableCastUltra();
		}
		_actor.RefreshSkillUseable();
		_actor.ActiveDefaultModelGroup();
		_actor.ResumeAnimationGroup();
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		ClearTransformState();
	}
}
