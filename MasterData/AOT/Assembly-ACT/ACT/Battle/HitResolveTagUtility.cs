using ACT.Battle.Configs;

namespace ACT.Battle;

internal static class HitResolveTagUtility
{
	public static bool HasResolveTag(HitResolveContext context, HitResolveTag tag)
	{
		if ((context.hitResolveTag & tag) != 0)
		{
			return true;
		}
		return false;
	}
}
