using System;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._116;

public class SupportSkill : SkillAdvancedBase
{
	private readonly string comboTag = "ComboSupport";

	private readonly string eventName_GenerateAreaEffect = "Fire";

	private readonly string areaEffectKey = "AreaEffect_Soldier_11601_Support";

	private readonly string areaEffectKey_Potential3 = "AreaEffect_Soldier_11601_Support_N";

	private const int buffId_OnAreaHit = 250116501;

	private int _potentialLv;

	private readonly List<int> _buffIdsForTarget = new List<int> { 250116501 };

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_potentialLv = ((SoldierActor)_actor).GetPotentialLv();
	}

	public void OnStart()
	{
		if (_actor.attackTarget == null)
		{
			_actor.attackTarget = ((SoldierActor)_actor).soldierAI?.FindNearestConfrontTarget();
		}
		string actionTag = comboTag;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, eventName_GenerateAreaEffect))
		{
			if (_actor.attackTarget == null)
			{
				_actor.attackTarget = ((SoldierActor)_actor).FindNearestConfrontTarget();
			}
			LockDirection();
			TSVector2 position = ((_actor.attackTarget != null) ? _actor.attackTarget.tsTransform.Position : _actor.tsTransform.Position);
			string fxAlias = ((_potentialLv >= 3) ? areaEffectKey_Potential3 : areaEffectKey);
			AdventureActor actor = _actor;
			Action<AreaEffectEntity> onBeforeSetup = OnAreaEffectBeforeSetup;
			ILRuntimeAPI.PlayAreaEffect(actor, fxAlias, position, default, onBeforeSetup);
		}
	}

	private void OnAreaEffectBeforeSetup(AreaEffectEntity entity)
	{
		if (entity == null)
		{
			return;
		}
		AreaEffect_AttackComponent[] components = entity.GetComponents<AreaEffect_AttackComponent>();
		if (components == null)
		{
			return;
		}
		foreach (AreaEffect_AttackComponent areaEffect_AttackComponent in components)
		{
			if (areaEffect_AttackComponent == null)
			{
				continue;
			}
			if (_potentialLv >= 2)
			{
				areaEffect_AttackComponent.hitFlags |= HitBox.FeatureFlag.AddBuffForTarget;
				AreaEffect_AttackComponent areaEffect_AttackComponent2 = areaEffect_AttackComponent;
				if (areaEffect_AttackComponent2.hitFeatureData == null)
				{
					areaEffect_AttackComponent2.hitFeatureData = new HitBox.HitBoxFeatureData();
				}
				areaEffect_AttackComponent.hitFeatureData.buffIdsForTarget = _buffIdsForTarget;
			}
			else
			{
				areaEffect_AttackComponent.hitFlags &= ~HitBox.FeatureFlag.AddBuffForTarget;
				if (areaEffect_AttackComponent.hitFeatureData != null)
				{
					areaEffect_AttackComponent.hitFeatureData.buffIdsForTarget = null;
				}
			}
		}
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		_skill.Clear();
	}
}
