using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class AcceptMissionAck : IMessage<AcceptMissionAck>, IMessage, IEquatable<AcceptMissionAck>, IDeepCloneable<AcceptMissionAck>, IBufferMessage
{
	private static readonly MessageParser<AcceptMissionAck> _parser = new MessageParser<AcceptMissionAck>(() => new AcceptMissionAck());

	private UnknownFieldSet _unknownFields;

	public const int OkFieldNumber = 1;

	private bool ok_;

	public const int ErrorMessageFieldNumber = 2;

	private string errorMessage_ = "";

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<AcceptMissionAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => MissionReflection.Descriptor.MessageTypes[3];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Ok
	{
		get
		{
			return ok_;
		}
		set
		{
			ok_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string ErrorMessage
	{
		get
		{
			return errorMessage_;
		}
		set
		{
			errorMessage_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AcceptMissionAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AcceptMissionAck(AcceptMissionAck other)
		: this()
	{
		ok_ = other.ok_;
		errorMessage_ = other.errorMessage_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AcceptMissionAck Clone()
	{
		return new AcceptMissionAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as AcceptMissionAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(AcceptMissionAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Ok != other.Ok)
		{
			return false;
		}
		if (ErrorMessage != other.ErrorMessage)
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
		if (Ok)
		{
			num ^= Ok.GetHashCode();
		}
		if (ErrorMessage.Length != 0)
		{
			num ^= ErrorMessage.GetHashCode();
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
		if (Ok)
		{
			output.WriteRawTag(8);
			output.WriteBool(Ok);
		}
		if (ErrorMessage.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(ErrorMessage);
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
		if (Ok)
		{
			num += 2;
		}
		if (ErrorMessage.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ErrorMessage);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(AcceptMissionAck other)
	{
		if (other != null)
		{
			if (other.Ok)
			{
				Ok = other.Ok;
			}
			if (other.ErrorMessage.Length != 0)
			{
				ErrorMessage = other.ErrorMessage;
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
				Ok = input.ReadBool();
				break;
			case 18u:
				ErrorMessage = input.ReadString();
				break;
			}
		}
	}
}
