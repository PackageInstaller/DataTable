using System;
using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._10301;

public class SkillScript_Ultra : SkillAdvancedBase
{
	private string actionKey1 = "Ultra_TL";

	private string actionKey2 = "Ultra_NoTL";

	private FP radius = 15;

	private FP loopTime = 5;

	private const int perkId_2 = 510342;

	private PlayTimeline _playTimeline = new PlayTimeline();

	private CoroutineNode corMain;

	private string actionKey;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.EnableInvincible();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		Clear();
	}

	public void OnStart()
	{
		_playTimeline.Play(_actor, () =>
		{
			actionKey = actionKey1;
			StartCoroutine(ref corMain, DoMainLogic());
		}, () =>
		{
			actionKey = actionKey2;
			StartCoroutine(ref corMain, DoMainLogic());
		});
	}

	public void OnUpdate()
	{
	}

	private void Clear()
	{
		StopCoroutine(ref corMain);
		_actor.DisableInvincible();
	}

	private void OnFinishOrInterrupt()
	{
		_skill?.Clear();
	}

	private IEnumerator DoMainLogic()
	{
		LogicEntity target = SearchTarget();
		if (target != null)
		{
			_actor.LookAtDir((target.tsTransform.Position - _actor.tsTransform.Position).normalized, 0);
		}
		SkillScript_Ultra skillScript_Ultra = this;
		string actionTag = actionKey;
		Action<string> action = onCustomEvent;
		Action onComboFinish = OnFinishOrInterrupt;
		Action onInterrupt = OnFinishOrInterrupt;
		RequestComboAttack req = skillScript_Ultra.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
		while (!req.isAnticipationEnd)
		{
			yield return null;
		}
		if (GetPerkLv(510342, out var _))
		{
			_actor.GetLogicComponent<PlayerSkillCd>().ResetSkillCD(ActionKey.B);
		}
		FP curTime = loopTime;
		while (curTime > 0 && target != null && !target.IsDead())
		{
			_actor.LookAt(target.tsTransform.Position, 0);
			curTime -= _actor.LogicDeltaTime;
			yield return null;
		}
		_actor.StopRotate();
		_actor.CancelAttack();
	}

	private void onCustomEvent(string eventName)
	{
	}

	private LogicEntity SearchTarget()
	{
		return GetAttackTarget() ?? CommonUtils.SearchNearTargetByCircle(_actor, radius);
	}

	private LogicEntity GetAttackTarget()
	{
		if ((_actor as PlayerAdventureActor).isAssist)
		{
			return CommonUtils.GetAssistantAttackTarget(_actor);
		}
		return _actor.attackTarget;
	}

	public bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}
}
