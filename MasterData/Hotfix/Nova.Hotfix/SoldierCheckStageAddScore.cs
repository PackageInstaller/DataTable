using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SoldierCheckStageAddScore : IMessage<SoldierCheckStageAddScore>, IMessage, IEquatable<SoldierCheckStageAddScore>, IDeepCloneable<SoldierCheckStageAddScore>
{
	private static readonly MessageParser<SoldierCheckStageAddScore> _parser = new MessageParser<SoldierCheckStageAddScore>(() => new SoldierCheckStageAddScore());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupFieldNumber = 2;

	private int group_;

	public const int IndexFieldNumber = 3;

	private int index_;

	public const int DPSFieldNumber = 4;

	private int dPS_;

	public const int DPSAddScoreFieldNumber = 5;

	private int dPSAddScore_;

	public const int DurationFieldNumber = 6;

	private int duration_;

	public const int TankingAddScoreFieldNumber = 7;

	private int tankingAddScore_;

	[DebuggerNonUserCode]
	public static MessageParser<SoldierCheckStageAddScore> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(744);

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
	public int Group
	{
		get
		{
			return group_;
		}
		set
		{
			group_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Index
	{
		get
		{
			return index_;
		}
		set
		{
			index_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DPS
	{
		get
		{
			return dPS_;
		}
		set
		{
			dPS_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DPSAddScore
	{
		get
		{
			return dPSAddScore_;
		}
		set
		{
			dPSAddScore_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Duration
	{
		get
		{
			return duration_;
		}
		set
		{
			duration_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TankingAddScore
	{
		get
		{
			return tankingAddScore_;
		}
		set
		{
			tankingAddScore_ = value;
		}
	}

	[DebuggerNonUserCode]
	public SoldierCheckStageAddScore()
	{
	}

	[DebuggerNonUserCode]
	public SoldierCheckStageAddScore(SoldierCheckStageAddScore other)
		: this()
	{
		id_ = other.id_;
		group_ = other.group_;
		index_ = other.index_;
		dPS_ = other.dPS_;
		dPSAddScore_ = other.dPSAddScore_;
		duration_ = other.duration_;
		tankingAddScore_ = other.tankingAddScore_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SoldierCheckStageAddScore Clone()
	{
		return new SoldierCheckStageAddScore(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SoldierCheckStageAddScore);
	}

	[DebuggerNonUserCode]
	public bool Equals(SoldierCheckStageAddScore other)
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
		if (Group != other.Group)
		{
			return false;
		}
		if (Index != other.Index)
		{
			return false;
		}
		if (DPS != other.DPS)
		{
			return false;
		}
		if (DPSAddScore != other.DPSAddScore)
		{
			return false;
		}
		if (Duration != other.Duration)
		{
			return false;
		}
		if (TankingAddScore != other.TankingAddScore)
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
		if (Group != 0)
		{
			num ^= Group.GetHashCode();
		}
		if (Index != 0)
		{
			num ^= Index.GetHashCode();
		}
		if (DPS != 0)
		{
			num ^= DPS.GetHashCode();
		}
		if (DPSAddScore != 0)
		{
			num ^= DPSAddScore.GetHashCode();
		}
		if (Duration != 0)
		{
			num ^= Duration.GetHashCode();
		}
		if (TankingAddScore != 0)
		{
			num ^= TankingAddScore.GetHashCode();
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
		if (Group != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Group);
		}
		if (Index != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Index);
		}
		if (DPS != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(DPS);
		}
		if (DPSAddScore != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(DPSAddScore);
		}
		if (Duration != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Duration);
		}
		if (TankingAddScore != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(TankingAddScore);
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
		if (Group != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Group);
		}
		if (Index != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Index);
		}
		if (DPS != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DPS);
		}
		if (DPSAddScore != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DPSAddScore);
		}
		if (Duration != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Duration);
		}
		if (TankingAddScore != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TankingAddScore);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SoldierCheckStageAddScore other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Group != 0)
			{
				Group = other.Group;
			}
			if (other.Index != 0)
			{
				Index = other.Index;
			}
			if (other.DPS != 0)
			{
				DPS = other.DPS;
			}
			if (other.DPSAddScore != 0)
			{
				DPSAddScore = other.DPSAddScore;
			}
			if (other.Duration != 0)
			{
				Duration = other.Duration;
			}
			if (other.TankingAddScore != 0)
			{
				TankingAddScore = other.TankingAddScore;
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
				Group = input.ReadInt32();
				break;
			case 24u:
				Index = input.ReadInt32();
				break;
			case 32u:
				DPS = input.ReadInt32();
				break;
			case 40u:
				DPSAddScore = input.ReadInt32();
				break;
			case 48u:
				Duration = input.ReadInt32();
				break;
			case 56u:
				TankingAddScore = input.ReadInt32();
				break;
			}
		}
	}
}
