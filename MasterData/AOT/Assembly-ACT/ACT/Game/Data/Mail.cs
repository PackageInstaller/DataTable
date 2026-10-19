using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class Mail : IMessage<Mail>, IMessage, IEquatable<Mail>, IDeepCloneable<Mail>, IBufferMessage
{
	private static readonly MessageParser<Mail> _parser = new MessageParser<Mail>(() => new Mail());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TemplateIDFieldNumber = 2;

	private int templateID_;

	public const int PriorityFieldNumber = 3;

	private int priority_;

	public const int CreateTsFieldNumber = 4;

	private long createTs_;

	public const int ExpireTsFieldNumber = 5;

	private long expireTs_;

	public const int TypeFieldNumber = 6;

	private int type_;

	public const int SenderFieldNumber = 7;

	private string sender_ = "";

	public const int TitleFieldNumber = 8;

	private string title_ = "";

	public const int ContentFieldNumber = 9;

	private string content_ = "";

	public const int StateFieldNumber = 10;

	private int state_;

	public const int RewardsFieldNumber = 11;

	private static readonly FieldCodec<Item> _repeated_rewards_codec = FieldCodec.ForMessage(90u, Item.Parser);

	private readonly RepeatedField<Item> rewards_ = new RepeatedField<Item>();

	public const int TagFieldNumber = 12;

	private int tag_;

	public const int QuestionnaireUrlFieldNumber = 13;

	private string questionnaireUrl_ = "";

	public const int QuestionnaireTitleFieldNumber = 14;

	private string questionnaireTitle_ = "";

	public const int LinkTypeFieldNumber = 15;

	private MailLinkType linkType_;

	public const int LinkFieldNumber = 16;

	private int link_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<Mail> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[100];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
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
	[GeneratedCode("protoc", null)]
	public int TemplateID
	{
		get
		{
			return templateID_;
		}
		set
		{
			templateID_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Priority
	{
		get
		{
			return priority_;
		}
		set
		{
			priority_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long CreateTs
	{
		get
		{
			return createTs_;
		}
		set
		{
			createTs_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long ExpireTs
	{
		get
		{
			return expireTs_;
		}
		set
		{
			expireTs_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
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
	[GeneratedCode("protoc", null)]
	public string Sender
	{
		get
		{
			return sender_;
		}
		set
		{
			sender_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
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
	[GeneratedCode("protoc", null)]
	public string Content
	{
		get
		{
			return content_;
		}
		set
		{
			content_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int State
	{
		get
		{
			return state_;
		}
		set
		{
			state_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<Item> Rewards => rewards_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Tag
	{
		get
		{
			return tag_;
		}
		set
		{
			tag_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string QuestionnaireUrl
	{
		get
		{
			return questionnaireUrl_;
		}
		set
		{
			questionnaireUrl_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string QuestionnaireTitle
	{
		get
		{
			return questionnaireTitle_;
		}
		set
		{
			questionnaireTitle_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MailLinkType LinkType
	{
		get
		{
			return linkType_;
		}
		set
		{
			linkType_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Link
	{
		get
		{
			return link_;
		}
		set
		{
			link_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Mail()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Mail(Mail other)
		: this()
	{
		id_ = other.id_;
		templateID_ = other.templateID_;
		priority_ = other.priority_;
		createTs_ = other.createTs_;
		expireTs_ = other.expireTs_;
		type_ = other.type_;
		sender_ = other.sender_;
		title_ = other.title_;
		content_ = other.content_;
		state_ = other.state_;
		rewards_ = other.rewards_.Clone();
		tag_ = other.tag_;
		questionnaireUrl_ = other.questionnaireUrl_;
		questionnaireTitle_ = other.questionnaireTitle_;
		linkType_ = other.linkType_;
		link_ = other.link_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Mail Clone()
	{
		return new Mail(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as Mail);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(Mail other)
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
		if (TemplateID != other.TemplateID)
		{
			return false;
		}
		if (Priority != other.Priority)
		{
			return false;
		}
		if (CreateTs != other.CreateTs)
		{
			return false;
		}
		if (ExpireTs != other.ExpireTs)
		{
			return false;
		}
		if (Type != other.Type)
		{
			return false;
		}
		if (Sender != other.Sender)
		{
			return false;
		}
		if (Title != other.Title)
		{
			return false;
		}
		if (Content != other.Content)
		{
			return false;
		}
		if (State != other.State)
		{
			return false;
		}
		if (!rewards_.Equals(other.rewards_))
		{
			return false;
		}
		if (Tag != other.Tag)
		{
			return false;
		}
		if (QuestionnaireUrl != other.QuestionnaireUrl)
		{
			return false;
		}
		if (QuestionnaireTitle != other.QuestionnaireTitle)
		{
			return false;
		}
		if (LinkType != other.LinkType)
		{
			return false;
		}
		if (Link != other.Link)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override int GetHashCode()
	{
		int num = 1;
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (TemplateID != 0)
		{
			num ^= TemplateID.GetHashCode();
		}
		if (Priority != 0)
		{
			num ^= Priority.GetHashCode();
		}
		if (CreateTs != 0L)
		{
			num ^= CreateTs.GetHashCode();
		}
		if (ExpireTs != 0L)
		{
			num ^= ExpireTs.GetHashCode();
		}
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (Sender.Length != 0)
		{
			num ^= Sender.GetHashCode();
		}
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (Content.Length != 0)
		{
			num ^= Content.GetHashCode();
		}
		if (State != 0)
		{
			num ^= State.GetHashCode();
		}
		num ^= rewards_.GetHashCode();
		if (Tag != 0)
		{
			num ^= Tag.GetHashCode();
		}
		if (QuestionnaireUrl.Length != 0)
		{
			num ^= QuestionnaireUrl.GetHashCode();
		}
		if (QuestionnaireTitle.Length != 0)
		{
			num ^= QuestionnaireTitle.GetHashCode();
		}
		if (LinkType != MailLinkType.None)
		{
			num ^= LinkType.GetHashCode();
		}
		if (Link != 0)
		{
			num ^= Link.GetHashCode();
		}
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void WriteTo(CodedOutputStream output)
	{
		output.WriteRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalWriteTo(ref WriteContext output)
	{
		if (Id != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Id);
		}
		if (TemplateID != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(TemplateID);
		}
		if (Priority != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Priority);
		}
		if (CreateTs != 0L)
		{
			output.WriteRawTag(32);
			output.WriteInt64(CreateTs);
		}
		if (ExpireTs != 0L)
		{
			output.WriteRawTag(40);
			output.WriteInt64(ExpireTs);
		}
		if (Type != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Type);
		}
		if (Sender.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(Sender);
		}
		if (Title.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(Title);
		}
		if (Content.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(Content);
		}
		if (State != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(State);
		}
		rewards_.WriteTo(ref output, _repeated_rewards_codec);
		if (Tag != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(Tag);
		}
		if (QuestionnaireUrl.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(QuestionnaireUrl);
		}
		if (QuestionnaireTitle.Length != 0)
		{
			output.WriteRawTag(114);
			output.WriteString(QuestionnaireTitle);
		}
		if (LinkType != MailLinkType.None)
		{
			output.WriteRawTag(120);
			output.WriteEnum((int)LinkType);
		}
		if (Link != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(Link);
		}
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(ref output);
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CalculateSize()
	{
		int num = 0;
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		if (TemplateID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TemplateID);
		}
		if (Priority != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Priority);
		}
		if (CreateTs != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(CreateTs);
		}
		if (ExpireTs != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(ExpireTs);
		}
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (Sender.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Sender);
		}
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (Content.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Content);
		}
		if (State != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(State);
		}
		num += rewards_.CalculateSize(_repeated_rewards_codec);
		if (Tag != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Tag);
		}
		if (QuestionnaireUrl.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(QuestionnaireUrl);
		}
		if (QuestionnaireTitle.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(QuestionnaireTitle);
		}
		if (LinkType != MailLinkType.None)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)LinkType);
		}
		if (Link != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Link);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(Mail other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.TemplateID != 0)
			{
				TemplateID = other.TemplateID;
			}
			if (other.Priority != 0)
			{
				Priority = other.Priority;
			}
			if (other.CreateTs != 0L)
			{
				CreateTs = other.CreateTs;
			}
			if (other.ExpireTs != 0L)
			{
				ExpireTs = other.ExpireTs;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.Sender.Length != 0)
			{
				Sender = other.Sender;
			}
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.Content.Length != 0)
			{
				Content = other.Content;
			}
			if (other.State != 0)
			{
				State = other.State;
			}
			rewards_.Add(other.rewards_);
			if (other.Tag != 0)
			{
				Tag = other.Tag;
			}
			if (other.QuestionnaireUrl.Length != 0)
			{
				QuestionnaireUrl = other.QuestionnaireUrl;
			}
			if (other.QuestionnaireTitle.Length != 0)
			{
				QuestionnaireTitle = other.QuestionnaireTitle;
			}
			if (other.LinkType != MailLinkType.None)
			{
				LinkType = other.LinkType;
			}
			if (other.Link != 0)
			{
				Link = other.Link;
			}
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CodedInputStream input)
	{
		input.ReadRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalMergeFrom(ref ParseContext input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			switch (num)
			{
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				break;
			case 8u:
				Id = input.ReadInt32();
				break;
			case 16u:
				TemplateID = input.ReadInt32();
				break;
			case 24u:
				Priority = input.ReadInt32();
				break;
			case 32u:
				CreateTs = input.ReadInt64();
				break;
			case 40u:
				ExpireTs = input.ReadInt64();
				break;
			case 48u:
				Type = input.ReadInt32();
				break;
			case 58u:
				Sender = input.ReadString();
				break;
			case 66u:
				Title = input.ReadString();
				break;
			case 74u:
				Content = input.ReadString();
				break;
			case 80u:
				State = input.ReadInt32();
				break;
			case 90u:
				rewards_.AddEntriesFrom(ref input, _repeated_rewards_codec);
				break;
			case 96u:
				Tag = input.ReadInt32();
				break;
			case 106u:
				QuestionnaireUrl = input.ReadString();
				break;
			case 114u:
				QuestionnaireTitle = input.ReadString();
				break;
			case 120u:
				LinkType = (MailLinkType)input.ReadEnum();
				break;
			case 128u:
				Link = input.ReadInt32();
				break;
			}
		}
	}
}
