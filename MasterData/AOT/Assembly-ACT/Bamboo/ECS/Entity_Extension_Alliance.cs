using ACT.Battle;

namespace Bamboo.ECS;

public static class Entity_Extension_Alliance
{
	public static void SetAlliance(this Entity entity, Alliance alliance)
	{
		if (entity.TryGetCompAlliance(out CompAlliance component))
		{
			component.alliance = alliance;
		}
	}

	public static Alliance GetAlliance(this Entity entity)
	{
		if (!entity.TryGetCompAlliance(out CompAlliance component))
		{
			return Alliance.Netural;
		}
		return component.alliance;
	}

	public static Alliance GetOp(this Alliance alliance)
	{
		return CompAlliance.GetOp(alliance);
	}
}
