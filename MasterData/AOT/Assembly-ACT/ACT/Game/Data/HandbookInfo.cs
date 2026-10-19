using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class HandbookInfo : IMessage<HandbookInfo>, IMessage, IEquatable<HandbookInfo>, IDeepCloneable<HandbookInfo>, IBufferMessage
{
	private static readonly MessageParser<HandbookInfo> _parser = new MessageParser<HandbookInfo>(() => new HandbookInfo());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int MaxSizeFieldNumber = 2;

	private float maxSize_;

	public const int MaxTsFieldNumber = 3;

	private int maxTs_;

	public const int MinSizeFieldNumber = 4;

	private float minSize_;

	public const int MinTsFieldNumber = 5;

	private int minTs_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<HandbookInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[78];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
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
	[GeneratedCode("protoc", null)]
	public float MaxSize
	{
		get
		{
			return maxSize_;
		}
		set
		{
			maxSize_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int MaxTs
	{
		get
		{
			return maxTs_;
		}
		set
		{
			maxTs_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public float MinSize
	{
		get
		{
			return minSize_;
		}
		set
		{
			minSize_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int MinTs
	{
		get
		{
			return minTs_;
		}
		set
		{
			minTs_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public HandbookInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public HandbookInfo(HandbookInfo other)
		: this()
	{
		id_ = other.id_;
		maxSize_ = other.maxSize_;
		maxTs_ = other.maxTs_;
		minSize_ = other.minSize_;
		minTs_ = other.minTs_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public HandbookInfo Clone()
	{
		return new HandbookInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as HandbookInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(HandbookInfo other)
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
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(MaxSize, other.MaxSize))
		{
			return false;
		}
		if (MaxTs != other.MaxTs)
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(MinSize, other.MinSize))
		{
			return false;
		}
		if (MinTs != other.MinTs)
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
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (MaxSize != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(MaxSize);
		}
		if (MaxTs != 0)
		{
			num ^= MaxTs.GetHashCode();
		}
		if (MinSize != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(MinSize);
		}
		if (MinTs != 0)
		{
			num ^= MinTs.GetHashCode();
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
		if (Id != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Id);
		}
		if (MaxSize != 0f)
		{
			output.WriteRawTag(21);
			output.WriteFloat(MaxSize);
		}
		if (MaxTs != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(MaxTs);
		}
		if (MinSize != 0f)
		{
			output.WriteRawTag(37);
			output.WriteFloat(MinSize);
		}
		if (MinTs != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(MinTs);
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
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		if (MaxSize != 0f)
		{
			num += 5;
		}
		if (MaxTs != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MaxTs);
		}
		if (MinSize != 0f)
		{
			num += 5;
		}
		if (MinTs != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MinTs);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(HandbookInfo other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.MaxSize != 0f)
			{
				MaxSize = other.MaxSize;
			}
			if (other.MaxTs != 0)
			{
				MaxTs = other.MaxTs;
			}
			if (other.MinSize != 0f)
			{
				MinSize = other.MinSize;
			}
			if (other.MinTs != 0)
			{
				MinTs = other.MinTs;
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
				Id = input.ReadInt32();
				break;
			case 21u:
				MaxSize = input.ReadFloat();
				break;
			case 24u:
				MaxTs = input.ReadInt32();
				break;
			case 37u:
				MinSize = input.ReadFloat();
				break;
			case 40u:
				MinTs = input.ReadInt32();
				break;
			}
		}
	}

	public void CopyFrom(HandbookInfo change)
	{
		id_ = change.id_;
		maxSize_ = change.maxSize_;
		maxTs_ = change.maxTs_;
		minSize_ = change.minSize_;
		minTs_ = change.minTs_;
	}
}
