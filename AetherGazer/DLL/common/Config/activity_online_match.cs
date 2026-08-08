using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class activity_online_match : IMessage<activity_online_match>, IMessage, IEquatable<activity_online_match>, IDeepCloneable<activity_online_match>
{
	private static readonly MessageParser<activity_online_match> _parser = new MessageParser<activity_online_match>(() => new activity_online_match());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int TypeFieldNumber = 2;

	private int type_;

	public const int WaveBaseRelationFieldNumber = 3;

	private static readonly FieldCodec<IntArray> _repeated_waveBaseRelation_codec = FieldCodec.ForMessage(26u, IntArray.Parser);

	private readonly RepeatedField<IntArray> waveBaseRelation_ = new RepeatedField<IntArray>();

	public const int WaveRareRelationFieldNumber = 4;

	private static readonly FieldCodec<IntArray> _repeated_waveRareRelation_codec = FieldCodec.ForMessage(34u, IntArray.Parser);

	private readonly RepeatedField<IntArray> waveRareRelation_ = new RepeatedField<IntArray>();

	public const int UniqueFieldNumber = 5;

	private bool unique_;

	[DebuggerNonUserCode]
	public static MessageParser<activity_online_match> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[71];

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
	public int Type
	{
		get
		{
			return type_;
		}
		set
		{
			type_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<IntArray> WaveBaseRelation => waveBaseRelation_;

	[DebuggerNonUserCode]
	public RepeatedField<IntArray> WaveRareRelation => waveRareRelation_;

	[DebuggerNonUserCode]
	public bool Unique
	{
		get
		{
			return unique_;
		}
		set
		{
			unique_ = value;
		}
	}

	[DebuggerNonUserCode]
	public activity_online_match()
	{
	}

	[DebuggerNonUserCode]
	public activity_online_match(activity_online_match other)
		: this()
	{
		iD_ = other.iD_;
		type_ = other.type_;
		waveBaseRelation_ = other.waveBaseRelation_.Clone();
		waveRareRelation_ = other.waveRareRelation_.Clone();
		unique_ = other.unique_;
	}

	[DebuggerNonUserCode]
	public activity_online_match Clone()
	{
		return new activity_online_match(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as activity_online_match);
	}

	[DebuggerNonUserCode]
	public bool Equals(activity_online_match other)
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
		if (Type != other.Type)
		{
			return false;
		}
		if (!waveBaseRelation_.Equals(other.waveBaseRelation_))
		{
			return false;
		}
		if (!waveRareRelation_.Equals(other.waveRareRelation_))
		{
			return false;
		}
		if (Unique != other.Unique)
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
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		num ^= waveBaseRelation_.GetHashCode();
		num ^= waveRareRelation_.GetHashCode();
		if (Unique)
		{
			num ^= Unique.GetHashCode();
		}
		return num;
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
		if (Type != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Type);
		}
		waveBaseRelation_.WriteTo(output, _repeated_waveBaseRelation_codec);
		waveRareRelation_.WriteTo(output, _repeated_waveRareRelation_codec);
		if (Unique)
		{
			output.WriteRawTag(40);
			output.WriteBool(Unique);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (ID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ID);
		}
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		num += waveBaseRelation_.CalculateSize(_repeated_waveBaseRelation_codec);
		num += waveRareRelation_.CalculateSize(_repeated_waveRareRelation_codec);
		if (Unique)
		{
			num += 2;
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(activity_online_match other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			waveBaseRelation_.Add(other.waveBaseRelation_);
			waveRareRelation_.Add(other.waveRareRelation_);
			if (other.Unique)
			{
				Unique = other.Unique;
			}
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
				Type = input.ReadInt32();
				break;
			case 26u:
				waveBaseRelation_.AddEntriesFrom(input, _repeated_waveBaseRelation_codec);
				break;
			case 34u:
				waveRareRelation_.AddEntriesFrom(input, _repeated_waveRareRelation_codec);
				break;
			case 40u:
				Unique = input.ReadBool();
				break;
			}
		}
	}
}
