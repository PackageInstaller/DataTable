using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StorySetChapter : IMessage<StorySetChapter>, IMessage, IEquatable<StorySetChapter>, IDeepCloneable<StorySetChapter>
{
	private static readonly MessageParser<StorySetChapter> _parser = new MessageParser<StorySetChapter>(() => new StorySetChapter());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int OpenTimeFieldNumber = 2;

	private string openTime_ = "";

	public const int OpenCondTypeFieldNumber = 3;

	private int openCondType_;

	public const int OpenCondParamsFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_openCondParams_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> openCondParams_ = new RepeatedField<int>();

	public const int TitleFieldNumber = 5;

	private string title_ = "";

	public const int NameFieldNumber = 6;

	private string name_ = "";

	public const int LockTextFieldNumber = 7;

	private string lockText_ = "";

	public const int IsShowFieldNumber = 8;

	private bool isShow_;

	public const int IsHighLightFieldNumber = 9;

	private bool isHighLight_;

	public const int IconFieldNumber = 10;

	private string icon_ = "";

	public const int ImageFieldNumber = 11;

	private string image_ = "";

	public const int BgFieldNumber = 12;

	private string bg_ = "";

	public const int BannerFieldNumber = 13;

	private string banner_ = "";

	public const int TabIdFieldNumber = 14;

	private int tabId_;

	[DebuggerNonUserCode]
	public static MessageParser<StorySetChapter> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(904);

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
	public string OpenTime
	{
		get
		{
			return openTime_;
		}
		set
		{
			openTime_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int OpenCondType
	{
		get
		{
			return openCondType_;
		}
		set
		{
			openCondType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> OpenCondParams => openCondParams_;

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
	public string LockText
	{
		get
		{
			return lockText_;
		}
		set
		{
			lockText_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public bool IsShow
	{
		get
		{
			return isShow_;
		}
		set
		{
			isShow_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsHighLight
	{
		get
		{
			return isHighLight_;
		}
		set
		{
			isHighLight_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Icon
	{
		get
		{
			return icon_;
		}
		set
		{
			icon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Image
	{
		get
		{
			return image_;
		}
		set
		{
			image_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Bg
	{
		get
		{
			return bg_;
		}
		set
		{
			bg_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Banner
	{
		get
		{
			return banner_;
		}
		set
		{
			banner_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int TabId
	{
		get
		{
			return tabId_;
		}
		set
		{
			tabId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public StorySetChapter()
	{
	}

	[DebuggerNonUserCode]
	public StorySetChapter(StorySetChapter other)
		: this()
	{
		id_ = other.id_;
		openTime_ = other.openTime_;
		openCondType_ = other.openCondType_;
		openCondParams_ = other.openCondParams_.Clone();
		title_ = other.title_;
		name_ = other.name_;
		lockText_ = other.lockText_;
		isShow_ = other.isShow_;
		isHighLight_ = other.isHighLight_;
		icon_ = other.icon_;
		image_ = other.image_;
		bg_ = other.bg_;
		banner_ = other.banner_;
		tabId_ = other.tabId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StorySetChapter Clone()
	{
		return new StorySetChapter(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StorySetChapter);
	}

	[DebuggerNonUserCode]
	public bool Equals(StorySetChapter other)
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
		if (OpenTime != other.OpenTime)
		{
			return false;
		}
		if (OpenCondType != other.OpenCondType)
		{
			return false;
		}
		if (!openCondParams_.Equals(other.openCondParams_))
		{
			return false;
		}
		if (Title != other.Title)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (LockText != other.LockText)
		{
			return false;
		}
		if (IsShow != other.IsShow)
		{
			return false;
		}
		if (IsHighLight != other.IsHighLight)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (Image != other.Image)
		{
			return false;
		}
		if (Bg != other.Bg)
		{
			return false;
		}
		if (Banner != other.Banner)
		{
			return false;
		}
		if (TabId != other.TabId)
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
		if (OpenTime.Length != 0)
		{
			num ^= OpenTime.GetHashCode();
		}
		if (OpenCondType != 0)
		{
			num ^= OpenCondType.GetHashCode();
		}
		num ^= openCondParams_.GetHashCode();
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (LockText.Length != 0)
		{
			num ^= LockText.GetHashCode();
		}
		if (IsShow)
		{
			num ^= IsShow.GetHashCode();
		}
		if (IsHighLight)
		{
			num ^= IsHighLight.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (Image.Length != 0)
		{
			num ^= Image.GetHashCode();
		}
		if (Bg.Length != 0)
		{
			num ^= Bg.GetHashCode();
		}
		if (Banner.Length != 0)
		{
			num ^= Banner.GetHashCode();
		}
		if (TabId != 0)
		{
			num ^= TabId.GetHashCode();
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
		if (OpenTime.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(OpenTime);
		}
		if (OpenCondType != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(OpenCondType);
		}
		openCondParams_.WriteTo(output, _repeated_openCondParams_codec);
		if (Title.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Title);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Name);
		}
		if (LockText.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(LockText);
		}
		if (IsShow)
		{
			output.WriteRawTag(64);
			output.WriteBool(IsShow);
		}
		if (IsHighLight)
		{
			output.WriteRawTag(72);
			output.WriteBool(IsHighLight);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(Icon);
		}
		if (Image.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(Image);
		}
		if (Bg.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(Bg);
		}
		if (Banner.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(Banner);
		}
		if (TabId != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(TabId);
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
		if (OpenTime.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(OpenTime);
		}
		if (OpenCondType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(OpenCondType);
		}
		num += openCondParams_.CalculateSize(_repeated_openCondParams_codec);
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (LockText.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(LockText);
		}
		if (IsShow)
		{
			num += 2;
		}
		if (IsHighLight)
		{
			num += 2;
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (Image.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Image);
		}
		if (Bg.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Bg);
		}
		if (Banner.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Banner);
		}
		if (TabId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TabId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(StorySetChapter other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.OpenTime.Length != 0)
			{
				OpenTime = other.OpenTime;
			}
			if (other.OpenCondType != 0)
			{
				OpenCondType = other.OpenCondType;
			}
			openCondParams_.Add(other.openCondParams_);
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.LockText.Length != 0)
			{
				LockText = other.LockText;
			}
			if (other.IsShow)
			{
				IsShow = other.IsShow;
			}
			if (other.IsHighLight)
			{
				IsHighLight = other.IsHighLight;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.Image.Length != 0)
			{
				Image = other.Image;
			}
			if (other.Bg.Length != 0)
			{
				Bg = other.Bg;
			}
			if (other.Banner.Length != 0)
			{
				Banner = other.Banner;
			}
			if (other.TabId != 0)
			{
				TabId = other.TabId;
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
				OpenTime = input.ReadString();
				break;
			case 24u:
				OpenCondType = input.ReadInt32();
				break;
			case 32u:
			case 34u:
				openCondParams_.AddEntriesFrom(input, _repeated_openCondParams_codec);
				break;
			case 42u:
				Title = input.ReadString();
				break;
			case 50u:
				Name = input.ReadString();
				break;
			case 58u:
				LockText = input.ReadString();
				break;
			case 64u:
				IsShow = input.ReadBool();
				break;
			case 72u:
				IsHighLight = input.ReadBool();
				break;
			case 82u:
				Icon = input.ReadString();
				break;
			case 90u:
				Image = input.ReadString();
				break;
			case 98u:
				Bg = input.ReadString();
				break;
			case 106u:
				Banner = input.ReadString();
				break;
			case 112u:
				TabId = input.ReadInt32();
				break;
			}
		}
	}
}
