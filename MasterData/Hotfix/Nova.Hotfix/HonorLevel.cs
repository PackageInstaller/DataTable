using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class HonorLevel : IMessage<HonorLevel>, IMessage, IEquatable<HonorLevel>, IDeepCloneable<HonorLevel>
{
	private static readonly MessageParser<HonorLevel> _parser = new MessageParser<HonorLevel>(() => new HonorLevel());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupIdFieldNumber = 2;

	private int groupId_;

	public const int LevelFieldNumber = 3;

	private int level_;

	public const int BigBgPathFieldNumber = 4;

	private string bigBgPath_ = "";

	public const int SmallBgPathFieldNumber = 5;

	private string smallBgPath_ = "";

	public const int StarGroupFieldNumber = 6;

	private static readonly FieldCodec<int> _repeated_starGroup_codec = FieldCodec.ForInt32(50u);

	private readonly RepeatedField<int> starGroup_ = new RepeatedField<int>();

	public const int SortFieldNumber = 7;

	private int sort_;

	public const int BGTypeFieldNumber = 8;

	private int bGType_;

	[DebuggerNonUserCode]
	public static MessageParser<HonorLevel> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(428);

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
	public int Level
	{
		get
		{
			return level_;
		}
		set
		{
			level_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string BigBgPath
	{
		get
		{
			return bigBgPath_;
		}
		set
		{
			bigBgPath_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string SmallBgPath
	{
		get
		{
			return smallBgPath_;
		}
		set
		{
			smallBgPath_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> StarGroup => starGroup_;

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
	public int BGType
	{
		get
		{
			return bGType_;
		}
		set
		{
			bGType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public HonorLevel()
	{
	}

	[DebuggerNonUserCode]
	public HonorLevel(HonorLevel other)
		: this()
	{
		id_ = other.id_;
		groupId_ = other.groupId_;
		level_ = other.level_;
		bigBgPath_ = other.bigBgPath_;
		smallBgPath_ = other.smallBgPath_;
		starGroup_ = other.starGroup_.Clone();
		sort_ = other.sort_;
		bGType_ = other.bGType_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public HonorLevel Clone()
	{
		return new HonorLevel(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as HonorLevel);
	}

	[DebuggerNonUserCode]
	public bool Equals(HonorLevel other)
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
		if (Level != other.Level)
		{
			return false;
		}
		if (BigBgPath != other.BigBgPath)
		{
			return false;
		}
		if (SmallBgPath != other.SmallBgPath)
		{
			return false;
		}
		if (!starGroup_.Equals(other.starGroup_))
		{
			return false;
		}
		if (Sort != other.Sort)
		{
			return false;
		}
		if (BGType != other.BGType)
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
		if (Level != 0)
		{
			num ^= Level.GetHashCode();
		}
		if (BigBgPath.Length != 0)
		{
			num ^= BigBgPath.GetHashCode();
		}
		if (SmallBgPath.Length != 0)
		{
			num ^= SmallBgPath.GetHashCode();
		}
		num ^= starGroup_.GetHashCode();
		if (Sort != 0)
		{
			num ^= Sort.GetHashCode();
		}
		if (BGType != 0)
		{
			num ^= BGType.GetHashCode();
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
		if (Level != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Level);
		}
		if (BigBgPath.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(BigBgPath);
		}
		if (SmallBgPath.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(SmallBgPath);
		}
		starGroup_.WriteTo(output, _repeated_starGroup_codec);
		if (Sort != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Sort);
		}
		if (BGType != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(BGType);
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
		if (Level != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Level);
		}
		if (BigBgPath.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BigBgPath);
		}
		if (SmallBgPath.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SmallBgPath);
		}
		num += starGroup_.CalculateSize(_repeated_starGroup_codec);
		if (Sort != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Sort);
		}
		if (BGType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BGType);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(HonorLevel other)
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
			if (other.Level != 0)
			{
				Level = other.Level;
			}
			if (other.BigBgPath.Length != 0)
			{
				BigBgPath = other.BigBgPath;
			}
			if (other.SmallBgPath.Length != 0)
			{
				SmallBgPath = other.SmallBgPath;
			}
			starGroup_.Add(other.starGroup_);
			if (other.Sort != 0)
			{
				Sort = other.Sort;
			}
			if (other.BGType != 0)
			{
				BGType = other.BGType;
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
				Level = input.ReadInt32();
				break;
			case 34u:
				BigBgPath = input.ReadString();
				break;
			case 42u:
				SmallBgPath = input.ReadString();
				break;
			case 48u:
			case 50u:
				starGroup_.AddEntriesFrom(input, _repeated_starGroup_codec);
				break;
			case 56u:
				Sort = input.ReadInt32();
				break;
			case 64u:
				BGType = input.ReadInt32();
				break;
			}
		}
	}
}
