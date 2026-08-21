using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class FloatArray : IMessage<FloatArray>, IMessage, IEquatable<FloatArray>, IDeepCloneable<FloatArray>
{
	private static readonly MessageParser<FloatArray> _parser = new MessageParser<FloatArray>(() => new FloatArray());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int DataFieldNumber = 2;

	private static readonly FieldCodec<float> _repeated_data_codec = FieldCodec.ForFloat(18u);

	private readonly RepeatedField<float> data_ = new RepeatedField<float>();

	[DebuggerNonUserCode]
	public static MessageParser<FloatArray> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[2];

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
	public RepeatedField<float> Data => data_;

	[DebuggerNonUserCode]
	public FloatArray()
	{
	}

	[DebuggerNonUserCode]
	public FloatArray(FloatArray other)
		: this()
	{
		iD_ = other.iD_;
		data_ = other.data_.Clone();
	}

	[DebuggerNonUserCode]
	public FloatArray Clone()
	{
		return new FloatArray(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as FloatArray);
	}

	[DebuggerNonUserCode]
	public bool Equals(FloatArray other)
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
	public void MergeFrom(FloatArray other)
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
			case 18u:
			case 21u:
				data_.AddEntriesFrom(input, _repeated_data_codec);
				break;
			}
		}
	}
}
