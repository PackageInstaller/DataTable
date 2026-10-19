using ACT.Battle.Configs;

namespace ACT.Battle;

public static class DefenseStateDynamicTags
{
	public const string Invincible = "INVINCIBLE";

	private static int s_InvincibleId;

	public const string TrueInvincible = "TRUEINVINCIBLE";

	private static int s_TrueInvincibleId;

	public const string BlockThrow = "BLOCKTHROW";

	private static int s_BlockThrowId;

	public const string NoDamageOnHit = "NODAMAGEONHIT";

	private static int s_NoDamageOnHitId;

	public const string IgnoreLaser = "IGNORELASER";

	private static int s_IgnoreLaserId;

	public static int InvincibleId => GetOrCreate(ref s_InvincibleId, "INVINCIBLE");

	public static int TrueInvincibleId => GetOrCreate(ref s_TrueInvincibleId, "TRUEINVINCIBLE");

	public static int BlockThrowId => GetOrCreate(ref s_BlockThrowId, "BLOCKTHROW");

	public static int NoDamageOnHitId => GetOrCreate(ref s_NoDamageOnHitId, "NODAMAGEONHIT");

	public static int IgnoreLaserId => GetOrCreate(ref s_IgnoreLaserId, "IGNORELASER");

	private static int GetOrCreate(ref int cache, string tag)
	{
		if (cache != 0)
		{
			return cache;
		}
		int[] array = AbilityTagRegistry.CompileCustomTagIds(new string[1] { tag });
		cache = ((array.Length != 0) ? array[0] : 0);
		return cache;
	}
}
