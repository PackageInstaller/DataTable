using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SoldierStoryReward : IMessage<SoldierStoryReward>, IMessage, IEquatable<SoldierStoryReward>, IDeepCloneable<SoldierStoryReward>
{
	private static readonly MessageParser<SoldierStoryReward> _parser = new MessageParser<SoldierStoryReward>(() => new SoldierStoryReward());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int Type1FieldNumber = 2;

	private int type1_;

	public const int Param1FieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_param1_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> param1_ = new RepeatedField<int>();

	public const int Type2FieldNumber = 4;

	private int type2_;

	public const int Param2FieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_param2_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> param2_ = new RepeatedField<int>();

	public const int Type3FieldNumber = 6;

	private int type3_;

	public const int Param3FieldNumber = 7;

	private static readonly FieldCodec<int> _repeated_param3_codec = FieldCodec.ForInt32(58u);

	private readonly RepeatedField<int> param3_ = new RepeatedField<int>();

	public const int Type4FieldNumber = 8;

	private int type4_;

	public const int Param4FieldNumber = 9;

	private static readonly FieldCodec<int> _repeated_param4_codec = FieldCodec.ForInt32(74u);

	private readonly RepeatedField<int> param4_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<SoldierStoryReward> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(804);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int Id
	{
		get
		{
			return id_;
		}
		set
		{
			id_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Type1
	{
		get
		{
			return type1_;
		}
		set
		{
			type1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Param1 => param1_;

	[DebuggerNonUserCode]
	public int Type2
	{
		get
		{
			return type2_;
		}
		set
		{
			type2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Param2 => param2_;

	[DebuggerNonUserCode]
	public int Type3
	{
		get
		{
			return type3_;
		}
		set
		{
			type3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Param3 => param3_;

	[DebuggerNonUserCode]
	public int Type4
	{
		get
		{
			return type4_;
		}
		set
		{
			type4_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Param4 => param4_;

	[DebuggerNonUserCode]
	public SoldierStoryReward()
	{
	}

	[DebuggerNonUserCode]
	public SoldierStoryReward(SoldierStoryReward other)
		: this()
	{
		id_ = other.id_;
		type1_ = other.type1_;
		param1_ = other.param1_.Clone();
		type2_ = other.type2_;
		param2_ = other.param2_.Clone();
		type3_ = other.type3_;
		param3_ = other.param3_.Clone();
		type4_ = other.type4_;
		param4_ = other.param4_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SoldierStoryReward Clone()
	{
		return new SoldierStoryReward(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SoldierStoryReward);
	}

	[DebuggerNonUserCode]
	public bool Equals(SoldierStoryReward other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Id != other.Id)
		{
			return false;
		}
		if (Type1 != other.Type1)
		{
			return false;
		}
		if (!param1_.Equals(other.param1_))
		{
			return false;
		}
		if (Type2 != other.Type2)
		{
			return false;
		}
		if (!param2_.Equals(other.param2_))
		{
			return false;
		}
		if (Type3 != other.Type3)
		{
			return false;
		}
		if (!param3_.Equals(other.param3_))
		{
			return false;
		}
		if (Type4 != other.Type4)
		{
			return false;
		}
		if (!param4_.Equals(other.param4_))
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (Type1 != 0)
		{
			num ^= Type1.GetHashCode();
		}
		num ^= param1_.GetHashCode();
		if (Type2 != 0)
		{
			num ^= Type2.GetHashCode();
		}
		num ^= param2_.GetHashCode();
		if (Type3 != 0)
		{
			num ^= Type3.GetHashCode();
		}
		num ^= param3_.GetHashCode();
		if (Type4 != 0)
		{
			num ^= Type4.GetHashCode();
		}
		num ^= param4_.GetHashCode();
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
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
		if (Id != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Id);
		}
		if (Type1 != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Type1);
		}
		param1_.WriteTo(output, _repeated_param1_codec);
		if (Type2 != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Type2);
		}
		param2_.WriteTo(output, _repeated_param2_codec);
		if (Type3 != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Type3);
		}
		param3_.WriteTo(output, _repeated_param3_codec);
		if (Type4 != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Type4);
		}
		param4_.WriteTo(output, _repeated_param4_codec);
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(output);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		if (Type1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type1);
		}
		num += param1_.CalculateSize(_repeated_param1_codec);
		if (Type2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type2);
		}
		num += param2_.CalculateSize(_repeated_param2_codec);
		if (Type3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type3);
		}
		num += param3_.CalculateSize(_repeated_param3_codec);
		if (Type4 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type4);
		}
		num += param4_.CalculateSize(_repeated_param4_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SoldierStoryReward other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Type1 != 0)
			{
				Type1 = other.Type1;
			}
			param1_.Add(other.param1_);
			if (other.Type2 != 0)
			{
				Type2 = other.Type2;
			}
			param2_.Add(other.param2_);
			if (other.Type3 != 0)
			{
				Type3 = other.Type3;
			}
			param3_.Add(other.param3_);
			if (other.Type4 != 0)
			{
				Type4 = other.Type4;
			}
			param4_.Add(other.param4_);
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
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
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, input);
				break;
			case 8u:
				Id = input.ReadInt32();
				break;
			case 16u:
				Type1 = input.ReadInt32();
				break;
			case 24u:
			case 26u:
				param1_.AddEntriesFrom(input, _repeated_param1_codec);
				break;
			case 32u:
				Type2 = input.ReadInt32();
				break;
			case 40u:
			case 42u:
				param2_.AddEntriesFrom(input, _repeated_param2_codec);
				break;
			case 48u:
				Type3 = input.ReadInt32();
				break;
			case 56u:
			case 58u:
				param3_.AddEntriesFrom(input, _repeated_param3_codec);
				break;
			case 64u:
				Type4 = input.ReadInt32();
				break;
			case 72u:
			case 74u:
				param4_.AddEntriesFrom(input, _repeated_param4_codec);
				break;
			}
		}
	}
}
