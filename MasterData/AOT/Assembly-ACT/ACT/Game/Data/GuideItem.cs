using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class GuideItem : IMessage<GuideItem>, IMessage, IEquatable<GuideItem>, IDeepCloneable<GuideItem>, IBufferMessage
{
	private static readonly MessageParser<GuideItem> _parser = new MessageParser<GuideItem>(() => new GuideItem());

	private UnknownFieldSet _unknownFields;

	public const int FirstTriggerTsFieldNumber = 1;

	private int firstTriggerTs_;

	public const int FirstReadTsFieldNumber = 2;

	private int firstReadTs_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<GuideItem> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[162];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int FirstTriggerTs
	{
		get
		{
			return firstTriggerTs_;
		}
		set
		{
			firstTriggerTs_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int FirstReadTs
	{
		get
		{
			return firstReadTs_;
		}
		set
		{
			firstReadTs_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GuideItem()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GuideItem(GuideItem other)
		: this()
	{
		firstTriggerTs_ = other.firstTriggerTs_;
		firstReadTs_ = other.firstReadTs_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GuideItem Clone()
	{
		return new GuideItem(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as GuideItem);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(GuideItem other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (FirstTriggerTs != other.FirstTriggerTs)
		{
			return false;
		}
		if (FirstReadTs != other.FirstReadTs)
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
		if (FirstTriggerTs != 0)
		{
			num ^= FirstTriggerTs.GetHashCode();
		}
		if (FirstReadTs != 0)
		{
			num ^= FirstReadTs.GetHashCode();
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
		if (FirstTriggerTs != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(FirstTriggerTs);
		}
		if (FirstReadTs != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(FirstReadTs);
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
		if (FirstTriggerTs != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FirstTriggerTs);
		}
		if (FirstReadTs != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FirstReadTs);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(GuideItem other)
	{
		if (other != null)
		{
			if (other.FirstTriggerTs != 0)
			{
				FirstTriggerTs = other.FirstTriggerTs;
			}
			if (other.FirstReadTs != 0)
			{
				FirstReadTs = other.FirstReadTs;
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
				FirstTriggerTs = input.ReadInt32();
				break;
			case 16u:
				FirstReadTs = input.ReadInt32();
				break;
			}
		}
	}
}
