using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class NotifyCollectionItem : IMessage<NotifyCollectionItem>, IMessage, IEquatable<NotifyCollectionItem>, IDeepCloneable<NotifyCollectionItem>, IBufferMessage
{
	private static readonly MessageParser<NotifyCollectionItem> _parser = new MessageParser<NotifyCollectionItem>(() => new NotifyCollectionItem());

	private UnknownFieldSet _unknownFields;

	public const int ItemIdFieldNumber = 1;

	private int itemId_;

	public const int LimitFieldNumber = 2;

	private int limit_;

	public const int DestoryedCountFieldNumber = 3;

	private int destoryedCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<NotifyCollectionItem> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[146];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ItemId
	{
		get
		{
			return itemId_;
		}
		set
		{
			itemId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Limit
	{
		get
		{
			return limit_;
		}
		set
		{
			limit_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int DestoryedCount
	{
		get
		{
			return destoryedCount_;
		}
		set
		{
			destoryedCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public NotifyCollectionItem()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public NotifyCollectionItem(NotifyCollectionItem other)
		: this()
	{
		itemId_ = other.itemId_;
		limit_ = other.limit_;
		destoryedCount_ = other.destoryedCount_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public NotifyCollectionItem Clone()
	{
		return new NotifyCollectionItem(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as NotifyCollectionItem);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(NotifyCollectionItem other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ItemId != other.ItemId)
		{
			return false;
		}
		if (Limit != other.Limit)
		{
			return false;
		}
		if (DestoryedCount != other.DestoryedCount)
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
		if (ItemId != 0)
		{
			num ^= ItemId.GetHashCode();
		}
		if (Limit != 0)
		{
			num ^= Limit.GetHashCode();
		}
		if (DestoryedCount != 0)
		{
			num ^= DestoryedCount.GetHashCode();
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
		if (ItemId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ItemId);
		}
		if (Limit != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Limit);
		}
		if (DestoryedCount != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(DestoryedCount);
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
		if (ItemId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemId);
		}
		if (Limit != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Limit);
		}
		if (DestoryedCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DestoryedCount);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(NotifyCollectionItem other)
	{
		if (other != null)
		{
			if (other.ItemId != 0)
			{
				ItemId = other.ItemId;
			}
			if (other.Limit != 0)
			{
				Limit = other.Limit;
			}
			if (other.DestoryedCount != 0)
			{
				DestoryedCount = other.DestoryedCount;
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
				ItemId = input.ReadInt32();
				break;
			case 16u:
				Limit = input.ReadInt32();
				break;
			case 24u:
				DestoryedCount = input.ReadInt32();
				break;
			}
		}
	}
}
