using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;

namespace Mono;

internal abstract class DataConverter
{
	private class PackContext
	{
		public byte[] buffer;

		private int next;

		public string description;

		public int i;

		public DataConverter conv;

		public int repeat;

		public int align;

		public void Add(byte[] group)
		{
			if (buffer == null)
			{
				buffer = group;
				next = group.Length;
				return;
			}
			if (align != 0)
			{
				if (align == -1)
				{
					next = Align(next, group.Length);
				}
				else
				{
					next = Align(next, align);
				}
				align = 0;
			}
			if (next + group.Length > buffer.Length)
			{
				byte[] destinationArray = new byte[System.Math.Max(next, 16) * 2 + group.Length];
				Array.Copy(buffer, destinationArray, buffer.Length);
				Array.Copy(group, 0, destinationArray, next, group.Length);
				next += group.Length;
				buffer = destinationArray;
			}
			else
			{
				Array.Copy(group, 0, buffer, next, group.Length);
				next += group.Length;
			}
		}

		public byte[] Get()
		{
			if (buffer == null)
			{
				return new byte[0];
			}
			if (buffer.Length != next)
			{
				byte[] array = new byte[next];
				Array.Copy(buffer, array, next);
				return array;
			}
			return buffer;
		}
	}

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

		public unsafe override void PutBytes(byte[] dest, int destIdx, double value)
		{
			Check(dest, destIdx, 8);
			fixed (byte* ptr = &dest[destIdx])
			{
				long* ptr2 = (long*)(&value);
				*(long*)ptr = *ptr2;
			}
		}

		public unsafe override void PutBytes(byte[] dest, int destIdx, float value)
		{
			Check(dest, destIdx, 4);
			fixed (byte* ptr = &dest[destIdx])
			{
				uint* ptr2 = (uint*)(&value);
				*(uint*)ptr = *ptr2;
			}
		}

		public unsafe override void PutBytes(byte[] dest, int destIdx, int value)
		{
			Check(dest, destIdx, 4);
			fixed (byte* ptr = &dest[destIdx])
			{
				uint* ptr2 = (uint*)(&value);
				*(uint*)ptr = *ptr2;
			}
		}

		public unsafe override void PutBytes(byte[] dest, int destIdx, uint value)
		{
			Check(dest, destIdx, 4);
			fixed (byte* ptr = &dest[destIdx])
			{
				uint* ptr2 = &value;
				*(uint*)ptr = *ptr2;
			}
		}

		public unsafe override void PutBytes(byte[] dest, int destIdx, long value)
		{
			Check(dest, destIdx, 8);
			fixed (byte* ptr = &dest[destIdx])
			{
				long* ptr2 = &value;
				*(long*)ptr = *ptr2;
			}
		}

		public unsafe override void PutBytes(byte[] dest, int destIdx, ulong value)
		{
			Check(dest, destIdx, 8);
			fixed (byte* ptr = &dest[destIdx])
			{
				ulong* ptr2 = &value;
				*(ulong*)ptr = *ptr2;
			}
		}

		public unsafe override void PutBytes(byte[] dest, int destIdx, short value)
		{
			Check(dest, destIdx, 2);
			fixed (byte* ptr = &dest[destIdx])
			{
				ushort* ptr2 = (ushort*)(&value);
				*(ushort*)ptr = *ptr2;
			}
		}

