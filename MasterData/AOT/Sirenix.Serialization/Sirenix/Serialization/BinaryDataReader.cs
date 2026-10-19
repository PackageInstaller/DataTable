using System;
using System.Collections.Generic;
using System.IO;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using Sirenix.Serialization.Utilities.Unsafe;

namespace Sirenix.Serialization;

public class BinaryDataReader : BaseDataReader
{
	private struct Struct256Bit
	{
		public decimal d1;

		public decimal d2;
	}

	private static readonly Dictionary<Type, Delegate> PrimitiveFromByteMethods = new Dictionary<Type, Delegate>
	{
		{
			typeof(char),
			(Func<byte[], int, char>)((byte[] b, int i) => (char)ProperBitConverter.ToUInt16(b, i))
		},
		{
			typeof(byte),
			(Func<byte[], int, byte>)((byte[] b, int i) => b[i])
		},
		{
			typeof(sbyte),
			(Func<byte[], int, sbyte>)((byte[] b, int i) => (sbyte)b[i])
		},
		{
			typeof(bool),
			(Func<byte[], int, bool>)((byte[] b, int i) => b[i] != 0)
		},
		{
			typeof(short),
			new Func<byte[], int, short>(ProperBitConverter.ToInt16)
		},
		{
			typeof(int),
			new Func<byte[], int, int>(ProperBitConverter.ToInt32)
		},
		{
			typeof(long),
			new Func<byte[], int, long>(ProperBitConverter.ToInt64)
		},
		{
			typeof(ushort),
			new Func<byte[], int, ushort>(ProperBitConverter.ToUInt16)
		},
		{
			typeof(uint),
			new Func<byte[], int, uint>(ProperBitConverter.ToUInt32)
		},
		{
			typeof(ulong),
			new Func<byte[], int, ulong>(ProperBitConverter.ToUInt64)
		},
		{
			typeof(decimal),
			new Func<byte[], int, decimal>(ProperBitConverter.ToDecimal)
		},
		{
			typeof(float),
			new Func<byte[], int, float>(ProperBitConverter.ToSingle)
		},
		{
			typeof(double),
			new Func<byte[], int, double>(ProperBitConverter.ToDouble)
		},
		{
			typeof(Guid),
			new Func<byte[], int, Guid>(ProperBitConverter.ToGuid)
		}
	};

	private byte[] internalBufferBackup;

	private byte[] buffer = new byte[102400];

	private int bufferIndex;

	private int bufferEnd;

	private EntryType? peekedEntryType;

	private BinaryEntryType peekedBinaryEntryType;

	private string peekedEntryName;

	private Dictionary<int, Type> types = new Dictionary<int, Type>(16);

	public BinaryDataReader()
		: base(null, null)
	{
		internalBufferBackup = buffer;
	}

	public BinaryDataReader(Stream stream, DeserializationContext context)
		: base(stream, context)
	{
		internalBufferBackup = buffer;
	}

	public override void Dispose()
	{
	}

	public override EntryType PeekEntry(out string name)
	{
		if (peekedEntryType.HasValue)
		{
			name = peekedEntryName;
			return peekedEntryType.Value;
		}
		peekedBinaryEntryType = (BinaryEntryType)(HasBufferData(1) ? buffer[bufferIndex++] : 49);
		switch (peekedBinaryEntryType)
		{
		case BinaryEntryType.EndOfStream:
			name = null;
			peekedEntryName = null;
			peekedEntryType = EntryType.EndOfStream;
			break;
		case BinaryEntryType.NamedStartOfReferenceNode:
		case BinaryEntryType.NamedStartOfStructNode:
			name = ReadStringValue();
			peekedEntryType = EntryType.StartOfNode;
			break;
		case BinaryEntryType.UnnamedStartOfReferenceNode:
		case BinaryEntryType.UnnamedStartOfStructNode:
			name = null;
			peekedEntryType = EntryType.StartOfNode;
			break;
		case BinaryEntryType.EndOfNode:
			name = null;
			peekedEntryType = EntryType.EndOfNode;
			break;
		case BinaryEntryType.StartOfArray:
			name = null;
			peekedEntryType = EntryType.StartOfArray;
			break;
		case BinaryEntryType.EndOfArray:
			name = null;
			peekedEntryType = EntryType.EndOfArray;
			break;
		case BinaryEntryType.PrimitiveArray:
			name = null;
			peekedEntryType = EntryType.PrimitiveArray;
			break;
		case BinaryEntryType.NamedInternalReference:
			name = ReadStringValue();
			peekedEntryType = EntryType.InternalReference;
			break;
		case BinaryEntryType.UnnamedInternalReference:
			name = null;
			peekedEntryType = EntryType.InternalReference;
			break;
		case BinaryEntryType.NamedExternalReferenceByIndex:
			name = ReadStringValue();
			peekedEntryType = EntryType.ExternalReferenceByIndex;
			break;
		case BinaryEntryType.UnnamedExternalReferenceByIndex:
			name = null;
			peekedEntryType = EntryType.ExternalReferenceByIndex;
			break;
		case BinaryEntryType.NamedExternalReferenceByGuid:
			name = ReadStringValue();
			peekedEntryType = EntryType.ExternalReferenceByGuid;
			break;
		case BinaryEntryType.UnnamedExternalReferenceByGuid:
			name = null;
			peekedEntryType = EntryType.ExternalReferenceByGuid;
			break;
		case BinaryEntryType.NamedExternalReferenceByString:
			name = ReadStringValue();
			peekedEntryType = EntryType.ExternalReferenceByString;
			break;
		case BinaryEntryType.UnnamedExternalReferenceByString:
			name = null;
			peekedEntryType = EntryType.ExternalReferenceByString;
			break;
		case BinaryEntryType.NamedSByte:
			name = ReadStringValue();
			peekedEntryType = EntryType.Integer;
			break;
		case BinaryEntryType.UnnamedSByte:
			name = null;
			peekedEntryType = EntryType.Integer;
			break;
		case BinaryEntryType.NamedByte:
			name = ReadStringValue();
			peekedEntryType = EntryType.Integer;
			break;
		case BinaryEntryType.UnnamedByte:
			name = null;
			peekedEntryType = EntryType.Integer;
			break;
		case BinaryEntryType.NamedShort:
			name = ReadStringValue();
			peekedEntryType = EntryType.Integer;
			break;
		case BinaryEntryType.UnnamedShort:
			name = null;
			peekedEntryType = EntryType.Integer;
			break;
		case BinaryEntryType.NamedUShort:
			name = ReadStringValue();
			peekedEntryType = EntryType.Integer;
			break;
		case BinaryEntryType.UnnamedUShort:
			name = null;
			peekedEntryType = EntryType.Integer;
			break;
		case BinaryEntryType.NamedInt:
			name = ReadStringValue();
			peekedEntryType = EntryType.Integer;
			break;
		case BinaryEntryType.UnnamedInt:
			name = null;
			peekedEntryType = EntryType.Integer;
			break;
		case BinaryEntryType.NamedUInt:
			name = ReadStringValue();
			peekedEntryType = EntryType.Integer;
			break;
		case BinaryEntryType.UnnamedUInt:
			name = null;
			peekedEntryType = EntryType.Integer;
			break;
		case BinaryEntryType.NamedLong:
			name = ReadStringValue();
			peekedEntryType = EntryType.Integer;
			break;
		case BinaryEntryType.UnnamedLong:
			name = null;
			peekedEntryType = EntryType.Integer;
			break;
		case BinaryEntryType.NamedULong:
			name = ReadStringValue();
			peekedEntryType = EntryType.Integer;
			break;
		case BinaryEntryType.UnnamedULong:
			name = null;
			peekedEntryType = EntryType.Integer;
			break;
		case BinaryEntryType.NamedFloat:
			name = ReadStringValue();
			peekedEntryType = EntryType.FloatingPoint;
			break;
		case BinaryEntryType.UnnamedFloat:
			name = null;
			peekedEntryType = EntryType.FloatingPoint;
			break;
		case BinaryEntryType.NamedDouble:
			name = ReadStringValue();
			peekedEntryType = EntryType.FloatingPoint;
			break;
		case BinaryEntryType.UnnamedDouble:
			name = null;
			peekedEntryType = EntryType.FloatingPoint;
			break;
		case BinaryEntryType.NamedDecimal:
			name = ReadStringValue();
			peekedEntryType = EntryType.FloatingPoint;
			break;
		case BinaryEntryType.UnnamedDecimal:
			name = null;
			peekedEntryType = EntryType.FloatingPoint;
			break;
		case BinaryEntryType.NamedChar:
			name = ReadStringValue();
			peekedEntryType = EntryType.String;
			break;
		case BinaryEntryType.UnnamedChar:
			name = null;
			peekedEntryType = EntryType.String;
			break;
		case BinaryEntryType.NamedString:
			name = ReadStringValue();
			peekedEntryType = EntryType.String;
			break;
		case BinaryEntryType.UnnamedString:
			name = null;
			peekedEntryType = EntryType.String;
			break;
		case BinaryEntryType.NamedGuid:
			name = ReadStringValue();
			peekedEntryType = EntryType.Guid;
			break;
		case BinaryEntryType.UnnamedGuid:
			name = null;
			peekedEntryType = EntryType.Guid;
			break;
		case BinaryEntryType.NamedBoolean:
			name = ReadStringValue();
			peekedEntryType = EntryType.Boolean;
			break;
		case BinaryEntryType.UnnamedBoolean:
			name = null;
			peekedEntryType = EntryType.Boolean;
			break;
		case BinaryEntryType.NamedNull:
			name = ReadStringValue();
			peekedEntryType = EntryType.Null;
			break;
		case BinaryEntryType.UnnamedNull:
			name = null;
			peekedEntryType = EntryType.Null;
			break;
		case BinaryEntryType.TypeName:
		case BinaryEntryType.TypeID:
			peekedBinaryEntryType = BinaryEntryType.Invalid;
			peekedEntryType = EntryType.Invalid;
			throw new InvalidOperationException("Invalid binary data stream: BinaryEntryType.TypeName and BinaryEntryType.TypeID must never be peeked by the binary reader.");
		default:
		{
			name = null;
			peekedBinaryEntryType = BinaryEntryType.Invalid;
			peekedEntryType = EntryType.Invalid;
			byte b = (byte)peekedBinaryEntryType;
			throw new InvalidOperationException("Invalid binary data stream: could not parse peeked BinaryEntryType byte '" + b + "' into a known entry type.");
		}
		}
		peekedEntryName = name;
		return peekedEntryType.Value;
	}

