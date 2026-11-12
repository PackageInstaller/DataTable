using System;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Character._11101;

public class SkillScript_MainControl : SkillAdvancedBase
{
	private string key_Base = "B1_Skill";

	private string key_P1 = "B1P01_Skill";

	private string key_P4 = "B1P04_Skill";

	private string key_P14 = "B1P01P04_Skill";

	public int skillId_S1 = 11131001;

	public int skillId_S2 = 11131003;

	private const int perkId_1 = 511101;

	private int buffId_1 = 11150111;

	private int maxCount_1 = 20;

	private const int perkId_3 = 511103;

	private int paramId_3_prob = 11150311;

	private const int perkId_4 = 511104;

	private string key;

	private CoroutineNode corMain;

	private ActorSearchTarget actorSearchInfo;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		actorSearchInfo = _actor.GetLogicComponent<ActorSearchTarget>();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref corMain);
		if (GetPerkLv(511101, out var _))
		{
			_actor.DisableSuperArmor();
		}
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

	private void DoMainLogic()
	{
		_actor.attackTarget = actorSearchInfo.GetLockingConfrontActor(useInputDirection: true);
		key = key_Base;
		bool flag = GetPerkLv(511101, out var lv) && _actor.buffComponent.GetBuffNumByID(buffId_1) >= maxCount_1;
		bool perkLv = GetPerkLv(511104, out lv);
		if (flag & perkLv)
		{
			key = key_P14;
		}
		else
		{
			if (flag)
			{
				key = key_P1;
			}
			if (perkLv)
			{
				key = key_P4;
			}
		}
		if (flag)
		{
			_actor.EnableSuperArmor();
		}
		string actionTag = key;
		LogicEntity attackTarget = _actor.attackTarget;
		Action onComboFinish = SkillFinish;
		Action onInterrupt = SkillInterrupt;
		Action action = onRecoveryBegin;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, attackTarget, null, default, null, action, onComboFinish, onInterrupt);
	}

	private void onRecoveryBegin()
	{
		if (GetPerkLv(511103, out var _) && TSRandom.Range(0, 100) < CommonUtils.GetScriptValue(_actor, paramId_3_prob).AsInt())
		{
			AdventurRebindSkill adventurRebindSkill = AdventurRebindSkill.Generate();
			adventurRebindSkill.sender = _actor;
			adventurRebindSkill.slotKey = ActionKey.B;
			adventurRebindSkill.skillId = skillId_S2;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventurRebindSkill);
		}
	}

	public bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}
}
