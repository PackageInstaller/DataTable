using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class LongArray : IMessage<LongArray>, IMessage, IEquatable<LongArray>, IDeepCloneable<LongArray>
{
	private static readonly MessageParser<LongArray> _parser = new MessageParser<LongArray>(() => new LongArray());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int DataFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_data_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> data_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<LongArray> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[1];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int ID
	{
		get
		{
			return iD_;
		}
		set
		{
			iD_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Data => data_;

	[DebuggerNonUserCode]
	public LongArray()
	{
	}

	[DebuggerNonUserCode]
	public LongArray(LongArray other)
		: this()
	{
		iD_ = other.iD_;
		data_ = other.data_.Clone();
	}

	[DebuggerNonUserCode]
	public LongArray Clone()
	{
		return new LongArray(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as LongArray);
	}

	[DebuggerNonUserCode]
	public bool Equals(LongArray other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ID != other.ID)
		{
			return false;
		}
		if (!data_.Equals(other.data_))
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (ID != 0)
		{
			num ^= ID.GetHashCode();
		}
		return num ^ data_.GetHashCode();
	}

	[DebuggerNonUserCode]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	public void WriteTo(CodedOutputStream output)
	{
		if (ID != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ID);
		}
		data_.WriteTo(output, _repeated_data_codec);
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (ID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ID);
		}
		return num + data_.CalculateSize(_repeated_data_codec);
	}

	[DebuggerNonUserCode]
	public void MergeFrom(LongArray other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
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
			case 8u:
				ID = input.ReadInt32();
				break;
			case 16u:
			case 18u:
				data_.AddEntriesFrom(input, _repeated_data_codec);
				break;
			}
		}
	}
}
