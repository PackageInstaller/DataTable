using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class DormRoomLayout : IMessage<DormRoomLayout>, IMessage, IEquatable<DormRoomLayout>, IDeepCloneable<DormRoomLayout>
{
	private static readonly MessageParser<DormRoomLayout> _parser = new MessageParser<DormRoomLayout>(() => new DormRoomLayout());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int RoomLayoutIdFieldNumber = 2;

	private int roomLayoutId_;

	public const int FurnitureIdFieldNumber = 3;

	private int furnitureId_;

	public const int PosFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_pos_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> pos_ = new RepeatedField<int>();

	public const int RotFieldNumber = 5;

	private int rot_;

	public const int ApplyRoomTypeFieldNumber = 6;

	private int applyRoomType_;

	[DebuggerNonUserCode]
	public static MessageParser<DormRoomLayout> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(310);

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
	public int RoomLayoutId
	{
		get
		{
			return roomLayoutId_;
		}
		set
		{
			roomLayoutId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FurnitureId
	{
		get
		{
			return furnitureId_;
		}
		set
		{
			furnitureId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Pos => pos_;

	[DebuggerNonUserCode]
	public int Rot
	{
		get
		{
			return rot_;
		}
		set
		{
			rot_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ApplyRoomType
	{
		get
		{
			return applyRoomType_;
		}
		set
		{
			applyRoomType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public DormRoomLayout()
	{
	}

	[DebuggerNonUserCode]
	public DormRoomLayout(DormRoomLayout other)
		: this()
	{
		id_ = other.id_;
		roomLayoutId_ = other.roomLayoutId_;
		furnitureId_ = other.furnitureId_;
		pos_ = other.pos_.Clone();
		rot_ = other.rot_;
		applyRoomType_ = other.applyRoomType_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public DormRoomLayout Clone()
	{
		return new DormRoomLayout(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as DormRoomLayout);
	}

	[DebuggerNonUserCode]
	public bool Equals(DormRoomLayout other)
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
		if (RoomLayoutId != other.RoomLayoutId)
		{
			return false;
		}
		if (FurnitureId != other.FurnitureId)
		{
			return false;
		}
		if (!pos_.Equals(other.pos_))
		{
			return false;
		}
		if (Rot != other.Rot)
		{
			return false;
		}
		if (ApplyRoomType != other.ApplyRoomType)
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
		if (RoomLayoutId != 0)
		{
			num ^= RoomLayoutId.GetHashCode();
		}
		if (FurnitureId != 0)
		{
			num ^= FurnitureId.GetHashCode();
		}
		num ^= pos_.GetHashCode();
		if (Rot != 0)
		{
			num ^= Rot.GetHashCode();
		}
		if (ApplyRoomType != 0)
		{
			num ^= ApplyRoomType.GetHashCode();
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
		if (RoomLayoutId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(RoomLayoutId);
		}
		if (FurnitureId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(FurnitureId);
		}
		pos_.WriteTo(output, _repeated_pos_codec);
		if (Rot != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Rot);
		}
		if (ApplyRoomType != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(ApplyRoomType);
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
		if (RoomLayoutId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RoomLayoutId);
		}
		if (FurnitureId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FurnitureId);
		}
		num += pos_.CalculateSize(_repeated_pos_codec);
		if (Rot != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Rot);
		}
		if (ApplyRoomType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ApplyRoomType);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(DormRoomLayout other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.RoomLayoutId != 0)
			{
				RoomLayoutId = other.RoomLayoutId;
			}
			if (other.FurnitureId != 0)
			{
				FurnitureId = other.FurnitureId;
			}
			pos_.Add(other.pos_);
			if (other.Rot != 0)
			{
				Rot = other.Rot;
			}
			if (other.ApplyRoomType != 0)
			{
				ApplyRoomType = other.ApplyRoomType;
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
				RoomLayoutId = input.ReadInt32();
				break;
			case 24u:
				FurnitureId = input.ReadInt32();
				break;
			case 32u:
			case 34u:
				pos_.AddEntriesFrom(input, _repeated_pos_codec);
				break;
			case 40u:
				Rot = input.ReadInt32();
				break;
			case 48u:
				ApplyRoomType = input.ReadInt32();
				break;
			}
		}
	}
}
