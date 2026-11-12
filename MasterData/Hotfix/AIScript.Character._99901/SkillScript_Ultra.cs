using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._99901;

public class SkillScript_Ultra : SkillAdvancedBase
{
	private const string actionKey1 = "999_Ultra_TL";

	private const string actionKey2 = "999_Ultra_NoTL";

	private const string evt_End = "999_Ultra_End";

	private readonly FP rotateSpeed = 60;

	private readonly FP rotateTime = 0.7;

	private CoroutineNode corMain;

	private PlayTimeline _playTimeline = new PlayTimeline();

	private long areaEffectId;

	private string actionKey;

	private TSVector2 _bornForward;

	private bool _endRotating;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_bornForward = _actor.tsTransform.Forward;
		_endRotating = false;
		_actor.EnableInvincible();
		_actor.EnableSuperArmor();
		_actor.EnableImmuneControl();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		Clear();
	}

	public void OnStart()
	{
		MonoSingleton<LuaManager>.Instance.FireEvent("UICloseEvent", a1: false);
		_playTimeline.Play(_actor, () =>
		{
			actionKey = "999_Ultra_TL";
			MonoSingleton<LuaManager>.Instance.FireEvent("UICloseEvent", a1: true);
			DoMainLogic(hasTimeline: true);
		}, () =>
		{
			actionKey = "999_Ultra_NoTL";
			MonoSingleton<LuaManager>.Instance.FireEvent("UICloseEvent", a1: true);
			DoMainLogic(hasTimeline: false);
		});
	}

	public void OnUpdate()
	{
		DoUpdateLogic();
	}

	private void OnFinishOrInterrupt()
	{
		_skill?.Clear();
	}

	private void Clear()
	{
		StopCoroutine(ref corMain);
		if (areaEffectId > 0)
		{
			ILRuntimeAPI.StopAreaEffect(areaEffectId);
			areaEffectId = 0L;
		}
		_actor.DisableInvincible();
		_actor.DisableSuperArmor();
		_actor.DisableImmuneControl();
	}

	private void DoMainLogic(bool hasTimeline)
	{
		string actionTag = actionKey;
		Action<string> onCustomEvent = OnCustomEvent;
		System.Action onComboFinish = OnFinishOrInterrupt;
		System.Action onInterrupt = OnFinishOrInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string evt)
	{
		if (evt.Equals("999_Ultra_End"))
		{
			_endRotating = true;
			_actor.LookAtDir(_bornForward, rotateTime);
		}
	}

	private void DoUpdateLogic()
	{
		if (_endRotating)
		{
			return;
		}
		TSVector2 movementInputDirection = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
		if (!(movementInputDirection == TSVector2.zero))
		{
			movementInputDirection = movementInputDirection.normalized;
			TSVector2 forward = _actor.tsTransform.Forward;
			FP fP = TSVector2.SignedAngle(forward, movementInputDirection);
			FP fP2 = rotateSpeed * _actor.LogicDeltaTime;
			if (fP > fP2)
			{
				fP = fP2;
			}
			else if (fP < -fP2)
			{
				fP = -fP2;
			}
			TSVector2 dir = TSVector2.Rotate(forward, fP);
			_actor.LookAtDir(dir, 0);
		}
	}
}
