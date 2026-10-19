using ACT.Battle.Configs;
using Bamboo.ECS;

namespace ACT.Battle;

public readonly struct MotionAttackSourceInfo(Entity attacker, ConfigMotion configMotion, AttackPattern attackPattern, int stateIndex, int attackIndex, int motionSkillDetailId, int resolvedSkillId)
{
	public readonly Entity attacker = attacker;

	public readonly ConfigMotion configMotion = configMotion;

	public readonly AttackPattern attackPattern = attackPattern;

	public readonly int stateIndex = stateIndex;

	public readonly int attackIndex = attackIndex;

	public readonly int motionSkillDetailId = motionSkillDetailId;

	public readonly int resolvedSkillId = resolvedSkillId;
}
