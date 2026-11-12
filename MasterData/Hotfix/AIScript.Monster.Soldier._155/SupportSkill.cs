using System;
using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._155;

public class SupportSkill : SkillAdvancedBase
{
	private const string actionKey_1 = "Support1";

	private const string actionKey_2 = "Support2";

	private const string fireEvent = "Fire";

	private const string bullet01 = "Support_1";

	private const string bullet02 = "Support_2";

	private static readonly FP shootRadius = 20;

	private static readonly FP shootInterval = 3;

	private int _potentialLv = 1;

	private SoldierLevelController _levelCtrl;

	private CoroutineNode _corFire;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_potentialLv = (_actor as SoldierActor).GetPotentialLv();
		_levelCtrl = ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController;
		_actor.Hide();
		_actor.EnableSearchedImmunity();
		_actor.EnableUnparalleled();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref _corFire);
		_actor.CancelAiming();
	}

	public void OnStart()
	{
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
		string actionTag = ((_potentialLv >= 2) ? "Support2" : "Support1");
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
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
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
	}

	private void OnCustomEvent(string evt)
	{
		if (evt.Equals("Fire"))
		{
			StartCoroutine(ref _corFire, DoFire());
		}
	}

	private IEnumerator DoFire()
	{
		int shootCount = ((_potentialLv < 2) ? 1 : 2);
		for (int i = 0; i < shootCount; i++)
		{
			FireOnce();
			if (i < shootCount - 1)
			{
				yield return _actor.WaitTime(shootInterval);
			}
		}
	}

	private void FireOnce()
	{
		TSVector2 tSVector = ((_levelCtrl != null && _levelCtrl.mainControlActor != null) ? _levelCtrl.mainControlActor.tsTransform.Position : _actor.tsTransform.Position);
		TSVector2 tSVector2 = TrueSyncExtensions.RandomPointInsideRing(tSVector, shootRadius, shootRadius);
		TSVector2 normalized = (tSVector - tSVector2).normalized;
		if (_actor.attackTarget != null)
		{
			normalized = (_actor.attackTarget.tsTransform.Position - tSVector2).normalized;
		}
		ILRuntimeAPI.ShootByDirection("Support_1", _actor, default, normalized, tSVector2);
		if (_potentialLv >= 3)
		{
			ILRuntimeAPI.ShootByDirection("Support_2", _actor, default, normalized, tSVector2);
		}
	}
}
