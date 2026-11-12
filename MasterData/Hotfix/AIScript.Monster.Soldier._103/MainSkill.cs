using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._103;

public class MainSkill : SkillAdvancedBase
{
	private string actionKey = "Skill";

	private string customEvent = "Fire";

	private TSVector2 offset = new TSVector2(0, 0);

	private const string areaEffect = "AreaEffect";

	private const string areaEffect_Potential = "AreaEffectMax";

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
		if (!evt.Equals(customEvent))
		{
			return;
		}
		string fxAlias = "AreaEffect";
		if (PotentialLv >= 3)
		{
			fxAlias = "AreaEffectMax";
		}
		ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, _actor.tsTransform.Position + offset, _actor.tsTransform.Rotation, (AreaEffectEntity entity) =>
		{
			AreaEffect_FollowComponent logicComponent = entity.GetLogicComponent<AreaEffect_FollowComponent>();
			if (logicComponent != null)
			{
				logicComponent.enabled = true;
				logicComponent.targetType = AreaEffect_FollowComponent.FollowTargetType.SpecifiedTarget;
				logicComponent.FollowTarget = _actor.attackTarget;
			}
		});
	}
}
