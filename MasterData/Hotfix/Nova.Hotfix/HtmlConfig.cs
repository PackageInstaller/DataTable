using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class HtmlConfig : IMessage<HtmlConfig>, IMessage, IEquatable<HtmlConfig>, IDeepCloneable<HtmlConfig>
{
	private static readonly MessageParser<HtmlConfig> _parser = new MessageParser<HtmlConfig>(() => new HtmlConfig());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int HtmlFrameFieldNumber = 2;

	private string htmlFrame_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<HtmlConfig> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(430);

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
	public string HtmlFrame
	{
		get
		{
			return htmlFrame_;
		}
		set
		{
			htmlFrame_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public HtmlConfig()
	{
	}

	[DebuggerNonUserCode]
	public HtmlConfig(HtmlConfig other)
		: this()
	{
		id_ = other.id_;
		htmlFrame_ = other.htmlFrame_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public HtmlConfig Clone()
	{
		return new HtmlConfig(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as HtmlConfig);
	}

	[DebuggerNonUserCode]
	public bool Equals(HtmlConfig other)
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
		if (HtmlFrame != other.HtmlFrame)
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
		if (HtmlFrame.Length != 0)
		{
			num ^= HtmlFrame.GetHashCode();
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
		if (HtmlFrame.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(HtmlFrame);
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
		if (HtmlFrame.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(HtmlFrame);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(HtmlConfig other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.HtmlFrame.Length != 0)
			{
				HtmlFrame = other.HtmlFrame;
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
				HtmlFrame = input.ReadString();
				break;
			}
		}
	}
}
