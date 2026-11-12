using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13301;

public class SkillScript_MainControl : SkillAdvancedBase
{
	private Dictionary<int, string> dicSkillTag = new Dictionary<int, string>
	{
		[0] = "133_B1",
		[1] = "133_B1P1",
		[10] = "133_B1P2",
		[100] = "133_B1P3",
		[11] = "133_B1P1P2",
		[101] = "133_B1P1P3",
		[110] = "133_B1P2P3"
	};

	private Dictionary<int, FP> dicSkillTime = new Dictionary<int, FP>
	{
		[0] = 3,
		[1] = 3,
		[10] = 6,
		[100] = 3,
		[11] = 6,
		[101] = 3,
		[110] = 6
	};

	private readonly string event_b1p4 = "133_B1P4_Wind";

	private readonly string event_b1p42 = "133_B1P4_Wind2";

	public PlayerSkillCd skillMgr;

	private readonly string selfFx_p6 = "fx_13301_loop_Wind_Perk06_shield";

	private readonly FP angle_limt = 120;

	private FP _searchUseInputDirectionInterval = 0.2f;

	private PlayFX playFX = new PlayFX();

	private CoroutineNode corMain;

	private long areaId;

	private FP searchUseInputDirectionInterval;

	private bool _searchAndAim;

	private bool _inLoopStage;

	private AimTarget _aimTarget;

	private FP beginTime;

	private FP loopTime;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_searchAndAim = true;
		_inLoopStage = false;
		searchUseInputDirectionInterval = _searchUseInputDirectionInterval;
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = true;
		AimDirection(forceLookAtTarget: true);
		skillMgr = _actor.GetLogicComponent<PlayerSkillCd>();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref corMain);
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = false;
		Parallel.iMainSkill = false;
		if (areaId > 0)
		{
			ILRuntimeAPI.StopAreaEffect(areaId);
		}
		playFX?.Stop();
		if (GetPerk(513301))
		{
			_actor.buffComponent.RemoveBuffByBuffId(13350111);
		}
		if (GetPerk(513306))
		{
			_actor.buffComponent.RemoveBuffByBuffId(13350611);
		}
		_actor.CancelAiming();
		_aimTarget?.Cancel();
		_aimTarget?.Clear();
		if (GetPerk(513302))
		{
			FP fP = ((_actor.LogicTime - beginTime < 1) ? ((FP)1) : (_actor.LogicTime - beginTime));
			FP fP2 = loopTime - (fP - 1);
			if (fP2 > 0)
			{
				fP2 = TSMath.RoundToInt(fP2);
				FP resumeTimeAbs = -skillMgr.GetSkillCD(ActionKey.B).originalSectionResumeTime * fP2 * 5 / 100;
				(_actor as PlayerAdventureActor).playerSkillCd.ModifyResumeTimeAbs(resumeTimeAbs, ActionKey.B);
			}
		}
	}

	public void OnStart()
	{
		if (GetPerk(513306))
		{
			_actor.buffComponent.AddBuff(13350611, _actor);
		}
		StartCoroutine(ref corMain, DoMainLogic());
	}

	protected void onFinishOrInterrupt()
	{
		_skill.Clear();
	}

	protected void OnCustomEvent(string evt)
	{
		if (GetPerk(513304))
		{
			areaId = 0L;
			if (string.Equals(evt, event_b1p4))
			{
				areaId = ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_13301_B1P4_Wind", _actor.tsTransform.Position, _actor.tsTransform.Rotation);
			}
			else if (string.Equals(evt, event_b1p42))
			{
				areaId = ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_13301_B1P4_Wind2", _actor.tsTransform.Position, _actor.tsTransform.Rotation);
			}
		}
	}

	protected virtual void OnRecoveryBegin()
	{
		_searchAndAim = false;
		_inLoopStage = false;
		if (GetPerk(513310))
		{
			_actor.buffComponent.AddBuff(13351011, _actor);
		}
		playFX?.Stop();
		_aimTarget?.Aim(_actor, _actor.attackTarget as AdventureActor);
		if (!GetPerk(513303))
		{
			_aimTarget?.Cancel();
		}
	}

	protected virtual void OnAnticipationEnd()
	{
		_inLoopStage = true;
		if (GetPerk(513306))
		{
			playFX.Play(_actor, selfFx_p6, 1f, _actor.transform.position, _actor.transform.rotation);
		}
	}

	private IEnumerator DoMainLogic()
	{
		Parallel.perk2_Time = _actor.LogicTime;
		Parallel.iMainSkill = true;
		if (GetPerk(513308))
		{
			_actor.buffComponent.AddBuff(13350811, _actor);
		}
		int num = 0;
		if (GetPerk(513301))
		{
			num++;
			_actor.buffComponent.AddBuff(13350111, _actor);
		}
		if (GetPerk(513302))
		{
			num += 10;
		}
		if (GetPerk(513303))
		{
			num += 100;
		}
		SkillScript_MainControl skillScript_MainControl = this;
		string actionTag = dicSkillTag.get_Item(num);
		Action onComboFinish = onFinishOrInterrupt;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onInterrupt = onFinishOrInterrupt;
		Action onAnticipationEnd = OnAnticipationEnd;
		Action onRecoveryBegin = OnRecoveryBegin;
		skillScript_MainControl.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, onRecoveryBegin, onComboFinish, onInterrupt, onCustomEvent);
		beginTime = _actor.LogicTime;
		loopTime = dicSkillTime.get_Item(num);
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(loopTime));
		_actor.CancelAttack();
	}

	public void OnUpdate()
	{
		if (!_searchAndAim)
		{
			return;
		}
		if (searchUseInputDirectionInterval > 0)
		{
			searchUseInputDirectionInterval -= _actor.LogicDeltaTime;
			if (!CommonUtils.CheckTargetIsValid(_actor.attackTarget, 0L))
			{
				_actor.attackTarget = _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: false, dontLostTarget: true);
			}
		}
		else
		{
			searchUseInputDirectionInterval = _searchUseInputDirectionInterval;
			bool useInputDirection = _actor.actorSearchTargetInfo.GetEnterVisionAlertActors(useInputDirection: true).Count > 0;
			_actor.attackTarget = _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection, dontLostTarget: true);
		}
		AimDirection();
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
			FP fP2 = angle_limt * _actor.LogicDeltaTime;
			fP = ((TSMath.Abs(fP) < fP2) ? fP : (fP2 * TSMath.Sign(fP)));
			tSVector = TSVector2.Rotate(_actor.tsTransform.Forward, fP);
			_actor.tsTransform.Forward = tSVector;
		}
	}
}