	public override bool EnterArray(out long length)
	{
		if (!peekedEntryType.HasValue)
		{
			PeekEntry(out var _);
		}
		if (peekedEntryType == EntryType.StartOfArray)
		{
			PushArray();
			MarkEntryContentConsumed();
			if (UNSAFE_Read_8_Int64(out length))
			{
				if (length < 0)
				{
					length = 0L;
					Context.Config.DebugContext.LogError("Invalid array length: " + length + ".");
					return false;
				}
				return true;
			}
			return false;
		}
		SkipEntry();
		length = 0L;
		return false;
	}

	public override bool EnterNode(out Type type)
	{
		if (!peekedEntryType.HasValue)
		{
			PeekEntry(out var _);
		}
		if (peekedBinaryEntryType == BinaryEntryType.NamedStartOfReferenceNode || peekedBinaryEntryType == BinaryEntryType.UnnamedStartOfReferenceNode)
		{
			MarkEntryContentConsumed();
			type = ReadTypeEntry();
			if (!UNSAFE_Read_4_Int32(out var value))
			{
				type = null;
				return false;
			}
			PushNode(peekedEntryName, value, type);
			return true;
		}
		if (peekedBinaryEntryType == BinaryEntryType.NamedStartOfStructNode || peekedBinaryEntryType == BinaryEntryType.UnnamedStartOfStructNode)
		{
			type = ReadTypeEntry();
			PushNode(peekedEntryName, -1, type);
			MarkEntryContentConsumed();
			return true;
		}
		SkipEntry();
		type = null;
		return false;
	}

	public override bool ExitArray()
	{
		if (!peekedEntryType.HasValue)
		{
			PeekEntry(out var _);
		}
		while (peekedBinaryEntryType != BinaryEntryType.EndOfArray && peekedBinaryEntryType != BinaryEntryType.EndOfStream)
		{
			if (peekedEntryType == EntryType.EndOfNode)
			{
				Context.Config.DebugContext.LogError("Data layout mismatch; skipping past node boundary when exiting array.");
				MarkEntryContentConsumed();
			}
			SkipEntry();
		}
		if (peekedBinaryEntryType == BinaryEntryType.EndOfArray)
		{
			MarkEntryContentConsumed();
			PopArray();
			return true;
		}
		return false;
	}

	public override bool ExitNode()
	{
		if (!peekedEntryType.HasValue)
		{
			PeekEntry(out var _);
		}
		while (peekedBinaryEntryType != BinaryEntryType.EndOfNode && peekedBinaryEntryType != BinaryEntryType.EndOfStream)
		{
			if (peekedEntryType == EntryType.EndOfArray)
			{
				Context.Config.DebugContext.LogError("Data layout mismatch; skipping past array boundary when exiting node.");
				MarkEntryContentConsumed();
			}
			SkipEntry();
		}
		if (peekedBinaryEntryType == BinaryEntryType.EndOfNode)
		{
			MarkEntryContentConsumed();
			PopNode(CurrentNodeName);
			return true;
		}
		return false;
	}

