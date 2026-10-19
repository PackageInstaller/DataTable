using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class GachaHistoryItem : IMessage<GachaHistoryItem>, IMessage, IEquatable<GachaHistoryItem>, IDeepCloneable<GachaHistoryItem>, IBufferMessage
{
	private static readonly MessageParser<GachaHistoryItem> _parser = new MessageParser<GachaHistoryItem>(() => new GachaHistoryItem());

	private UnknownFieldSet _unknownFields;

	public const int ItemFieldNumber = 1;

	private Item item_;

	public const int DrawTimestampFieldNumber = 2;

	private int drawTimestamp_;

	public const int PoolIdFieldNumber = 3;

	private int poolId_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<GachaHistoryItem> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[149];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Item Item
	{
		get
		{
			return item_;
		}
		set
		{
			item_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int DrawTimestamp
	{
		get
		{
			return drawTimestamp_;
		}
		set
		{
			drawTimestamp_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int PoolId
	{
		get
		{
			return poolId_;
		}
		set
		{
			poolId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaHistoryItem()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaHistoryItem(GachaHistoryItem other)
		: this()
	{
		item_ = ((other.item_ != null) ? other.item_.Clone() : null);
		drawTimestamp_ = other.drawTimestamp_;
		poolId_ = other.poolId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaHistoryItem Clone()
	{
		return new GachaHistoryItem(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as GachaHistoryItem);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(GachaHistoryItem other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(Item, other.Item))
		{
			return false;
		}
		if (DrawTimestamp != other.DrawTimestamp)
		{
			return false;
		}
		if (PoolId != other.PoolId)
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
		if (item_ != null)
		{
			num ^= Item.GetHashCode();
		}
		if (DrawTimestamp != 0)
		{
			num ^= DrawTimestamp.GetHashCode();
		}
		if (PoolId != 0)
		{
			num ^= PoolId.GetHashCode();
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
		if (item_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(Item);
		}
		if (DrawTimestamp != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(DrawTimestamp);
		}
		if (PoolId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(PoolId);
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
		if (item_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Item);
		}
		if (DrawTimestamp != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DrawTimestamp);
		}
		if (PoolId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PoolId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(GachaHistoryItem other)
	{
		if (other == null)
		{
			return;
		}
		if (other.item_ != null)
		{
			if (item_ == null)
			{
				Item = new Item();
			}
			Item.MergeFrom(other.Item);
		}
		if (other.DrawTimestamp != 0)
		{
			DrawTimestamp = other.DrawTimestamp;
		}
		if (other.PoolId != 0)
		{
			PoolId = other.PoolId;
		}
		_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
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
			case 10u:
				if (item_ == null)
				{
					Item = new Item();
				}
				input.ReadMessage(Item);
				break;
			case 16u:
				DrawTimestamp = input.ReadInt32();
				break;
			case 24u:
				PoolId = input.ReadInt32();
				break;
			}
		}
	}
}
