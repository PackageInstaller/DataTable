using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class AnswerQuestionReq : IMessage<AnswerQuestionReq>, IMessage, IEquatable<AnswerQuestionReq>, IDeepCloneable<AnswerQuestionReq>, IBufferMessage
{
	private static readonly MessageParser<AnswerQuestionReq> _parser = new MessageParser<AnswerQuestionReq>(() => new AnswerQuestionReq());

	private UnknownFieldSet _unknownFields;

	public const int QuestionIdFieldNumber = 1;

	private int questionId_;

	public const int OptionIdFieldNumber = 2;

	private int optionId_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<AnswerQuestionReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[99];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int QuestionId
	{
		get
		{
			return questionId_;
		}
		set
		{
			questionId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int OptionId
	{
		get
		{
			return optionId_;
		}
		set
		{
			optionId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AnswerQuestionReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AnswerQuestionReq(AnswerQuestionReq other)
		: this()
	{
		questionId_ = other.questionId_;
		optionId_ = other.optionId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AnswerQuestionReq Clone()
	{
		return new AnswerQuestionReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as AnswerQuestionReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(AnswerQuestionReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (QuestionId != other.QuestionId)
		{
			return false;
		}
		if (OptionId != other.OptionId)
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
		if (QuestionId != 0)
		{
			num ^= QuestionId.GetHashCode();
		}
		if (OptionId != 0)
		{
			num ^= OptionId.GetHashCode();
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
		if (QuestionId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(QuestionId);
		}
		if (OptionId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(OptionId);
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
		if (QuestionId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(QuestionId);
		}
		if (OptionId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(OptionId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(AnswerQuestionReq other)
	{
		if (other != null)
		{
			if (other.QuestionId != 0)
			{
				QuestionId = other.QuestionId;
			}
			if (other.OptionId != 0)
			{
				OptionId = other.OptionId;
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
				QuestionId = input.ReadInt32();
				break;
			case 16u:
				OptionId = input.ReadInt32();
				break;
			}
		}
	}
}
