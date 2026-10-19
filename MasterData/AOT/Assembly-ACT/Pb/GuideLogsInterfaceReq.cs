using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class GuideLogsInterfaceReq : IMessage<GuideLogsInterfaceReq>, IMessage, IEquatable<GuideLogsInterfaceReq>, IDeepCloneable<GuideLogsInterfaceReq>, IBufferMessage
{
	private static readonly MessageParser<GuideLogsInterfaceReq> _parser = new MessageParser<GuideLogsInterfaceReq>(() => new GuideLogsInterfaceReq());

	private UnknownFieldSet _unknownFields;

	public const int GroupFieldNumber = 1;

	private int group_;

	public const int StepFieldNumber = 2;

	private int step_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<GuideLogsInterfaceReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[82];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Group
	{
		get
		{
			return group_;
		}
		set
		{
			group_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Step
	{
		get
		{
			return step_;
		}
		set
		{
			step_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GuideLogsInterfaceReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GuideLogsInterfaceReq(GuideLogsInterfaceReq other)
		: this()
	{
		group_ = other.group_;
		step_ = other.step_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GuideLogsInterfaceReq Clone()
	{
		return new GuideLogsInterfaceReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as GuideLogsInterfaceReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(GuideLogsInterfaceReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Group != other.Group)
		{
			return false;
		}
		if (Step != other.Step)
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
		if (Group != 0)
		{
			num ^= Group.GetHashCode();
		}
		if (Step != 0)
		{
			num ^= Step.GetHashCode();
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
		if (Group != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Group);
		}
		if (Step != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Step);
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
		if (Group != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Group);
		}
		if (Step != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Step);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(GuideLogsInterfaceReq other)
	{
		if (other != null)
		{
			if (other.Group != 0)
			{
				Group = other.Group;
			}
			if (other.Step != 0)
			{
				Step = other.Step;
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
				Group = input.ReadInt32();
				break;
			case 16u:
				Step = input.ReadInt32();
				break;
			}
		}
	}
}
