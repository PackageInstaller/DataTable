using System;
using System.Collections;
using TrueSync;

namespace AIScript.Character._11401;

public class SkillScript_MainControl : SkillAdvancedBase
{
	private string key_Start = "B1_Skill_Charge";

	private string key_End_1 = "B1_Shoot_Short";

	private string key_End_2 = "B1_Shoot_Long";

	private string evt_shoot2 = "shoot2";

	private string evt_CancleAim = "CancleAim";

	private readonly FP castMaxTime = 0.5;

	private int shootEvent = CommonHelper.StringToHash("shootEvent");

	private const int perkId_1 = 511401;

	private const int perkId_2 = 511402;

	private const int perkId_6 = 511406;

	private FP reduceCd_6 = 0;

	private CoroutineNode corMain;

	private bool reduceCd;

	private FP holdTime;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		reduceCd = false;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		Clear();
		if (reduceCd && GetPerk(511406))
		{
			_actor.GetLogicComponent<PlayerSkillCd>().ModifyResumeTimeAbs(reduceCd_6, ActionKey.B);
		}
	}

	public void OnStart()
	{
		StartCoroutine(ref corMain, DoMainLogic());
	}

	private void Clear()
	{
		StopCoroutine(ref corMain);
		_actor.ResumeMovementBlock();
		_actor.CancelAiming();
	}

	private void SkillFinish()
	{
		_skill?.Clear();
	}

	private void SkillInterrupt()
	{
		_skill?.Clear();
	}

	private IEnumerator DoMainLogic()
	{
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
		RequestComboAttack req = BeginAttack(key_Start, flushInputedKeys: true);
		while (!req.isAnticipationEnd)
		{
			yield return null;
		}
		holdTime = 0;
		bool flag = CheckPressHold();
		string text = (flag ? key_End_2 : key_End_1);
		if (flag)
		{
			reduceCd = true;
			while (true)
			{
				if (!CheckPressHold())
				{
					text = ((!(holdTime < castMaxTime)) ? key_End_2 : key_End_1);
					break;
				}
				if (holdTime >= castMaxTime)
				{
					text = key_End_2;
					break;
				}
				yield return null;
				holdTime += _actor.LogicDeltaTime;
			}
		}
		SkillScript_MainControl skillScript_MainControl = this;
		string actionTag = text;
		Action<string> action = onCustomEvent;
		Action onComboFinish = SkillFinish;
		Action onInterrupt = SkillInterrupt;
		skillScript_MainControl.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
	}

	private bool CheckPressHold()
	{
		bool result = _actor.logicVariable.GetLogicTagToggle("HoldingKeyD");
		if ((GetPerk(511401) || GetPerk(511402)) && (ModuleController<AdventureModuleController>.Instance.SemiAutoBattle || ModuleController<AdventureModuleController>.Instance.FullAutoBattle))
		{
			result = true;
		}
		return result;
	}

	private void onCustomEvent(string evt)
	{
		if (evt.Equals(evt_shoot2))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = _actor;
			adventureActorCustomEvent.eventHashCode = shootEvent;
			adventureActorCustomEvent.intParam = 1;
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
		else if (evt.Equals(evt_CancleAim))
		{
			LockDirection(_actor.tsTransform.Forward);
		}
	}
}
