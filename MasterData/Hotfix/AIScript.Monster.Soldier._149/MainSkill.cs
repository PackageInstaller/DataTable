using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._149;

public class MainSkill : SkillAdvancedBase
{
	private string actionKey = "Skill";

	private int buff_id = 250101001;

	private const string fireEvent = "Fire";

	private const string areaEffect = "AreaEffect";

	private FP areaOffsetX = 0;

	private FP areaOffsetY = 8;

	private int PotentialLv = 1;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		PotentialLv = (_actor as SoldierActor).GetPotentialLv();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.CancelAiming();
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
		OnFinish();
	}

	public void OnUpdate()
	{
	}

	private void DoMainLogic()
	{
		if (PotentialLv >= 3)
		{
			_actor.buffComponent.AddBuff(buff_id, _actor);
		}
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
		string actionTag = actionKey;
		Action<string> action = onCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
	}

	private void onCustomEvent(string evt)
	{
		if (evt.Equals("Fire") && PotentialLv >= 2)
		{
			TSVector2 position = _actor.tsTransform.TransformLocalPointToWorldSpace(new TSVector2(areaOffsetX, areaOffsetY));
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect", position);
		}
		if (evt.Equals("Stop"))
		{
			_actor.CancelAttack();
		}
	}
}
