using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StarTowerMonsterBornGroup : IMessage<StarTowerMonsterBornGroup>, IMessage, IEquatable<StarTowerMonsterBornGroup>, IDeepCloneable<StarTowerMonsterBornGroup>
{
	private static readonly MessageParser<StarTowerMonsterBornGroup> _parser = new MessageParser<StarTowerMonsterBornGroup>(() => new StarTowerMonsterBornGroup());

	private UnknownFieldSet _unknownFields;

	public const int GroupIdFieldNumber = 1;

	private int groupId_;

	public const int MonsterIdFieldNumber = 2;

	private int monsterId_;

	public const int DifficultyFieldNumber = 3;

	private int difficulty_;

	public const int MinFloorFieldNumber = 4;

	private int minFloor_;

	public const int MaxFloorFieldNumber = 5;

	private int maxFloor_;

	[DebuggerNonUserCode]
	public static MessageParser<StarTowerMonsterBornGroup> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(864);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

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
	public int MonsterId
	{
		get
		{
			return monsterId_;
		}
		set
		{
			monsterId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Difficulty
	{
		get
		{
			return difficulty_;
		}
		set
		{
			difficulty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MinFloor
	{
		get
		{
			return minFloor_;
		}
		set
		{
			minFloor_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MaxFloor
	{
		get
		{
			return maxFloor_;
		}
		set
		{
			maxFloor_ = value;
		}
	}

	[DebuggerNonUserCode]
	public StarTowerMonsterBornGroup()
	{
	}

	[DebuggerNonUserCode]
	public StarTowerMonsterBornGroup(StarTowerMonsterBornGroup other)
		: this()
	{
		groupId_ = other.groupId_;
		monsterId_ = other.monsterId_;
		difficulty_ = other.difficulty_;
		minFloor_ = other.minFloor_;
		maxFloor_ = other.maxFloor_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StarTowerMonsterBornGroup Clone()
	{
		return new StarTowerMonsterBornGroup(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StarTowerMonsterBornGroup);
	}

	[DebuggerNonUserCode]
	public bool Equals(StarTowerMonsterBornGroup other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (GroupId != other.GroupId)
		{
			return false;
		}
		if (MonsterId != other.MonsterId)
		{
			return false;
		}
		if (Difficulty != other.Difficulty)
		{
			return false;
		}
		if (MinFloor != other.MinFloor)
		{
			return false;
		}
		if (MaxFloor != other.MaxFloor)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (GroupId != 0)
		{
			num ^= GroupId.GetHashCode();
		}
		if (MonsterId != 0)
		{
			num ^= MonsterId.GetHashCode();
		}
		if (Difficulty != 0)
		{
			num ^= Difficulty.GetHashCode();
		}
		if (MinFloor != 0)
		{
			num ^= MinFloor.GetHashCode();
		}
		if (MaxFloor != 0)
		{
			num ^= MaxFloor.GetHashCode();
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
		if (GroupId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(GroupId);
		}
		if (MonsterId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(MonsterId);
		}
		if (Difficulty != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Difficulty);
		}
		if (MinFloor != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(MinFloor);
		}
		if (MaxFloor != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(MaxFloor);
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
		if (GroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GroupId);
		}
		if (MonsterId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MonsterId);
		}
		if (Difficulty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Difficulty);
		}
		if (MinFloor != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MinFloor);
		}
		if (MaxFloor != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MaxFloor);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(StarTowerMonsterBornGroup other)
	{
		if (other != null)
		{
			if (other.GroupId != 0)
			{
				GroupId = other.GroupId;
			}
			if (other.MonsterId != 0)
			{
				MonsterId = other.MonsterId;
			}
			if (other.Difficulty != 0)
			{
				Difficulty = other.Difficulty;
			}
			if (other.MinFloor != 0)
			{
				MinFloor = other.MinFloor;
			}
			if (other.MaxFloor != 0)
			{
				MaxFloor = other.MaxFloor;
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
				GroupId = input.ReadInt32();
				break;
			case 16u:
				MonsterId = input.ReadInt32();
				break;
			case 24u:
				Difficulty = input.ReadInt32();
				break;
			case 32u:
				MinFloor = input.ReadInt32();
				break;
			case 40u:
				MaxFloor = input.ReadInt32();
				break;
			}
		}
	}
}