	public unsafe override bool ReadPrimitiveArray<T>(out T[] array)
	{
		if (!FormatterUtilities.IsPrimitiveArrayType(typeof(T)))
		{
			throw new ArgumentException("Type " + typeof(T).Name + " is not a valid primitive array type.");
		}
		if (!peekedEntryType.HasValue)
		{
			PeekEntry(out var _);
		}
		if (peekedEntryType == EntryType.PrimitiveArray)
		{
			MarkEntryContentConsumed();
			if (!UNSAFE_Read_4_Int32(out var value) || !UNSAFE_Read_4_Int32(out var value2))
			{
				array = null;
				return false;
			}
			int num = value * value2;
			if (!HasBufferData(num))
			{
				bufferIndex = bufferEnd;
				array = null;
				return false;
			}
			if (typeof(T) == typeof(byte))
			{
				byte[] array2 = new byte[num];
				Buffer.BlockCopy(buffer, bufferIndex, array2, 0, num);
				array = (T[])(object)array2;
				bufferIndex += num;
				return true;
			}
			array = new T[value];
			if (BitConverter.IsLittleEndian)
			{
				GCHandle gCHandle = GCHandle.Alloc(array, GCHandleType.Pinned);
				try
				{
					fixed (byte* ptr = buffer)
					{
						void* ptr2 = ptr + bufferIndex;
						void* to = gCHandle.AddrOfPinnedObject().ToPointer();
						UnsafeUtilities.MemoryCopy(ptr2, to, num);
					}
				}
				finally
				{
					gCHandle.Free();
				}
			}
			else
			{
				Func<byte[], int, T> func = (Func<byte[], int, T>)PrimitiveFromByteMethods[typeof(T)];
				for (int i = 0; i < value; i++)
				{
					array[i] = func(buffer, bufferIndex + i * value2);
				}
			}
			bufferIndex += num;
			return true;
		}
		SkipEntry();
		array = null;
		return false;
	}

	public override bool ReadBoolean(out bool value)
	{
		if (!peekedEntryType.HasValue)
		{
			PeekEntry(out var _);
		}
		if (peekedEntryType == EntryType.Boolean)
		{
			MarkEntryContentConsumed();
			if (HasBufferData(1))
			{
				value = buffer[bufferIndex++] == 1;
				return true;
			}
			value = false;
			return false;
		}
		SkipEntry();
		value = false;
		return false;
	}

	public override bool ReadSByte(out sbyte value)
	{
		if (ReadInt64(out var value2))
		{
			try
			{
				value = checked((sbyte)value2);
			}
			catch (OverflowException)
			{
				value = 0;
			}
			return true;
		}
		value = 0;
		return false;
	}

	public override bool ReadByte(out byte value)
	{
		if (ReadUInt64(out var value2))
		{
			try
			{
				value = checked((byte)value2);
			}
			catch (OverflowException)
			{
				value = 0;
			}
			return true;
		}
		value = 0;
		return false;
	}

	public override bool ReadInt16(out short value)
	{
		if (ReadInt64(out var value2))
		{
			try
			{
				value = checked((short)value2);
			}
			catch (OverflowException)
			{
				value = 0;
			}
			return true;
		}
		value = 0;
		return false;
	}

	public override bool ReadUInt16(out ushort value)
	{
		if (ReadUInt64(out var value2))
		{
			try
			{
				value = checked((ushort)value2);
			}
			catch (OverflowException)
			{
				value = 0;
			}
			return true;
		}
		value = 0;
		return false;
	}

	public override bool ReadInt32(out int value)
	{
		if (ReadInt64(out var value2))
		{
			try
			{
				value = checked((int)value2);
			}
			catch (OverflowException)
			{
				value = 0;
			}
			return true;
		}
		value = 0;
		return false;
	}

	public override bool ReadUInt32(out uint value)
	{
		if (ReadUInt64(out var value2))
		{
			try
			{
				value = checked((uint)value2);
			}
			catch (OverflowException)
			{
				value = 0u;
			}
			return true;
		}
		value = 0u;
		return false;
	}

	public override bool ReadInt64(out long value)
	{
		if (!peekedEntryType.HasValue)
		{
			PeekEntry(out var _);
		}
		if (peekedEntryType == EntryType.Integer)
		{
			try
			{
				switch (peekedBinaryEntryType)
				{
				case BinaryEntryType.NamedSByte:
				case BinaryEntryType.UnnamedSByte:
				{
					if (!UNSAFE_Read_1_SByte(out var value5))
					{
						value = 0L;
						return false;
					}
					value = value5;
					break;
				}
				case BinaryEntryType.NamedByte:
				case BinaryEntryType.UnnamedByte:
				{
					if (!UNSAFE_Read_1_Byte(out var value6))
					{
						value = 0L;
						return false;
					}
					value = value6;
					break;
				}
				case BinaryEntryType.NamedShort:
				case BinaryEntryType.UnnamedShort:
				{
					if (!UNSAFE_Read_2_Int16(out var value7))
					{
						value = 0L;
						return false;
					}
					value = value7;
					break;
				}
				case BinaryEntryType.NamedUShort:
				case BinaryEntryType.UnnamedUShort:
				{
					if (!UNSAFE_Read_2_UInt16(out var value3))
					{
						value = 0L;
						return false;
					}
					value = value3;
					break;
				}
				case BinaryEntryType.NamedInt:
				case BinaryEntryType.UnnamedInt:
				{
					if (!UNSAFE_Read_4_Int32(out var value4))
					{
						value = 0L;
						return false;
					}
					value = value4;
					break;
				}
				case BinaryEntryType.NamedUInt:
				case BinaryEntryType.UnnamedUInt:
				{
					if (!UNSAFE_Read_4_UInt32(out var value8))
					{
						value = 0L;
						return false;
					}
					value = value8;
					break;
				}
				case BinaryEntryType.NamedLong:
				case BinaryEntryType.UnnamedLong:
					if (!UNSAFE_Read_8_Int64(out value))
					{
						return false;
					}
					break;
				case BinaryEntryType.NamedULong:
				case BinaryEntryType.UnnamedULong:
				{
					if (!UNSAFE_Read_8_UInt64(out var value2))
					{
						value = 0L;
						return false;
					}
					if (value2 > long.MaxValue)
					{
						value = 0L;
						return false;
					}
					value = (long)value2;
					break;
				}
				default:
					throw new InvalidOperationException();
				}
				return true;
			}
			finally
			{
				MarkEntryContentConsumed();
			}
		}
		SkipEntry();
		value = 0L;
		return false;
	}

