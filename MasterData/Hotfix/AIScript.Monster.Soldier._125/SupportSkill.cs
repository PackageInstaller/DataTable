using System;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._125;

public class SupportSkill : SkillAdvancedBase
{
	private readonly string comboTag = "Support";

	private readonly string eventName_GenerateAreaEffect = "Fire";

	private readonly string areaEffectKey = "AreaEffect";

	private readonly List<TSVector2> areaEffectOffsetList_Potential = new List<TSVector2>
	{
		new TSVector2(0, 1.5),
		new TSVector2(0, -1.5),
		new TSVector2(1.5, 0),
		new TSVector2(-1.5, 0)
	};

	private readonly string areaEffectKey_Potential = "AreaEffect";

	private int _potentialLv;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_potentialLv = ((SoldierActor)_actor).GetPotentialLv();
	}

	public void OnStart()
	{
		string actionTag = comboTag;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (!string.Equals(eventName, eventName_GenerateAreaEffect))
		{
			return;
		}
		TSVector2 tSVector = ((_actor.attackTarget != null) ? _actor.attackTarget.tsTransform.Position : _actor.tsTransform.Position);
		if (_potentialLv >= 1)
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, areaEffectKey_Potential, tSVector);
			{
				foreach (TSVector2 item in areaEffectOffsetList_Potential)
				{
					ILRuntimeAPI.PlayAreaEffect(_actor, areaEffectKey_Potential, tSVector + item);
				}
				return;
			}
		}
		ILRuntimeAPI.PlayAreaEffect(_actor, areaEffectKey, tSVector);
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		_skill.Clear();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}
}
