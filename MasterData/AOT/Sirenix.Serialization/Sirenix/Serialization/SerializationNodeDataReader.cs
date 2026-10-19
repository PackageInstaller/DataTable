using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Text;

namespace Sirenix.Serialization;

public class SerializationNodeDataReader : BaseDataReader
{
	private string peekedEntryName;

	private EntryType? peekedEntryType;

	private string peekedEntryData;

	private int currentIndex = -1;

	private List<SerializationNode> nodes;

	private Dictionary<Type, Delegate> primitiveTypeReaders;

	private bool IndexIsValid
	{
		get
		{
			if (nodes != null && currentIndex >= 0)
			{
				return currentIndex < nodes.Count;
			}
			return false;
		}
	}

	public List<SerializationNode> Nodes
	{
		get
		{
			if (nodes == null)
			{
				nodes = new List<SerializationNode>();
			}
			return nodes;
		}
		set
		{
			if (value == null)
			{
				throw new ArgumentNullException();
			}
			nodes = value;
		}
	}

	public override Stream Stream
	{
		get
		{
			throw new NotSupportedException("This data reader has no stream.");
		}
		set
		{
			throw new NotSupportedException("This data reader has no stream.");
		}
	}

	public SerializationNodeDataReader(DeserializationContext context)
		: base(null, context)
	{
		primitiveTypeReaders = new Dictionary<Type, Delegate>
		{
			{
				typeof(char),
				(Func<char>)(() =>
				{
					ReadChar(out var value);
					return value;
				})
			},
			{
				typeof(sbyte),
				(Func<sbyte>)(() =>
				{
					ReadSByte(out var value);
					return value;
				})
			},
			{
				typeof(short),
				(Func<short>)(() =>
				{
					ReadInt16(out var value);
					return value;
				})
			},
			{
				typeof(int),
				(Func<int>)(() =>
				{
					ReadInt32(out var value);
					return value;
				})
			},
			{
				typeof(long),
				(Func<long>)(() =>
				{
					ReadInt64(out var value);
					return value;
				})
			},
			{
				typeof(byte),
				(Func<byte>)(() =>
				{
					ReadByte(out var value);
					return value;
				})
			},
			{
				typeof(ushort),
				(Func<ushort>)(() =>
				{
					ReadUInt16(out var value);
					return value;
				})
			},
			{
				typeof(uint),
				(Func<uint>)(() =>
				{
					ReadUInt32(out var value);
					return value;
				})
			},
			{
				typeof(ulong),
				(Func<ulong>)(() =>
				{
					ReadUInt64(out var value);
					return value;
				})
			},
			{
				typeof(decimal),
				(Func<decimal>)(() =>
				{
					ReadDecimal(out var value);
					return value;
				})
			},
			{
				typeof(bool),
				(Func<bool>)(() =>
				{
					ReadBoolean(out var value);
					return value;
				})
			},
			{
				typeof(float),
				(Func<float>)(() =>
				{
					ReadSingle(out var value);
					return value;
				})
			},
			{
				typeof(double),
				(Func<double>)(() =>
				{
					ReadDouble(out var value);
					return value;
				})
			},
			{
				typeof(Guid),
				(Func<Guid>)(() =>
				{
					ReadGuid(out var value);
					return value;
				})
			}
		};
	}

	public override void Dispose()
	{
		nodes = null;
		currentIndex = -1;
	}

	public override void PrepareNewSerializationSession()
	{
		base.PrepareNewSerializationSession();
		currentIndex = -1;
	}

	public override EntryType PeekEntry(out string name)
	{
		if (peekedEntryType.HasValue)
		{
			name = peekedEntryName;
			return peekedEntryType.Value;
		}
		currentIndex++;
		if (IndexIsValid)
		{
			SerializationNode serializationNode = nodes[currentIndex];
			peekedEntryName = serializationNode.Name;
			peekedEntryType = serializationNode.Entry;
			peekedEntryData = serializationNode.Data;
		}
		else
		{
			peekedEntryName = null;
			peekedEntryType = EntryType.EndOfStream;
			peekedEntryData = null;
		}
		name = peekedEntryName;
		return peekedEntryType.Value;
	}

