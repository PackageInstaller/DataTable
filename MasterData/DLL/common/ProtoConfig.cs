using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

public sealed class ProtoConfig : IMessage<ProtoConfig>, IMessage, IEquatable<ProtoConfig>, IDeepCloneable<ProtoConfig>
{
	private static readonly MessageParser<ProtoConfig> _parser = new MessageParser<ProtoConfig>(() => new ProtoConfig());

	public const int DataFieldNumber = 1;

	private static readonly MapField<string, ProtoTable>.Codec _map_data_codec = new MapField<string, ProtoTable>.Codec(FieldCodec.ForString(10u), FieldCodec.ForMessage(18u, ProtoTable.Parser), 10u);

	private readonly MapField<string, ProtoTable> data_ = new MapField<string, ProtoTable>();

	[DebuggerNonUserCode]
	public static MessageParser<ProtoConfig> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => BlackboardReflection.Descriptor.MessageTypes[0];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public MapField<string, ProtoTable> Data => data_;

	[DebuggerNonUserCode]
	public ProtoConfig()
	{
	}

	[DebuggerNonUserCode]
	public ProtoConfig(ProtoConfig other)
		: this()
	{
		data_ = other.data_.Clone();
	}

	[DebuggerNonUserCode]
	public ProtoConfig Clone()
	{
		return new ProtoConfig(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ProtoConfig);
	}

	[DebuggerNonUserCode]
	public bool Equals(ProtoConfig other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
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
		data_.WriteTo(output, _map_data_codec);
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		return num + data_.CalculateSize(_map_data_codec);
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ProtoConfig other)
	{
		if (other != null)
		{
			data_.Add(other.data_);
		}
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CodedInputStream input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			if (num != 10)
			{
				input.SkipLastField();
			}
			else
			{
				data_.AddEntriesFrom(input, _map_data_codec);
			}
		}
	}
}
