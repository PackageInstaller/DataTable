using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class DormLayoutReward : IMessage<DormLayoutReward>, IMessage, IEquatable<DormLayoutReward>, IDeepCloneable<DormLayoutReward>
{
	private static readonly MessageParser<DormLayoutReward> _parser = new MessageParser<DormLayoutReward>(() => new DormLayoutReward());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int RoomTypeFieldNumber = 2;

	private int roomType_;

	public const int FurnitureCountFieldNumber = 3;

	private int furnitureCount_;

	public const int NoShowFieldNumber = 4;

	private bool noShow_;

	public const int RoomLayoutNameFieldNumber = 5;

	private string roomLayoutName_ = "";

	public const int RoomLayoutDescFieldNumber = 6;

	private string roomLayoutDesc_ = "";

	public const int RoomLayoutTagFieldNumber = 7;

	private string roomLayoutTag_ = "";

	public const int RoomLayoutListIconFieldNumber = 8;

	private string roomLayoutListIcon_ = "";

	public const int RewardId1FieldNumber = 9;

	private int rewardId1_;

	public const int Qty1FieldNumber = 10;

	private int qty1_;

	public const int RewardId2FieldNumber = 11;

	private int rewardId2_;

	public const int Qty2FieldNumber = 12;

	private int qty2_;

	public const int RewardId3FieldNumber = 13;

	private int rewardId3_;

	public const int Qty3FieldNumber = 14;

	private int qty3_;

	public const int GetWayFieldNumber = 15;

	private string getWay_ = "";

	public const int JumpToFieldNumber = 16;

	private int jumpTo_;

	[DebuggerNonUserCode]
	public static MessageParser<DormLayoutReward> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(296);

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
	public int RoomType
	{
		get
		{
			return roomType_;
		}
		set
		{
			roomType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FurnitureCount
	{
		get
		{
			return furnitureCount_;
		}
		set
		{
			furnitureCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool NoShow
	{
		get
		{
			return noShow_;
		}
		set
		{
			noShow_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string RoomLayoutName
	{
		get
		{
			return roomLayoutName_;
		}
		set
		{
			roomLayoutName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string RoomLayoutDesc
	{
		get
		{
			return roomLayoutDesc_;
		}
		set
		{
			roomLayoutDesc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string RoomLayoutTag
	{
		get
		{
			return roomLayoutTag_;
		}
		set
		{
			roomLayoutTag_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string RoomLayoutListIcon
	{
		get
		{
			return roomLayoutListIcon_;
		}
		set
		{
			roomLayoutListIcon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int RewardId1
	{
		get
		{
			return rewardId1_;
		}
		set
		{
			rewardId1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Qty1
	{
		get
		{
			return qty1_;
		}
		set
		{
			qty1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RewardId2
	{
		get
		{
			return rewardId2_;
		}
		set
		{
			rewardId2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Qty2
	{
		get
		{
			return qty2_;
		}
		set
		{
			qty2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RewardId3
	{
		get
		{
			return rewardId3_;
		}
		set
		{
			rewardId3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Qty3
	{
		get
		{
			return qty3_;
		}
		set
		{
			qty3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string GetWay
	{
		get
		{
			return getWay_;
		}
		set
		{
			getWay_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int JumpTo
	{
		get
		{
			return jumpTo_;
		}
		set
		{
			jumpTo_ = value;
		}
	}

	[DebuggerNonUserCode]
	public DormLayoutReward()
	{
	}

	[DebuggerNonUserCode]
	public DormLayoutReward(DormLayoutReward other)
		: this()
	{
		id_ = other.id_;
		roomType_ = other.roomType_;
		furnitureCount_ = other.furnitureCount_;
		noShow_ = other.noShow_;
		roomLayoutName_ = other.roomLayoutName_;
		roomLayoutDesc_ = other.roomLayoutDesc_;
		roomLayoutTag_ = other.roomLayoutTag_;
		roomLayoutListIcon_ = other.roomLayoutListIcon_;
		rewardId1_ = other.rewardId1_;
		qty1_ = other.qty1_;
		rewardId2_ = other.rewardId2_;
		qty2_ = other.qty2_;
		rewardId3_ = other.rewardId3_;
		qty3_ = other.qty3_;
		getWay_ = other.getWay_;
		jumpTo_ = other.jumpTo_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public DormLayoutReward Clone()
	{
		return new DormLayoutReward(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as DormLayoutReward);
	}

	[DebuggerNonUserCode]
	public bool Equals(DormLayoutReward other)
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
		if (RoomType != other.RoomType)
		{
			return false;
		}
		if (FurnitureCount != other.FurnitureCount)
		{
			return false;
		}
		if (NoShow != other.NoShow)
		{
			return false;
		}
		if (RoomLayoutName != other.RoomLayoutName)
		{
			return false;
		}
		if (RoomLayoutDesc != other.RoomLayoutDesc)
		{
			return false;
		}
		if (RoomLayoutTag != other.RoomLayoutTag)
		{
			return false;
		}
		if (RoomLayoutListIcon != other.RoomLayoutListIcon)
		{
			return false;
		}
		if (RewardId1 != other.RewardId1)
		{
			return false;
		}
		if (Qty1 != other.Qty1)
		{
			return false;
		}
		if (RewardId2 != other.RewardId2)
		{
			return false;
		}
		if (Qty2 != other.Qty2)
		{
			return false;
		}
		if (RewardId3 != other.RewardId3)
		{
			return false;
		}
		if (Qty3 != other.Qty3)
		{
			return false;
		}
		if (GetWay != other.GetWay)
		{
			return false;
		}
		if (JumpTo != other.JumpTo)
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
		if (RoomType != 0)
		{
			num ^= RoomType.GetHashCode();
		}
		if (FurnitureCount != 0)
		{
			num ^= FurnitureCount.GetHashCode();
		}
		if (NoShow)
		{
			num ^= NoShow.GetHashCode();
		}
		if (RoomLayoutName.Length != 0)
		{
			num ^= RoomLayoutName.GetHashCode();
		}
		if (RoomLayoutDesc.Length != 0)
		{
			num ^= RoomLayoutDesc.GetHashCode();
		}
		if (RoomLayoutTag.Length != 0)
		{
			num ^= RoomLayoutTag.GetHashCode();
		}
		if (RoomLayoutListIcon.Length != 0)
		{
			num ^= RoomLayoutListIcon.GetHashCode();
		}
		if (RewardId1 != 0)
		{
			num ^= RewardId1.GetHashCode();
		}
		if (Qty1 != 0)
		{
			num ^= Qty1.GetHashCode();
		}
		if (RewardId2 != 0)
		{
			num ^= RewardId2.GetHashCode();
		}
		if (Qty2 != 0)
		{
			num ^= Qty2.GetHashCode();
		}
		if (RewardId3 != 0)
		{
			num ^= RewardId3.GetHashCode();
		}
		if (Qty3 != 0)
		{
			num ^= Qty3.GetHashCode();
		}
		if (GetWay.Length != 0)
		{
			num ^= GetWay.GetHashCode();
		}
		if (JumpTo != 0)
		{
			num ^= JumpTo.GetHashCode();
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
		if (RoomType != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(RoomType);
		}
		if (FurnitureCount != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(FurnitureCount);
		}
		if (NoShow)
		{
			output.WriteRawTag(32);
			output.WriteBool(NoShow);
		}
		if (RoomLayoutName.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(RoomLayoutName);
		}
		if (RoomLayoutDesc.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(RoomLayoutDesc);
		}
		if (RoomLayoutTag.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(RoomLayoutTag);
		}
		if (RoomLayoutListIcon.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(RoomLayoutListIcon);
		}
		if (RewardId1 != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(RewardId1);
		}
		if (Qty1 != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(Qty1);
		}
		if (RewardId2 != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(RewardId2);
		}
		if (Qty2 != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(Qty2);
		}
		if (RewardId3 != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(RewardId3);
		}
		if (Qty3 != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(Qty3);
		}
		if (GetWay.Length != 0)
		{
			output.WriteRawTag(122);
			output.WriteString(GetWay);
		}
		if (JumpTo != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(JumpTo);
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
		if (RoomType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RoomType);
		}
		if (FurnitureCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FurnitureCount);
		}
		if (NoShow)
		{
			num += 2;
		}
		if (RoomLayoutName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(RoomLayoutName);
		}
		if (RoomLayoutDesc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(RoomLayoutDesc);
		}
		if (RoomLayoutTag.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(RoomLayoutTag);
		}
		if (RoomLayoutListIcon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(RoomLayoutListIcon);
		}
		if (RewardId1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardId1);
		}
		if (Qty1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Qty1);
		}
		if (RewardId2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardId2);
		}
		if (Qty2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Qty2);
		}
		if (RewardId3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardId3);
		}
		if (Qty3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Qty3);
		}
		if (GetWay.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(GetWay);
		}
		if (JumpTo != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(JumpTo);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(DormLayoutReward other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.RoomType != 0)
			{
				RoomType = other.RoomType;
			}
			if (other.FurnitureCount != 0)
			{
				FurnitureCount = other.FurnitureCount;
			}
			if (other.NoShow)
			{
				NoShow = other.NoShow;
			}
			if (other.RoomLayoutName.Length != 0)
			{
				RoomLayoutName = other.RoomLayoutName;
			}
			if (other.RoomLayoutDesc.Length != 0)
			{
				RoomLayoutDesc = other.RoomLayoutDesc;
			}
			if (other.RoomLayoutTag.Length != 0)
			{
				RoomLayoutTag = other.RoomLayoutTag;
			}
			if (other.RoomLayoutListIcon.Length != 0)
			{
				RoomLayoutListIcon = other.RoomLayoutListIcon;
			}
			if (other.RewardId1 != 0)
			{
				RewardId1 = other.RewardId1;
			}
			if (other.Qty1 != 0)
			{
				Qty1 = other.Qty1;
			}
			if (other.RewardId2 != 0)
			{
				RewardId2 = other.RewardId2;
			}
			if (other.Qty2 != 0)
			{
				Qty2 = other.Qty2;
			}
			if (other.RewardId3 != 0)
			{
				RewardId3 = other.RewardId3;
			}
			if (other.Qty3 != 0)
			{
				Qty3 = other.Qty3;
			}
			if (other.GetWay.Length != 0)
			{
				GetWay = other.GetWay;
			}
			if (other.JumpTo != 0)
			{
				JumpTo = other.JumpTo;
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
				RoomType = input.ReadInt32();
				break;
			case 24u:
				FurnitureCount = input.ReadInt32();
				break;
			case 32u:
				NoShow = input.ReadBool();
				break;
			case 42u:
				RoomLayoutName = input.ReadString();
				break;
			case 50u:
				RoomLayoutDesc = input.ReadString();
				break;
			case 58u:
				RoomLayoutTag = input.ReadString();
				break;
			case 66u:
				RoomLayoutListIcon = input.ReadString();
				break;
			case 72u:
				RewardId1 = input.ReadInt32();
				break;
			case 80u:
				Qty1 = input.ReadInt32();
				break;
			case 88u:
				RewardId2 = input.ReadInt32();
				break;
			case 96u:
				Qty2 = input.ReadInt32();
				break;
			case 104u:
				RewardId3 = input.ReadInt32();
				break;
			case 112u:
				Qty3 = input.ReadInt32();
				break;
			case 122u:
				GetWay = input.ReadString();
				break;
			case 128u:
				JumpTo = input.ReadInt32();
				break;
			}
		}
	}
}