	public override bool EnterArray(out long length)
	{
		PeekEntry();
		if (peekedEntryType == EntryType.StartOfArray)
		{
			PushArray();
			if (!long.TryParse(peekedEntryData, NumberStyles.Any, CultureInfo.InvariantCulture, out length))
			{
				length = 0L;
				Context.Config.DebugContext.LogError("Failed to parse array length from data '" + peekedEntryData + "'.");
			}
			ConsumeCurrentEntry();
			return true;
		}
		SkipEntry();
		length = 0L;
		return false;
	}

	public override bool EnterNode(out Type type)
	{
		PeekEntry();
		if (peekedEntryType == EntryType.StartOfNode)
		{
			string text = peekedEntryData;
			int id = -1;
			type = null;
			if (!string.IsNullOrEmpty(text))
			{
				string text2 = null;
				int num = text.IndexOf("|", StringComparison.InvariantCulture);
				int result;
				if (num >= 0)
				{
					text2 = text.Substring(num + 1);
					string text3 = text.Substring(0, num);
					if (int.TryParse(text3, NumberStyles.Any, CultureInfo.InvariantCulture, out result))
					{
						id = result;
					}
					else
					{
						Context.Config.DebugContext.LogError("Failed to parse id string '" + text3 + "' from data '" + text + "'.");
					}
				}
				else if (int.TryParse(text, out result))
				{
					id = result;
				}
				else
				{
					text2 = text;
				}
				if (text2 != null)
				{
					type = Context.Binder.BindToType(text2, Context.Config.DebugContext);
				}
			}
			ConsumeCurrentEntry();
			PushNode(peekedEntryName, id, type);
			return true;
		}
		SkipEntry();
		type = null;
		return false;
	}

	public override bool ExitArray()
	{
		PeekEntry();
		while (peekedEntryType != EntryType.EndOfArray && peekedEntryType != EntryType.EndOfStream)
		{
			if (peekedEntryType == EntryType.EndOfNode)
			{
				Context.Config.DebugContext.LogError("Data layout mismatch; skipping past node boundary when exiting array.");
				ConsumeCurrentEntry();
			}
			SkipEntry();
		}
		if (peekedEntryType == EntryType.EndOfArray)
		{
			ConsumeCurrentEntry();
			PopArray();
			return true;
		}
		return false;
	}

	public override bool ExitNode()
	{
		PeekEntry();
		while (peekedEntryType != EntryType.EndOfNode && peekedEntryType != EntryType.EndOfStream)
		{
			if (peekedEntryType == EntryType.EndOfArray)
			{
				Context.Config.DebugContext.LogError("Data layout mismatch; skipping past array boundary when exiting node.");
				ConsumeCurrentEntry();
			}
			SkipEntry();
		}
		if (peekedEntryType == EntryType.EndOfNode)
		{
			ConsumeCurrentEntry();
			PopNode(CurrentNodeName);
			return true;
		}
		return false;
	}

