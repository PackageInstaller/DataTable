using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class NPCSkin : IMessage<NPCSkin>, IMessage, IEquatable<NPCSkin>, IDeepCloneable<NPCSkin>
{
	private static readonly MessageParser<NPCSkin> _parser = new MessageParser<NPCSkin>(() => new NPCSkin());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int DescFieldNumber = 3;

	private string desc_ = "";

	public const int IsShowFieldNumber = 4;

	private bool isShow_;

	public const int CharIdFieldNumber = 5;

	private int charId_;

	public const int TypeFieldNumber = 6;

	private int type_;

	public const int SourceDescFieldNumber = 7;

	private int sourceDesc_;

	public const int IconFieldNumber = 8;

	private string icon_ = "";

	public const int SmallPortraitFieldNumber = 9;

	private string smallPortrait_ = "";

	public const int ModelScaleFieldNumber = 10;

	private int modelScale_;

	public const int ModelFieldNumber = 11;

	private string model_ = "";

	public const int PortraitFieldNumber = 12;

	private string portrait_ = "";

	public const int BgFieldNumber = 13;

	private string bg_ = "";

	public const int OffsetFieldNumber = 14;

	private string offset_ = "";

	public const int L2DFieldNumber = 15;

	private string l2D_ = "";

	public const int FullScreenPortraitFieldNumber = 16;

	private string fullScreenPortrait_ = "";

	public const int SkinThemeFieldNumber = 17;

	private int skinTheme_;

	public const int InteractiveActionFieldNumber = 18;

	private bool interactiveAction_;

	public const int InteractiveActionIdFieldNumber = 19;

	private int interactiveActionId_;

	[DebuggerNonUserCode]
	public static MessageParser<NPCSkin> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(602);

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
	public int CharId
	{
		get
		{
			return charId_;
		}
		set
		{
			charId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Type
	{
		get
		{
			return type_;
		}
		set
		{
			type_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SourceDesc
	{
		get
		{
			return sourceDesc_;
		}
		set
		{
			sourceDesc_ = value;
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
	public string SmallPortrait
	{
		get
		{
			return smallPortrait_;
		}
		set
		{
			smallPortrait_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int ModelScale
	{
		get
		{
			return modelScale_;
		}
		set
		{
			modelScale_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Model
	{
		get
		{
			return model_;
		}
		set
		{
			model_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Portrait
	{
		get
		{
			return portrait_;
		}
		set
		{
			portrait_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public string Offset
	{
		get
		{
			return offset_;
		}
		set
		{
			offset_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string L2D
	{
		get
		{
			return l2D_;
		}
		set
		{
			l2D_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string FullScreenPortrait
	{
		get
		{
			return fullScreenPortrait_;
		}
		set
		{
			fullScreenPortrait_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int SkinTheme
	{
		get
		{
			return skinTheme_;
		}
		set
		{
			skinTheme_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool InteractiveAction
	{
		get
		{
			return interactiveAction_;
		}
		set
		{
			interactiveAction_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int InteractiveActionId
	{
		get
		{
			return interactiveActionId_;
		}
		set
		{
			interactiveActionId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public NPCSkin()
	{
	}

	[DebuggerNonUserCode]
	public NPCSkin(NPCSkin other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		desc_ = other.desc_;
		isShow_ = other.isShow_;
		charId_ = other.charId_;
		type_ = other.type_;
		sourceDesc_ = other.sourceDesc_;
		icon_ = other.icon_;
		smallPortrait_ = other.smallPortrait_;
		modelScale_ = other.modelScale_;
		model_ = other.model_;
		portrait_ = other.portrait_;
		bg_ = other.bg_;
		offset_ = other.offset_;
		l2D_ = other.l2D_;
		fullScreenPortrait_ = other.fullScreenPortrait_;
		skinTheme_ = other.skinTheme_;
		interactiveAction_ = other.interactiveAction_;
		interactiveActionId_ = other.interactiveActionId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public NPCSkin Clone()
	{
		return new NPCSkin(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as NPCSkin);
	}

	[DebuggerNonUserCode]
	public bool Equals(NPCSkin other)
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
		if (IsShow != other.IsShow)
		{
			return false;
		}
		if (CharId != other.CharId)
		{
			return false;
		}
		if (Type != other.Type)
		{
			return false;
		}
		if (SourceDesc != other.SourceDesc)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (SmallPortrait != other.SmallPortrait)
		{
			return false;
		}
		if (ModelScale != other.ModelScale)
		{
			return false;
		}
		if (Model != other.Model)
		{
			return false;
		}
		if (Portrait != other.Portrait)
		{
			return false;
		}
		if (Bg != other.Bg)
		{
			return false;
		}
		if (Offset != other.Offset)
		{
			return false;
		}
		if (L2D != other.L2D)
		{
			return false;
		}
		if (FullScreenPortrait != other.FullScreenPortrait)
		{
			return false;
		}
		if (SkinTheme != other.SkinTheme)
		{
			return false;
		}
		if (InteractiveAction != other.InteractiveAction)
		{
			return false;
		}
		if (InteractiveActionId != other.InteractiveActionId)
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
		if (IsShow)
		{
			num ^= IsShow.GetHashCode();
		}
		if (CharId != 0)
		{
			num ^= CharId.GetHashCode();
		}
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (SourceDesc != 0)
		{
			num ^= SourceDesc.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (SmallPortrait.Length != 0)
		{
			num ^= SmallPortrait.GetHashCode();
		}
		if (ModelScale != 0)
		{
			num ^= ModelScale.GetHashCode();
		}
		if (Model.Length != 0)
		{
			num ^= Model.GetHashCode();
		}
		if (Portrait.Length != 0)
		{
			num ^= Portrait.GetHashCode();
		}
		if (Bg.Length != 0)
		{
			num ^= Bg.GetHashCode();
		}
		if (Offset.Length != 0)
		{
			num ^= Offset.GetHashCode();
		}
		if (L2D.Length != 0)
		{
			num ^= L2D.GetHashCode();
		}
		if (FullScreenPortrait.Length != 0)
		{
			num ^= FullScreenPortrait.GetHashCode();
		}
		if (SkinTheme != 0)
		{
			num ^= SkinTheme.GetHashCode();
		}
		if (InteractiveAction)
		{
			num ^= InteractiveAction.GetHashCode();
		}
		if (InteractiveActionId != 0)
		{
			num ^= InteractiveActionId.GetHashCode();
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
		if (IsShow)
		{
			output.WriteRawTag(32);
			output.WriteBool(IsShow);
		}
		if (CharId != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(CharId);
		}
		if (Type != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Type);
		}
		if (SourceDesc != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(SourceDesc);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(Icon);
		}
		if (SmallPortrait.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(SmallPortrait);
		}
		if (ModelScale != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(ModelScale);
		}
		if (Model.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(Model);
		}
		if (Portrait.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(Portrait);
		}
		if (Bg.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(Bg);
		}
		if (Offset.Length != 0)
		{
			output.WriteRawTag(114);
			output.WriteString(Offset);
		}
		if (L2D.Length != 0)
		{
			output.WriteRawTag(122);
			output.WriteString(L2D);
		}
		if (FullScreenPortrait.Length != 0)
		{
			output.WriteRawTag(130, 1);
			output.WriteString(FullScreenPortrait);
		}
		if (SkinTheme != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(SkinTheme);
		}
		if (InteractiveAction)
		{
			output.WriteRawTag(144, 1);
			output.WriteBool(InteractiveAction);
		}
		if (InteractiveActionId != 0)
		{
			output.WriteRawTag(152, 1);
			output.WriteInt32(InteractiveActionId);
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
		if (IsShow)
		{
			num += 2;
		}
		if (CharId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CharId);
		}
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (SourceDesc != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SourceDesc);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (SmallPortrait.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SmallPortrait);
		}
		if (ModelScale != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ModelScale);
		}
		if (Model.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Model);
		}
		if (Portrait.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Portrait);
		}
		if (Bg.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Bg);
		}
		if (Offset.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Offset);
		}
		if (L2D.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(L2D);
		}
		if (FullScreenPortrait.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(FullScreenPortrait);
		}
		if (SkinTheme != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SkinTheme);
		}
		if (InteractiveAction)
		{
			num += 3;
		}
		if (InteractiveActionId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(InteractiveActionId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(NPCSkin other)
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
			if (other.IsShow)
			{
				IsShow = other.IsShow;
			}
			if (other.CharId != 0)
			{
				CharId = other.CharId;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.SourceDesc != 0)
			{
				SourceDesc = other.SourceDesc;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.SmallPortrait.Length != 0)
			{
				SmallPortrait = other.SmallPortrait;
			}
			if (other.ModelScale != 0)
			{
				ModelScale = other.ModelScale;
			}
			if (other.Model.Length != 0)
			{
				Model = other.Model;
			}
			if (other.Portrait.Length != 0)
			{
				Portrait = other.Portrait;
			}
			if (other.Bg.Length != 0)
			{
				Bg = other.Bg;
			}
			if (other.Offset.Length != 0)
			{
				Offset = other.Offset;
			}
			if (other.L2D.Length != 0)
			{
				L2D = other.L2D;
			}
			if (other.FullScreenPortrait.Length != 0)
			{
				FullScreenPortrait = other.FullScreenPortrait;
			}
			if (other.SkinTheme != 0)
			{
				SkinTheme = other.SkinTheme;
			}
			if (other.InteractiveAction)
			{
				InteractiveAction = other.InteractiveAction;
			}
			if (other.InteractiveActionId != 0)
			{
				InteractiveActionId = other.InteractiveActionId;
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
				IsShow = input.ReadBool();
				break;
			case 40u:
				CharId = input.ReadInt32();
				break;
			case 48u:
				Type = input.ReadInt32();
				break;
			case 56u:
				SourceDesc = input.ReadInt32();
				break;
			case 66u:
				Icon = input.ReadString();
				break;
			case 74u:
				SmallPortrait = input.ReadString();
				break;
			case 80u:
				ModelScale = input.ReadInt32();
				break;
			case 90u:
				Model = input.ReadString();
				break;
			case 98u:
				Portrait = input.ReadString();
				break;
			case 106u:
				Bg = input.ReadString();
				break;
			case 114u:
				Offset = input.ReadString();
				break;
			case 122u:
				L2D = input.ReadString();
				break;
			case 130u:
				FullScreenPortrait = input.ReadString();
				break;
			case 136u:
				SkinTheme = input.ReadInt32();
				break;
			case 144u:
				InteractiveAction = input.ReadBool();
				break;
			case 152u:
				InteractiveActionId = input.ReadInt32();
				break;
			}
		}
	}
}
