using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class OperationTimeStampsNtf : IMessage<OperationTimeStampsNtf>, IMessage, IEquatable<OperationTimeStampsNtf>, IDeepCloneable<OperationTimeStampsNtf>, IBufferMessage
{
	private static readonly MessageParser<OperationTimeStampsNtf> _parser = new MessageParser<OperationTimeStampsNtf>(() => new OperationTimeStampsNtf());

	private UnknownFieldSet _unknownFields;

	public const int ChangeWorldLevelTSFieldNumber = 1;

	private long changeWorldLevelTS_;

	public const int ChangeGenderTSFieldNumber = 2;

	private int changeGenderTS_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<OperationTimeStampsNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[10];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long ChangeWorldLevelTS
	{
		get
		{
			return changeWorldLevelTS_;
		}
		set
		{
			changeWorldLevelTS_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ChangeGenderTS
	{
		get
		{
			return changeGenderTS_;
		}
		set
		{
			changeGenderTS_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public OperationTimeStampsNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public OperationTimeStampsNtf(OperationTimeStampsNtf other)
		: this()
	{
		changeWorldLevelTS_ = other.changeWorldLevelTS_;
		changeGenderTS_ = other.changeGenderTS_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public OperationTimeStampsNtf Clone()
	{
		return new OperationTimeStampsNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as OperationTimeStampsNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(OperationTimeStampsNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ChangeWorldLevelTS != other.ChangeWorldLevelTS)
		{
			return false;
		}
		if (ChangeGenderTS != other.ChangeGenderTS)
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
		if (ChangeWorldLevelTS != 0L)
		{
			num ^= ChangeWorldLevelTS.GetHashCode();
		}
		if (ChangeGenderTS != 0)
		{
			num ^= ChangeGenderTS.GetHashCode();
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
		if (ChangeWorldLevelTS != 0L)
		{
			output.WriteRawTag(8);
			output.WriteInt64(ChangeWorldLevelTS);
		}
		if (ChangeGenderTS != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ChangeGenderTS);
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
		if (ChangeWorldLevelTS != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(ChangeWorldLevelTS);
		}
		if (ChangeGenderTS != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ChangeGenderTS);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(OperationTimeStampsNtf other)
	{
		if (other != null)
		{
			if (other.ChangeWorldLevelTS != 0L)
			{
				ChangeWorldLevelTS = other.ChangeWorldLevelTS;
			}
			if (other.ChangeGenderTS != 0)
			{
				ChangeGenderTS = other.ChangeGenderTS;
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
				ChangeWorldLevelTS = input.ReadInt64();
				break;
			case 16u:
				ChangeGenderTS = input.ReadInt32();
				break;
			}
		}
	}
}
