namespace System.Collections.Generic;

internal sealed class BitHelper
{
	private readonly int _length;

	private unsafe readonly int* _arrayPtr;

	private readonly int[] _array;

	private readonly bool _useStackAlloc;

	internal unsafe BitHelper(int* bitArrayPtr, int length)
	{
		_arrayPtr = bitArrayPtr;
		_length = length;
		_useStackAlloc = true;
	}

	internal BitHelper(int[] bitArray, int length)
	{
		_array = bitArray;
		_length = length;
	}

	internal unsafe void MarkBit(int bitPosition)
	{
		int num = bitPosition / 32;
		if (num < _length && num >= 0)
		{
			int num2 = 1 << bitPosition % 32;
			if (_useStackAlloc)
			{
				_arrayPtr[num] |= num2;
			}
			else
			{
				_array[num] |= num2;
			}
		}
	}

	internal unsafe bool IsMarked(int bitPosition)
	{
		int num = bitPosition / 32;
		if (num < _length && num >= 0)
		{
			int num2 = 1 << bitPosition % 32;
			if (_useStackAlloc)
			{
				return (_arrayPtr[num] & num2) != 0;
			}
			return (_array[num] & num2) != 0;
		}
		return false;
	}

	internal static int ToIntArrayLength(int n)
	{
		if (n <= 0)
		{
			return 0;
		}
		return (n - 1) / 32 + 1;
	}
}
