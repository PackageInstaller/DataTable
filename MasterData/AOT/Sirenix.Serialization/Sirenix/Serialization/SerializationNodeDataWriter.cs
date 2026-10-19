using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Text;

namespace Sirenix.Serialization;

public class SerializationNodeDataWriter : BaseDataWriter
{
	private List<SerializationNode> nodes;

	private Dictionary<Type, Delegate> primitiveTypeWriters;

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
			throw new NotSupportedException("This data writer has no stream.");
		}
		set
		{
			throw new NotSupportedException("This data writer has no stream.");
		}
	}

	public SerializationNodeDataWriter(SerializationContext context)
		: base(null, context)
	{
		primitiveTypeWriters = new Dictionary<Type, Delegate>
		{
			{
				typeof(char),
				new Action<string, char>(WriteChar)
			},
			{
				typeof(sbyte),
				new Action<string, sbyte>(WriteSByte)
			},
			{
				typeof(short),
				new Action<string, short>(WriteInt16)
			},
			{
				typeof(int),
				new Action<string, int>(WriteInt32)
			},
			{
				typeof(long),
				new Action<string, long>(WriteInt64)
			},
			{
				typeof(byte),
				new Action<string, byte>(WriteByte)
			},
			{
				typeof(ushort),
				new Action<string, ushort>(WriteUInt16)
			},
			{
				typeof(uint),
				new Action<string, uint>(WriteUInt32)
			},
			{
				typeof(ulong),
				new Action<string, ulong>(WriteUInt64)
			},
			{
				typeof(decimal),
				new Action<string, decimal>(WriteDecimal)
			},
			{
				typeof(bool),
				new Action<string, bool>(WriteBoolean)
			},
			{
				typeof(float),
				new Action<string, float>(WriteSingle)
			},
			{
				typeof(double),
				new Action<string, double>(WriteDouble)
			},
			{
				typeof(Guid),
				new Action<string, Guid>(WriteGuid)
			}
		};
	}

	public override void BeginArrayNode(long length)
	{
		Nodes.Add(new SerializationNode
		{
			Name = string.Empty,
			Entry = EntryType.StartOfArray,
			Data = length.ToString(CultureInfo.InvariantCulture)
		});
		PushArray();
	}

	public override void BeginReferenceNode(string name, Type type, int id)
	{
		Nodes.Add(new SerializationNode
		{
			Name = name,
			Entry = EntryType.StartOfNode,
			Data = ((type != null) ? (id.ToString(CultureInfo.InvariantCulture) + "|" + Context.Binder.BindToName(type, Context.Config.DebugContext)) : id.ToString(CultureInfo.InvariantCulture))
		});
		PushNode(name, id, type);
	}

	public override void BeginStructNode(string name, Type type)
	{
		Nodes.Add(new SerializationNode
		{
			Name = name,
			Entry = EntryType.StartOfNode,
			Data = ((type != null) ? Context.Binder.BindToName(type, Context.Config.DebugContext) : "")
		});
		PushNode(name, -1, type);
	}

	public override void Dispose()
	{
		nodes = null;
	}

	public override void EndArrayNode()
	{
		PopArray();
		Nodes.Add(new SerializationNode
		{
			Name = string.Empty,
			Entry = EntryType.EndOfArray,
			Data = string.Empty
		});
	}

	public override void EndNode(string name)
	{
		PopNode(name);
		Nodes.Add(new SerializationNode
		{
			Name = string.Empty,
			Entry = EntryType.EndOfNode,
			Data = string.Empty
		});
	}

	public override void PrepareNewSerializationSession()
	{
		base.PrepareNewSerializationSession();
	}

	public override void WriteBoolean(string name, bool value)
	{
		Nodes.Add(new SerializationNode
		{
			Name = name,
			Entry = EntryType.Boolean,
			Data = (value ? "true" : "false")
		});
	}

	public override void WriteByte(string name, byte value)
	{
		Nodes.Add(new SerializationNode
		{
			Name = name,
			Entry = EntryType.Integer,
			Data = value.ToString("D", CultureInfo.InvariantCulture)
		});
	}

	public override void WriteChar(string name, char value)
	{
		Nodes.Add(new SerializationNode
		{
			Name = name,
			Entry = EntryType.String,
			Data = value.ToString(CultureInfo.InvariantCulture)
		});
	}

	public override void WriteDecimal(string name, decimal value)
	{
		Nodes.Add(new SerializationNode
		{
			Name = name,
			Entry = EntryType.FloatingPoint,
			Data = value.ToString("G", CultureInfo.InvariantCulture)
		});
	}

	public override void WriteSingle(string name, float value)
	{
		Nodes.Add(new SerializationNode
		{
			Name = name,
			Entry = EntryType.FloatingPoint,
			Data = value.ToString("R", CultureInfo.InvariantCulture)
		});
	}

	public override void WriteDouble(string name, double value)
	{
		Nodes.Add(new SerializationNode
		{
			Name = name,
			Entry = EntryType.FloatingPoint,
			Data = value.ToString("R", CultureInfo.InvariantCulture)
		});
	}

	public override void WriteExternalReference(string name, Guid guid)
	{
		Nodes.Add(new SerializationNode
		{
			Name = name,
			Entry = EntryType.ExternalReferenceByGuid,
			Data = guid.ToString("N", CultureInfo.InvariantCulture)
		});
	}

	public override void WriteExternalReference(string name, string id)
	{
		Nodes.Add(new SerializationNode
		{
			Name = name,
			Entry = EntryType.ExternalReferenceByString,
			Data = id
		});
	}

	public override void WriteExternalReference(string name, int index)
	{
		Nodes.Add(new SerializationNode
		{
			Name = name,
			Entry = EntryType.ExternalReferenceByIndex,
			Data = index.ToString("D", CultureInfo.InvariantCulture)
		});
	}

	public override void WriteGuid(string name, Guid value)
	{
		Nodes.Add(new SerializationNode
		{
			Name = name,
			Entry = EntryType.Guid,
			Data = value.ToString("N", CultureInfo.InvariantCulture)
		});
	}

	public override void WriteInt16(string name, short value)
	{
		Nodes.Add(new SerializationNode
		{
			Name = name,
			Entry = EntryType.Integer,
			Data = value.ToString("D", CultureInfo.InvariantCulture)
		});
	}

	public override void WriteInt32(string name, int value)
	{
		Nodes.Add(new SerializationNode
		{
			Name = name,
			Entry = EntryType.Integer,
			Data = value.ToString("D", CultureInfo.InvariantCulture)
		});
	}

	public override void WriteInt64(string name, long value)
	{
		Nodes.Add(new SerializationNode
		{
			Name = name,
			Entry = EntryType.Integer,
			Data = value.ToString("D", CultureInfo.InvariantCulture)
		});
	}

	public override void WriteInternalReference(string name, int id)
	{
		Nodes.Add(new SerializationNode
		{
			Name = name,
			Entry = EntryType.InternalReference,
			Data = id.ToString("D", CultureInfo.InvariantCulture)
		});
	}

	public override void WriteNull(string name)
	{
		Nodes.Add(new SerializationNode
		{
			Name = name,
			Entry = EntryType.Null,
			Data = string.Empty
		});
	}

	public override void WritePrimitiveArray<T>(T[] array)
	{
		if (!FormatterUtilities.IsPrimitiveArrayType(typeof(T)))
		{
			throw new ArgumentException("Type " + typeof(T).Name + " is not a valid primitive array type.");
		}
		if (typeof(T) == typeof(byte))
		{
			string data = ProperBitConverter.BytesToHexString((byte[])(object)array);
			Nodes.Add(new SerializationNode
			{
				Name = string.Empty,
				Entry = EntryType.PrimitiveArray,
				Data = data
			});
			return;
		}
		Nodes.Add(new SerializationNode
		{
			Name = string.Empty,
			Entry = EntryType.PrimitiveArray,
			Data = array.LongLength.ToString(CultureInfo.InvariantCulture)
		});
		PushArray();
		Action<string, T> action = (Action<string, T>)primitiveTypeWriters[typeof(T)];
		for (int i = 0; i < array.Length; i++)
		{
			action(string.Empty, array[i]);
		}
		EndArrayNode();
	}

	public override void WriteSByte(string name, sbyte value)
	{
		Nodes.Add(new SerializationNode
		{
			Name = name,
			Entry = EntryType.Integer,
			Data = value.ToString("D", CultureInfo.InvariantCulture)
		});
	}

	public override void WriteString(string name, string value)
	{
		Nodes.Add(new SerializationNode
		{
			Name = name,
			Entry = EntryType.String,
			Data = value
		});
	}

	public override void WriteUInt16(string name, ushort value)
	{
		Nodes.Add(new SerializationNode
		{
			Name = name,
			Entry = EntryType.Integer,
			Data = value.ToString("D", CultureInfo.InvariantCulture)
		});
	}

	public override void WriteUInt32(string name, uint value)
	{
		Nodes.Add(new SerializationNode
		{
			Name = name,
			Entry = EntryType.Integer,
			Data = value.ToString("D", CultureInfo.InvariantCulture)
		});
	}

	public override void WriteUInt64(string name, ulong value)
	{
		Nodes.Add(new SerializationNode
		{
			Name = name,
			Entry = EntryType.Integer,
			Data = value.ToString("D", CultureInfo.InvariantCulture)
		});
	}

	public override void FlushToStream()
	{
	}

	public override string GetDataDump()
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append("Nodes: \n\n");
		for (int i = 0; i < nodes.Count; i++)
		{
			SerializationNode serializationNode = nodes[i];
			stringBuilder.AppendLine("    - Name: " + serializationNode.Name);
			int entry = (int)serializationNode.Entry;
			stringBuilder.AppendLine("      Entry: " + entry);
			stringBuilder.AppendLine("      Data: " + serializationNode.Data);
		}
		return stringBuilder.ToString();
	}
}