	public override bool ReadUInt64(out ulong value)
	{
		if (!peekedEntryType.HasValue)
		{
			PeekEntry(out var _);
		}
		if (peekedEntryType == EntryType.Integer)
		{
			try
			{
				switch (peekedBinaryEntryType)
				{
				case BinaryEntryType.NamedSByte:
				case BinaryEntryType.UnnamedSByte:
				case BinaryEntryType.NamedByte:
				case BinaryEntryType.UnnamedByte:
				{
					if (!UNSAFE_Read_1_Byte(out var value7))
					{
						value = 0uL;
						return false;
					}
					value = value7;
					break;
				}
				case BinaryEntryType.NamedShort:
				case BinaryEntryType.UnnamedShort:
				{
					if (!UNSAFE_Read_2_Int16(out var value4))
					{
						value = 0uL;
						return false;
					}
					if (value4 < 0)
					{
						value = 0uL;
						return false;
					}
					value = (ulong)value4;
					break;
				}
				case BinaryEntryType.NamedUShort:
				case BinaryEntryType.UnnamedUShort:
				{
					if (!UNSAFE_Read_2_UInt16(out var value6))
					{
						value = 0uL;
						return false;
					}
					value = value6;
					break;
				}
				case BinaryEntryType.NamedInt:
				case BinaryEntryType.UnnamedInt:
				{
					if (!UNSAFE_Read_4_Int32(out var value5))
					{
						value = 0uL;
						return false;
					}
					if (value5 < 0)
					{
						value = 0uL;
						return false;
					}
					value = (ulong)value5;
					break;
				}
				case BinaryEntryType.NamedUInt:
				case BinaryEntryType.UnnamedUInt:
				{
					if (!UNSAFE_Read_4_UInt32(out var value2))
					{
						value = 0uL;
						return false;
					}
					value = value2;
					break;
				}
				case BinaryEntryType.NamedLong:
				case BinaryEntryType.UnnamedLong:
				{
					if (!UNSAFE_Read_8_Int64(out var value3))
					{
						value = 0uL;
						return false;
					}
					if (value3 < 0)
					{
						value = 0uL;
						return false;
					}
					value = (ulong)value3;
					break;
				}
				case BinaryEntryType.NamedULong:
				case BinaryEntryType.UnnamedULong:
					if (!UNSAFE_Read_8_UInt64(out value))
					{
						return false;
					}
					break;
				default:
					throw new InvalidOperationException();
				}
				return true;
			}
			finally
			{
				MarkEntryContentConsumed();
			}
		}
		SkipEntry();
		value = 0uL;
		return false;
	}

	public override bool ReadChar(out char value)
	{
		if (!peekedEntryType.HasValue)
		{
			PeekEntry(out var _);
		}
		if (peekedBinaryEntryType == BinaryEntryType.NamedChar || peekedBinaryEntryType == BinaryEntryType.UnnamedChar)
		{
			MarkEntryContentConsumed();
			return UNSAFE_Read_2_Char(out value);
		}
		if (peekedBinaryEntryType == BinaryEntryType.NamedString || peekedBinaryEntryType == BinaryEntryType.UnnamedString)
		{
			MarkEntryContentConsumed();
			string text = ReadStringValue();
			if (text == null || text.Length == 0)
			{
				value = '\0';
				return false;
			}
			value = text[0];
			return true;
		}
		SkipEntry();
		value = '\0';
		return false;
	}

	public override bool ReadSingle(out float value)
	{
		if (!peekedEntryType.HasValue)
		{
			PeekEntry(out var _);
		}
		if (peekedBinaryEntryType == BinaryEntryType.NamedFloat || peekedBinaryEntryType == BinaryEntryType.UnnamedFloat)
		{
			MarkEntryContentConsumed();
			return UNSAFE_Read_4_Float32(out value);
		}
		if (peekedBinaryEntryType == BinaryEntryType.NamedDouble || peekedBinaryEntryType == BinaryEntryType.UnnamedDouble)
		{
			MarkEntryContentConsumed();
			if (!UNSAFE_Read_8_Float64(out var value2))
			{
				value = 0f;
				return false;
			}
			try
			{
				value = (float)value2;
			}
			catch (OverflowException)
			{
				value = 0f;
			}
			return true;
		}
		if (peekedBinaryEntryType == BinaryEntryType.NamedDecimal || peekedBinaryEntryType == BinaryEntryType.UnnamedDecimal)
		{
			MarkEntryContentConsumed();
			if (!UNSAFE_Read_16_Decimal(out var value3))
			{
				value = 0f;
				return false;
			}
			try
			{
				value = (float)value3;
			}
			catch (OverflowException)
			{
				value = 0f;
			}
			return true;
		}
		if (peekedEntryType == EntryType.Integer)
		{
			if (!ReadInt64(out var value4))
			{
				value = 0f;
				return false;
			}
			try
			{
				value = value4;
			}
			catch (OverflowException)
			{
				value = 0f;
			}
			return true;
		}
		SkipEntry();
		value = 0f;
		return false;
	}

	public override bool ReadDouble(out double value)
	{
		if (!peekedEntryType.HasValue)
		{
			PeekEntry(out var _);
		}
		if (peekedBinaryEntryType == BinaryEntryType.NamedDouble || peekedBinaryEntryType == BinaryEntryType.UnnamedDouble)
		{
			MarkEntryContentConsumed();
			return UNSAFE_Read_8_Float64(out value);
		}
		if (peekedBinaryEntryType == BinaryEntryType.NamedFloat || peekedBinaryEntryType == BinaryEntryType.UnnamedFloat)
		{
			MarkEntryContentConsumed();
			if (!UNSAFE_Read_4_Float32(out var value2))
			{
				value = 0.0;
				return false;
			}
			value = value2;
			return true;
		}
		if (peekedBinaryEntryType == BinaryEntryType.NamedDecimal || peekedBinaryEntryType == BinaryEntryType.UnnamedDecimal)
		{
			MarkEntryContentConsumed();
			if (!UNSAFE_Read_16_Decimal(out var value3))
			{
				value = 0.0;
				return false;
			}
			try
			{
				value = (double)value3;
			}
			catch (OverflowException)
			{
				value = 0.0;
			}
			return true;
		}
		if (peekedEntryType == EntryType.Integer)
		{
			if (!ReadInt64(out var value4))
			{
				value = 0.0;
				return false;
			}
			try
			{
				value = value4;
			}
			catch (OverflowException)
			{
				value = 0.0;
			}
			return true;
		}
		SkipEntry();
		value = 0.0;
		return false;
	}

	public override bool ReadDecimal(out decimal value)
	{
		if (!peekedEntryType.HasValue)
		{
			PeekEntry(out var _);
		}
		if (peekedBinaryEntryType == BinaryEntryType.NamedDecimal || peekedBinaryEntryType == BinaryEntryType.UnnamedDecimal)
		{
			MarkEntryContentConsumed();
			return UNSAFE_Read_16_Decimal(out value);
		}
		if (peekedBinaryEntryType == BinaryEntryType.NamedDouble || peekedBinaryEntryType == BinaryEntryType.UnnamedDouble)
		{
			MarkEntryContentConsumed();
			if (!UNSAFE_Read_8_Float64(out var value2))
			{
				value = 0m;
				return false;
			}
			try
			{
				value = (decimal)value2;
			}
			catch (OverflowException)
			{
				value = 0m;
			}
			return true;
		}
		if (peekedBinaryEntryType == BinaryEntryType.NamedFloat || peekedBinaryEntryType == BinaryEntryType.UnnamedFloat)
		{
			MarkEntryContentConsumed();
			if (!UNSAFE_Read_4_Float32(out var value3))
			{
				value = 0m;
				return false;
			}
			try
			{
				value = (decimal)value3;
			}
			catch (OverflowException)
			{
				value = 0m;
			}
			return true;
		}
		if (peekedEntryType == EntryType.Integer)
		{
			if (!ReadInt64(out var value4))
			{
				value = 0m;
				return false;
			}
			try
			{
				value = value4;
			}
			catch (OverflowException)
			{
				value = 0m;
			}
			return true;
		}
		SkipEntry();
		value = 0m;
		return false;
	}

