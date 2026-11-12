using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._12701;

public class SkillScript_MainControl_S2 : SkillAdvancedBase
{
	private FP intervalTime = 0.32f;

	private string key_Base = "127_B1_Skill_Derive";

	private string key_1 = "127_B1_Skill_Derive_Strength";

	private CoroutineNode corMain;

	private LookAtTarget lookAtTarget = new LookAtTarget();

	private AimTarget aimTarget = new AimTarget();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref corMain);
		aimTarget.Cancel();
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	private void SkillFinish()
	{
		_skill?.Clear();
	}

	private void SkillInterrupt()
	{
		_skill?.Clear();
	}

	public void OnUpdate()
	{
		if (ModuleController<AdventureModuleController>.Instance.SemiAutoBattle && _actor.attackTarget != null)
		{
			aimTarget.Aim(_actor, _actor.attackTarget as AdventureActor);
		}
	}

	private void DoMainLogic()
	{
		string text = key_Base;
		FP logicTagValue = _actor.logicVariable.GetLogicTagValue("SetSkillTime");
		if (!_actor.logicVariable.GetLogicTagToggle("127_Interrupt") && _actor.LogicTime - logicTagValue >= intervalTime)
		{
			text = key_1;
		}
		TSVector2 tSVector = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
		if (tSVector == TSVector2.zero && _actor.attackTarget == null)
		{
			tSVector = _actor.tsTransform.Forward;
		}
		if (tSVector != TSVector2.zero)
		{
			_actor.LookAtDir(tSVector, 0f);
			string actionTag = text;
			System.Action onComboFinish = SkillFinish;
			System.Action onInterrupt = SkillInterrupt;
			BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, null, null, fadeOutAnim: true);
		}
		else
		{
			string actionTag2 = text;
			System.Action onInterrupt = SkillFinish;
			System.Action onComboFinish = SkillInterrupt;
			BeginAttack(actionTag2, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onInterrupt, onComboFinish, null, null, fadeOutAnim: true);
		}
	}

	private bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}
}
