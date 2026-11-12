using System;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._10701;

public class SkillScript_Zhiyuan_Skill : SkillAdvancedBase
{
	protected readonly ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[3]
	{
		(ComboInputBuffer.ActionKey)1634882679,
		(ComboInputBuffer.ActionKey)1766023024,
		(ComboInputBuffer.ActionKey)1663990132
	};

	protected const string shootShieldEvent = "ThrowShield";

	protected const string shieldKey = "Bullet_107_Support_Skill_ThrowShield";

	private readonly string shieldKey_p24 = "Bullet_107_Support_Skill_ThrowShield_P24";

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.CancelAiming();
	}

	public void OnStart()
	{
		if (GetPerk(Parallel.perk_23))
		{
			LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
			_actor.AimAtTarget(activedPlayerActor);
		}
		else
		{
			_actor.attackTarget = CommonUtils.GetAssistantAttackTarget(_actor);
			if (_actor.attackTarget != null)
			{
				_actor.AimAtTarget(_actor.attackTarget);
			}
		}
		Parallel.current_cout_22 = 0;
		Parallel.dicArea_p21.Clear();
		ComboInputBuffer.ActionKey[] keys = actionKeys;
		Action<string> onCustomEvent = OnCustomEvent;
		System.Action onComboFinish = OnFinish;
		System.Action onInterrupt = OnInterrupt;
		BeginAttack(keys, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	protected void OnCustomEvent(string eventName)
	{
		if (!string.Equals("ThrowShield", eventName))
		{
			return;
		}
		string weaponAlias = GetShieldKey();
		LogicEntity logicEntity = _actor.attackTarget;
		bool perk = GetPerk(Parallel.perk_23);
		if (perk)
		{
			logicEntity = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
			_actor.tsTransform.Forward = (logicEntity.tsTransform.Position - _actor.tsTransform.Position).normalized;
		}
		if (GetPerk(Parallel.perk_24))
		{
			TSVector2 position = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.tsTransform.Position + Parallel.forwardDis_24 * _actor.tsTransform.Forward;
			DeterministicShape deterministicFanShape = CommonUtils.GetDeterministicFanShape(Parallel.radius_out_24, Parallel.radius_in_24, Parallel.angle_24, position, _actor.tsTransform.Rotation);
			List<LogicEntity> monstersFromShape = ILRuntimeAPI.GetMonstersFromShape(_actor, deterministicFanShape);
			if (monstersFromShape.Count > 0)
			{
				for (int i = 0; i < monstersFromShape.Count && i < 5; i++)
				{
					if (monstersFromShape.get_Item(i) is MonsterAdventureActor entity && !entity.IsSearchedImmunity())
					{
						string weaponAlias2 = shieldKey_p24;
						AdventureActor actor = _actor;
						TSVector2 position2 = _actor.tsTransform.Position;
						LogicEntity target = monstersFromShape.get_Item(i);
						ILRuntimeAPI.Shoot(weaponAlias2, actor, position2, default, default, target);
					}
				}
			}
			if (perk)
			{
				AdventureActor actor2 = _actor;
				TSVector2 position3 = _actor.tsTransform.Position;
				LogicEntity target = logicEntity;
				ILRuntimeAPI.Shoot(weaponAlias, actor2, position3, default, default, target);
			}
		}
		else if (logicEntity != null)
		{
			AdventureActor actor3 = _actor;
			TSVector2 position4 = _actor.tsTransform.Position;
			LogicEntity target = logicEntity;
			ILRuntimeAPI.Shoot(weaponAlias, actor3, position4, default, default, target);
		}
		else
		{
			AdventureActor actor4 = _actor;
			TSVector2 position5 = _actor.tsTransform.Position;
			TSVector2 forward = _actor.tsTransform.Forward;
			LogicEntity target = logicEntity;
			ILRuntimeAPI.Shoot(weaponAlias, actor4, position5, forward, default, target);
		}
		_actor.CancelAiming();
	}

	protected string GetShieldKey()
	{
		return "Bullet_107_Support_Skill_ThrowShield";
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		OnFinish();
	}
}
