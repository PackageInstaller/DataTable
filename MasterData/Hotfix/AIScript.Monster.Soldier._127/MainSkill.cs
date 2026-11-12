using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster.Soldier._127;

public class MainSkill : SkillAdvancedBase
{
	private const string actionKey = "Skill";

	private const string fireEvent = "Fire";

	private const string areaEffect = "AreaEffect";

	private const int buffId_2 = 250100601;

	private static readonly FP buffRadius_2 = 100;

	private FP loopTime = 5;

	private int PotentialLv = 1;

	private readonly List<LogicEntity> _allyBuffer = new List<LogicEntity>();

	private CoroutineNode corMain;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		PotentialLv = (_actor as SoldierActor).GetPotentialLv();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.CancelAiming();
		_allyBuffer.Clear();
		StopCoroutine(ref corMain);
	}

	public void OnStart()
	{
		StartCoroutine(ref corMain, DoMainLogic());
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

	private IEnumerator DoMainLogic()
	{
		MainSkill mainSkill = this;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		mainSkill.BeginAttack("Skill", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
		yield return _actor.WaitTime(loopTime);
		_actor.CancelAttack();
	}

	private void OnCustomEvent(string evt)
	{
		if (evt.Equals("Fire") && PotentialLv >= 2)
		{
			AddBuffToAllies();
		}
	}

	private void AddBuffToAllies()
	{
		CommonUtils.SearchNearTargetsByCircle(_actor, buffRadius_2, isConfront: false, includeSelf: true, _allyBuffer);
		for (int i = 0; i < _allyBuffer.Count; i++)
		{
			if (_allyBuffer.get_Item(i) is AdventureActor adventureActor && !(adventureActor is SoldierActor { isSupport: not false }))
			{
				ActorHealthInfo actorHealthInfo = adventureActor.actorHealthInfo;
				if (actorHealthInfo != null && actorHealthInfo.isAlive && !(adventureActor.buffComponent == null))
				{
					adventureActor.buffComponent.AddBuff(250100601, _actor);
				}
			}
		}
	}
}
