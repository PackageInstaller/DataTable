using System.Collections.Generic;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("锁定生命值效果", "Mixin", new string[] { "lock", "hp" })]
public class ConfigMixinLockHP : ConfigMixin
{
	public enum DoLockHPType
	{
		once,
		forever
	}

	public struct Phase
	{
		public enum LockHPType
		{
			percent,
			hpValue,
			lethalDamage
		}

		public enum PhaseType
		{
			dontReduceDamage,
			autoReduceDamage,
			zeroThisDamage
		}

		public LockHPType lockHPType;

		[Tooltip("锁血百分比")]
		public float percent;

		[Tooltip("锁血生命值")]
		public int hp;

		public PhaseType phaseType;

		[Tooltip("锁血时触发")]
		public ConfigAction[] actions;
	}

	[Tooltip("优先级")]
	public int priority;

	[Tooltip("锁血条件条件，满足才会生效")]
	public ConfigPredicate[] predicates;

	public DoLockHPType doLockHPType;

	[Tooltip("锁血阶段条件")]
	public Phase[] phases;

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
		if (phases != null)
		{
			for (int i = 0; i < phases.Length; i++)
			{
				ConfigAbility.CacheActionList(list, phases[i].actions, ab);
			}
		}
	}

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinLockHP(this, ab, index);
	}
}
