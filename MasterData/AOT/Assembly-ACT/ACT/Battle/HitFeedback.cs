using ACT.Battle.Configs;
using Bamboo.ECS;

namespace ACT.Battle;

public static class HitFeedback
{
	public static void Play(ActionMemory memory, ActionHit config, FindTargetResult target)
	{
		config.hitEffect?.Do(memory);
		config.hitSound?.Do(memory);
		if (!target.entity.IsCollection())
		{
			config.carry?.Do(memory);
			config.attackeeFrameHalt?.Do(memory);
			ActionMemory memory2 = new ActionMemory(memory.caster, memory.owner, memory.caster, null, memory.ability);
			config.attackerFrameHalt?.Do(memory2);
		}
	}
}
