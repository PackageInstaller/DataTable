using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem;

internal struct DynamicBitfield
{
	public InlinedArray<ulong> array;

	public int length;

	public void SetLength(int newLength)
	{
		int num = BitCountToULongCount(newLength);
		if (array.length < num)
		{
			array.SetLength(num);
		}
		length = newLength;
	}

	public void SetBit(int bitIndex)
	{
		array[bitIndex / 64] |= (ulong)(1L << bitIndex % 64);
	}

	public bool TestBit(int bitIndex)
	{
		return (array[bitIndex / 64] & (ulong)(1L << bitIndex % 64)) != 0;
	}

	public void ClearBit(int bitIndex)
	{
		array[bitIndex / 64] &= (ulong)(~(1L << bitIndex % 64));
	}

	public bool AnyBitIsSet()
	{
		for (int i = 0; i < array.length; i++)
		{
			if (array[i] != 0L)
			{
				return true;
			}
		}
		return false;
	}

	private static int BitCountToULongCount(int bitCount)
	{
		return (bitCount + 63) / 64;
	}
}
