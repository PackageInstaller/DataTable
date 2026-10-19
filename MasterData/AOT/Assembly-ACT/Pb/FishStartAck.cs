using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class FishStartAck : IMessage<FishStartAck>, IMessage, IEquatable<FishStartAck>, IDeepCloneable<FishStartAck>, IBufferMessage
{
	private static readonly MessageParser<FishStartAck> _parser = new MessageParser<FishStartAck>(() => new FishStartAck());

	private UnknownFieldSet _unknownFields;

	public const int StartTsFieldNumber = 1;

	private long startTs_;

	public const int FinishTsFieldNumber = 2;

	private long finishTs_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<FishStartAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => FishReflection.Descriptor.MessageTypes[3];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long StartTs
	{
		get
		{
			return startTs_;
		}
		set
		{
			startTs_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long FinishTs
	{
		get
		{
			return finishTs_;
		}
		set
		{
			finishTs_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public FishStartAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public FishStartAck(FishStartAck other)
		: this()
	{
		startTs_ = other.startTs_;
		finishTs_ = other.finishTs_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public FishStartAck Clone()
	{
		return new FishStartAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as FishStartAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(FishStartAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (StartTs != other.StartTs)
		{
			return false;
		}
		if (FinishTs != other.FinishTs)
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
		if (StartTs != 0L)
		{
			num ^= StartTs.GetHashCode();
		}
		if (FinishTs != 0L)
		{
			num ^= FinishTs.GetHashCode();
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
		if (StartTs != 0L)
		{
			output.WriteRawTag(8);
			output.WriteInt64(StartTs);
		}
		if (FinishTs != 0L)
		{
			output.WriteRawTag(16);
			output.WriteInt64(FinishTs);
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
		if (StartTs != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(StartTs);
		}
		if (FinishTs != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(FinishTs);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(FishStartAck other)
	{
		if (other != null)
		{
			if (other.StartTs != 0L)
			{
				StartTs = other.StartTs;
			}
			if (other.FinishTs != 0L)
			{
				FinishTs = other.FinishTs;
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
				StartTs = input.ReadInt64();
				break;
			case 16u:
				FinishTs = input.ReadInt64();
				break;
			}
		}
	}
}
