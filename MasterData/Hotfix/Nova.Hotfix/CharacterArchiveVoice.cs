using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class CharacterArchiveVoice : IMessage<CharacterArchiveVoice>, IMessage, IEquatable<CharacterArchiveVoice>, IDeepCloneable<CharacterArchiveVoice>
{
	private static readonly MessageParser<CharacterArchiveVoice> _parser = new MessageParser<CharacterArchiveVoice>(() => new CharacterArchiveVoice());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int CharacterIdFieldNumber = 2;

	private int characterId_;

	public const int UnlockAffinityLevelFieldNumber = 3;

	private int unlockAffinityLevel_;

	public const int UnlockPlotFieldNumber = 4;

	private int unlockPlot_;

	public const int UnlockSkinIdFieldNumber = 5;

	private int unlockSkinId_;

	public const int TitleFieldNumber = 6;

	private string title_ = "";

	public const int SourceFieldNumber = 7;

	private string source_ = "";

	public const int ArchVoiceTypeFieldNumber = 8;

	private int archVoiceType_;

	public const int SortFieldNumber = 9;

	private int sort_;

	[DebuggerNonUserCode]
	public static MessageParser<CharacterArchiveVoice> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(160);

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
	public int UnlockPlot
	{
		get
		{
			return unlockPlot_;
		}
		set
		{
			unlockPlot_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int UnlockSkinId
	{
		get
		{
			return unlockSkinId_;
		}
		set
		{
			unlockSkinId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Title
	{
		get
		{
			return title_;
		}
		set
		{
			title_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Source
	{
		get
		{
			return source_;
		}
		set
		{
			source_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int ArchVoiceType
	{
		get
		{
			return archVoiceType_;
		}
		set
		{
			archVoiceType_ = value;
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
	public CharacterArchiveVoice()
	{
	}

	[DebuggerNonUserCode]
	public CharacterArchiveVoice(CharacterArchiveVoice other)
		: this()
	{
		id_ = other.id_;
		characterId_ = other.characterId_;
		unlockAffinityLevel_ = other.unlockAffinityLevel_;
		unlockPlot_ = other.unlockPlot_;
		unlockSkinId_ = other.unlockSkinId_;
		title_ = other.title_;
		source_ = other.source_;
		archVoiceType_ = other.archVoiceType_;
		sort_ = other.sort_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public CharacterArchiveVoice Clone()
	{
		return new CharacterArchiveVoice(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as CharacterArchiveVoice);
	}

	[DebuggerNonUserCode]
	public bool Equals(CharacterArchiveVoice other)
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
		if (CharacterId != other.CharacterId)
		{
			return false;
		}
		if (UnlockAffinityLevel != other.UnlockAffinityLevel)
		{
			return false;
		}
		if (UnlockPlot != other.UnlockPlot)
		{
			return false;
		}
		if (UnlockSkinId != other.UnlockSkinId)
		{
			return false;
		}
		if (Title != other.Title)
		{
			return false;
		}
		if (Source != other.Source)
		{
			return false;
		}
		if (ArchVoiceType != other.ArchVoiceType)
		{
			return false;
		}
		if (Sort != other.Sort)
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
		if (CharacterId != 0)
		{
			num ^= CharacterId.GetHashCode();
		}
		if (UnlockAffinityLevel != 0)
		{
			num ^= UnlockAffinityLevel.GetHashCode();
		}
		if (UnlockPlot != 0)
		{
			num ^= UnlockPlot.GetHashCode();
		}
		if (UnlockSkinId != 0)
		{
			num ^= UnlockSkinId.GetHashCode();
		}
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (Source.Length != 0)
		{
			num ^= Source.GetHashCode();
		}
		if (ArchVoiceType != 0)
		{
			num ^= ArchVoiceType.GetHashCode();
		}
		if (Sort != 0)
		{
			num ^= Sort.GetHashCode();
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
		if (CharacterId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(CharacterId);
		}
		if (UnlockAffinityLevel != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(UnlockAffinityLevel);
		}
		if (UnlockPlot != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(UnlockPlot);
		}
		if (UnlockSkinId != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(UnlockSkinId);
		}
		if (Title.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Title);
		}
		if (Source.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(Source);
		}
		if (ArchVoiceType != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(ArchVoiceType);
		}
		if (Sort != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Sort);
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
		if (CharacterId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CharacterId);
		}
		if (UnlockAffinityLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UnlockAffinityLevel);
		}
		if (UnlockPlot != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UnlockPlot);
		}
		if (UnlockSkinId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UnlockSkinId);
		}
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (Source.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Source);
		}
		if (ArchVoiceType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ArchVoiceType);
		}
		if (Sort != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Sort);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CharacterArchiveVoice other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.CharacterId != 0)
			{
				CharacterId = other.CharacterId;
			}
			if (other.UnlockAffinityLevel != 0)
			{
				UnlockAffinityLevel = other.UnlockAffinityLevel;
			}
			if (other.UnlockPlot != 0)
			{
				UnlockPlot = other.UnlockPlot;
			}
			if (other.UnlockSkinId != 0)
			{
				UnlockSkinId = other.UnlockSkinId;
			}
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.Source.Length != 0)
			{
				Source = other.Source;
			}
			if (other.ArchVoiceType != 0)
			{
				ArchVoiceType = other.ArchVoiceType;
			}
			if (other.Sort != 0)
			{
				Sort = other.Sort;
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
				CharacterId = input.ReadInt32();
				break;
			case 24u:
				UnlockAffinityLevel = input.ReadInt32();
				break;
			case 32u:
				UnlockPlot = input.ReadInt32();
				break;
			case 40u:
				UnlockSkinId = input.ReadInt32();
				break;
			case 50u:
				Title = input.ReadString();
				break;
			case 58u:
				Source = input.ReadString();
				break;
			case 64u:
				ArchVoiceType = input.ReadInt32();
				break;
			case 72u:
				Sort = input.ReadInt32();
				break;
			}
		}
	}
}
