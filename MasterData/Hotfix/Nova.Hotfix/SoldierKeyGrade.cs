using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SoldierKeyGrade : IMessage<SoldierKeyGrade>, IMessage, IEquatable<SoldierKeyGrade>, IDeepCloneable<SoldierKeyGrade>
{
	private static readonly MessageParser<SoldierKeyGrade> _parser = new MessageParser<SoldierKeyGrade>(() => new SoldierKeyGrade());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int SeasonFieldNumber = 2;

	private int season_;

	public const int NameFieldNumber = 3;

	private string name_ = "";

	public const int IconFieldNumber = 4;

	private string icon_ = "";

	public const int Reward1FieldNumber = 5;

	private int reward1_;

	public const int RewardQty1FieldNumber = 6;

	private int rewardQty1_;

	public const int Reward2FieldNumber = 7;

	private int reward2_;

	public const int RewardQty2FieldNumber = 8;

	private int rewardQty2_;

	[DebuggerNonUserCode]
	public static MessageParser<SoldierKeyGrade> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(768);

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
	public int Season
	{
		get
		{
			return season_;
		}
		set
		{
			season_ = value;
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
	public int Reward1
	{
		get
		{
			return reward1_;
		}
		set
		{
			reward1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RewardQty1
	{
		get
		{
			return rewardQty1_;
		}
		set
		{
			rewardQty1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Reward2
	{
		get
		{
			return reward2_;
		}
		set
		{
			reward2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RewardQty2
	{
		get
		{
			return rewardQty2_;
		}
		set
		{
			rewardQty2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public SoldierKeyGrade()
	{
	}

	[DebuggerNonUserCode]
	public SoldierKeyGrade(SoldierKeyGrade other)
		: this()
	{
		id_ = other.id_;
		season_ = other.season_;
		name_ = other.name_;
		icon_ = other.icon_;
		reward1_ = other.reward1_;
		rewardQty1_ = other.rewardQty1_;
		reward2_ = other.reward2_;
		rewardQty2_ = other.rewardQty2_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SoldierKeyGrade Clone()
	{
		return new SoldierKeyGrade(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SoldierKeyGrade);
	}

	[DebuggerNonUserCode]
	public bool Equals(SoldierKeyGrade other)
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
		if (Season != other.Season)
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
		if (Reward1 != other.Reward1)
		{
			return false;
		}
		if (RewardQty1 != other.RewardQty1)
		{
			return false;
		}
		if (Reward2 != other.Reward2)
		{
			return false;
		}
		if (RewardQty2 != other.RewardQty2)
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
		if (Season != 0)
		{
			num ^= Season.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (Reward1 != 0)
		{
			num ^= Reward1.GetHashCode();
		}
		if (RewardQty1 != 0)
		{
			num ^= RewardQty1.GetHashCode();
		}
		if (Reward2 != 0)
		{
			num ^= Reward2.GetHashCode();
		}
		if (RewardQty2 != 0)
		{
			num ^= RewardQty2.GetHashCode();
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
		if (Season != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Season);
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
		if (Reward1 != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Reward1);
		}
		if (RewardQty1 != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(RewardQty1);
		}
		if (Reward2 != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Reward2);
		}
		if (RewardQty2 != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(RewardQty2);
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
		if (Season != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Season);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (Reward1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward1);
		}
		if (RewardQty1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardQty1);
		}
		if (Reward2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward2);
		}
		if (RewardQty2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardQty2);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SoldierKeyGrade other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Season != 0)
			{
				Season = other.Season;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.Reward1 != 0)
			{
				Reward1 = other.Reward1;
			}
			if (other.RewardQty1 != 0)
			{
				RewardQty1 = other.RewardQty1;
			}
			if (other.Reward2 != 0)
			{
				Reward2 = other.Reward2;
			}
			if (other.RewardQty2 != 0)
			{
				RewardQty2 = other.RewardQty2;
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
				Season = input.ReadInt32();
				break;
			case 26u:
				Name = input.ReadString();
				break;
			case 34u:
				Icon = input.ReadString();
				break;
			case 40u:
				Reward1 = input.ReadInt32();
				break;
			case 48u:
				RewardQty1 = input.ReadInt32();
				break;
			case 56u:
				Reward2 = input.ReadInt32();
				break;
			case 64u:
				RewardQty2 = input.ReadInt32();
				break;
			}
		}
	}
}
