using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SoldierStoryType : IMessage<SoldierStoryType>, IMessage, IEquatable<SoldierStoryType>, IDeepCloneable<SoldierStoryType>
{
	private static readonly MessageParser<SoldierStoryType> _parser = new MessageParser<SoldierStoryType>(() => new SoldierStoryType());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int StoryTypeFieldNumber = 2;

	private int storyType_;

	public const int TitleFieldNumber = 3;

	private string title_ = "";

	public const int DescFieldNumber = 4;

	private string desc_ = "";

	public const int OptionTitleDesc1FieldNumber = 5;

	private string optionTitleDesc1_ = "";

	public const int NPCIdFieldNumber = 6;

	private int nPCId_;

	public const int AVGBgFieldNumber = 7;

	private string aVGBg_ = "";

	public const int AvgElementFieldNumber = 8;

	private string avgElement_ = "";

	public const int IsBossCGFieldNumber = 9;

	private bool isBossCG_;

	public const int BossCGFieldNumber = 10;

	private string bossCG_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<SoldierStoryType> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(806);

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
	public int StoryType
	{
		get
		{
			return storyType_;
		}
		set
		{
			storyType_ = value;
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
	public string OptionTitleDesc1
	{
		get
		{
			return optionTitleDesc1_;
		}
		set
		{
			optionTitleDesc1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int NPCId
	{
		get
		{
			return nPCId_;
		}
		set
		{
			nPCId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string AVGBg
	{
		get
		{
			return aVGBg_;
		}
		set
		{
			aVGBg_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string AvgElement
	{
		get
		{
			return avgElement_;
		}
		set
		{
			avgElement_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public bool IsBossCG
	{
		get
		{
			return isBossCG_;
		}
		set
		{
			isBossCG_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string BossCG
	{
		get
		{
			return bossCG_;
		}
		set
		{
			bossCG_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public SoldierStoryType()
	{
	}

	[DebuggerNonUserCode]
	public SoldierStoryType(SoldierStoryType other)
		: this()
	{
		id_ = other.id_;
		storyType_ = other.storyType_;
		title_ = other.title_;
		desc_ = other.desc_;
		optionTitleDesc1_ = other.optionTitleDesc1_;
		nPCId_ = other.nPCId_;
		aVGBg_ = other.aVGBg_;
		avgElement_ = other.avgElement_;
		isBossCG_ = other.isBossCG_;
		bossCG_ = other.bossCG_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SoldierStoryType Clone()
	{
		return new SoldierStoryType(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SoldierStoryType);
	}

	[DebuggerNonUserCode]
	public bool Equals(SoldierStoryType other)
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
		if (StoryType != other.StoryType)
		{
			return false;
		}
		if (Title != other.Title)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (OptionTitleDesc1 != other.OptionTitleDesc1)
		{
			return false;
		}
		if (NPCId != other.NPCId)
		{
			return false;
		}
		if (AVGBg != other.AVGBg)
		{
			return false;
		}
		if (AvgElement != other.AvgElement)
		{
			return false;
		}
		if (IsBossCG != other.IsBossCG)
		{
			return false;
		}
		if (BossCG != other.BossCG)
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
		if (StoryType != 0)
		{
			num ^= StoryType.GetHashCode();
		}
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (OptionTitleDesc1.Length != 0)
		{
			num ^= OptionTitleDesc1.GetHashCode();
		}
		if (NPCId != 0)
		{
			num ^= NPCId.GetHashCode();
		}
		if (AVGBg.Length != 0)
		{
			num ^= AVGBg.GetHashCode();
		}
		if (AvgElement.Length != 0)
		{
			num ^= AvgElement.GetHashCode();
		}
		if (IsBossCG)
		{
			num ^= IsBossCG.GetHashCode();
		}
		if (BossCG.Length != 0)
		{
			num ^= BossCG.GetHashCode();
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
		if (StoryType != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(StoryType);
		}
		if (Title.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Title);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Desc);
		}
		if (OptionTitleDesc1.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(OptionTitleDesc1);
		}
		if (NPCId != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(NPCId);
		}
		if (AVGBg.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(AVGBg);
		}
		if (AvgElement.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(AvgElement);
		}
		if (IsBossCG)
		{
			output.WriteRawTag(72);
			output.WriteBool(IsBossCG);
		}
		if (BossCG.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(BossCG);
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
		if (StoryType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StoryType);
		}
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (OptionTitleDesc1.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(OptionTitleDesc1);
		}
		if (NPCId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(NPCId);
		}
		if (AVGBg.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AVGBg);
		}
		if (AvgElement.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AvgElement);
		}
		if (IsBossCG)
		{
			num += 2;
		}
		if (BossCG.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BossCG);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SoldierStoryType other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.StoryType != 0)
			{
				StoryType = other.StoryType;
			}
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.OptionTitleDesc1.Length != 0)
			{
				OptionTitleDesc1 = other.OptionTitleDesc1;
			}
			if (other.NPCId != 0)
			{
				NPCId = other.NPCId;
			}
			if (other.AVGBg.Length != 0)
			{
				AVGBg = other.AVGBg;
			}
			if (other.AvgElement.Length != 0)
			{
				AvgElement = other.AvgElement;
			}
			if (other.IsBossCG)
			{
				IsBossCG = other.IsBossCG;
			}
			if (other.BossCG.Length != 0)
			{
				BossCG = other.BossCG;
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
				StoryType = input.ReadInt32();
				break;
			case 26u:
				Title = input.ReadString();
				break;
			case 34u:
				Desc = input.ReadString();
				break;
			case 42u:
				OptionTitleDesc1 = input.ReadString();
				break;
			case 48u:
				NPCId = input.ReadInt32();
				break;
			case 58u:
				AVGBg = input.ReadString();
				break;
			case 66u:
				AvgElement = input.ReadString();
				break;
			case 72u:
				IsBossCG = input.ReadBool();
				break;
			case 82u:
				BossCG = input.ReadString();
				break;
			}
		}
	}
}
