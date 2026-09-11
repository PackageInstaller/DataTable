namespace UnityEngine;

public static class HashUnsafeUtilities
{
	public unsafe static void ComputeHash128(void* data, ulong dataSize, ulong* hash1, ulong* hash2)
	{
		SpookyHash.Hash(data, dataSize, hash1, hash2);
	}

	public unsafe static void ComputeHash128(void* data, ulong dataSize, Hash128* hash)
	{
		ulong u64_ = hash->u64_0;
		ulong u64_2 = hash->u64_1;
		ComputeHash128(data, dataSize, &u64_, &u64_2);
		*hash = new Hash128(u64_, u64_2);
	}
}
