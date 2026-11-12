using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StarTowerStage : IMessage<StarTowerStage>, IMessage, IEquatable<StarTowerStage>, IDeepCloneable<StarTowerStage>
{
	private static readonly MessageParser<StarTowerStage> _parser = new MessageParser<StarTowerStage>(() => new StarTowerStage());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int StageFieldNumber = 2;

	private int stage_;

	public const int GroupIdFieldNumber = 3;

	private int groupId_;

	public const int FloorFieldNumber = 4;

	private int floor_;

	public const int RoomTypeFieldNumber = 5;

	private int roomType_;

	public const int InteriorCurrencyQuantityFieldNumber = 6;

	private int interiorCurrencyQuantity_;

	public const int GuaranteedMapIdFieldNumber = 7;

	private int guaranteedMapId_;

	public const int GuaranteedMonsterPlanIdFieldNumber = 8;

	private int guaranteedMonsterPlanId_;

	[DebuggerNonUserCode]
	public static MessageParser<StarTowerStage> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(880);

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
	public int Stage
	{
		get
		{
			return stage_;
		}
		set
		{
			stage_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int GroupId
	{
		get
		{
			return groupId_;
		}
		set
		{
			groupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Floor
	{
		get
		{
			return floor_;
		}
		set
		{
			floor_ = value;
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
	public int InteriorCurrencyQuantity
	{
		get
		{
			return interiorCurrencyQuantity_;
		}
		set
		{
			interiorCurrencyQuantity_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int GuaranteedMapId
	{
		get
		{
			return guaranteedMapId_;
		}
		set
		{
			guaranteedMapId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int GuaranteedMonsterPlanId
	{
		get
		{
			return guaranteedMonsterPlanId_;
		}
		set
		{
			guaranteedMonsterPlanId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public StarTowerStage()
	{
	}

	[DebuggerNonUserCode]
	public StarTowerStage(StarTowerStage other)
		: this()
	{
		id_ = other.id_;
		stage_ = other.stage_;
		groupId_ = other.groupId_;
		floor_ = other.floor_;
		roomType_ = other.roomType_;
		interiorCurrencyQuantity_ = other.interiorCurrencyQuantity_;
		guaranteedMapId_ = other.guaranteedMapId_;
		guaranteedMonsterPlanId_ = other.guaranteedMonsterPlanId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StarTowerStage Clone()
	{
		return new StarTowerStage(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StarTowerStage);
	}

	[DebuggerNonUserCode]
	public bool Equals(StarTowerStage other)
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
		if (Stage != other.Stage)
		{
			return false;
		}
		if (GroupId != other.GroupId)
		{
			return false;
		}
		if (Floor != other.Floor)
		{
			return false;
		}
		if (RoomType != other.RoomType)
		{
			return false;
		}
		if (InteriorCurrencyQuantity != other.InteriorCurrencyQuantity)
		{
			return false;
		}
		if (GuaranteedMapId != other.GuaranteedMapId)
		{
			return false;
		}
		if (GuaranteedMonsterPlanId != other.GuaranteedMonsterPlanId)
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
		if (Stage != 0)
		{
			num ^= Stage.GetHashCode();
		}
		if (GroupId != 0)
		{
			num ^= GroupId.GetHashCode();
		}
		if (Floor != 0)
		{
			num ^= Floor.GetHashCode();
		}
		if (RoomType != 0)
		{
			num ^= RoomType.GetHashCode();
		}
		if (InteriorCurrencyQuantity != 0)
		{
			num ^= InteriorCurrencyQuantity.GetHashCode();
		}
		if (GuaranteedMapId != 0)
		{
			num ^= GuaranteedMapId.GetHashCode();
		}
		if (GuaranteedMonsterPlanId != 0)
		{
			num ^= GuaranteedMonsterPlanId.GetHashCode();
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
		if (Stage != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Stage);
		}
		if (GroupId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(GroupId);
		}
		if (Floor != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Floor);
		}
		if (RoomType != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(RoomType);
		}
		if (InteriorCurrencyQuantity != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(InteriorCurrencyQuantity);
		}
		if (GuaranteedMapId != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(GuaranteedMapId);
		}
		if (GuaranteedMonsterPlanId != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(GuaranteedMonsterPlanId);
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
		if (Stage != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Stage);
		}
		if (GroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GroupId);
		}
		if (Floor != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Floor);
		}
		if (RoomType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RoomType);
		}
		if (InteriorCurrencyQuantity != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(InteriorCurrencyQuantity);
		}
		if (GuaranteedMapId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GuaranteedMapId);
		}
		if (GuaranteedMonsterPlanId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GuaranteedMonsterPlanId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(StarTowerStage other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Stage != 0)
			{
				Stage = other.Stage;
			}
			if (other.GroupId != 0)
			{
				GroupId = other.GroupId;
			}
			if (other.Floor != 0)
			{
				Floor = other.Floor;
			}
			if (other.RoomType != 0)
			{
				RoomType = other.RoomType;
			}
			if (other.InteriorCurrencyQuantity != 0)
			{
				InteriorCurrencyQuantity = other.InteriorCurrencyQuantity;
			}
			if (other.GuaranteedMapId != 0)
			{
				GuaranteedMapId = other.GuaranteedMapId;
			}
			if (other.GuaranteedMonsterPlanId != 0)
			{
				GuaranteedMonsterPlanId = other.GuaranteedMonsterPlanId;
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
				Stage = input.ReadInt32();
				break;
			case 24u:
				GroupId = input.ReadInt32();
				break;
			case 32u:
				Floor = input.ReadInt32();
				break;
			case 40u:
				RoomType = input.ReadInt32();
				break;
			case 48u:
				InteriorCurrencyQuantity = input.ReadInt32();
				break;
			case 56u:
				GuaranteedMapId = input.ReadInt32();
				break;
			case 64u:
				GuaranteedMonsterPlanId = input.ReadInt32();
				break;
			}
		}
	}
}
