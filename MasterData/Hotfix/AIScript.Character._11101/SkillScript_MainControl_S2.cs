using System;
using System.Collections;
using TrueSync;

namespace AIScript.Character._11101;

public class SkillScript_MainControl_S2 : SkillAdvancedBase
{
	private string key = "B1P03_Skill_S2";

	private string key_P5 = "B1P03P05_Skill_S2";

	private FP baseTime = 5;

	private int skillId_S1 = 11131001;

	private const int perkId_5 = 511105;

	private CoroutineNode corMain;

	private FP dTime;

	public PlayerSkillCd skillMgr;

	private bool isReBind;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		skillMgr = _actor.GetLogicComponent<PlayerSkillCd>();
		dTime = 0;
		isReBind = false;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref corMain);
		_actor.CancelAiming();
		ReBindS1(isInterrupt: true);
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

	private void onFinishOrInterrupt()
	{
		_skill?.Clear();
	}

	private IEnumerator DoMainLogic()
	{
		if (GetPerkLv(511105, out var _))
		{
			key = key_P5;
		}
		SkillScript_MainControl_S2 skillScript_MainControl_S = this;
		string actionTag = key;
		Action onInterrupt = onFinishOrInterrupt;
		Action onComboFinish = onFinishOrInterrupt;
		skillScript_MainControl_S.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt);
		dTime = 0;
		while (!(dTime > baseTime))
		{
			dTime += _actor.LogicDeltaTime;
			yield return null;
		}
		ReBindS1(isInterrupt: false);
		_actor.CancelAttack();
	}

	private void ReBindS1(bool isInterrupt)
	{
		if (!isReBind)
		{
			isReBind = true;
			AdventurRebindSkill adventurRebindSkill = AdventurRebindSkill.Generate();
			adventurRebindSkill.sender = _actor;
			adventurRebindSkill.slotKey = ActionKey.B;
			adventurRebindSkill.skillId = skillId_S1;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventurRebindSkill);
		}
	}

	public bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}
}
