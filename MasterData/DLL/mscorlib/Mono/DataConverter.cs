using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;

namespace Mono;

internal abstract class DataConverter
{
	private class CopyConverter : DataConverter
	{
		public unsafe override double GetDouble(byte[] data, int index)
		{
			if (data == null)
			{
				throw new ArgumentNullException("data");
			}
			if (data.Length - index < 8)
			{
				throw new ArgumentException("index");
			}
			if (index < 0)
			{
				throw new ArgumentException("index");
			}
			double result = default(double);
			byte* ptr = (byte*)(&result);
			for (int i = 0; i < 8; i++)
			{
				ptr[i] = data[index + i];
			}
			return result;
		}

		public unsafe override ulong GetUInt64(byte[] data, int index)
		{
			if (data == null)
			{
				throw new ArgumentNullException("data");
			}
			if (data.Length - index < 8)
			{
				throw new ArgumentException("index");
			}
			if (index < 0)
			{
				throw new ArgumentException("index");
			}
			ulong result = default(ulong);
			byte* ptr = (byte*)(&result);
			for (int i = 0; i < 8; i++)
			{
				ptr[i] = data[index + i];
			}
			return result;
		}

		public unsafe override long GetInt64(byte[] data, int index)
		{
			if (data == null)
			{
				throw new ArgumentNullException("data");
			}
			if (data.Length - index < 8)
			{
				throw new ArgumentException("index");
			}
			if (index < 0)
			{
				throw new ArgumentException("index");
			}
			long result = default(long);
			byte* ptr = (byte*)(&result);
			for (int i = 0; i < 8; i++)
			{
				ptr[i] = data[index + i];
			}
			return result;
		}

		public unsafe override float GetFloat(byte[] data, int index)
		{
			if (data == null)
			{
				throw new ArgumentNullException("data");
			}
			if (data.Length - index < 4)
			{
				throw new ArgumentException("index");
			}
			if (index < 0)
			{
				throw new ArgumentException("index");
			}
			float result = default(float);
			byte* ptr = (byte*)(&result);
			for (int i = 0; i < 4; i++)
			{
				ptr[i] = data[index + i];
			}
			return result;
		}

		public unsafe override int GetInt32(byte[] data, int index)
		{
			if (data == null)
			{
				throw new ArgumentNullException("data");
			}
			if (data.Length - index < 4)
			{
				throw new ArgumentException("index");
			}
			if (index < 0)
			{
				throw new ArgumentException("index");
			}
			int result = default(int);
			byte* ptr = (byte*)(&result);
			for (int i = 0; i < 4; i++)
			{
				ptr[i] = data[index + i];
			}
			return result;
		}

		public unsafe override uint GetUInt32(byte[] data, int index)
		{
			if (data == null)
			{
				throw new ArgumentNullException("data");
			}
			if (data.Length - index < 4)
			{
				throw new ArgumentException("index");
			}
			if (index < 0)
			{
				throw new ArgumentException("index");
			}
			uint result = default(uint);
			byte* ptr = (byte*)(&result);
			for (int i = 0; i < 4; i++)
			{
				ptr[i] = data[index + i];
			}
			return result;
		}

		public unsafe override short GetInt16(byte[] data, int index)
		{
			if (data == null)
			{
				throw new ArgumentNullException("data");
			}
			if (data.Length - index < 2)
			{
				throw new ArgumentException("index");
			}
			if (index < 0)
			{
				throw new ArgumentException("index");
			}
			short result = default(short);
			byte* ptr = (byte*)(&result);
			for (int i = 0; i < 2; i++)
			{
				ptr[i] = data[index + i];
			}
			return result;
		}

		public unsafe override ushort GetUInt16(byte[] data, int index)
		{
			if (data == null)
			{
				throw new ArgumentNullException("data");
			}
			if (data.Length - index < 2)
			{
				throw new ArgumentException("index");
			}
			if (index < 0)
			{
				throw new ArgumentException("index");
			}
			ushort result = default(ushort);
			byte* ptr = (byte*)(&result);
			for (int i = 0; i < 2; i++)
			{
				ptr[i] = data[index + i];
			}
			return result;
		}
	}

