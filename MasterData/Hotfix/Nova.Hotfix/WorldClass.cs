using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class WorldClass : IMessage<WorldClass>, IMessage, IEquatable<WorldClass>, IDeepCloneable<WorldClass>
{
	private static readonly MessageParser<WorldClass> _parser = new MessageParser<WorldClass>(() => new WorldClass());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ExpFieldNumber = 2;

	private int exp_;

	public const int DoubleCountFieldNumber = 3;

	private int doubleCount_;

	public const int RewardFieldNumber = 4;

	private string reward_ = "";

	public const int RewardLimitFieldNumber = 5;

	private int rewardLimit_;

	public const int OpenFuncFieldNumber = 6;

	private static readonly FieldCodec<int> _repeated_openFunc_codec = FieldCodec.ForInt32(50u);

	private readonly RepeatedField<int> openFunc_ = new RepeatedField<int>();

	public const int FuncChangeText1FieldNumber = 7;

	private string funcChangeText1_ = "";

	public const int FuncChangeText2FieldNumber = 8;

	private string funcChangeText2_ = "";

	public const int FuncChangeText3FieldNumber = 9;

	private string funcChangeText3_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<WorldClass> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(1090);

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
	public int Exp
	{
		get
		{
			return exp_;
		}
		set
		{
			exp_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DoubleCount
	{
		get
		{
			return doubleCount_;
		}
		set
		{
			doubleCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Reward
	{
		get
		{
			return reward_;
		}
		set
		{
			reward_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int RewardLimit
	{
		get
		{
			return rewardLimit_;
		}
		set
		{
			rewardLimit_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> OpenFunc => openFunc_;

	[DebuggerNonUserCode]
	public string FuncChangeText1
	{
		get
		{
			return funcChangeText1_;
		}
		set
		{
			funcChangeText1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string FuncChangeText2
	{
		get
		{
			return funcChangeText2_;
		}
		set
		{
			funcChangeText2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string FuncChangeText3
	{
		get
		{
			return funcChangeText3_;
		}
		set
		{
			funcChangeText3_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public WorldClass()
	{
	}

	[DebuggerNonUserCode]
	public WorldClass(WorldClass other)
		: this()
	{
		id_ = other.id_;
		exp_ = other.exp_;
		doubleCount_ = other.doubleCount_;
		reward_ = other.reward_;
		rewardLimit_ = other.rewardLimit_;
		openFunc_ = other.openFunc_.Clone();
		funcChangeText1_ = other.funcChangeText1_;
		funcChangeText2_ = other.funcChangeText2_;
		funcChangeText3_ = other.funcChangeText3_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public WorldClass Clone()
	{
		return new WorldClass(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as WorldClass);
	}

	[DebuggerNonUserCode]
	public bool Equals(WorldClass other)
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
		if (Exp != other.Exp)
		{
			return false;
		}
		if (DoubleCount != other.DoubleCount)
		{
			return false;
		}
		if (Reward != other.Reward)
		{
			return false;
		}
		if (RewardLimit != other.RewardLimit)
		{
			return false;
		}
		if (!openFunc_.Equals(other.openFunc_))
		{
			return false;
		}
		if (FuncChangeText1 != other.FuncChangeText1)
		{
			return false;
		}
		if (FuncChangeText2 != other.FuncChangeText2)
		{
			return false;
		}
		if (FuncChangeText3 != other.FuncChangeText3)
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
		if (Exp != 0)
		{
			num ^= Exp.GetHashCode();
		}
		if (DoubleCount != 0)
		{
			num ^= DoubleCount.GetHashCode();
		}
		if (Reward.Length != 0)
		{
			num ^= Reward.GetHashCode();
		}
		if (RewardLimit != 0)
		{
			num ^= RewardLimit.GetHashCode();
		}
		num ^= openFunc_.GetHashCode();
		if (FuncChangeText1.Length != 0)
		{
			num ^= FuncChangeText1.GetHashCode();
		}
		if (FuncChangeText2.Length != 0)
		{
			num ^= FuncChangeText2.GetHashCode();
		}
		if (FuncChangeText3.Length != 0)
		{
			num ^= FuncChangeText3.GetHashCode();
		}
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
		if (Exp != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Exp);
		}
		if (DoubleCount != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(DoubleCount);
		}
		if (Reward.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Reward);
		}
		if (RewardLimit != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(RewardLimit);
		}
		openFunc_.WriteTo(output, _repeated_openFunc_codec);
		if (FuncChangeText1.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(FuncChangeText1);
		}
		if (FuncChangeText2.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(FuncChangeText2);
		}
		if (FuncChangeText3.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(FuncChangeText3);
		}
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
		if (Exp != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Exp);
		}
		if (DoubleCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DoubleCount);
		}
		if (Reward.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Reward);
		}
		if (RewardLimit != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardLimit);
		}
		num += openFunc_.CalculateSize(_repeated_openFunc_codec);
		if (FuncChangeText1.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(FuncChangeText1);
		}
		if (FuncChangeText2.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(FuncChangeText2);
		}
		if (FuncChangeText3.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(FuncChangeText3);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(WorldClass other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Exp != 0)
			{
				Exp = other.Exp;
			}
			if (other.DoubleCount != 0)
			{
				DoubleCount = other.DoubleCount;
			}
			if (other.Reward.Length != 0)
			{
				Reward = other.Reward;
			}
			if (other.RewardLimit != 0)
			{
				RewardLimit = other.RewardLimit;
			}
			openFunc_.Add(other.openFunc_);
			if (other.FuncChangeText1.Length != 0)
			{
				FuncChangeText1 = other.FuncChangeText1;
			}
			if (other.FuncChangeText2.Length != 0)
			{
				FuncChangeText2 = other.FuncChangeText2;
			}
			if (other.FuncChangeText3.Length != 0)
			{
				FuncChangeText3 = other.FuncChangeText3;
			}
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
				Exp = input.ReadInt32();
				break;
			case 24u:
				DoubleCount = input.ReadInt32();
				break;
			case 34u:
				Reward = input.ReadString();
				break;
			case 40u:
				RewardLimit = input.ReadInt32();
				break;
			case 48u:
			case 50u:
				openFunc_.AddEntriesFrom(input, _repeated_openFunc_codec);
				break;
			case 58u:
				FuncChangeText1 = input.ReadString();
				break;
			case 66u:
				FuncChangeText2 = input.ReadString();
				break;
			case 74u:
				FuncChangeText3 = input.ReadString();
				break;
			}
		}
	}
}
