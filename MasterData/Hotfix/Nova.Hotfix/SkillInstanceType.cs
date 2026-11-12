using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SkillInstanceType : IMessage<SkillInstanceType>, IMessage, IEquatable<SkillInstanceType>, IDeepCloneable<SkillInstanceType>
{
	private static readonly MessageParser<SkillInstanceType> _parser = new MessageParser<SkillInstanceType>(() => new SkillInstanceType());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int WorldClassLevelFieldNumber = 3;

	private int worldClassLevel_;

	public const int EpisodeFieldNumber = 4;

	private string episode_ = "";

	public const int SortFieldNumber = 5;

	private int sort_;

	public const int EETFieldNumber = 6;

	private static readonly FieldCodec<int> _repeated_eET_codec = FieldCodec.ForInt32(50u);

	private readonly RepeatedField<int> eET_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<SkillInstanceType> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(728);

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
	public string Name
	{
		get
		{
			return name_;
		}
		set
		{
			name_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int WorldClassLevel
	{
		get
		{
			return worldClassLevel_;
		}
		set
		{
			worldClassLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Episode
	{
		get
		{
			return episode_;
		}
		set
		{
			episode_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public RepeatedField<int> EET => eET_;

	[DebuggerNonUserCode]
	public SkillInstanceType()
	{
	}

	[DebuggerNonUserCode]
	public SkillInstanceType(SkillInstanceType other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		worldClassLevel_ = other.worldClassLevel_;
		episode_ = other.episode_;
		sort_ = other.sort_;
		eET_ = other.eET_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SkillInstanceType Clone()
	{
		return new SkillInstanceType(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SkillInstanceType);
	}

	[DebuggerNonUserCode]
	public bool Equals(SkillInstanceType other)
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
		if (Name != other.Name)
		{
			return false;
		}
		if (WorldClassLevel != other.WorldClassLevel)
		{
			return false;
		}
		if (Episode != other.Episode)
		{
			return false;
		}
		if (Sort != other.Sort)
		{
			return false;
		}
		if (!eET_.Equals(other.eET_))
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
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (WorldClassLevel != 0)
		{
			num ^= WorldClassLevel.GetHashCode();
		}
		if (Episode.Length != 0)
		{
			num ^= Episode.GetHashCode();
		}
		if (Sort != 0)
		{
			num ^= Sort.GetHashCode();
		}
		num ^= eET_.GetHashCode();
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
		if (Name.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Name);
		}
		if (WorldClassLevel != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(WorldClassLevel);
		}
		if (Episode.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Episode);
		}
		if (Sort != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Sort);
		}
		eET_.WriteTo(output, _repeated_eET_codec);
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
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (WorldClassLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WorldClassLevel);
		}
		if (Episode.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Episode);
		}
		if (Sort != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Sort);
		}
		num += eET_.CalculateSize(_repeated_eET_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SkillInstanceType other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.WorldClassLevel != 0)
			{
				WorldClassLevel = other.WorldClassLevel;
			}
			if (other.Episode.Length != 0)
			{
				Episode = other.Episode;
			}
			if (other.Sort != 0)
			{
				Sort = other.Sort;
			}
			eET_.Add(other.eET_);
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
			case 18u:
				Name = input.ReadString();
				break;
			case 24u:
				WorldClassLevel = input.ReadInt32();
				break;
			case 34u:
				Episode = input.ReadString();
				break;
			case 40u:
				Sort = input.ReadInt32();
				break;
			case 48u:
			case 50u:
				eET_.AddEntriesFrom(input, _repeated_eET_codec);
				break;
			}
		}
	}
}
