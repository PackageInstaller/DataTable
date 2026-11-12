using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._12701;

public class SkillScript_MainControl : SkillAdvancedBase
{
	private string key_Base = "127_B1_Skill_1st";

	private string key_P1 = "127_B1_Skill_1st_P01";

	private string key_P2 = "127_B1_Skill_1st_P02";

	private string key_P12 = "127_B1_Skill_1st_P01P02";

	private int shieldId = 12750001;

	private string evt_shield = "127MainAddShield";

	public int skillId_S1 = 12731000;

	public int skillId_S2 = 12731001;

	private const int perkId_1 = 512701;

	private const int perkId_2 = 512702;

	private bool isReBind;

	private CoroutineNode corMain;

	private LookAtTarget lookAtTarget = new LookAtTarget();

	private AimTarget aimTarget = new AimTarget();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		isReBind = false;
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
		ReBindS2(isInterrupt: true);
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
		bool perkLv = GetPerkLv(512701, out var lv);
		bool perkLv2 = GetPerkLv(512702, out lv);
		if (perkLv & perkLv2)
		{
			text = key_P12;
		}
		else
		{
			if (perkLv)
			{
				text = key_P1;
			}
			if (perkLv2)
			{
				text = key_P2;
			}
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
			Action<string> action = onCustomEvent;
			System.Action action2 = onRecoveryBegin;
			System.Action onComboFinish = SkillFinish;
			System.Action onInterrupt = SkillInterrupt;
			BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, action2, onComboFinish, onInterrupt, action, null, fadeOutAnim: true);
		}
		else
		{
			string actionTag2 = text;
			Action<string> action = onCustomEvent;
			System.Action onInterrupt = onRecoveryBegin;
			System.Action onComboFinish = SkillFinish;
			System.Action action2 = SkillInterrupt;
			BeginAttack(actionTag2, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, onInterrupt, onComboFinish, action2, action, null, fadeOutAnim: true);
		}
	}

	private void onRecoveryBegin()
	{
		ReBindS2(isInterrupt: false);
	}

	private void ReBindS2(bool isInterrupt)
	{
		if (GetPerkLv(512702, out var _) && !isReBind)
		{
			isReBind = true;
			AdventurRebindSkill adventurRebindSkill = AdventurRebindSkill.Generate();
			adventurRebindSkill.sender = _actor;
			adventurRebindSkill.slotKey = ActionKey.B;
			adventurRebindSkill.skillId = skillId_S2;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventurRebindSkill);
			_actor.logicVariable.ToggleLogicTag("127_Interrupt", isInterrupt);
		}
	}

	private void onCustomEvent(string evt)
	{
		if (evt.Equals(evt_shield))
		{
			_actor.actorShield.AddShield(shieldId, _actor);
		}
	}

	private bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}
}
