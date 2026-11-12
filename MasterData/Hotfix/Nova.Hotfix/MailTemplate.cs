using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class MailTemplate : IMessage<MailTemplate>, IMessage, IEquatable<MailTemplate>, IDeepCloneable<MailTemplate>
{
	private static readonly MessageParser<MailTemplate> _parser = new MessageParser<MailTemplate>(() => new MailTemplate());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ExplanationFieldNumber = 2;

	private string explanation_ = "";

	public const int IconFieldNumber = 3;

	private string icon_ = "";

	public const int AuthorFieldNumber = 4;

	private string author_ = "";

	public const int LetterPaperFieldNumber = 5;

	private string letterPaper_ = "";

	public const int SubjectFieldNumber = 6;

	private string subject_ = "";

	public const int DescFieldNumber = 7;

	private string desc_ = "";

	public const int TypeFieldNumber = 8;

	private int type_;

	public const int ItemsFieldNumber = 9;

	private string items_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<MailTemplate> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(502);

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
	public string Explanation
	{
		get
		{
			return explanation_;
		}
		set
		{
			explanation_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public string Author
	{
		get
		{
			return author_;
		}
		set
		{
			author_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string LetterPaper
	{
		get
		{
			return letterPaper_;
		}
		set
		{
			letterPaper_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Subject
	{
		get
		{
			return subject_;
		}
		set
		{
			subject_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public string Items
	{
		get
		{
			return items_;
		}
		set
		{
			items_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public MailTemplate()
	{
	}

	[DebuggerNonUserCode]
	public MailTemplate(MailTemplate other)
		: this()
	{
		id_ = other.id_;
		explanation_ = other.explanation_;
		icon_ = other.icon_;
		author_ = other.author_;
		letterPaper_ = other.letterPaper_;
		subject_ = other.subject_;
		desc_ = other.desc_;
		type_ = other.type_;
		items_ = other.items_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public MailTemplate Clone()
	{
		return new MailTemplate(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as MailTemplate);
	}

	[DebuggerNonUserCode]
	public bool Equals(MailTemplate other)
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
		if (Explanation != other.Explanation)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (Author != other.Author)
		{
			return false;
		}
		if (LetterPaper != other.LetterPaper)
		{
			return false;
		}
		if (Subject != other.Subject)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (Type != other.Type)
		{
			return false;
		}
		if (Items != other.Items)
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
		if (Explanation.Length != 0)
		{
			num ^= Explanation.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (Author.Length != 0)
		{
			num ^= Author.GetHashCode();
		}
		if (LetterPaper.Length != 0)
		{
			num ^= LetterPaper.GetHashCode();
		}
		if (Subject.Length != 0)
		{
			num ^= Subject.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (Items.Length != 0)
		{
			num ^= Items.GetHashCode();
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
		if (Explanation.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Explanation);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Icon);
		}
		if (Author.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Author);
		}
		if (LetterPaper.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(LetterPaper);
		}
		if (Subject.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Subject);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(Desc);
		}
		if (Type != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Type);
		}
		if (Items.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(Items);
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
		if (Explanation.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Explanation);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (Author.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Author);
		}
		if (LetterPaper.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(LetterPaper);
		}
		if (Subject.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Subject);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (Items.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Items);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(MailTemplate other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Explanation.Length != 0)
			{
				Explanation = other.Explanation;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.Author.Length != 0)
			{
				Author = other.Author;
			}
			if (other.LetterPaper.Length != 0)
			{
				LetterPaper = other.LetterPaper;
			}
			if (other.Subject.Length != 0)
			{
				Subject = other.Subject;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.Items.Length != 0)
			{
				Items = other.Items;
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
				Explanation = input.ReadString();
				break;
			case 26u:
				Icon = input.ReadString();
				break;
			case 34u:
				Author = input.ReadString();
				break;
			case 42u:
				LetterPaper = input.ReadString();
				break;
			case 50u:
				Subject = input.ReadString();
				break;
			case 58u:
				Desc = input.ReadString();
				break;
			case 64u:
				Type = input.ReadInt32();
				break;
			case 74u:
				Items = input.ReadString();
				break;
			}
		}
	}
}
