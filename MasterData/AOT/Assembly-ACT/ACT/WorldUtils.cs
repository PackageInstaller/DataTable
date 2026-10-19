namespace ACT;

internal static class WorldUtils
{
	public static bool InGameWorldIdRange(int worldId)
	{
		if (worldId >= 100)
		{
			return worldId >= 500;
		}
		return true;
	}
}