	private class SwapConverter : DataConverter
	{
		public unsafe override double GetDouble(byte[] data, int index)
		{
			if (data == null)
			{
				throw new ArgumentNullException("data");
			}
			if (data.Length - index < 8)
			{
				throw new ArgumentException("index");
			}
			if (index < 0)
			{
				throw new ArgumentException("index");
			}
			double result = default(double);
			byte* ptr = (byte*)(&result);
			for (int i = 0; i < 8; i++)
			{
				ptr[7 - i] = data[index + i];
			}
			return result;
		}

		public unsafe override ulong GetUInt64(byte[] data, int index)
		{
			if (data == null)
			{
				throw new ArgumentNullException("data");
			}
			if (data.Length - index < 8)
			{
				throw new ArgumentException("index");
			}
			if (index < 0)
			{
				throw new ArgumentException("index");
			}
			ulong result = default(ulong);
			byte* ptr = (byte*)(&result);
			for (int i = 0; i < 8; i++)
			{
				ptr[7 - i] = data[index + i];
			}
			return result;
		}

		public unsafe override long GetInt64(byte[] data, int index)
		{
			if (data == null)
			{
				throw new ArgumentNullException("data");
			}
			if (data.Length - index < 8)
			{
				throw new ArgumentException("index");
			}
			if (index < 0)
			{
				throw new ArgumentException("index");
			}
			long result = default(long);
			byte* ptr = (byte*)(&result);
			for (int i = 0; i < 8; i++)
			{
				ptr[7 - i] = data[index + i];
			}
			return result;
		}

		public unsafe override float GetFloat(byte[] data, int index)
		{
			if (data == null)
			{
				throw new ArgumentNullException("data");
			}
			if (data.Length - index < 4)
			{
				throw new ArgumentException("index");
			}
			if (index < 0)
			{
				throw new ArgumentException("index");
			}
			float result = default(float);
			byte* ptr = (byte*)(&result);
			for (int i = 0; i < 4; i++)
			{
				ptr[3 - i] = data[index + i];
			}
			return result;
		}

		public unsafe override int GetInt32(byte[] data, int index)
		{
			if (data == null)
			{
				throw new ArgumentNullException("data");
			}
			if (data.Length - index < 4)
			{
				throw new ArgumentException("index");
			}
			if (index < 0)
			{
				throw new ArgumentException("index");
			}
			int result = default(int);
			byte* ptr = (byte*)(&result);
			for (int i = 0; i < 4; i++)
			{
				ptr[3 - i] = data[index + i];
			}
			return result;
		}

		public unsafe override uint GetUInt32(byte[] data, int index)
		{
			if (data == null)
			{
				throw new ArgumentNullException("data");
			}
			if (data.Length - index < 4)
			{
				throw new ArgumentException("index");
			}
			if (index < 0)
			{
				throw new ArgumentException("index");
			}
			uint result = default(uint);
			byte* ptr = (byte*)(&result);
			for (int i = 0; i < 4; i++)
			{
				ptr[3 - i] = data[index + i];
			}
			return result;
		}

		public unsafe override short GetInt16(byte[] data, int index)
		{
			if (data == null)
			{
				throw new ArgumentNullException("data");
			}
			if (data.Length - index < 2)
			{
				throw new ArgumentException("index");
			}
			if (index < 0)
			{
				throw new ArgumentException("index");
			}
			short result = default(short);
			byte* ptr = (byte*)(&result);
			for (int i = 0; i < 2; i++)
			{
				ptr[1 - i] = data[index + i];
			}
			return result;
		}