	public override bool ReadExternalReference(out Guid guid)
	{
		if (!peekedEntryType.HasValue)
		{
			PeekEntry(out var _);
		}
		if (peekedBinaryEntryType == BinaryEntryType.NamedExternalReferenceByGuid || peekedBinaryEntryType == BinaryEntryType.UnnamedExternalReferenceByGuid)
		{
			MarkEntryContentConsumed();
			return UNSAFE_Read_16_Guid(out guid);
		}
		SkipEntry();
		guid = default;
		return false;
	}

	public override bool ReadGuid(out Guid value)
	{
		if (!peekedEntryType.HasValue)
		{
			PeekEntry(out var _);
		}
		if (peekedBinaryEntryType == BinaryEntryType.NamedGuid || peekedBinaryEntryType == BinaryEntryType.UnnamedGuid)
		{
			MarkEntryContentConsumed();
			return UNSAFE_Read_16_Guid(out value);
		}
		SkipEntry();
		value = default;
		return false;
	}

	public override bool ReadExternalReference(out int index)
	{
		if (!peekedEntryType.HasValue)
		{
			PeekEntry(out var _);
		}
		if (peekedBinaryEntryType == BinaryEntryType.NamedExternalReferenceByIndex || peekedBinaryEntryType == BinaryEntryType.UnnamedExternalReferenceByIndex)
		{
			MarkEntryContentConsumed();
			return UNSAFE_Read_4_Int32(out index);
		}
		SkipEntry();
		index = -1;
		return false;
	}

	public override bool ReadExternalReference(out string id)
	{
		if (!peekedEntryType.HasValue)
		{
			PeekEntry(out var _);
		}
		if (peekedBinaryEntryType == BinaryEntryType.NamedExternalReferenceByString || peekedBinaryEntryType == BinaryEntryType.UnnamedExternalReferenceByString)
		{
			id = ReadStringValue();
			MarkEntryContentConsumed();
			return id != null;
		}
		SkipEntry();
		id = null;
		return false;
	}

	public override bool ReadNull()
	{
		if (!peekedEntryType.HasValue)
		{
			PeekEntry(out var _);
		}
		if (peekedBinaryEntryType == BinaryEntryType.NamedNull || peekedBinaryEntryType == BinaryEntryType.UnnamedNull)
		{
			MarkEntryContentConsumed();
			return true;
		}
		SkipEntry();
		return false;
	}

	public override bool ReadInternalReference(out int id)
	{
		if (!peekedEntryType.HasValue)
		{
			PeekEntry(out var _);
		}
		if (peekedBinaryEntryType == BinaryEntryType.NamedInternalReference || peekedBinaryEntryType == BinaryEntryType.UnnamedInternalReference)
		{
			MarkEntryContentConsumed();
			return UNSAFE_Read_4_Int32(out id);
		}
		SkipEntry();
		id = -1;
		return false;
	}

	public override bool ReadString(out string value)
	{
		if (!peekedEntryType.HasValue)
		{
			PeekEntry(out var _);
		}
		if (peekedBinaryEntryType == BinaryEntryType.NamedString || peekedBinaryEntryType == BinaryEntryType.UnnamedString)
		{
			value = ReadStringValue();
			MarkEntryContentConsumed();
			return value != null;
		}
		SkipEntry();
		value = null;
		return false;
	}

	public override void PrepareNewSerializationSession()
	{
		base.PrepareNewSerializationSession();
		peekedEntryType = null;
		peekedEntryName = null;
		peekedBinaryEntryType = BinaryEntryType.Invalid;
		types.Clear();
		bufferIndex = 0;
		bufferEnd = 0;
		buffer = internalBufferBackup;
	}

	public unsafe override string GetDataDump()
	{
		byte[] array;
		if (bufferEnd == buffer.Length)
		{
			array = buffer;
		}
		else
		{
			array = new byte[bufferEnd];
			fixed (byte* ptr = buffer)
			{
				void* ptr2 = ptr;
				fixed (byte* ptr3 = array)
				{
					void* to = ptr3;
					UnsafeUtilities.MemoryCopy(ptr2, to, array.Length);
				}
			}
		}
		return "Binary hex dump: " + ProperBitConverter.BytesToHexString(array);
	}

	[MethodImpl((MethodImplOptions)256)]
	private unsafe string ReadStringValue()
	{
		if (!UNSAFE_Read_1_Byte(out var value))
		{
			return null;
		}
		if (!UNSAFE_Read_4_Int32(out var value2))
		{
			return null;
		}
		string text = new string(' ', value2);
		if (value == 0)
		{
			fixed (byte* ptr = buffer)
			{
				fixed (char* ptr2 = text)
				{
					byte* ptr3 = ptr + bufferIndex;
					byte* ptr4 = (byte*)ptr2;
					if (BitConverter.IsLittleEndian)
					{
						for (int i = 0; i < value2; i++)
						{
							*(ptr4++) = *(ptr3++);
							ptr4++;
						}
					}
					else
					{
						for (int j = 0; j < value2; j++)
						{
							ptr4++;
							*(ptr4++) = *(ptr3++);
						}
					}
				}
			}
			bufferIndex += value2;
			return text;
		}
		int num = value2 * 2;
		fixed (byte* ptr5 = buffer)
		{
			fixed (char* ptr6 = text)
			{
				if (BitConverter.IsLittleEndian)
				{
					Struct256Bit* ptr7 = (Struct256Bit*)(ptr5 + bufferIndex);
					Struct256Bit* ptr8 = (Struct256Bit*)ptr6;
					byte* ptr9 = (byte*)ptr6 + num;
					while (ptr8 + 1 < ptr9)
					{
						*(ptr8++) = *(ptr7++);
					}
					byte* ptr10 = (byte*)ptr7;
					byte* ptr11 = (byte*)ptr8;
					while (ptr11 < ptr9)
					{
						*(ptr11++) = *(ptr10++);
					}
				}
				else
				{
					byte* ptr12 = ptr5 + bufferIndex;
					byte* ptr13 = (byte*)ptr6;
					for (int k = 0; k < value2; k++)
					{
						*ptr13 = ptr12[1];
						ptr13[1] = *ptr12;
						ptr12 += 2;
						ptr13 += 2;
					}
				}
			}
		}
		bufferIndex += num;
		return text;
	}

