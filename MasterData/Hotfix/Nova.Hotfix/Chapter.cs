using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class Chapter : IMessage<Chapter>, IMessage, IEquatable<Chapter>, IDeepCloneable<Chapter>
{
	private static readonly MessageParser<Chapter> _parser = new MessageParser<Chapter>(() => new Chapter());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int DescFieldNumber = 3;

	private string desc_ = "";

	public const int ChapterTypeFieldNumber = 4;

	private int chapterType_;

	public const int WorldClassFieldNumber = 5;

	private int worldClass_;

	public const int PrevMainlinesFieldNumber = 6;

	private static readonly FieldCodec<int> _repeated_prevMainlines_codec = FieldCodec.ForInt32(50u);

	private readonly RepeatedField<int> prevMainlines_ = new RepeatedField<int>();

	public const int CompleteRewardsFieldNumber = 7;

	private string completeRewards_ = "";

	public const int ChapterImgFieldNumber = 8;

	private string chapterImg_ = "";

	public const int ChapterIconFieldNumber = 9;

	private string chapterIcon_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<Chapter> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(148);

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
	public string Desc
	{
		get
		{
			return desc_;
		}
		set
		{
			desc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int ChapterType
	{
		get
		{
			return chapterType_;
		}
		set
		{
			chapterType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int WorldClass
	{
		get
		{
			return worldClass_;
		}
		set
		{
			worldClass_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> PrevMainlines => prevMainlines_;

	[DebuggerNonUserCode]
	public string CompleteRewards
	{
		get
		{
			return completeRewards_;
		}
		set
		{
			completeRewards_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string ChapterImg
	{
		get
		{
			return chapterImg_;
		}
		set
		{
			chapterImg_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string ChapterIcon
	{
		get
		{
			return chapterIcon_;
		}
		set
		{
			chapterIcon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public Chapter()
	{
	}

	[DebuggerNonUserCode]
	public Chapter(Chapter other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		desc_ = other.desc_;
		chapterType_ = other.chapterType_;
		worldClass_ = other.worldClass_;
		prevMainlines_ = other.prevMainlines_.Clone();
		completeRewards_ = other.completeRewards_;
		chapterImg_ = other.chapterImg_;
		chapterIcon_ = other.chapterIcon_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public Chapter Clone()
	{
		return new Chapter(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Chapter);
	}

	[DebuggerNonUserCode]
	public bool Equals(Chapter other)
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
		if (Desc != other.Desc)
		{
			return false;
		}
		if (ChapterType != other.ChapterType)
		{
			return false;
		}
		if (WorldClass != other.WorldClass)
		{
			return false;
		}
		if (!prevMainlines_.Equals(other.prevMainlines_))
		{
			return false;
		}
		if (CompleteRewards != other.CompleteRewards)
		{
			return false;
		}
		if (ChapterImg != other.ChapterImg)
		{
			return false;
		}
		if (ChapterIcon != other.ChapterIcon)
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
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (ChapterType != 0)
		{
			num ^= ChapterType.GetHashCode();
		}
		if (WorldClass != 0)
		{
			num ^= WorldClass.GetHashCode();
		}
		num ^= prevMainlines_.GetHashCode();
		if (CompleteRewards.Length != 0)
		{
			num ^= CompleteRewards.GetHashCode();
		}
		if (ChapterImg.Length != 0)
		{
			num ^= ChapterImg.GetHashCode();
		}
		if (ChapterIcon.Length != 0)
		{
			num ^= ChapterIcon.GetHashCode();
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
		if (Name.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Name);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Desc);
		}
		if (ChapterType != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(ChapterType);
		}
		if (WorldClass != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(WorldClass);
		}
		prevMainlines_.WriteTo(output, _repeated_prevMainlines_codec);
		if (CompleteRewards.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(CompleteRewards);
		}
		if (ChapterImg.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(ChapterImg);
		}
		if (ChapterIcon.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(ChapterIcon);
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
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (ChapterType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ChapterType);
		}
		if (WorldClass != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WorldClass);
		}
		num += prevMainlines_.CalculateSize(_repeated_prevMainlines_codec);
		if (CompleteRewards.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CompleteRewards);
		}
		if (ChapterImg.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ChapterImg);
		}
		if (ChapterIcon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ChapterIcon);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Chapter other)
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
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.ChapterType != 0)
			{
				ChapterType = other.ChapterType;
			}
			if (other.WorldClass != 0)
			{
				WorldClass = other.WorldClass;
			}
			prevMainlines_.Add(other.prevMainlines_);
			if (other.CompleteRewards.Length != 0)
			{
				CompleteRewards = other.CompleteRewards;
			}
			if (other.ChapterImg.Length != 0)
			{
				ChapterImg = other.ChapterImg;
			}
			if (other.ChapterIcon.Length != 0)
			{
				ChapterIcon = other.ChapterIcon;
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
			case 18u:
				Name = input.ReadString();
				break;
			case 26u:
				Desc = input.ReadString();
				break;
			case 32u:
				ChapterType = input.ReadInt32();
				break;
			case 40u:
				WorldClass = input.ReadInt32();
				break;
			case 48u:
			case 50u:
				prevMainlines_.AddEntriesFrom(input, _repeated_prevMainlines_codec);
				break;
			case 58u:
				CompleteRewards = input.ReadString();
				break;
			case 66u:
				ChapterImg = input.ReadString();
				break;
			case 74u:
				ChapterIcon = input.ReadString();
				break;
			}
		}
	}
}