		public unsafe override ushort GetUInt16(byte[] data, int index)
		{
			if (data == null)
			{
				throw new ArgumentNullException("data");
			}
			if (data.Length - index < 2)
			{
				throw new ArgumentException("index");
			}
			if (index < 0)
			{
				throw new ArgumentException("index");
			}
			ushort result = default(ushort);
			byte* ptr = (byte*)(&result);
			for (int i = 0; i < 2; i++)
			{
				ptr[1 - i] = data[index + i];
			}
			return result;
		}
	}

	private static readonly DataConverter SwapConv = new SwapConverter();

	private static readonly DataConverter CopyConv = new CopyConverter();

	public static readonly bool IsLittleEndian = BitConverter.IsLittleEndian;

	public static DataConverter LittleEndian
	{
		get
		{
			if (!BitConverter.IsLittleEndian)
			{
				return SwapConv;
			}
			return CopyConv;
		}
	}

	public static DataConverter BigEndian
	{
		get
		{
			if (!BitConverter.IsLittleEndian)
			{
				return CopyConv;
			}
			return SwapConv;
		}
	}

	public static DataConverter Native => CopyConv;

	public abstract double GetDouble(byte[] data, int index);

	public abstract float GetFloat(byte[] data, int index);

	public abstract long GetInt64(byte[] data, int index);

	public abstract int GetInt32(byte[] data, int index);

	public abstract short GetInt16(byte[] data, int index);

	[CLSCompliant(false)]
	public abstract uint GetUInt32(byte[] data, int index);

	[CLSCompliant(false)]
	public abstract ushort GetUInt16(byte[] data, int index);

	[CLSCompliant(false)]
	public abstract ulong GetUInt64(byte[] data, int index);

	private static int Align(int current, int align)
	{
		return (current + align - 1) / align * align;
	}

	private static bool Prepare(byte[] buffer, ref int idx, int size, ref bool align)
	{
		if (align)
		{
			idx = Align(idx, size);
			align = false;
		}
		if (idx + size > buffer.Length)
		{
			idx = buffer.Length;
			return false;
		}
		return true;
	}

