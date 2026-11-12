using System;
using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11301;

public class SkillScript_MainControl : SkillAdvancedBase
{
	private Dictionary<int, string> dicKey = new Dictionary<int, string>
	{
		[0] = "Main_S1",
		[2] = "Main_S1_P02",
		[1] = "Main_S1_P03",
		[3] = "Main_S1_P02&03"
	};

	public int loopCount = 3;

	public int loopCount_P01 = 6;

	private string evt_P04 = "P04";

	private string areaEffect_P04 = "AreaEffect_11301_Skill_Main_P04_Wave";

	private string areaEffect_P03_04 = "AreaEffect_11301_Skill_Main_P04_Wave_Ex";

	public int skillId_S2 = 11331002;

	private const int perkId_1 = 511301;

	private const int perkId_2 = 511302;

	private const int perkId_3 = 511303;

	private const int perkId_4 = 511304;

	private const int perkId_5 = 511305;

	private int mLoopCount;

	private int curLoopCount;

	private CoroutineNode corMain;

	public PlayerSkillCd skillMgr;

	private bool triggerS2;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		skillMgr = _actor.GetLogicComponent<PlayerSkillCd>();
		curLoopCount = 0;
		triggerS2 = false;
		if (GetPerkLv(511305, out var _))
		{
			_actor.EnableSuperArmor();
		}
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref corMain);
		_actor.CancelAiming();
		if (GetPerkLv(511305, out var _))
		{
			_actor.DisableSuperArmor();
		}
		if (!triggerS2)
		{
			RebindSkill();
		}
	}

	public void OnStart()
	{
		StartCoroutine(ref corMain, DoMainLogic());
	}

	public void OnUpdate()
	{
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
	}

	public void SkillFinish()
	{
		_skill?.Clear();
	}

	public void SkillInterrupt()
	{
		_skill?.Clear();
	}

	private IEnumerator DoMainLogic()
	{
		mLoopCount = loopCount;
		if (GetPerkLv(511301, out var lv))
		{
			mLoopCount = loopCount_P01;
		}
		int num = (GetPerkLv(511302, out lv) ? 2 : 0);
		int num2 = (GetPerkLv(511303, out lv) ? 1 : 0);
		int key = num | num2;
		string key2 = dicKey.get_Item(key);
		while (curLoopCount < mLoopCount)
		{
			curLoopCount++;
			_actor.CancelAiming();
			_actor.AimAtTarget(_actor.attackTarget);
			SkillScript_MainControl skillScript_MainControl = this;
			LogicEntity attackTarget = _actor.attackTarget;
			Action<string> action = onCustomEvent;
			Action onInterrupt = SkillInterrupt;
			Action onComboFinish = SkillFinish;
			bool recoveryBeginCheckCdStart = curLoopCount == mLoopCount;
			RequestComboAttack req = skillScript_MainControl.BeginAttack(key2, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: true, attackTarget, null, default, null, null, onComboFinish, onInterrupt, action, null, fadeOutAnim: false, null, recoveryBeginCheckCdStart);
			while (!req.isRecoveryBegin)
			{
				yield return null;
			}
			if (curLoopCount == mLoopCount)
			{
				triggerS2 = true;
				RebindSkill();
			}
		}
	}

	private void onCustomEvent(string evt)
	{
		if (!evt.Equals(evt_P04))
		{
			return;
		}
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

	private bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}

	private void RebindSkill()
	{
		AdventurRebindSkill adventurRebindSkill = AdventurRebindSkill.Generate();
		adventurRebindSkill.sender = _actor;
		adventurRebindSkill.slotKey = ActionKey.B;
		adventurRebindSkill.skillId = skillId_S2;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventurRebindSkill);
	}
}