	public override bool ReadBoolean(out bool value)
	{
		PeekEntry();
		try
		{
			if (peekedEntryType == EntryType.Boolean)
			{
				value = peekedEntryData == "true";
				return true;
			}
			value = false;
			return false;
		}
		finally
		{
			ConsumeCurrentEntry();
		}
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

	public override bool ReadChar(out char value)
	{
		PeekEntry();
		if (peekedEntryType == EntryType.String)
		{
			try
			{
				if (peekedEntryData.Length == 1)
				{
					value = peekedEntryData[0];
					return true;
				}
				Context.Config.DebugContext.LogWarning("Expected string of length 1 for char entry.");
				value = '\0';
				return false;
			}
			finally
			{
				ConsumeCurrentEntry();
			}
		}
		SkipEntry();
		value = '\0';
		return false;
	}

	public override bool ReadDecimal(out decimal value)
	{
		PeekEntry();
		if (peekedEntryType == EntryType.FloatingPoint || peekedEntryType == EntryType.Integer)
		{
			try
			{
				if (!decimal.TryParse(peekedEntryData, NumberStyles.Any, CultureInfo.InvariantCulture, out value))
				{
					Context.Config.DebugContext.LogError("Failed to parse decimal value from entry data '" + peekedEntryData + "'.");
					return false;
				}
				return true;
			}
			finally
			{
				ConsumeCurrentEntry();
			}
		}
		SkipEntry();
		value = 0m;
		return false;
	}

	public override bool ReadDouble(out double value)
	{
		PeekEntry();
		if (peekedEntryType == EntryType.FloatingPoint || peekedEntryType == EntryType.Integer)
		{
			try
			{
				if (!double.TryParse(peekedEntryData, NumberStyles.Any, CultureInfo.InvariantCulture, out value))
				{
					Context.Config.DebugContext.LogError("Failed to parse double value from entry data '" + peekedEntryData + "'.");
					return false;
				}
				return true;
			}
			finally
			{
				ConsumeCurrentEntry();
			}
		}
		SkipEntry();
		value = 0.0;
		return false;
	}

	public override bool ReadExternalReference(out Guid guid)
	{
		PeekEntry();
		if (peekedEntryType == EntryType.ExternalReferenceByGuid)
		{
			try
			{
				if ((guid = new Guid(peekedEntryData)) != Guid.Empty)
				{
					return true;
				}
				guid = Guid.Empty;
				return false;
			}
			catch (FormatException)
			{
				guid = Guid.Empty;
				return false;
			}
			catch (OverflowException)
			{
				guid = Guid.Empty;
				return false;
			}
			finally
			{
				ConsumeCurrentEntry();
			}
		}
		SkipEntry();
		guid = Guid.Empty;
		return false;
	}

	public override bool ReadExternalReference(out string id)
	{
		PeekEntry();
		if (peekedEntryType == EntryType.ExternalReferenceByString)
		{
			id = peekedEntryData;
			ConsumeCurrentEntry();
			return true;
		}
		SkipEntry();
		id = null;
		return false;
	}

	public override bool ReadExternalReference(out int index)
	{
		PeekEntry();
		if (peekedEntryType == EntryType.ExternalReferenceByIndex)
		{
			try
			{
				if (!int.TryParse(peekedEntryData, NumberStyles.Any, CultureInfo.InvariantCulture, out index))
				{
					Context.Config.DebugContext.LogError("Failed to parse external index reference integer value from entry data '" + peekedEntryData + "'.");
					return false;
				}
				return true;
			}
			finally
			{
				ConsumeCurrentEntry();
			}
		}
		SkipEntry();
		index = 0;
		return false;
	}

	public override bool ReadGuid(out Guid value)
	{
		PeekEntry();
		if (peekedEntryType == EntryType.Guid)
		{
			try
			{
				if ((value = new Guid(peekedEntryData)) != Guid.Empty)
				{
					return true;
				}
				value = Guid.Empty;
				return false;
			}
			catch (FormatException)
			{
				value = Guid.Empty;
				return false;
			}
			catch (OverflowException)
			{
				value = Guid.Empty;
				return false;
			}
			finally
			{
				ConsumeCurrentEntry();
			}
		}
		SkipEntry();
		value = Guid.Empty;
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

	public override bool ReadInt64(out long value)
	{
		PeekEntry();
		if (peekedEntryType == EntryType.Integer)
		{
			try
			{
				if (!long.TryParse(peekedEntryData, NumberStyles.Any, CultureInfo.InvariantCulture, out value))
				{
					Context.Config.DebugContext.LogError("Failed to parse integer value from entry data '" + peekedEntryData + "'.");
					return false;
				}
				return true;
			}
			finally
			{
				ConsumeCurrentEntry();
			}
		}
		SkipEntry();
		value = 0L;
		return false;
	}

	public override bool ReadInternalReference(out int id)
	{
		PeekEntry();
		if (peekedEntryType == EntryType.InternalReference)
		{
			try
			{
				if (!int.TryParse(peekedEntryData, NumberStyles.Any, CultureInfo.InvariantCulture, out id))
				{
					Context.Config.DebugContext.LogError("Failed to parse internal reference id integer value from entry data '" + peekedEntryData + "'.");
					return false;
				}
				return true;
			}
			finally
			{
				ConsumeCurrentEntry();
			}
		}
		SkipEntry();
		id = 0;
		return false;
	}

	public override bool ReadNull()
	{
		PeekEntry();
		if (peekedEntryType == EntryType.Null)
		{
			ConsumeCurrentEntry();
			return true;
		}
		SkipEntry();
		return false;
	}

	public override bool ReadPrimitiveArray<T>(out T[] array)
	{
		if (!FormatterUtilities.IsPrimitiveArrayType(typeof(T)))
		{
			throw new ArgumentException("Type " + typeof(T).Name + " is not a valid primitive array type.");
		}
		if (peekedEntryType != EntryType.PrimitiveArray)
		{
			SkipEntry();
			array = null;
			return false;
		}
		if (typeof(T) == typeof(byte))
		{
			array = (T[])(object)ProperBitConverter.HexStringToBytes(peekedEntryData);
			return true;
		}
		PeekEntry();
		if (peekedEntryType != EntryType.PrimitiveArray)
		{
			DebugContext debugContext = Context.Config.DebugContext;
			string[] array2 = new string[5]
			{
				"Expected entry of type '",
				EntryType.StartOfArray.ToString(),
				"' when reading primitive array but got entry of type '",
				null,
				null
			};
			EntryType? entryType = peekedEntryType;
			array2[3] = entryType.ToString();
			array2[4] = "'.";
			debugContext.LogError(string.Concat(array2));
			SkipEntry();
			array = new T[0];
			return false;
		}
		if (!long.TryParse(peekedEntryData, NumberStyles.Any, CultureInfo.InvariantCulture, out var result))
		{
			Context.Config.DebugContext.LogError("Failed to parse primitive array length from entry data '" + peekedEntryData + "'.");
			SkipEntry();
			array = new T[0];
			return false;
		}
		ConsumeCurrentEntry();
		PushArray();
		array = new T[result];
		Func<T> func = (Func<T>)primitiveTypeReaders[typeof(T)];
		for (int i = 0; i < result; i++)
		{
			array[i] = func();
		}
		ExitArray();
		return true;
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

	public override bool ReadSingle(out float value)
	{
		PeekEntry();
		if (peekedEntryType == EntryType.FloatingPoint || peekedEntryType == EntryType.Integer)
		{
			try
			{
				if (!float.TryParse(peekedEntryData, NumberStyles.Any, CultureInfo.InvariantCulture, out value))
				{
					Context.Config.DebugContext.LogError("Failed to parse float value from entry data '" + peekedEntryData + "'.");
					return false;
				}
				return true;
			}
			finally
			{
				ConsumeCurrentEntry();
			}
		}
		SkipEntry();
		value = 0f;
		return false;
	}

	public override bool ReadString(out string value)
	{
		PeekEntry();
		if (peekedEntryType == EntryType.String)
		{
			value = peekedEntryData;
			ConsumeCurrentEntry();
			return true;
		}
		SkipEntry();
		value = null;
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

	public override bool ReadUInt64(out ulong value)
	{
		PeekEntry();
		if (peekedEntryType == EntryType.Integer)
		{
			try
			{
				if (!ulong.TryParse(peekedEntryData, NumberStyles.Any, CultureInfo.InvariantCulture, out value))
				{
					Context.Config.DebugContext.LogError("Failed to parse integer value from entry data '" + peekedEntryData + "'.");
					return false;
				}
				return true;
			}
			finally
			{
				ConsumeCurrentEntry();
			}
		}
		SkipEntry();
		value = 0uL;
		return false;
	}

	public override string GetDataDump()
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append("Nodes: \n\n");
		for (int i = 0; i < nodes.Count; i++)
		{
			SerializationNode serializationNode = nodes[i];
			stringBuilder.Append("    - Name: " + serializationNode.Name);
			if (i == currentIndex)
			{
				stringBuilder.AppendLine("    <<<< READ POSITION");
			}
			else
			{
				stringBuilder.AppendLine();
			}
			int entry = (int)serializationNode.Entry;
			stringBuilder.AppendLine("      Entry: " + entry);
			stringBuilder.AppendLine("      Data: " + serializationNode.Data);
		}
		return stringBuilder.ToString();
	}

	private void ConsumeCurrentEntry()
	{
		if (peekedEntryType.HasValue && peekedEntryType != EntryType.EndOfStream)
		{
			peekedEntryType = null;
		}
	}

	protected override EntryType PeekEntry()
	{
		string name;
		return PeekEntry(out name);
	}

	protected override EntryType ReadToNextEntry()
	{
		ConsumeCurrentEntry();
		string name;
		return PeekEntry(out name);
	}
}
