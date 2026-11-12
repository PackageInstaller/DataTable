using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class InfinityTowerBountyLevel : IMessage<InfinityTowerBountyLevel>, IMessage, IEquatable<InfinityTowerBountyLevel>, IDeepCloneable<InfinityTowerBountyLevel>
{
	private static readonly MessageParser<InfinityTowerBountyLevel> _parser = new MessageParser<InfinityTowerBountyLevel>(() => new InfinityTowerBountyLevel());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int LevelFieldNumber = 2;

	private int level_;

	public const int NameFieldNumber = 3;

	private string name_ = "";

	public const int IconFieldNumber = 4;

	private string icon_ = "";

	public const int RewardDropIdFieldNumber = 5;

	private int rewardDropId_;

	public const int RewardShowFieldNumber = 6;

	private string rewardShow_ = "";

	public const int Cond1FieldNumber = 7;

	private int cond1_;

	public const int CondParam1FieldNumber = 8;

	private static readonly FieldCodec<int> _repeated_condParam1_codec = FieldCodec.ForInt32(66u);

	private readonly RepeatedField<int> condParam1_ = new RepeatedField<int>();

	public const int CondDesc1FieldNumber = 9;

	private string condDesc1_ = "";

	public const int Cond2FieldNumber = 10;

	private int cond2_;

	public const int CondParam2FieldNumber = 11;

	private static readonly FieldCodec<int> _repeated_condParam2_codec = FieldCodec.ForInt32(90u);

	private readonly RepeatedField<int> condParam2_ = new RepeatedField<int>();

	public const int CondDesc2FieldNumber = 12;

	private string condDesc2_ = "";

	public const int Cond3FieldNumber = 13;

	private int cond3_;

	public const int CondParam3FieldNumber = 14;

	private static readonly FieldCodec<int> _repeated_condParam3_codec = FieldCodec.ForInt32(114u);

	private readonly RepeatedField<int> condParam3_ = new RepeatedField<int>();

	public const int CondDesc3FieldNumber = 15;

	private string condDesc3_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<InfinityTowerBountyLevel> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(448);

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
	public int Level
	{
		get
		{
			return level_;
		}
		set
		{
			level_ = value;
		}
	}

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
	public string Icon
	{
		get
		{
			return icon_;
		}
		set
		{
			icon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int RewardDropId
	{
		get
		{
			return rewardDropId_;
		}
		set
		{
			rewardDropId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string RewardShow
	{
		get
		{
			return rewardShow_;
		}
		set
		{
			rewardShow_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Cond1
	{
		get
		{
			return cond1_;
		}
		set
		{
			cond1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> CondParam1 => condParam1_;

	[DebuggerNonUserCode]
	public string CondDesc1
	{
		get
		{
			return condDesc1_;
		}
		set
		{
			condDesc1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Cond2
	{
		get
		{
			return cond2_;
		}
		set
		{
			cond2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> CondParam2 => condParam2_;

	[DebuggerNonUserCode]
	public string CondDesc2
	{
		get
		{
			return condDesc2_;
		}
		set
		{
			condDesc2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Cond3
	{
		get
		{
			return cond3_;
		}
		set
		{
			cond3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> CondParam3 => condParam3_;

	[DebuggerNonUserCode]
	public string CondDesc3
	{
		get
		{
			return condDesc3_;
		}
		set
		{
			condDesc3_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public InfinityTowerBountyLevel()
	{
	}

	[DebuggerNonUserCode]
	public InfinityTowerBountyLevel(InfinityTowerBountyLevel other)
		: this()
	{
		id_ = other.id_;
		level_ = other.level_;
		name_ = other.name_;
		icon_ = other.icon_;
		rewardDropId_ = other.rewardDropId_;
		rewardShow_ = other.rewardShow_;
		cond1_ = other.cond1_;
		condParam1_ = other.condParam1_.Clone();
		condDesc1_ = other.condDesc1_;
		cond2_ = other.cond2_;
		condParam2_ = other.condParam2_.Clone();
		condDesc2_ = other.condDesc2_;
		cond3_ = other.cond3_;
		condParam3_ = other.condParam3_.Clone();
		condDesc3_ = other.condDesc3_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public InfinityTowerBountyLevel Clone()
	{
		return new InfinityTowerBountyLevel(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as InfinityTowerBountyLevel);
	}

	[DebuggerNonUserCode]
	public bool Equals(InfinityTowerBountyLevel other)
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
		if (Level != other.Level)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (RewardDropId != other.RewardDropId)
		{
			return false;
		}
		if (RewardShow != other.RewardShow)
		{
			return false;
		}
		if (Cond1 != other.Cond1)
		{
			return false;
		}
		if (!condParam1_.Equals(other.condParam1_))
		{
			return false;
		}
		if (CondDesc1 != other.CondDesc1)
		{
			return false;
		}
		if (Cond2 != other.Cond2)
		{
			return false;
		}
		if (!condParam2_.Equals(other.condParam2_))
		{
			return false;
		}
		if (CondDesc2 != other.CondDesc2)
		{
			return false;
		}
		if (Cond3 != other.Cond3)
		{
			return false;
		}
		if (!condParam3_.Equals(other.condParam3_))
		{
			return false;
		}
		if (CondDesc3 != other.CondDesc3)
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
		if (Level != 0)
		{
			num ^= Level.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (RewardDropId != 0)
		{
			num ^= RewardDropId.GetHashCode();
		}
		if (RewardShow.Length != 0)
		{
			num ^= RewardShow.GetHashCode();
		}
		if (Cond1 != 0)
		{
			num ^= Cond1.GetHashCode();
		}
		num ^= condParam1_.GetHashCode();
		if (CondDesc1.Length != 0)
		{
			num ^= CondDesc1.GetHashCode();
		}
		if (Cond2 != 0)
		{
			num ^= Cond2.GetHashCode();
		}
		num ^= condParam2_.GetHashCode();
		if (CondDesc2.Length != 0)
		{
			num ^= CondDesc2.GetHashCode();
		}
		if (Cond3 != 0)
		{
			num ^= Cond3.GetHashCode();
		}
		num ^= condParam3_.GetHashCode();
		if (CondDesc3.Length != 0)
		{
			num ^= CondDesc3.GetHashCode();
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
		if (Level != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Level);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Name);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Icon);
		}
		if (RewardDropId != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(RewardDropId);
		}
		if (RewardShow.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(RewardShow);
		}
		if (Cond1 != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Cond1);
		}
		condParam1_.WriteTo(output, _repeated_condParam1_codec);
		if (CondDesc1.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(CondDesc1);
		}
		if (Cond2 != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(Cond2);
		}
		condParam2_.WriteTo(output, _repeated_condParam2_codec);
		if (CondDesc2.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(CondDesc2);
		}
		if (Cond3 != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(Cond3);
		}
		condParam3_.WriteTo(output, _repeated_condParam3_codec);
		if (CondDesc3.Length != 0)
		{
			output.WriteRawTag(122);
			output.WriteString(CondDesc3);
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
		if (Level != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Level);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (RewardDropId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardDropId);
		}
		if (RewardShow.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(RewardShow);
		}
		if (Cond1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Cond1);
		}
		num += condParam1_.CalculateSize(_repeated_condParam1_codec);
		if (CondDesc1.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CondDesc1);
		}
		if (Cond2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Cond2);
		}
		num += condParam2_.CalculateSize(_repeated_condParam2_codec);
		if (CondDesc2.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CondDesc2);
		}
		if (Cond3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Cond3);
		}
		num += condParam3_.CalculateSize(_repeated_condParam3_codec);
		if (CondDesc3.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CondDesc3);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(InfinityTowerBountyLevel other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Level != 0)
			{
				Level = other.Level;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.RewardDropId != 0)
			{
				RewardDropId = other.RewardDropId;
			}
			if (other.RewardShow.Length != 0)
			{
				RewardShow = other.RewardShow;
			}
			if (other.Cond1 != 0)
			{
				Cond1 = other.Cond1;
			}
			condParam1_.Add(other.condParam1_);
			if (other.CondDesc1.Length != 0)
			{
				CondDesc1 = other.CondDesc1;
			}
			if (other.Cond2 != 0)
			{
				Cond2 = other.Cond2;
			}
			condParam2_.Add(other.condParam2_);
			if (other.CondDesc2.Length != 0)
			{
				CondDesc2 = other.CondDesc2;
			}
			if (other.Cond3 != 0)
			{
				Cond3 = other.Cond3;
			}
			condParam3_.Add(other.condParam3_);
			if (other.CondDesc3.Length != 0)
			{
				CondDesc3 = other.CondDesc3;
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
				Level = input.ReadInt32();
				break;
			case 26u:
				Name = input.ReadString();
				break;
			case 34u:
				Icon = input.ReadString();
				break;
			case 40u:
				RewardDropId = input.ReadInt32();
				break;
			case 50u:
				RewardShow = input.ReadString();
				break;
			case 56u:
				Cond1 = input.ReadInt32();
				break;
			case 64u:
			case 66u:
				condParam1_.AddEntriesFrom(input, _repeated_condParam1_codec);
				break;
			case 74u:
				CondDesc1 = input.ReadString();
				break;
			case 80u:
				Cond2 = input.ReadInt32();
				break;
			case 88u:
			case 90u:
				condParam2_.AddEntriesFrom(input, _repeated_condParam2_codec);
				break;
			case 98u:
				CondDesc2 = input.ReadString();
				break;
			case 104u:
				Cond3 = input.ReadInt32();
				break;
			case 112u:
			case 114u:
				condParam3_.AddEntriesFrom(input, _repeated_condParam3_codec);
				break;
			case 122u:
				CondDesc3 = input.ReadString();
				break;
			}
		}
	}
}
