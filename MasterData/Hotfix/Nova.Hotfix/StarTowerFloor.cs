using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StarTowerFloor : IMessage<StarTowerFloor>, IMessage, IEquatable<StarTowerFloor>, IDeepCloneable<StarTowerFloor>
{
	private static readonly MessageParser<StarTowerFloor> _parser = new MessageParser<StarTowerFloor>(() => new StarTowerFloor());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int CommonGameplayTypeFieldNumber = 2;

	private int commonGameplayType_;

	public const int CommonMonsterSetFieldNumber = 3;

	private string commonMonsterSet_ = "";

	public const int LimitTimeFieldNumber = 4;

	private int limitTime_;

	public const int DropObjectGroupIdFieldNumber = 5;

	private int dropObjectGroupId_;

	public const int DropObjectRateFieldNumber = 6;

	private int dropObjectRate_;

	public const int DropMaxNumFieldNumber = 7;

	private int dropMaxNum_;

	public const int MonsterSurplusNumFieldNumber = 8;

	private int monsterSurplusNum_;

	[DebuggerNonUserCode]
	public static MessageParser<StarTowerFloor> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(848);

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
	public int CommonGameplayType
	{
		get
		{
			return commonGameplayType_;
		}
		set
		{
			commonGameplayType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string CommonMonsterSet
	{
		get
		{
			return commonMonsterSet_;
		}
		set
		{
			commonMonsterSet_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int LimitTime
	{
		get
		{
			return limitTime_;
		}
		set
		{
			limitTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DropObjectGroupId
	{
		get
		{
			return dropObjectGroupId_;
		}
		set
		{
			dropObjectGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DropObjectRate
	{
		get
		{
			return dropObjectRate_;
		}
		set
		{
			dropObjectRate_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DropMaxNum
	{
		get
		{
			return dropMaxNum_;
		}
		set
		{
			dropMaxNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MonsterSurplusNum
	{
		get
		{
			return monsterSurplusNum_;
		}
		set
		{
			monsterSurplusNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	public StarTowerFloor()
	{
	}

	[DebuggerNonUserCode]
	public StarTowerFloor(StarTowerFloor other)
		: this()
	{
		id_ = other.id_;
		commonGameplayType_ = other.commonGameplayType_;
		commonMonsterSet_ = other.commonMonsterSet_;
		limitTime_ = other.limitTime_;
		dropObjectGroupId_ = other.dropObjectGroupId_;
		dropObjectRate_ = other.dropObjectRate_;
		dropMaxNum_ = other.dropMaxNum_;
		monsterSurplusNum_ = other.monsterSurplusNum_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StarTowerFloor Clone()
	{
		return new StarTowerFloor(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StarTowerFloor);
	}

	[DebuggerNonUserCode]
	public bool Equals(StarTowerFloor other)
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
		if (CommonGameplayType != other.CommonGameplayType)
		{
			return false;
		}
		if (CommonMonsterSet != other.CommonMonsterSet)
		{
			return false;
		}
		if (LimitTime != other.LimitTime)
		{
			return false;
		}
		if (DropObjectGroupId != other.DropObjectGroupId)
		{
			return false;
		}
		if (DropObjectRate != other.DropObjectRate)
		{
			return false;
		}
		if (DropMaxNum != other.DropMaxNum)
		{
			return false;
		}
		if (MonsterSurplusNum != other.MonsterSurplusNum)
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
		if (CommonGameplayType != 0)
		{
			num ^= CommonGameplayType.GetHashCode();
		}
		if (CommonMonsterSet.Length != 0)
		{
			num ^= CommonMonsterSet.GetHashCode();
		}
		if (LimitTime != 0)
		{
			num ^= LimitTime.GetHashCode();
		}
		if (DropObjectGroupId != 0)
		{
			num ^= DropObjectGroupId.GetHashCode();
		}
		if (DropObjectRate != 0)
		{
			num ^= DropObjectRate.GetHashCode();
		}
		if (DropMaxNum != 0)
		{
			num ^= DropMaxNum.GetHashCode();
		}
		if (MonsterSurplusNum != 0)
		{
			num ^= MonsterSurplusNum.GetHashCode();
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
		if (CommonGameplayType != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(CommonGameplayType);
		}
		if (CommonMonsterSet.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(CommonMonsterSet);
		}
		if (LimitTime != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(LimitTime);
		}
		if (DropObjectGroupId != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(DropObjectGroupId);
		}
		if (DropObjectRate != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(DropObjectRate);
		}
		if (DropMaxNum != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(DropMaxNum);
		}
		if (MonsterSurplusNum != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(MonsterSurplusNum);
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
		if (CommonGameplayType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CommonGameplayType);
		}
		if (CommonMonsterSet.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CommonMonsterSet);
		}
		if (LimitTime != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LimitTime);
		}
		if (DropObjectGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DropObjectGroupId);
		}
		if (DropObjectRate != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DropObjectRate);
		}
		if (DropMaxNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DropMaxNum);
		}
		if (MonsterSurplusNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MonsterSurplusNum);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(StarTowerFloor other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.CommonGameplayType != 0)
			{
				CommonGameplayType = other.CommonGameplayType;
			}
			if (other.CommonMonsterSet.Length != 0)
			{
				CommonMonsterSet = other.CommonMonsterSet;
			}
			if (other.LimitTime != 0)
			{
				LimitTime = other.LimitTime;
			}
			if (other.DropObjectGroupId != 0)
			{
				DropObjectGroupId = other.DropObjectGroupId;
			}
			if (other.DropObjectRate != 0)
			{
				DropObjectRate = other.DropObjectRate;
			}
			if (other.DropMaxNum != 0)
			{
				DropMaxNum = other.DropMaxNum;
			}
			if (other.MonsterSurplusNum != 0)
			{
				MonsterSurplusNum = other.MonsterSurplusNum;
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
				CommonGameplayType = input.ReadInt32();
				break;
			case 26u:
				CommonMonsterSet = input.ReadString();
				break;
			case 32u:
				LimitTime = input.ReadInt32();
				break;
			case 40u:
				DropObjectGroupId = input.ReadInt32();
				break;
			case 48u:
				DropObjectRate = input.ReadInt32();
				break;
			case 56u:
				DropMaxNum = input.ReadInt32();
				break;
			case 64u:
				MonsterSurplusNum = input.ReadInt32();
				break;
			}
		}
	}
}
