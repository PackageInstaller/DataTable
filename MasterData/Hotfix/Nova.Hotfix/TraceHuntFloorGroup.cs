using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TraceHuntFloorGroup : IMessage<TraceHuntFloorGroup>, IMessage, IEquatable<TraceHuntFloorGroup>, IDeepCloneable<TraceHuntFloorGroup>
{
	private static readonly MessageParser<TraceHuntFloorGroup> _parser = new MessageParser<TraceHuntFloorGroup>(() => new TraceHuntFloorGroup());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupIdFieldNumber = 2;

	private int groupId_;

	public const int DifficultFieldNumber = 3;

	private int difficult_;

	public const int SummonLevelUpFieldNumber = 4;

	private bool summonLevelUp_;

	public const int FloorIdFieldNumber = 5;

	private int floorId_;

	public const int ScoreGetSwitchGroupFieldNumber = 6;

	private int scoreGetSwitchGroup_;

	[DebuggerNonUserCode]
	public static MessageParser<TraceHuntFloorGroup> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(986);

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
	public int Difficult
	{
		get
		{
			return difficult_;
		}
		set
		{
			difficult_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool SummonLevelUp
	{
		get
		{
			return summonLevelUp_;
		}
		set
		{
			summonLevelUp_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FloorId
	{
		get
		{
			return floorId_;
		}
		set
		{
			floorId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ScoreGetSwitchGroup
	{
		get
		{
			return scoreGetSwitchGroup_;
		}
		set
		{
			scoreGetSwitchGroup_ = value;
		}
	}

	[DebuggerNonUserCode]
	public TraceHuntFloorGroup()
	{
	}

	[DebuggerNonUserCode]
	public TraceHuntFloorGroup(TraceHuntFloorGroup other)
		: this()
	{
		id_ = other.id_;
		groupId_ = other.groupId_;
		difficult_ = other.difficult_;
		summonLevelUp_ = other.summonLevelUp_;
		floorId_ = other.floorId_;
		scoreGetSwitchGroup_ = other.scoreGetSwitchGroup_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TraceHuntFloorGroup Clone()
	{
		return new TraceHuntFloorGroup(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TraceHuntFloorGroup);
	}

	[DebuggerNonUserCode]
	public bool Equals(TraceHuntFloorGroup other)
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
		if (GroupId != other.GroupId)
		{
			return false;
		}
		if (Difficult != other.Difficult)
		{
			return false;
		}
		if (SummonLevelUp != other.SummonLevelUp)
		{
			return false;
		}
		if (FloorId != other.FloorId)
		{
			return false;
		}
		if (ScoreGetSwitchGroup != other.ScoreGetSwitchGroup)
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
		if (GroupId != 0)
		{
			num ^= GroupId.GetHashCode();
		}
		if (Difficult != 0)
		{
			num ^= Difficult.GetHashCode();
		}
		if (SummonLevelUp)
		{
			num ^= SummonLevelUp.GetHashCode();
		}
		if (FloorId != 0)
		{
			num ^= FloorId.GetHashCode();
		}
		if (ScoreGetSwitchGroup != 0)
		{
			num ^= ScoreGetSwitchGroup.GetHashCode();
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
		if (GroupId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(GroupId);
		}
		if (Difficult != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Difficult);
		}
		if (SummonLevelUp)
		{
			output.WriteRawTag(32);
			output.WriteBool(SummonLevelUp);
		}
		if (FloorId != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(FloorId);
		}
		if (ScoreGetSwitchGroup != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(ScoreGetSwitchGroup);
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
		if (GroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GroupId);
		}
		if (Difficult != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Difficult);
		}
		if (SummonLevelUp)
		{
			num += 2;
		}
		if (FloorId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FloorId);
		}
		if (ScoreGetSwitchGroup != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ScoreGetSwitchGroup);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TraceHuntFloorGroup other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.GroupId != 0)
			{
				GroupId = other.GroupId;
			}
			if (other.Difficult != 0)
			{
				Difficult = other.Difficult;
			}
			if (other.SummonLevelUp)
			{
				SummonLevelUp = other.SummonLevelUp;
			}
			if (other.FloorId != 0)
			{
				FloorId = other.FloorId;
			}
			if (other.ScoreGetSwitchGroup != 0)
			{
				ScoreGetSwitchGroup = other.ScoreGetSwitchGroup;
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
				GroupId = input.ReadInt32();
				break;
			case 24u:
				Difficult = input.ReadInt32();
				break;
			case 32u:
				SummonLevelUp = input.ReadBool();
				break;
			case 40u:
				FloorId = input.ReadInt32();
				break;
			case 48u:
				ScoreGetSwitchGroup = input.ReadInt32();
				break;
			}
		}
	}
}
