using System;
using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11301;

public class SkillScript_MainControl_S2 : SkillAdvancedBase
{
	private Dictionary<int, string> dicKey_1 = new Dictionary<int, string>
	{
		[0] = "Main_S2_1",
		[2] = "Main_S2_P02",
		[1] = "Main_S2_1_P03",
		[3] = "Main_S2_P02&03"
	};

	private Dictionary<int, string> dicKey_2 = new Dictionary<int, string>
	{
		[0] = "Main_S2_2",
		[2] = "Main_S2_P02",
		[1] = "Main_S2_2_P03",
		[3] = "Main_S2_P02&03"
	};

	private string evt_P04 = "P04";

	private string areaEffect_P04 = "AreaEffect_11301_Skill_Main_P04_Wave";

	private string areaEffect_P03_04 = "AreaEffect_11301_Skill_Main_P04_Wave_Ex";

	private string evt_Input = "113Turn";

	private const int perkId_2 = 511302;

	private const int perkId_3 = 511303;

	private const int perkId_4 = 511304;

	private CoroutineNode corMain;

	private LookAtTarget lookAtTarget = new LookAtTarget();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.movementFSM.runtimeIgonreRootMotion = false;
	}

	public void OnStart()
	{
		StartCoroutine(ref corMain, DoMainLogic());
	}

	public void SkillFinish()
	{
		_skill?.Clear();
	}

	public void SkillInterrupt()
	{
		_skill?.Clear();
	}

	public void OnUpdate()
	{
	}

	private void UpdateRootMotionState()
	{
		TSVector2 movementInputDirection = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
		if (movementInputDirection != TSVector2.zero)
		{
			CancelLockDirection();
			_actor.tsTransform.Forward = movementInputDirection;
		}
		else
		{
			LockDirection();
		}
	}

	private IEnumerator DoMainLogic()
	{
		int num = (GetPerkLv(511302, out var lv) ? 2 : 0);
		int num2 = (GetPerkLv(511303, out lv) ? 1 : 0);
		int finalKey = num | num2;
		string text = dicKey_1.get_Item(finalKey);
		SkillScript_MainControl_S2 skillScript_MainControl_S = this;
		string actionTag = text;
		Action<string> action = onCustomEvent;
		Action onInterrupt = SkillInterrupt;
		RequestComboAttack req = skillScript_MainControl_S.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, onInterrupt, action, null, fadeOutAnim: false, null, recoveryBeginCheckCdStart: false);
		while (!req.isRecoveryBegin)
		{
			yield return null;
		}
		text = dicKey_2.get_Item(finalKey);
		SkillScript_MainControl_S2 skillScript_MainControl_S2 = this;
		string actionTag2 = text;
		action = onCustomEvent;
		onInterrupt = SkillFinish;
		Action onInterrupt2 = SkillInterrupt;
		skillScript_MainControl_S2.BeginAttack(actionTag2, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onInterrupt, onInterrupt2, action, null, fadeOutAnim: true);
	}

	private void onCustomEvent(string evt)
	{
		if (evt.Equals(evt_P04))
		{
			bool perkLv = GetPerkLv(511303, out var lv);
			if (GetPerkLv(511304, out lv))
			{
				if (perkLv)
				{
					ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_P03_04, _actor.tsTransform.Position);
				}
				else
				{
					ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_P04, _actor.tsTransform.Position);
				}
			}
		}
		else if (evt.Equals(evt_Input))
		{
			TSVector2 movementInputDirection = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
			if (movementInputDirection != TSVector2.zero)
			{
				_actor.LookAtDir(movementInputDirection, 0);
			}
			else if (_actor.attackTarget != null)
			{
				movementInputDirection = (_actor.attackTarget.tsTransform.Position - _actor.tsTransform.Position).normalized;
				_actor.LookAtDir(movementInputDirection, 0);
			}
		}
	}

	private bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}
}
