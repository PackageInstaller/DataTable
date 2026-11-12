using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class CharAffinityTemplate : IMessage<CharAffinityTemplate>, IMessage, IEquatable<CharAffinityTemplate>, IDeepCloneable<CharAffinityTemplate>
{
	private static readonly MessageParser<CharAffinityTemplate> _parser = new MessageParser<CharAffinityTemplate>(() => new CharAffinityTemplate());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TemplateIdFieldNumber = 2;

	private int templateId_;

	[DebuggerNonUserCode]
	public static MessageParser<CharAffinityTemplate> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(184);

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
	public int TemplateId
	{
		get
		{
			return templateId_;
		}
		set
		{
			templateId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public CharAffinityTemplate()
	{
	}

	[DebuggerNonUserCode]
	public CharAffinityTemplate(CharAffinityTemplate other)
		: this()
	{
		id_ = other.id_;
		templateId_ = other.templateId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public CharAffinityTemplate Clone()
	{
		return new CharAffinityTemplate(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as CharAffinityTemplate);
	}

	[DebuggerNonUserCode]
	public bool Equals(CharAffinityTemplate other)
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
		if (TemplateId != other.TemplateId)
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
		if (TemplateId != 0)
		{
			num ^= TemplateId.GetHashCode();
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
		if (TemplateId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(TemplateId);
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
		if (TemplateId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TemplateId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CharAffinityTemplate other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.TemplateId != 0)
			{
				TemplateId = other.TemplateId;
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
				TemplateId = input.ReadInt32();
				break;
			}
		}
	}
}