	public static IList Unpack(string description, byte[] buffer, int startIndex)
	{
		DataConverter dataConverter = CopyConv;
		List<object> list = new List<object>();
		int idx = startIndex;
		bool align = false;
		int num = 0;
		int num2 = 0;
		while (num2 < description.Length && idx < buffer.Length)
		{
			int num3 = num2;
			switch (description[num2])
			{
			case '^':
				dataConverter = BigEndian;
				break;
			case '_':
				dataConverter = LittleEndian;
				break;
			case '%':
				dataConverter = Native;
				break;
			case 'x':
				idx++;
				break;
			case '!':
				align = true;
				break;
			case 'i':
				if (Prepare(buffer, ref idx, 4, ref align))
				{
					list.Add(dataConverter.GetInt32(buffer, idx));
					idx += 4;
				}
				break;
			case 'I':
				if (Prepare(buffer, ref idx, 4, ref align))
				{
					list.Add(dataConverter.GetUInt32(buffer, idx));
					idx += 4;
				}
				break;
			case 's':
				if (Prepare(buffer, ref idx, 2, ref align))
				{
					list.Add(dataConverter.GetInt16(buffer, idx));
					idx += 2;
				}
				break;
			case 'S':
				if (Prepare(buffer, ref idx, 2, ref align))
				{
					list.Add(dataConverter.GetUInt16(buffer, idx));
					idx += 2;
				}
				break;
			case 'l':
				if (Prepare(buffer, ref idx, 8, ref align))
				{
					list.Add(dataConverter.GetInt64(buffer, idx));
					idx += 8;
				}
				break;
			case 'L':
				if (Prepare(buffer, ref idx, 8, ref align))
				{
					list.Add(dataConverter.GetUInt64(buffer, idx));
					idx += 8;
				}
				break;
			case 'f':
				if (Prepare(buffer, ref idx, 4, ref align))
				{
					list.Add(dataConverter.GetFloat(buffer, idx));
					idx += 4;
				}
				break;
			case 'd':
				if (Prepare(buffer, ref idx, 8, ref align))
				{
					list.Add(dataConverter.GetDouble(buffer, idx));
					idx += 8;
				}
				break;
			case 'b':
				if (Prepare(buffer, ref idx, 1, ref align))
				{
					list.Add(buffer[idx]);
					idx++;
				}
				break;
			case 'C':
			case 'c':
				if (Prepare(buffer, ref idx, 1, ref align))
				{
					char c2 = ((description[num2] != 'c') ? ((char)buffer[idx]) : ((char)(sbyte)buffer[idx]));
					list.Add(c2);
					idx++;
				}
				break;
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
				num = (short)description[num2] - 48;
				num3 = num2 + 1;
				break;
			case '*':
				num = int.MaxValue;
				break;
			case '[':
			{
				int num5 = -1;
				int j;
				for (j = num2 + 1; j < description.Length && description[j] != ']'; j++)
				{
					int num4 = (short)description[j] - 48;
					if (num4 >= 0 && num4 <= 9)
					{
						num5 = ((num5 != -1) ? (num5 * 10 + num4) : num4);
					}
				}
				if (num5 == -1)
				{
					throw new ArgumentException("invalid size specification");
				}
				num2 = j;
				num3 = num2 + 1;
				num = num5;
				break;
			}
			case '$':
			case 'z':
			{
				num2++;
				if (num2 >= description.Length)
				{
					throw new ArgumentException("$ description needs a type specified", "description");
				}
				char c = description[num2];
				if (align)
				{
					idx = Align(idx, 4);
					align = false;
				}
				if (idx >= buffer.Length)
				{
					break;
				}
				Encoding encoding;
				int num4;
				switch (c)
				{
				case '8':
					encoding = Encoding.UTF8;
					num4 = 1;
					break;
				case '6':
					encoding = Encoding.Unicode;
					num4 = 2;
					break;
				case '7':
					encoding = Encoding.UTF7;
					num4 = 1;
					break;
				case 'b':
					encoding = Encoding.BigEndianUnicode;
					num4 = 2;
					break;
				case '3':
					encoding = Encoding.GetEncoding(12000);
					num4 = 4;
					break;
				case '4':
					encoding = Encoding.GetEncoding(12001);
					num4 = 4;
					break;
				default:
					throw new ArgumentException("Invalid format for $ specifier", "description");
				}
				int i = idx;
				switch (num4)
				{
				case 1:
					for (; i < buffer.Length && buffer[i] != 0; i++)
					{
					}
					list.Add(encoding.GetChars(buffer, idx, i - idx));
					idx = ((i != buffer.Length) ? (i + 1) : i);
					break;
				case 2:
					for (; i < buffer.Length; i++)
					{
						if (i + 1 == buffer.Length)
						{
							i++;
							break;
						}
						if (buffer[i] == 0 && buffer[i + 1] == 0)
						{
							break;
						}
					}
					list.Add(encoding.GetChars(buffer, idx, i - idx));
					idx = ((i != buffer.Length) ? (i + 2) : i);
					break;
				case 4:
					for (; i < buffer.Length; i++)
					{
						if (i + 3 >= buffer.Length)
						{
							i = buffer.Length;
							break;
						}
						if (buffer[i] == 0 && buffer[i + 1] == 0 && buffer[i + 2] == 0 && buffer[i + 3] == 0)
						{
							break;
						}
					}
					list.Add(encoding.GetChars(buffer, idx, i - idx));
					idx = ((i != buffer.Length) ? (i + 4) : i);
					break;
				}
				break;
			}
			default:
				throw new ArgumentException($"invalid format specified `{description[num2]}'");
			}
			if (num > 0)
			{
				if (--num > 0)
				{
					num2 = num3;
				}
			}
			else
			{
				num2++;
			}
		}
		return list;
	}
}
