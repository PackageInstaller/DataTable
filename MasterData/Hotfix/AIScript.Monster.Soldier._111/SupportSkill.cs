using System;
using AdventureBehaviour;

namespace AIScript.Monster.Soldier._111;

public class SupportSkill : SkillAdvancedBase
{
	private string actionKey = "Support";

	private string customEvent = "Fire";

	private const string areaEffect = "AreaEffect_A";

	private const string areaEffect_Potential = "AreaEffect_B";

	private int PotentialLv = 1;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		PotentialLv = (_actor as SoldierActor).GetPotentialLv();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		_skill.Clear();
	}

	public void OnUpdate()
	{
	}

	private void DoMainLogic()
	{
		string actionTag = actionKey;
		Action<string> action = onCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
	}

	private void onCustomEvent(string evt)
	{
		if (evt.Equals(customEvent))
		{
			string fxAlias = "AreaEffect_A";
			if (PotentialLv >= 3)
			{
				fxAlias = "AreaEffect_B";
			}
			if (_actor.monsterTarget != null)
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, _actor.monsterTarget.tsTransform.Position);
			}
			else
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, _actor.tsTransform.Position);
			}
		}
	}
}
