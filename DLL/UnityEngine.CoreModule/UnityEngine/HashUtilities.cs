namespace UnityEngine;

public static class HashUtilities
{
	public unsafe static void AppendHash(ref Hash128 inHash, ref Hash128 outHash)
	{
		fixed (Hash128* hash = &outHash)
		{
			fixed (Hash128* data = &inHash)
			{
				HashUnsafeUtilities.ComputeHash128(data, (ulong)sizeof(Hash128), hash);
			}
		}
	}
}
