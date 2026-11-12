using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ErrorCode : IMessage<ErrorCode>, IMessage, IEquatable<ErrorCode>, IDeepCloneable<ErrorCode>
{
	private static readonly MessageParser<ErrorCode> _parser = new MessageParser<ErrorCode>(() => new ErrorCode());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TitleFieldNumber = 2;

	private string title_ = "";

	public const int TemplateFieldNumber = 3;

	private string template_ = "";

	public const int ShowTypeFieldNumber = 4;

	private int showType_;

	[DebuggerNonUserCode]
	public static MessageParser<ErrorCode> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(338);

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
	public string Template
	{
		get
		{
			return template_;
		}
		set
		{
			template_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int ShowType
	{
		get
		{
			return showType_;
		}
		set
		{
			showType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public ErrorCode()
	{
	}

	[DebuggerNonUserCode]
	public ErrorCode(ErrorCode other)
		: this()
	{
		id_ = other.id_;
		title_ = other.title_;
		template_ = other.template_;
		showType_ = other.showType_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ErrorCode Clone()
	{
		return new ErrorCode(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ErrorCode);
	}

	[DebuggerNonUserCode]
	public bool Equals(ErrorCode other)
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
		if (Title != other.Title)
		{
			return false;
		}
		if (Template != other.Template)
		{
			return false;
		}
		if (ShowType != other.ShowType)
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
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (Template.Length != 0)
		{
			num ^= Template.GetHashCode();
		}
		if (ShowType != 0)
		{
			num ^= ShowType.GetHashCode();
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
		if (Title.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Title);
		}
		if (Template.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Template);
		}
		if (ShowType != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(ShowType);
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
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (Template.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Template);
		}
		if (ShowType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ShowType);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ErrorCode other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.Template.Length != 0)
			{
				Template = other.Template;
			}
			if (other.ShowType != 0)
			{
				ShowType = other.ShowType;
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
				Title = input.ReadString();
				break;
			case 26u:
				Template = input.ReadString();
				break;
			case 32u:
				ShowType = input.ReadInt32();
				break;
			}
		}
	}
}
