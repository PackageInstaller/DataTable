using ACT.Battle.Configs;
using Bamboo.ECS;

namespace ACT.Battle;

public struct DamagePhaseContext
{
	public ActionMemory memory;

	public Entity attacker;

	public Entity attackee;

	public CompAbility attackerAb;

	public CompAbility attackeeAb;

	public Ability ability;

	public ActionDamage config;

	public float critMul;

	public float eleDamage;

	public float eleResist;

	public float defMul;

	public float mannerDmgIncrease;

	public float enemyStateFix;

	public float damageP;

	public float damageM;

	public float damageL;

	public float constValue;

	public float damageP2;

	public float damageM2;

	public float damageL2;

	public float constValue2;

	public float posDamageP;

	public float posMul1;

	public float posConstValue;

	public AttackData attackData;

	public static DamagePhaseContext Build(ActionMemory memory, AttackData atkData, ActionDamage config)
	{
		Entity caster = memory.caster;
		return new DamagePhaseContext
		{
			memory = memory,
			attacker = caster,
			attackee = memory.target.entity,
			attackerAb = caster.GetCompAbility(),
			attackeeAb = memory.target.entity.GetCompAbility(),
			ability = memory.ability,
			config = config,
			attackData = atkData,
			critMul = 1f,
			enemyStateFix = 1f
		};
	}
}
