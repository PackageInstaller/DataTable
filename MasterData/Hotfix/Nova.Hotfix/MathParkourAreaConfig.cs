using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class MathParkourAreaConfig : IMessage<MathParkourAreaConfig>, IMessage, IEquatable<MathParkourAreaConfig>, IDeepCloneable<MathParkourAreaConfig>
{
	private static readonly MessageParser<MathParkourAreaConfig> _parser = new MessageParser<MathParkourAreaConfig>(() => new MathParkourAreaConfig());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ActIdFieldNumber = 2;

	private int actId_;

	public const int AreaIdFieldNumber = 3;

	private int areaId_;

	public const int LaneIndexFieldNumber = 4;

	private int laneIndex_;

	public const int RowIndexFieldNumber = 5;

	private int rowIndex_;

	public const int ObjectIdFieldNumber = 6;

	private int objectId_;

	public const int ObjectGroupIdFieldNumber = 7;

	private int objectGroupId_;

	[DebuggerNonUserCode]
	public static MessageParser<MathParkourAreaConfig> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(532);

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
	public int ActId
	{
		get
		{
			return actId_;
		}
		set
		{
			actId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AreaId
	{
		get
		{
			return areaId_;
		}
		set
		{
			areaId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int LaneIndex
	{
		get
		{
			return laneIndex_;
		}
		set
		{
			laneIndex_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RowIndex
	{
		get
		{
			return rowIndex_;
		}
		set
		{
			rowIndex_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ObjectId
	{
		get
		{
			return objectId_;
		}
		set
		{
			objectId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ObjectGroupId
	{
		get
		{
			return objectGroupId_;
		}
		set
		{
			objectGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public MathParkourAreaConfig()
	{
	}

	[DebuggerNonUserCode]
	public MathParkourAreaConfig(MathParkourAreaConfig other)
		: this()
	{
		id_ = other.id_;
		actId_ = other.actId_;
		areaId_ = other.areaId_;
		laneIndex_ = other.laneIndex_;
		rowIndex_ = other.rowIndex_;
		objectId_ = other.objectId_;
		objectGroupId_ = other.objectGroupId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public MathParkourAreaConfig Clone()
	{
		return new MathParkourAreaConfig(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as MathParkourAreaConfig);
	}

	[DebuggerNonUserCode]
	public bool Equals(MathParkourAreaConfig other)
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
		if (ActId != other.ActId)
		{
			return false;
		}
		if (AreaId != other.AreaId)
		{
			return false;
		}
		if (LaneIndex != other.LaneIndex)
		{
			return false;
		}
		if (RowIndex != other.RowIndex)
		{
			return false;
		}
		if (ObjectId != other.ObjectId)
		{
			return false;
		}
		if (ObjectGroupId != other.ObjectGroupId)
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
		if (ActId != 0)
		{
			num ^= ActId.GetHashCode();
		}
		if (AreaId != 0)
		{
			num ^= AreaId.GetHashCode();
		}
		if (LaneIndex != 0)
		{
			num ^= LaneIndex.GetHashCode();
		}
		if (RowIndex != 0)
		{
			num ^= RowIndex.GetHashCode();
		}
		if (ObjectId != 0)
		{
			num ^= ObjectId.GetHashCode();
		}
		if (ObjectGroupId != 0)
		{
			num ^= ObjectGroupId.GetHashCode();
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
		if (ActId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ActId);
		}
		if (AreaId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(AreaId);
		}
		if (LaneIndex != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(LaneIndex);
		}
		if (RowIndex != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(RowIndex);
		}
		if (ObjectId != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(ObjectId);
		}
		if (ObjectGroupId != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(ObjectGroupId);
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
		if (ActId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ActId);
		}
		if (AreaId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AreaId);
		}
		if (LaneIndex != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LaneIndex);
		}
		if (RowIndex != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RowIndex);
		}
		if (ObjectId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ObjectId);
		}
		if (ObjectGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ObjectGroupId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(MathParkourAreaConfig other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.ActId != 0)
			{
				ActId = other.ActId;
			}
			if (other.AreaId != 0)
			{
				AreaId = other.AreaId;
			}
			if (other.LaneIndex != 0)
			{
				LaneIndex = other.LaneIndex;
			}
			if (other.RowIndex != 0)
			{
				RowIndex = other.RowIndex;
			}
			if (other.ObjectId != 0)
			{
				ObjectId = other.ObjectId;
			}
			if (other.ObjectGroupId != 0)
			{
				ObjectGroupId = other.ObjectGroupId;
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
				ActId = input.ReadInt32();
				break;
			case 24u:
				AreaId = input.ReadInt32();
				break;
			case 32u:
				LaneIndex = input.ReadInt32();
				break;
			case 40u:
				RowIndex = input.ReadInt32();
				break;
			case 48u:
				ObjectId = input.ReadInt32();
				break;
			case 56u:
				ObjectGroupId = input.ReadInt32();
				break;
			}
		}
	}
}
