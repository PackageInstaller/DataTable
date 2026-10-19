using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class Progress : IMessage<Progress>, IMessage, IEquatable<Progress>, IDeepCloneable<Progress>, IBufferMessage
{
	private static readonly MessageParser<Progress> _parser = new MessageParser<Progress>(() => new Progress());

	private UnknownFieldSet _unknownFields;

	public const int TypeFieldNumber = 1;

	private ProgressType type_;

	public const int IdFieldNumber = 2;

	private int id_;

	public const int RawDataFieldNumber = 3;

	private int rawData_;

	public const int NewDataFieldNumber = 4;

	private int newData_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<Progress> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[11];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ProgressType Type
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
	public int RawData
	{
		get
		{
			return rawData_;
		}
		set
		{
			rawData_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int NewData
	{
		get
		{
			return newData_;
		}
		set
		{
			newData_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Progress()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Progress(Progress other)
		: this()
	{
		type_ = other.type_;
		id_ = other.id_;
		rawData_ = other.rawData_;
		newData_ = other.newData_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Progress Clone()
	{
		return new Progress(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as Progress);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(Progress other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Type != other.Type)
		{
			return false;
		}
		if (Id != other.Id)
		{
			return false;
		}
		if (RawData != other.RawData)
		{
			return false;
		}
		if (NewData != other.NewData)
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
		if (Type != ProgressType.Item)
		{
			num ^= Type.GetHashCode();
		}
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (RawData != 0)
		{
			num ^= RawData.GetHashCode();
		}
		if (NewData != 0)
		{
			num ^= NewData.GetHashCode();
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
		if (Type != ProgressType.Item)
		{
			output.WriteRawTag(8);
			output.WriteEnum((int)Type);
		}
		if (Id != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Id);
		}
		if (RawData != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(RawData);
		}
		if (NewData != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(NewData);
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
		if (Type != ProgressType.Item)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)Type);
		}
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		if (RawData != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RawData);
		}
		if (NewData != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(NewData);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(Progress other)
	{
		if (other != null)
		{
			if (other.Type != ProgressType.Item)
			{
				Type = other.Type;
			}
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.RawData != 0)
			{
				RawData = other.RawData;
			}
			if (other.NewData != 0)
			{
				NewData = other.NewData;
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
				Type = (ProgressType)input.ReadEnum();
				break;
			case 16u:
				Id = input.ReadInt32();
				break;
			case 24u:
				RawData = input.ReadInt32();
				break;
			case 32u:
				NewData = input.ReadInt32();
				break;
			}
		}
	}
}
