using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class DrawCardAck : IMessage<DrawCardAck>, IMessage, IEquatable<DrawCardAck>, IDeepCloneable<DrawCardAck>, IBufferMessage
{
	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static class Types
	{
		public sealed class DrawCardItem : IMessage<DrawCardItem>, IMessage, IEquatable<DrawCardItem>, IDeepCloneable<DrawCardItem>, IBufferMessage
		{
			private static readonly MessageParser<DrawCardItem> _parser = new MessageParser<DrawCardItem>(() => new DrawCardItem());

			private UnknownFieldSet _unknownFields;

			public const int PoolItemFieldNumber = 1;

			private Item poolItem_;

			public const int ExtraItemFieldNumber = 2;

			private Item extraItem_;

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public static MessageParser<DrawCardItem> Parser => _parser;

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public static MessageDescriptor Descriptor => DrawCardAck.Descriptor.NestedTypes[0];

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			MessageDescriptor IMessage.Descriptor => Descriptor;

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public Item PoolItem
			{
				get
				{
					return poolItem_;
				}
				set
				{
					poolItem_ = value;
				}
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public Item ExtraItem
			{
				get
				{
					return extraItem_;
				}
				set
				{
					extraItem_ = value;
				}
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public DrawCardItem()
			{
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public DrawCardItem(DrawCardItem other)
				: this()
			{
				poolItem_ = ((other.poolItem_ != null) ? other.poolItem_.Clone() : null);
				extraItem_ = ((other.extraItem_ != null) ? other.extraItem_.Clone() : null);
				_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public DrawCardItem Clone()
			{
				return new DrawCardItem(this);
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public override bool Equals(object other)
			{
				return Equals(other as DrawCardItem);
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public bool Equals(DrawCardItem other)
			{
				if (other == null)
				{
					return false;
				}
				if (other == this)
				{
					return true;
				}
				if (!object.Equals(PoolItem, other.PoolItem))
				{
					return false;
				}
				if (!object.Equals(ExtraItem, other.ExtraItem))
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
				if (poolItem_ != null)
				{
					num ^= PoolItem.GetHashCode();
				}
				if (extraItem_ != null)
				{
					num ^= ExtraItem.GetHashCode();
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
				if (poolItem_ != null)
				{
					output.WriteRawTag(10);
					output.WriteMessage(PoolItem);
				}
				if (extraItem_ != null)
				{
					output.WriteRawTag(18);
					output.WriteMessage(ExtraItem);
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
				if (poolItem_ != null)
				{
					num += 1 + CodedOutputStream.ComputeMessageSize(PoolItem);
				}
				if (extraItem_ != null)
				{
					num += 1 + CodedOutputStream.ComputeMessageSize(ExtraItem);
				}
				if (_unknownFields != null)
				{
					num += _unknownFields.CalculateSize();
				}
				return num;
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public void MergeFrom(DrawCardItem other)
			{
				if (other == null)
				{
					return;
				}
				if (other.poolItem_ != null)
				{
					if (poolItem_ == null)
					{
						PoolItem = new Item();
					}
					PoolItem.MergeFrom(other.PoolItem);
				}
				if (other.extraItem_ != null)
				{
					if (extraItem_ == null)
					{
						ExtraItem = new Item();
					}
					ExtraItem.MergeFrom(other.ExtraItem);
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
						if (poolItem_ == null)
						{
							PoolItem = new Item();
						}
						input.ReadMessage(PoolItem);
						break;
					case 18u:
						if (extraItem_ == null)
						{
							ExtraItem = new Item();
						}
						input.ReadMessage(ExtraItem);
						break;
					}
				}
			}
		}
	}

	private static readonly MessageParser<DrawCardAck> _parser = new MessageParser<DrawCardAck>(() => new DrawCardAck());

	private UnknownFieldSet _unknownFields;

	public const int ItemsFieldNumber = 1;

	private static readonly FieldCodec<Item> _repeated_items_codec = FieldCodec.ForMessage(10u, Item.Parser);

	private readonly RepeatedField<Item> items_ = new RepeatedField<Item>();

	public const int GotItemsFieldNumber = 2;

	private static readonly FieldCodec<Types.DrawCardItem> _repeated_gotItems_codec = FieldCodec.ForMessage(18u, Types.DrawCardItem.Parser);

	private readonly RepeatedField<Types.DrawCardItem> gotItems_ = new RepeatedField<Types.DrawCardItem>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<DrawCardAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[34];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<Item> Items => items_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<Types.DrawCardItem> GotItems => gotItems_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DrawCardAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DrawCardAck(DrawCardAck other)
		: this()
	{
		items_ = other.items_.Clone();
		gotItems_ = other.gotItems_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DrawCardAck Clone()
	{
		return new DrawCardAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as DrawCardAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(DrawCardAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!items_.Equals(other.items_))
		{
			return false;
		}
		if (!gotItems_.Equals(other.gotItems_))
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
		num ^= items_.GetHashCode();
		num ^= gotItems_.GetHashCode();
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
		items_.WriteTo(ref output, _repeated_items_codec);
		gotItems_.WriteTo(ref output, _repeated_gotItems_codec);
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
		num += items_.CalculateSize(_repeated_items_codec);
		num += gotItems_.CalculateSize(_repeated_gotItems_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(DrawCardAck other)
	{
		if (other != null)
		{
			items_.Add(other.items_);
			gotItems_.Add(other.gotItems_);
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
			case 10u:
				items_.AddEntriesFrom(ref input, _repeated_items_codec);
				break;
			case 18u:
				gotItems_.AddEntriesFrom(ref input, _repeated_gotItems_codec);
				break;
			}
		}
	}
}
