using System;

namespace AIScript.Character._11401;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private string key_Base_Main = "Attack";

	private string key_Base_Support = "Attack";

	private string key_Strong = "Attack_Strong";

	private string key_Strong_Support = "Attack_Strong_Support";

	private string key_P12 = "Attack_H2";

	private string key_P42 = "Attack_Strong_P42";

	private string key_P42_Support = "Attack_Strong_P42_Support";

	private int perkId_12 = 511412;

	private int perkId_42 = 511442;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	public void OnUpdate()
	{
		if (_actor.attackTarget == null)
		{
			comboAttack.InterruptAttack();
		}
	}

	protected void onFinish()
	{
		_skill?.Clear();
	}

	private void DoMainLogic()
	{
		if (_actor is PlayerAdventureActor { isAssist: false })
		{
			string text = (GetPerk(perkId_12) ? key_P12 : key_Base_Main);
			bool perk = GetPerk(perkId_42);
			if (_actor.buffComponent.CheckBuffByBuffID(Config.buffStrong))
			{
				text = (perk ? key_P42 : key_Strong);
			}
			string actionTag = text;
			Action onComboFinish = onFinish;
			Action onInterrupt = onFinish;
			BeginAttack(actionTag, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
		}
		else
		{
			string text2 = key_Base_Support;
			bool perk2 = GetPerk(perkId_42);
			if (_actor.buffComponent.CheckBuffByBuffID(Config.buffStrong))
			{
				text2 = (perk2 ? key_P42_Support : key_Strong_Support);
			}
			string actionTag2 = text2;
			Action onInterrupt = onFinish;
			Action onComboFinish = onFinish;
			BeginAttack(actionTag2, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onInterrupt, onComboFinish);
		}
	}
}
