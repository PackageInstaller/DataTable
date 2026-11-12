using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class CharacterArchive : IMessage<CharacterArchive>, IMessage, IEquatable<CharacterArchive>, IDeepCloneable<CharacterArchive>
{
	private static readonly MessageParser<CharacterArchive> _parser = new MessageParser<CharacterArchive>(() => new CharacterArchive());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ArchTypeFieldNumber = 2;

	private int archType_;

	public const int CharacterIdFieldNumber = 3;

	private int characterId_;

	public const int UnlockAffinityLevelFieldNumber = 4;

	private int unlockAffinityLevel_;

	public const int RecordIdFieldNumber = 5;

	private int recordId_;

	public const int SortFieldNumber = 6;

	private int sort_;

	public const int ArchRewardFieldNumber = 7;

	private int archReward_;

	public const int ArchRewardQuantityFieldNumber = 8;

	private int archRewardQuantity_;

	[DebuggerNonUserCode]
	public static MessageParser<CharacterArchive> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(154);

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
	public int ArchType
	{
		get
		{
			return archType_;
		}
		set
		{
			archType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CharacterId
	{
		get
		{
			return characterId_;
		}
		set
		{
			characterId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int UnlockAffinityLevel
	{
		get
		{
			return unlockAffinityLevel_;
		}
		set
		{
			unlockAffinityLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RecordId
	{
		get
		{
			return recordId_;
		}
		set
		{
			recordId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Sort
	{
		get
		{
			return sort_;
		}
		set
		{
			sort_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ArchReward
	{
		get
		{
			return archReward_;
		}
		set
		{
			archReward_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ArchRewardQuantity
	{
		get
		{
			return archRewardQuantity_;
		}
		set
		{
			archRewardQuantity_ = value;
		}
	}

	[DebuggerNonUserCode]
	public CharacterArchive()
	{
	}

	[DebuggerNonUserCode]
	public CharacterArchive(CharacterArchive other)
		: this()
	{
		id_ = other.id_;
		archType_ = other.archType_;
		characterId_ = other.characterId_;
		unlockAffinityLevel_ = other.unlockAffinityLevel_;
		recordId_ = other.recordId_;
		sort_ = other.sort_;
		archReward_ = other.archReward_;
		archRewardQuantity_ = other.archRewardQuantity_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public CharacterArchive Clone()
	{
		return new CharacterArchive(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as CharacterArchive);
	}

	[DebuggerNonUserCode]
	public bool Equals(CharacterArchive other)
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
		if (ArchType != other.ArchType)
		{
			return false;
		}
		if (CharacterId != other.CharacterId)
		{
			return false;
		}
		if (UnlockAffinityLevel != other.UnlockAffinityLevel)
		{
			return false;
		}
		if (RecordId != other.RecordId)
		{
			return false;
		}
		if (Sort != other.Sort)
		{
			return false;
		}
		if (ArchReward != other.ArchReward)
		{
			return false;
		}
		if (ArchRewardQuantity != other.ArchRewardQuantity)
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
		if (ArchType != 0)
		{
			num ^= ArchType.GetHashCode();
		}
		if (CharacterId != 0)
		{
			num ^= CharacterId.GetHashCode();
		}
		if (UnlockAffinityLevel != 0)
		{
			num ^= UnlockAffinityLevel.GetHashCode();
		}
		if (RecordId != 0)
		{
			num ^= RecordId.GetHashCode();
		}
		if (Sort != 0)
		{
			num ^= Sort.GetHashCode();
		}
		if (ArchReward != 0)
		{
			num ^= ArchReward.GetHashCode();
		}
		if (ArchRewardQuantity != 0)
		{
			num ^= ArchRewardQuantity.GetHashCode();
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
		if (ArchType != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ArchType);
		}
		if (CharacterId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(CharacterId);
		}
		if (UnlockAffinityLevel != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(UnlockAffinityLevel);
		}
		if (RecordId != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(RecordId);
		}
		if (Sort != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Sort);
		}
		if (ArchReward != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(ArchReward);
		}
		if (ArchRewardQuantity != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(ArchRewardQuantity);
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
		if (ArchType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ArchType);
		}
		if (CharacterId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CharacterId);
		}
		if (UnlockAffinityLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UnlockAffinityLevel);
		}
		if (RecordId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RecordId);
		}
		if (Sort != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Sort);
		}
		if (ArchReward != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ArchReward);
		}
		if (ArchRewardQuantity != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ArchRewardQuantity);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CharacterArchive other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.ArchType != 0)
			{
				ArchType = other.ArchType;
			}
			if (other.CharacterId != 0)
			{
				CharacterId = other.CharacterId;
			}
			if (other.UnlockAffinityLevel != 0)
			{
				UnlockAffinityLevel = other.UnlockAffinityLevel;
			}
			if (other.RecordId != 0)
			{
				RecordId = other.RecordId;
			}
			if (other.Sort != 0)
			{
				Sort = other.Sort;
			}
			if (other.ArchReward != 0)
			{
				ArchReward = other.ArchReward;
			}
			if (other.ArchRewardQuantity != 0)
			{
				ArchRewardQuantity = other.ArchRewardQuantity;
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
				ArchType = input.ReadInt32();
				break;
			case 24u:
				CharacterId = input.ReadInt32();
				break;
			case 32u:
				UnlockAffinityLevel = input.ReadInt32();
				break;
			case 40u:
				RecordId = input.ReadInt32();
				break;
			case 48u:
				Sort = input.ReadInt32();
				break;
			case 56u:
				ArchReward = input.ReadInt32();
				break;
			case 64u:
				ArchRewardQuantity = input.ReadInt32();
				break;
			}
		}
	}
}