		public unsafe override void PutBytes(byte[] dest, int destIdx, ushort value)
		{
			Check(dest, destIdx, 2);
			fixed (byte* ptr = &dest[destIdx])
			{
				ushort* ptr2 = &value;
				*(ushort*)ptr = *ptr2;
			}
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

		public unsafe override void PutBytes(byte[] dest, int destIdx, double value)
		{
			Check(dest, destIdx, 8);
			fixed (byte* ptr = &dest[destIdx])
			{
				byte* ptr2 = (byte*)(&value);
				for (int i = 0; i < 8; i++)
				{
					ptr[i] = ptr2[7 - i];
				}
			}
		}

		public unsafe override void PutBytes(byte[] dest, int destIdx, float value)
		{
			Check(dest, destIdx, 4);
			fixed (byte* ptr = &dest[destIdx])
			{
				byte* ptr2 = (byte*)(&value);
				for (int i = 0; i < 4; i++)
				{
					ptr[i] = ptr2[3 - i];
				}
			}
		}

		public unsafe override void PutBytes(byte[] dest, int destIdx, int value)
		{
			Check(dest, destIdx, 4);
			fixed (byte* ptr = &dest[destIdx])
			{
				byte* ptr2 = (byte*)(&value);
				for (int i = 0; i < 4; i++)
				{
					ptr[i] = ptr2[3 - i];
				}
			}
		}

		public unsafe override void PutBytes(byte[] dest, int destIdx, uint value)
		{
			Check(dest, destIdx, 4);
			fixed (byte* ptr = &dest[destIdx])
			{
				byte* ptr2 = (byte*)(&value);
				for (int i = 0; i < 4; i++)
				{
					ptr[i] = ptr2[3 - i];
				}
			}
		}

		public unsafe override void PutBytes(byte[] dest, int destIdx, long value)
		{
			Check(dest, destIdx, 8);
			fixed (byte* ptr = &dest[destIdx])
			{
				byte* ptr2 = (byte*)(&value);
				for (int i = 0; i < 8; i++)
				{
					ptr[i] = ptr2[7 - i];
				}
			}
		}

		public unsafe override void PutBytes(byte[] dest, int destIdx, ulong value)
		{
			Check(dest, destIdx, 8);
			fixed (byte* ptr = &dest[destIdx])
			{
				byte* ptr2 = (byte*)(&value);
				for (int i = 0; i < 8; i++)
				{
					ptr[i] = ptr2[7 - i];
				}
			}
		}

		public unsafe override void PutBytes(byte[] dest, int destIdx, short value)
		{
			Check(dest, destIdx, 2);
			fixed (byte* ptr = &dest[destIdx])
			{
				byte* ptr2 = (byte*)(&value);
				for (int i = 0; i < 2; i++)
				{
					ptr[i] = ptr2[1 - i];
				}
			}
		}

		public unsafe override void PutBytes(byte[] dest, int destIdx, ushort value)
		{
			Check(dest, destIdx, 2);
			fixed (byte* ptr = &dest[destIdx])
			{
				byte* ptr2 = (byte*)(&value);
				for (int i = 0; i < 2; i++)
				{
					ptr[i] = ptr2[1 - i];
				}
			}
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

	public abstract void PutBytes(byte[] dest, int destIdx, double value);

	public abstract void PutBytes(byte[] dest, int destIdx, float value);

	public abstract void PutBytes(byte[] dest, int destIdx, int value);

	public abstract void PutBytes(byte[] dest, int destIdx, long value);

	public abstract void PutBytes(byte[] dest, int destIdx, short value);

	[CLSCompliant(false)]
	public abstract void PutBytes(byte[] dest, int destIdx, ushort value);

	[CLSCompliant(false)]
	public abstract void PutBytes(byte[] dest, int destIdx, uint value);

	[CLSCompliant(false)]
	public abstract void PutBytes(byte[] dest, int destIdx, ulong value);

	public byte[] GetBytes(double value)
	{
		byte[] array = new byte[8];
		PutBytes(array, 0, value);
		return array;
	}

	public byte[] GetBytes(float value)
	{
		byte[] array = new byte[4];
		PutBytes(array, 0, value);
		return array;
	}

	public byte[] GetBytes(int value)
	{
		byte[] array = new byte[4];
		PutBytes(array, 0, value);
		return array;
	}

	public byte[] GetBytes(long value)
	{
		byte[] array = new byte[8];
		PutBytes(array, 0, value);
		return array;
	}

	public byte[] GetBytes(short value)
	{
		byte[] array = new byte[2];
		PutBytes(array, 0, value);
		return array;
	}

	[CLSCompliant(false)]
	public byte[] GetBytes(ushort value)
	{
		byte[] array = new byte[2];
		PutBytes(array, 0, value);
		return array;
	}

	[CLSCompliant(false)]
	public byte[] GetBytes(uint value)
	{
		byte[] array = new byte[4];
		PutBytes(array, 0, value);
		return array;
	}

	[CLSCompliant(false)]
	public byte[] GetBytes(ulong value)
	{
		byte[] array = new byte[8];
		PutBytes(array, 0, value);
		return array;
	}

	private static int Align(int current, int align)
	{
		return (current + align - 1) / align * align;
	}

	public static byte[] Pack(string description, params object[] args)
	{
		int num = 0;
		PackContext packContext = new PackContext();
		packContext.conv = CopyConv;
		packContext.description = description;
		packContext.i = 0;
		while (packContext.i < description.Length)
		{
			object oarg;
			if (num < args.Length)
			{
				oarg = args[num];
			}
			else
			{
				if (packContext.repeat != 0)
				{
					break;
				}
				oarg = null;
			}
			int i = packContext.i;
			if (PackOne(packContext, oarg))
			{
				num++;
				if (packContext.repeat > 0)
				{
					if (--packContext.repeat > 0)
					{
						packContext.i = i;
					}
					else
					{
						packContext.i++;
					}
				}
				else
				{
					packContext.i++;
				}
			}
			else
			{
				packContext.i++;
			}
		}
		return packContext.Get();
	}

	private static bool PackOne(PackContext b, object oarg)
	{
		switch (b.description[b.i])
		{
		case '^':
			b.conv = BigEndian;
			return false;
		case '_':
			b.conv = LittleEndian;
			return false;
		case '%':
			b.conv = Native;
			return false;
		case '!':
			b.align = -1;
			return false;
		case 'x':
			b.Add(new byte[1]);
			return false;
		case 'i':
			b.Add(b.conv.GetBytes(Convert.ToInt32(oarg)));
			break;
		case 'I':
			b.Add(b.conv.GetBytes(Convert.ToUInt32(oarg)));
			break;
		case 's':
			b.Add(b.conv.GetBytes(Convert.ToInt16(oarg)));
			break;
		case 'S':
			b.Add(b.conv.GetBytes(Convert.ToUInt16(oarg)));
			break;
		case 'l':
			b.Add(b.conv.GetBytes(Convert.ToInt64(oarg)));
			break;
		case 'L':
			b.Add(b.conv.GetBytes(Convert.ToUInt64(oarg)));
			break;
		case 'f':
			b.Add(b.conv.GetBytes(Convert.ToSingle(oarg)));
			break;
		case 'd':
			b.Add(b.conv.GetBytes(Convert.ToDouble(oarg)));
			break;
		case 'b':
			b.Add(new byte[1] { Convert.ToByte(oarg) });
			break;
		case 'c':
			b.Add(new byte[1] { (byte)Convert.ToSByte(oarg) });
			break;
		case 'C':
			b.Add(new byte[1] { Convert.ToByte(oarg) });
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
			b.repeat = (short)b.description[b.i] - 48;
			return false;
		case '*':
			b.repeat = int.MaxValue;
			return false;
		case '[':
		{
			int num2 = -1;
			int i;
			for (i = b.i + 1; i < b.description.Length && b.description[i] != ']'; i++)
			{
				int num = (short)b.description[i] - 48;
				if (num >= 0 && num <= 9)
				{
					num2 = ((num2 != -1) ? (num2 * 10 + num) : num);
				}
			}
			if (num2 == -1)
			{
				throw new ArgumentException("invalid size specification");
			}
			b.i = i;
			b.repeat = num2;
			return false;
		}
		case '$':
		case 'z':
		{
			bool flag = b.description[b.i] == 'z';
			b.i++;
			if (b.i >= b.description.Length)
			{
				throw new ArgumentException("$ description needs a type specified", "description");
			}
			Encoding encoding;
			int num;
			switch (b.description[b.i])
			{
			case '8':
				encoding = Encoding.UTF8;
				num = 1;
				break;
			case '6':
				encoding = Encoding.Unicode;
				num = 2;
				break;
			case '7':
				encoding = Encoding.UTF7;
				num = 1;
				break;
			case 'b':
				encoding = Encoding.BigEndianUnicode;
				num = 2;
				break;
			case '3':
				encoding = Encoding.GetEncoding(12000);
				num = 4;
				break;
			case '4':
				encoding = Encoding.GetEncoding(12001);
				num = 4;
				break;
			default:
				throw new ArgumentException("Invalid format for $ specifier", "description");
			}
			if (b.align == -1)
			{
				b.align = 4;
			}
			b.Add(encoding.GetBytes(Convert.ToString(oarg)));
			if (flag)
			{
				b.Add(new byte[num]);
			}
			break;
		}
		default:
			throw new ArgumentException($"invalid format specified `{b.description[b.i]}'");
		}
		return true;
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

	internal void Check(byte[] dest, int destIdx, int size)
	{
		if (dest == null)
		{
			throw new ArgumentNullException("dest");
		}
		if (destIdx < 0 || destIdx > dest.Length - size)
		{
			throw new ArgumentException("destIdx");
		}
	}
}
