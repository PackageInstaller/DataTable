using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

public sealed class ProtoTable : IMessage<ProtoTable>, IMessage, IEquatable<ProtoTable>, IDeepCloneable<ProtoTable>
{
	private static readonly MessageParser<ProtoTable> _parser = new MessageParser<ProtoTable>(() => new ProtoTable());

	public const int NameFieldNumber = 1;

	private string name_ = "";

	public const int DataFieldNumber = 2;

	private static readonly MapField<int, ProtoBlackboardSource>.Codec _map_data_codec = new MapField<int, ProtoBlackboardSource>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, ProtoBlackboardSource.Parser), 18u);

	private readonly MapField<int, ProtoBlackboardSource> data_ = new MapField<int, ProtoBlackboardSource>();

	[DebuggerNonUserCode]
	public static MessageParser<ProtoTable> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => BlackboardReflection.Descriptor.MessageTypes[1];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public string Name
	{
		get
		{
			return name_;
		}
		set
		{
			name_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public MapField<int, ProtoBlackboardSource> Data => data_;

	[DebuggerNonUserCode]
	public ProtoTable()
	{
	}

	[DebuggerNonUserCode]
	public ProtoTable(ProtoTable other)
		: this()
	{
		name_ = other.name_;
		data_ = other.data_.Clone();
	}

	[DebuggerNonUserCode]
	public ProtoTable Clone()
	{
		return new ProtoTable(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ProtoTable);
	}

	[DebuggerNonUserCode]
	public bool Equals(ProtoTable other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (!Data.Equals(other.Data))
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		return num ^ Data.GetHashCode();
	}

	[DebuggerNonUserCode]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	public void WriteTo(CodedOutputStream output)
	{
		if (Name.Length != 0)
		{
			output.WriteRawTag(10);
			output.WriteString(Name);
		}
		data_.WriteTo(output, _map_data_codec);
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		return num + data_.CalculateSize(_map_data_codec);
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ProtoTable other)
	{
		if (other != null)
		{
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			data_.Add(other.data_);
		}
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CodedInputStream input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			switch (num)
			{
			default:
				input.SkipLastField();
				break;
			case 10u:
				Name = input.ReadString();
				break;
			case 18u:
				data_.AddEntriesFrom(input, _map_data_codec);
				break;
			}
		}
	}
}
