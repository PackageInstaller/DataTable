using System.Text;

namespace System.Collections.Specialized;

public struct BitVector32
{
	private uint _data;

	public bool this[int bit]
	{
		get
		{
			return (_data & bit) == (uint)bit;
		}
		set
		{
			if (value)
			{
				_data |= (uint)bit;
			}
			else
			{
				_data &= (uint)(~bit);
			}
		}
	}

	public static int CreateMask()
	{
		return CreateMask(0);
	}

	public static int CreateMask(int previous)
	{
		return previous switch
		{
			0 => 1, 
			int.MinValue => throw new InvalidOperationException("Bit vector is full."), 
			_ => previous << 1, 
		};
	}

	public override bool Equals(object o)
	{
		if (!(o is BitVector32))
		{
			return false;
		}
		return _data == ((BitVector32)o)._data;
	}

	public override int GetHashCode()
	{
		return base.GetHashCode();
	}

	public static string ToString(BitVector32 value)
	{
		StringBuilder stringBuilder = new StringBuilder(45);
		stringBuilder.Append("BitVector32{");
		int num = (int)value._data;
		for (int i = 0; i < 32; i++)
		{
			if ((num & 0x80000000u) != 0L)
			{
				stringBuilder.Append('1');
			}
			else
			{
				stringBuilder.Append('0');
			}
			num <<= 1;
		}
		stringBuilder.Append('}');
		return stringBuilder.ToString();
	}

	public override string ToString()
	{
		return ToString(this);
	}
}
