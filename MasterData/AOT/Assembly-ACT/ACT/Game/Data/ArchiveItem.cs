using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class ArchiveItem : IMessage<ArchiveItem>, IMessage, IEquatable<ArchiveItem>, IDeepCloneable<ArchiveItem>, IBufferMessage
{
	private static readonly MessageParser<ArchiveItem> _parser = new MessageParser<ArchiveItem>(() => new ArchiveItem());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int FirstTimestampFieldNumber = 2;

	private int firstTimestamp_;

	public const int ReadFieldNumber = 3;

	private bool read_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ArchiveItem> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[130];

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
	public int FirstTimestamp
	{
		get
		{
			return firstTimestamp_;
		}
		set
		{
			firstTimestamp_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Read
	{
		get
		{
			return read_;
		}
		set
		{
			read_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ArchiveItem()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ArchiveItem(ArchiveItem other)
		: this()
	{
		id_ = other.id_;
		firstTimestamp_ = other.firstTimestamp_;
		read_ = other.read_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ArchiveItem Clone()
	{
		return new ArchiveItem(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ArchiveItem);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ArchiveItem other)
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
		if (FirstTimestamp != other.FirstTimestamp)
		{
			return false;
		}
		if (Read != other.Read)
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
		if (FirstTimestamp != 0)
		{
			num ^= FirstTimestamp.GetHashCode();
		}
		if (Read)
		{
			num ^= Read.GetHashCode();
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
		if (FirstTimestamp != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(FirstTimestamp);
		}
		if (Read)
		{
			output.WriteRawTag(24);
			output.WriteBool(Read);
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
		if (FirstTimestamp != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FirstTimestamp);
		}
		if (Read)
		{
			num += 2;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ArchiveItem other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.FirstTimestamp != 0)
			{
				FirstTimestamp = other.FirstTimestamp;
			}
			if (other.Read)
			{
				Read = other.Read;
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
			case 16u:
				FirstTimestamp = input.ReadInt32();
				break;
			case 24u:
				Read = input.ReadBool();
				break;
			}
		}
	}
}