	[MethodImpl((MethodImplOptions)256)]
	private void SkipStringValue()
	{
		if (UNSAFE_Read_1_Byte(out var value) && UNSAFE_Read_4_Int32(out var value2))
		{
			if (value != 0)
			{
				value2 *= 2;
			}
			if (HasBufferData(value2))
			{
				bufferIndex += value2;
			}
			else
			{
				bufferIndex = bufferEnd;
			}
		}
	}

	private void SkipPeekedEntryContent()
	{
		if (!peekedEntryType.HasValue)
		{
			return;
		}
		try
		{
			switch (peekedBinaryEntryType)
			{
			case BinaryEntryType.NamedStartOfReferenceNode:
			case BinaryEntryType.UnnamedStartOfReferenceNode:
				ReadTypeEntry();
				if (SkipBuffer(4))
				{
				}
				break;
			case BinaryEntryType.NamedStartOfStructNode:
			case BinaryEntryType.UnnamedStartOfStructNode:
				ReadTypeEntry();
				break;
			case BinaryEntryType.StartOfArray:
				SkipBuffer(8);
				break;
			case BinaryEntryType.PrimitiveArray:
			{
				if (UNSAFE_Read_4_Int32(out var value) && UNSAFE_Read_4_Int32(out var value2))
				{
					SkipBuffer(value * value2);
				}
				break;
			}
			case BinaryEntryType.NamedSByte:
			case BinaryEntryType.UnnamedSByte:
			case BinaryEntryType.NamedByte:
			case BinaryEntryType.UnnamedByte:
			case BinaryEntryType.NamedBoolean:
			case BinaryEntryType.UnnamedBoolean:
				SkipBuffer(1);
				break;
			case BinaryEntryType.NamedShort:
			case BinaryEntryType.UnnamedShort:
			case BinaryEntryType.NamedUShort:
			case BinaryEntryType.UnnamedUShort:
			case BinaryEntryType.NamedChar:
			case BinaryEntryType.UnnamedChar:
				SkipBuffer(2);
				break;
			case BinaryEntryType.NamedInternalReference:
			case BinaryEntryType.UnnamedInternalReference:
			case BinaryEntryType.NamedExternalReferenceByIndex:
			case BinaryEntryType.UnnamedExternalReferenceByIndex:
			case BinaryEntryType.NamedInt:
			case BinaryEntryType.UnnamedInt:
			case BinaryEntryType.NamedUInt:
			case BinaryEntryType.UnnamedUInt:
			case BinaryEntryType.NamedFloat:
			case BinaryEntryType.UnnamedFloat:
				SkipBuffer(4);
				break;
			case BinaryEntryType.NamedLong:
			case BinaryEntryType.UnnamedLong:
			case BinaryEntryType.NamedULong:
			case BinaryEntryType.UnnamedULong:
			case BinaryEntryType.NamedDouble:
			case BinaryEntryType.UnnamedDouble:
				SkipBuffer(8);
				break;
			case BinaryEntryType.NamedExternalReferenceByGuid:
			case BinaryEntryType.UnnamedExternalReferenceByGuid:
			case BinaryEntryType.NamedDecimal:
			case BinaryEntryType.UnnamedDecimal:
			case BinaryEntryType.NamedGuid:
			case BinaryEntryType.UnnamedGuid:
				SkipBuffer(8);
				break;
			case BinaryEntryType.NamedString:
			case BinaryEntryType.UnnamedString:
			case BinaryEntryType.NamedExternalReferenceByString:
			case BinaryEntryType.UnnamedExternalReferenceByString:
				SkipStringValue();
				break;
			case BinaryEntryType.TypeName:
				Context.Config.DebugContext.LogError("Parsing error in binary data reader: should not be able to peek a TypeName entry.");
				SkipBuffer(4);
				ReadStringValue();
				break;
			case BinaryEntryType.TypeID:
				Context.Config.DebugContext.LogError("Parsing error in binary data reader: should not be able to peek a TypeID entry.");
				SkipBuffer(4);
				break;
			case BinaryEntryType.Invalid:
			case BinaryEntryType.EndOfNode:
			case BinaryEntryType.EndOfArray:
			case BinaryEntryType.NamedNull:
			case BinaryEntryType.UnnamedNull:
			case BinaryEntryType.EndOfStream:
				break;
			}
		}
		finally
		{
			MarkEntryContentConsumed();
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	private bool SkipBuffer(int amount)
	{
		int num = bufferIndex + amount;
		if (num > bufferEnd)
		{
			bufferIndex = bufferEnd;
			return false;
		}
		bufferIndex = num;
		return true;
	}

	[MethodImpl((MethodImplOptions)256)]
	private Type ReadTypeEntry()
	{
		if (!HasBufferData(1))
		{
			return null;
		}
		BinaryEntryType binaryEntryType = (BinaryEntryType)buffer[bufferIndex++];
		int value2;
		Type value;
		switch (binaryEntryType)
		{
		case BinaryEntryType.TypeID:
			if (!UNSAFE_Read_4_Int32(out value2))
			{
				return null;
			}
			if (!types.TryGetValue(value2, out value))
			{
				Context.Config.DebugContext.LogError("Missing type ID during deserialization: " + value2 + " at node " + CurrentNodeName + " and depth " + CurrentNodeDepth + " and id " + CurrentNodeId);
			}
			break;
		case BinaryEntryType.TypeName:
		{
			if (!UNSAFE_Read_4_Int32(out value2))
			{
				return null;
			}
			string text = ReadStringValue();
			value = ((text == null) ? null : Context.Binder.BindToType(text, Context.Config.DebugContext));
			types.Add(value2, value);
			break;
		}
		case BinaryEntryType.UnnamedNull:
			value = null;
			break;
		default:
			value = null;
			Context.Config.DebugContext.LogError("Expected TypeName, TypeID or UnnamedNull entry flag for reading type data, but instead got the entry flag: " + binaryEntryType.ToString() + ".");
			break;
		}
		return value;
	}

	[MethodImpl((MethodImplOptions)256)]
	private void MarkEntryContentConsumed()
	{
		peekedEntryType = null;
		peekedEntryName = null;
		peekedBinaryEntryType = BinaryEntryType.Invalid;
	}

	protected override EntryType PeekEntry()
	{
		string name;
		return PeekEntry(out name);
	}

	protected override EntryType ReadToNextEntry()
	{
		SkipPeekedEntryContent();
		string name;
		return PeekEntry(out name);
	}

	[MethodImpl((MethodImplOptions)256)]
	private bool UNSAFE_Read_1_Byte(out byte value)
	{
		if (HasBufferData(1))
		{
			value = buffer[bufferIndex++];
			return true;
		}
		value = 0;
		return false;
	}

	[MethodImpl((MethodImplOptions)256)]
	private bool UNSAFE_Read_1_SByte(out sbyte value)
	{
		if (HasBufferData(1))
		{
			value = (sbyte)buffer[bufferIndex++];
			return true;
		}
		value = 0;
		return false;
	}

	[MethodImpl((MethodImplOptions)256)]
	private unsafe bool UNSAFE_Read_2_Int16(out short value)
	{
		if (HasBufferData(2))
		{
			fixed (byte* ptr = buffer)
			{
				if (BitConverter.IsLittleEndian)
				{
					value = *(short*)(ptr + bufferIndex);
				}
				else
				{
					short num = 0;
					byte* ptr2 = (byte*)(&num) + 1;
					byte* ptr3 = ptr + bufferIndex;
					*(ptr2--) = *(ptr3++);
					*ptr2 = *ptr3;
					value = num;
				}
			}
			bufferIndex += 2;
			return true;
		}
		bufferIndex = bufferEnd;
		value = 0;
		return false;
	}

	[MethodImpl((MethodImplOptions)256)]
	private unsafe bool UNSAFE_Read_2_UInt16(out ushort value)
	{
		if (HasBufferData(2))
		{
			fixed (byte* ptr = buffer)
			{
				if (BitConverter.IsLittleEndian)
				{
					value = *(ushort*)(ptr + bufferIndex);
				}
				else
				{
					ushort num = 0;
					byte* ptr2 = (byte*)(&num) + 1;
					byte* ptr3 = ptr + bufferIndex;
					*(ptr2--) = *(ptr3++);
					*ptr2 = *ptr3;
					value = num;
				}
			}
			bufferIndex += 2;
			return true;
		}
		bufferIndex = bufferEnd;
		value = 0;
		return false;
	}

	[MethodImpl((MethodImplOptions)256)]
	private unsafe bool UNSAFE_Read_2_Char(out char value)
	{
		if (HasBufferData(2))
		{
			fixed (byte* ptr = buffer)
			{
				if (BitConverter.IsLittleEndian)
				{
					value = *(char*)(ptr + bufferIndex);
				}
				else
				{
					char c = '\0';
					byte* ptr2 = (byte*)(&c) + 1;
					byte* ptr3 = ptr + bufferIndex;
					*(ptr2--) = *(ptr3++);
					*ptr2 = *ptr3;
					value = c;
				}
			}
			bufferIndex += 2;
			return true;
		}
		bufferIndex = bufferEnd;
		value = '\0';
		return false;
	}

	[MethodImpl((MethodImplOptions)256)]
	private unsafe bool UNSAFE_Read_4_Int32(out int value)
	{
		if (HasBufferData(4))
		{
			fixed (byte* ptr = buffer)
			{
				if (BitConverter.IsLittleEndian)
				{
					value = *(int*)(ptr + bufferIndex);
				}
				else
				{
					int num = 0;
					byte* ptr2 = (byte*)(&num) + 3;
					byte* ptr3 = ptr + bufferIndex;
					*(ptr2--) = *(ptr3++);
					*(ptr2--) = *(ptr3++);
					*(ptr2--) = *(ptr3++);
					*ptr2 = *ptr3;
					value = num;
				}
			}
			bufferIndex += 4;
			return true;
		}
		bufferIndex = bufferEnd;
		value = 0;
		return false;
	}

	[MethodImpl((MethodImplOptions)256)]
	private unsafe bool UNSAFE_Read_4_UInt32(out uint value)
	{
		if (HasBufferData(4))
		{
			fixed (byte* ptr = buffer)
			{
				if (BitConverter.IsLittleEndian)
				{
					value = *(uint*)(ptr + bufferIndex);
				}
				else
				{
					uint num = 0u;
					byte* ptr2 = (byte*)(&num) + 3;
					byte* ptr3 = ptr + bufferIndex;
					*(ptr2--) = *(ptr3++);
					*(ptr2--) = *(ptr3++);
					*(ptr2--) = *(ptr3++);
					*ptr2 = *ptr3;
					value = num;
				}
			}
			bufferIndex += 4;
			return true;
		}
		bufferIndex = bufferEnd;
		value = 0u;
		return false;
	}

	[MethodImpl((MethodImplOptions)256)]
	private unsafe bool UNSAFE_Read_4_Float32(out float value)
	{
		if (HasBufferData(4))
		{
			fixed (byte* ptr = buffer)
			{
				if (BitConverter.IsLittleEndian)
				{
					if (ArchitectureInfo.Architecture_Supports_Unaligned_Float32_Reads)
					{
						value = *(float*)(ptr + bufferIndex);
					}
					else
					{
						float num = 0f;
						*(int*)(&num) = *(int*)(ptr + bufferIndex);
						value = num;
					}
				}
				else
				{
					float num2 = 0f;
					byte* ptr2 = (byte*)(&num2) + 3;
					byte* ptr3 = ptr + bufferIndex;
					*(ptr2--) = *(ptr3++);
					*(ptr2--) = *(ptr3++);
					*(ptr2--) = *(ptr3++);
					*ptr2 = *ptr3;
					value = num2;
				}
			}
			bufferIndex += 4;
			return true;
		}
		bufferIndex = bufferEnd;
		value = 0f;
		return false;
	}

	[MethodImpl((MethodImplOptions)256)]
	private unsafe bool UNSAFE_Read_8_Int64(out long value)
	{
		if (HasBufferData(8))
		{
			fixed (byte* ptr = buffer)
			{
				if (BitConverter.IsLittleEndian)
				{
					if (ArchitectureInfo.Architecture_Supports_All_Unaligned_ReadWrites)
					{
						value = *(long*)(ptr + bufferIndex);
					}
					else
					{
						long num = 0L;
						int* ptr2 = (int*)(&num);
						int* ptr3 = (int*)(ptr + bufferIndex);
						*(ptr2++) = *(ptr3++);
						*ptr2 = *ptr3;
						value = num;
					}
				}
				else
				{
					long num2 = 0L;
					byte* ptr4 = (byte*)(&num2) + 7;
					byte* ptr5 = ptr + bufferIndex;
					*(ptr4--) = *(ptr5++);
					*(ptr4--) = *(ptr5++);
					*(ptr4--) = *(ptr5++);
					*(ptr4--) = *(ptr5++);
					*(ptr4--) = *(ptr5++);
					*(ptr4--) = *(ptr5++);
					*(ptr4--) = *(ptr5++);
					*ptr4 = *ptr5;
					value = num2;
				}
			}
			bufferIndex += 8;
			return true;
		}
		bufferIndex = bufferEnd;
		value = 0L;
		return false;
	}

	[MethodImpl((MethodImplOptions)256)]
	private unsafe bool UNSAFE_Read_8_UInt64(out ulong value)
	{
		if (HasBufferData(8))
		{
			fixed (byte* ptr = buffer)
			{
				if (BitConverter.IsLittleEndian)
				{
					if (ArchitectureInfo.Architecture_Supports_All_Unaligned_ReadWrites)
					{
						value = *(ulong*)(ptr + bufferIndex);
					}
					else
					{
						ulong num = 0uL;
						int* ptr2 = (int*)(&num);
						int* ptr3 = (int*)(ptr + bufferIndex);
						*(ptr2++) = *(ptr3++);
						*ptr2 = *ptr3;
						value = num;
					}
				}
				else
				{
					ulong num2 = 0uL;
					byte* ptr4 = (byte*)(&num2) + 7;
					byte* ptr5 = ptr + bufferIndex;
					*(ptr4--) = *(ptr5++);
					*(ptr4--) = *(ptr5++);
					*(ptr4--) = *(ptr5++);
					*(ptr4--) = *(ptr5++);
					*(ptr4--) = *(ptr5++);
					*(ptr4--) = *(ptr5++);
					*(ptr4--) = *(ptr5++);
					*ptr4 = *ptr5;
					value = num2;
				}
			}
			bufferIndex += 8;
			return true;
		}
		bufferIndex = bufferEnd;
		value = 0uL;
		return false;
	}

	[MethodImpl((MethodImplOptions)256)]
	private unsafe bool UNSAFE_Read_8_Float64(out double value)
	{
		if (HasBufferData(8))
		{
			fixed (byte* ptr = buffer)
			{
				if (BitConverter.IsLittleEndian)
				{
					if (ArchitectureInfo.Architecture_Supports_All_Unaligned_ReadWrites)
					{
						value = *(double*)(ptr + bufferIndex);
					}
					else
					{
						double num = 0.0;
						int* ptr2 = (int*)(&num);
						int* ptr3 = (int*)(ptr + bufferIndex);
						*(ptr2++) = *(ptr3++);
						*ptr2 = *ptr3;
						value = num;
					}
				}
				else
				{
					double num2 = 0.0;
					byte* ptr4 = (byte*)(&num2) + 7;
					byte* ptr5 = ptr + bufferIndex;
					*(ptr4--) = *(ptr5++);
					*(ptr4--) = *(ptr5++);
					*(ptr4--) = *(ptr5++);
					*(ptr4--) = *(ptr5++);
					*(ptr4--) = *(ptr5++);
					*(ptr4--) = *(ptr5++);
					*(ptr4--) = *(ptr5++);
					*ptr4 = *ptr5;
					value = num2;
				}
			}
			bufferIndex += 8;
			return true;
		}
		bufferIndex = bufferEnd;
		value = 0.0;
		return false;
	}

	[MethodImpl((MethodImplOptions)256)]
	private unsafe bool UNSAFE_Read_16_Decimal(out decimal value)
	{
		if (HasBufferData(16))
		{
			fixed (byte* ptr = buffer)
			{
				if (BitConverter.IsLittleEndian)
				{
					if (ArchitectureInfo.Architecture_Supports_All_Unaligned_ReadWrites)
					{
						value = *(decimal*)(ptr + bufferIndex);
					}
					else
					{
						decimal num = 0m;
						int* ptr2 = (int*)(&num);
						int* ptr3 = (int*)(ptr + bufferIndex);
						*(ptr2++) = *(ptr3++);
						*(ptr2++) = *(ptr3++);
						*(ptr2++) = *(ptr3++);
						*ptr2 = *ptr3;
						value = num;
					}
				}
				else
				{
					decimal num2 = 0m;
					byte* ptr4 = (byte*)(&num2) + 15;
					byte* ptr5 = ptr + bufferIndex;
					*(ptr4--) = *(ptr5++);
					*(ptr4--) = *(ptr5++);
					*(ptr4--) = *(ptr5++);
					*(ptr4--) = *(ptr5++);
					*(ptr4--) = *(ptr5++);
					*(ptr4--) = *(ptr5++);
					*(ptr4--) = *(ptr5++);
					*(ptr4--) = *(ptr5++);
					*(ptr4--) = *(ptr5++);
					*(ptr4--) = *(ptr5++);
					*(ptr4--) = *(ptr5++);
					*(ptr4--) = *(ptr5++);
					*(ptr4--) = *(ptr5++);
					*(ptr4--) = *(ptr5++);
					*(ptr4--) = *(ptr5++);
					*ptr4 = *ptr5;
					value = num2;
				}
			}
			bufferIndex += 16;
			return true;
		}
		bufferIndex = bufferEnd;
		value = 0m;
		return false;
	}

	[MethodImpl((MethodImplOptions)256)]
	private unsafe bool UNSAFE_Read_16_Guid(out Guid value)
	{
		if (HasBufferData(16))
		{
			fixed (byte* ptr = buffer)
			{
				if (BitConverter.IsLittleEndian)
				{
					if (ArchitectureInfo.Architecture_Supports_All_Unaligned_ReadWrites)
					{
						value = *(Guid*)(ptr + bufferIndex);
					}
					else
					{
						Guid guid = default;
						int* ptr2 = (int*)(&guid);
						int* ptr3 = (int*)(ptr + bufferIndex);
						*(ptr2++) = *(ptr3++);
						*(ptr2++) = *(ptr3++);
						*(ptr2++) = *(ptr3++);
						*ptr2 = *ptr3;
						value = guid;
					}
				}
				else
				{
					Guid guid2 = default;
					byte* ptr4 = (byte*)(&guid2);
					byte* ptr5 = ptr + bufferIndex;
					*(ptr4++) = *(ptr5++);
					*(ptr4++) = *(ptr5++);
					*(ptr4++) = *(ptr5++);
					*(ptr4++) = *(ptr5++);
					*(ptr4++) = *(ptr5++);
					*(ptr4++) = *(ptr5++);
					*(ptr4++) = *(ptr5++);
					*(ptr4++) = *(ptr5++);
					*(ptr4++) = *(ptr5++);
					*ptr4 = *(ptr5++);
					ptr4 += 6;
					*(ptr4--) = *(ptr5++);
					*(ptr4--) = *(ptr5++);
					*(ptr4--) = *(ptr5++);
					*(ptr4--) = *(ptr5++);
					*(ptr4--) = *(ptr5++);
					*ptr4 = *ptr5;
					value = guid2;
				}
			}
			bufferIndex += 16;
			return true;
		}
		bufferIndex = bufferEnd;
		value = default;
		return false;
	}

	[MethodImpl((MethodImplOptions)256)]
	private bool HasBufferData(int amount)
	{
		if (bufferEnd == 0)
		{
			ReadEntireStreamToBuffer();
		}
		return bufferIndex + amount <= bufferEnd;
	}

	private void ReadEntireStreamToBuffer()
	{
		bufferIndex = 0;
		if (Stream is MemoryStream)
		{
			try
			{
				buffer = (Stream as MemoryStream).GetBuffer();
				bufferEnd = (int)Stream.Length;
				bufferIndex = (int)Stream.Position;
				return;
			}
			catch (UnauthorizedAccessException)
			{
			}
		}
		buffer = internalBufferBackup;
		int num = (int)(Stream.Length - Stream.Position);
		if (buffer.Length >= num)
		{
			Stream.Read(buffer, 0, num);
		}
		else
		{
			buffer = new byte[num];
			Stream.Read(buffer, 0, num);
			if (num <= 10485760)
			{
				internalBufferBackup = buffer;
			}
		}
		bufferIndex = 0;
		bufferEnd = num;
	}
}
