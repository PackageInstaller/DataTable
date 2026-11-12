using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class NPCConfig : IMessage<NPCConfig>, IMessage, IEquatable<NPCConfig>, IDeepCloneable<NPCConfig>
{
	private static readonly MessageParser<NPCConfig> _parser = new MessageParser<NPCConfig>(() => new NPCConfig());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TypeFieldNumber = 2;

	private int type_;

	public const int HintIconFieldNumber = 3;

	private string hintIcon_ = "";

	public const int NameFieldNumber = 4;

	private string name_ = "";

	public const int DescFieldNumber = 5;

	private string desc_ = "";

	public const int LiteraryFieldNumber = 6;

	private string literary_ = "";

	public const int RefreshPointFieldNumber = 7;

	private int refreshPoint_;

	public const int FirstLinesFieldNumber = 8;

	private static readonly FieldCodec<int> _repeated_firstLines_codec = FieldCodec.ForInt32(66u);

	private readonly RepeatedField<int> firstLines_ = new RepeatedField<int>();

	public const int LinesFieldNumber = 9;

	private static readonly FieldCodec<int> _repeated_lines_codec = FieldCodec.ForInt32(74u);

	private readonly RepeatedField<int> lines_ = new RepeatedField<int>();

	public const int ChatFieldNumber = 10;

	private static readonly FieldCodec<int> _repeated_chat_codec = FieldCodec.ForInt32(82u);

	private readonly RepeatedField<int> chat_ = new RepeatedField<int>();

	public const int ChatPropFieldNumber = 11;

	private int chatProp_;

	public const int ChatTimeFieldNumber = 12;

	private int chatTime_;

	public const int NPCIdFieldNumber = 13;

	private int nPCId_;

	public const int AffinityValueFieldNumber = 14;

	private string affinityValue_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<NPCConfig> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(600);

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
	public string HintIcon
	{
		get
		{
			return hintIcon_;
		}
		set
		{
			hintIcon_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public string Literary
	{
		get
		{
			return literary_;
		}
		set
		{
			literary_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int RefreshPoint
	{
		get
		{
			return refreshPoint_;
		}
		set
		{
			refreshPoint_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> FirstLines => firstLines_;

	[DebuggerNonUserCode]
	public RepeatedField<int> Lines => lines_;

	[DebuggerNonUserCode]
	public RepeatedField<int> Chat => chat_;

	[DebuggerNonUserCode]
	public int ChatProp
	{
		get
		{
			return chatProp_;
		}
		set
		{
			chatProp_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ChatTime
	{
		get
		{
			return chatTime_;
		}
		set
		{
			chatTime_ = value;
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
	public string AffinityValue
	{
		get
		{
			return affinityValue_;
		}
		set
		{
			affinityValue_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public NPCConfig()
	{
	}

	[DebuggerNonUserCode]
	public NPCConfig(NPCConfig other)
		: this()
	{
		id_ = other.id_;
		type_ = other.type_;
		hintIcon_ = other.hintIcon_;
		name_ = other.name_;
		desc_ = other.desc_;
		literary_ = other.literary_;
		refreshPoint_ = other.refreshPoint_;
		firstLines_ = other.firstLines_.Clone();
		lines_ = other.lines_.Clone();
		chat_ = other.chat_.Clone();
		chatProp_ = other.chatProp_;
		chatTime_ = other.chatTime_;
		nPCId_ = other.nPCId_;
		affinityValue_ = other.affinityValue_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public NPCConfig Clone()
	{
		return new NPCConfig(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as NPCConfig);
	}

	[DebuggerNonUserCode]
	public bool Equals(NPCConfig other)
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
		if (Type != other.Type)
		{
			return false;
		}
		if (HintIcon != other.HintIcon)
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
		if (Literary != other.Literary)
		{
			return false;
		}
		if (RefreshPoint != other.RefreshPoint)
		{
			return false;
		}
		if (!firstLines_.Equals(other.firstLines_))
		{
			return false;
		}
		if (!lines_.Equals(other.lines_))
		{
			return false;
		}
		if (!chat_.Equals(other.chat_))
		{
			return false;
		}
		if (ChatProp != other.ChatProp)
		{
			return false;
		}
		if (ChatTime != other.ChatTime)
		{
			return false;
		}
		if (NPCId != other.NPCId)
		{
			return false;
		}
		if (AffinityValue != other.AffinityValue)
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
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (HintIcon.Length != 0)
		{
			num ^= HintIcon.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (Literary.Length != 0)
		{
			num ^= Literary.GetHashCode();
		}
		if (RefreshPoint != 0)
		{
			num ^= RefreshPoint.GetHashCode();
		}
		num ^= firstLines_.GetHashCode();
		num ^= lines_.GetHashCode();
		num ^= chat_.GetHashCode();
		if (ChatProp != 0)
		{
			num ^= ChatProp.GetHashCode();
		}
		if (ChatTime != 0)
		{
			num ^= ChatTime.GetHashCode();
		}
		if (NPCId != 0)
		{
			num ^= NPCId.GetHashCode();
		}
		if (AffinityValue.Length != 0)
		{
			num ^= AffinityValue.GetHashCode();
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
		if (Type != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Type);
		}
		if (HintIcon.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(HintIcon);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Name);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Desc);
		}
		if (Literary.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Literary);
		}
		if (RefreshPoint != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(RefreshPoint);
		}
		firstLines_.WriteTo(output, _repeated_firstLines_codec);
		lines_.WriteTo(output, _repeated_lines_codec);
		chat_.WriteTo(output, _repeated_chat_codec);
		if (ChatProp != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(ChatProp);
		}
		if (ChatTime != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(ChatTime);
		}
		if (NPCId != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(NPCId);
		}
		if (AffinityValue.Length != 0)
		{
			output.WriteRawTag(114);
			output.WriteString(AffinityValue);
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
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (HintIcon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(HintIcon);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (Literary.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Literary);
		}
		if (RefreshPoint != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RefreshPoint);
		}
		num += firstLines_.CalculateSize(_repeated_firstLines_codec);
		num += lines_.CalculateSize(_repeated_lines_codec);
		num += chat_.CalculateSize(_repeated_chat_codec);
		if (ChatProp != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ChatProp);
		}
		if (ChatTime != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ChatTime);
		}
		if (NPCId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(NPCId);
		}
		if (AffinityValue.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AffinityValue);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(NPCConfig other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.HintIcon.Length != 0)
			{
				HintIcon = other.HintIcon;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.Literary.Length != 0)
			{
				Literary = other.Literary;
			}
			if (other.RefreshPoint != 0)
			{
				RefreshPoint = other.RefreshPoint;
			}
			firstLines_.Add(other.firstLines_);
			lines_.Add(other.lines_);
			chat_.Add(other.chat_);
			if (other.ChatProp != 0)
			{
				ChatProp = other.ChatProp;
			}
			if (other.ChatTime != 0)
			{
				ChatTime = other.ChatTime;
			}
			if (other.NPCId != 0)
			{
				NPCId = other.NPCId;
			}
			if (other.AffinityValue.Length != 0)
			{
				AffinityValue = other.AffinityValue;
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
				Type = input.ReadInt32();
				break;
			case 26u:
				HintIcon = input.ReadString();
				break;
			case 34u:
				Name = input.ReadString();
				break;
			case 42u:
				Desc = input.ReadString();
				break;
			case 50u:
				Literary = input.ReadString();
				break;
			case 56u:
				RefreshPoint = input.ReadInt32();
				break;
			case 64u:
			case 66u:
				firstLines_.AddEntriesFrom(input, _repeated_firstLines_codec);
				break;
			case 72u:
			case 74u:
				lines_.AddEntriesFrom(input, _repeated_lines_codec);
				break;
			case 80u:
			case 82u:
				chat_.AddEntriesFrom(input, _repeated_chat_codec);
				break;
			case 88u:
				ChatProp = input.ReadInt32();
				break;
			case 96u:
				ChatTime = input.ReadInt32();
				break;
			case 104u:
				NPCId = input.ReadInt32();
				break;
			case 114u:
				AffinityValue = input.ReadString();
				break;
			}
		}
	}
}
