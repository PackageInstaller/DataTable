using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.MultiPlayer;
using Bamboo.ECS;

namespace ACT.Battle;

public static class HitGlobalSpeedFx
{
	public static void Apply(Entity attackee, in CmdHit hit)
	{
		if (GameLoader.meta.hitGlobalSpeed == null)
		{
			return;
		}
		SystemTime timeSystem = GameManager.timeSystem;
		if (hit.globalSpeedConfigIndex >= 0)
		{
			List<HitGlobalSpeed> configs = GameLoader.meta.hitGlobalSpeed.configs;
			if (hit.globalSpeedConfigIndex < configs.Count)
			{
				timeSystem.ChangeGlobalSpeed(configs[hit.globalSpeedConfigIndex].config);
			}
		}
	}
}
