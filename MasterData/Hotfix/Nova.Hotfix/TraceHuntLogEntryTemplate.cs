using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TraceHuntLogEntryTemplate : IMessage<TraceHuntLogEntryTemplate>, IMessage, IEquatable<TraceHuntLogEntryTemplate>, IDeepCloneable<TraceHuntLogEntryTemplate>
{
	private static readonly MessageParser<TraceHuntLogEntryTemplate> _parser = new MessageParser<TraceHuntLogEntryTemplate>(() => new TraceHuntLogEntryTemplate());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int DescFieldNumber = 2;

	private string desc_ = "";

	public const int TypeFieldNumber = 3;

	private int type_;

	public const int TemplateFieldNumber = 4;

	private int template_;

	[DebuggerNonUserCode]
	public static MessageParser<TraceHuntLogEntryTemplate> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(990);

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
	public int Template
	{
		get
		{
			return template_;
		}
		set
		{
			template_ = value;
		}
	}

	[DebuggerNonUserCode]
	public TraceHuntLogEntryTemplate()
	{
	}

	[DebuggerNonUserCode]
	public TraceHuntLogEntryTemplate(TraceHuntLogEntryTemplate other)
		: this()
	{
		id_ = other.id_;
		desc_ = other.desc_;
		type_ = other.type_;
		template_ = other.template_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TraceHuntLogEntryTemplate Clone()
	{
		return new TraceHuntLogEntryTemplate(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TraceHuntLogEntryTemplate);
	}

	[DebuggerNonUserCode]
	public bool Equals(TraceHuntLogEntryTemplate other)
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
		if (Desc != other.Desc)
		{
			return false;
		}
		if (Type != other.Type)
		{
			return false;
		}
		if (Template != other.Template)
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
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (Template != 0)
		{
			num ^= Template.GetHashCode();
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
		if (Desc.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Desc);
		}
		if (Type != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Type);
		}
		if (Template != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Template);
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
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (Template != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Template);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TraceHuntLogEntryTemplate other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.Template != 0)
			{
				Template = other.Template;
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
				Desc = input.ReadString();
				break;
			case 24u:
				Type = input.ReadInt32();
				break;
			case 32u:
				Template = input.ReadInt32();
				break;
			}
		}
	}
}
