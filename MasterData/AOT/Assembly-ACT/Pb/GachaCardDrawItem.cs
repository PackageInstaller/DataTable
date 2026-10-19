using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class GachaCardDrawItem : IMessage<GachaCardDrawItem>, IMessage, IEquatable<GachaCardDrawItem>, IDeepCloneable<GachaCardDrawItem>, IBufferMessage
{
	private static readonly MessageParser<GachaCardDrawItem> _parser = new MessageParser<GachaCardDrawItem>(() => new GachaCardDrawItem());

	private UnknownFieldSet _unknownFields;

	public const int PoolItemFieldNumber = 1;

	private Item poolItem_;

	public const int ExtraItemFieldNumber = 2;

	private static readonly FieldCodec<Item> _repeated_extraItem_codec = FieldCodec.ForMessage(18u, Item.Parser);

	private readonly RepeatedField<Item> extraItem_ = new RepeatedField<Item>();

	public const int CharacterMaxConstellationFieldNumber = 3;

	private bool characterMaxConstellation_;

	public const int TiggeredFirstGuaranteedFieldNumber = 4;

	private bool tiggeredFirstGuaranteed_;

	public const int TriggeredTargetGuaranteedFieldNumber = 5;

	private bool triggeredTargetGuaranteed_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<GachaCardDrawItem> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[16];

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
	public RepeatedField<Item> ExtraItem => extraItem_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool CharacterMaxConstellation
	{
		get
		{
			return characterMaxConstellation_;
		}
		set
		{
			characterMaxConstellation_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool TiggeredFirstGuaranteed
	{
		get
		{
			return tiggeredFirstGuaranteed_;
		}
		set
		{
			tiggeredFirstGuaranteed_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool TriggeredTargetGuaranteed
	{
		get
		{
			return triggeredTargetGuaranteed_;
		}
		set
		{
			triggeredTargetGuaranteed_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaCardDrawItem()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaCardDrawItem(GachaCardDrawItem other)
		: this()
	{
		poolItem_ = ((other.poolItem_ != null) ? other.poolItem_.Clone() : null);
		extraItem_ = other.extraItem_.Clone();
		characterMaxConstellation_ = other.characterMaxConstellation_;
		tiggeredFirstGuaranteed_ = other.tiggeredFirstGuaranteed_;
		triggeredTargetGuaranteed_ = other.triggeredTargetGuaranteed_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaCardDrawItem Clone()
	{
		return new GachaCardDrawItem(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as GachaCardDrawItem);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(GachaCardDrawItem other)
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
		if (!extraItem_.Equals(other.extraItem_))
		{
			return false;
		}
		if (CharacterMaxConstellation != other.CharacterMaxConstellation)
		{
			return false;
		}
		if (TiggeredFirstGuaranteed != other.TiggeredFirstGuaranteed)
		{
			return false;
		}
		if (TriggeredTargetGuaranteed != other.TriggeredTargetGuaranteed)
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
		num ^= extraItem_.GetHashCode();
		if (CharacterMaxConstellation)
		{
			num ^= CharacterMaxConstellation.GetHashCode();
		}
		if (TiggeredFirstGuaranteed)
		{
			num ^= TiggeredFirstGuaranteed.GetHashCode();
		}
		if (TriggeredTargetGuaranteed)
		{
			num ^= TriggeredTargetGuaranteed.GetHashCode();
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
		extraItem_.WriteTo(ref output, _repeated_extraItem_codec);
		if (CharacterMaxConstellation)
		{
			output.WriteRawTag(24);
			output.WriteBool(CharacterMaxConstellation);
		}
		if (TiggeredFirstGuaranteed)
		{
			output.WriteRawTag(32);
			output.WriteBool(TiggeredFirstGuaranteed);
		}
		if (TriggeredTargetGuaranteed)
		{
			output.WriteRawTag(40);
			output.WriteBool(TriggeredTargetGuaranteed);
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
		num += extraItem_.CalculateSize(_repeated_extraItem_codec);
		if (CharacterMaxConstellation)
		{
			num += 2;
		}
		if (TiggeredFirstGuaranteed)
		{
			num += 2;
		}
		if (TriggeredTargetGuaranteed)
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
	public void MergeFrom(GachaCardDrawItem other)
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
		extraItem_.Add(other.extraItem_);
		if (other.CharacterMaxConstellation)
		{
			CharacterMaxConstellation = other.CharacterMaxConstellation;
		}
		if (other.TiggeredFirstGuaranteed)
		{
			TiggeredFirstGuaranteed = other.TiggeredFirstGuaranteed;
		}
		if (other.TriggeredTargetGuaranteed)
		{
			TriggeredTargetGuaranteed = other.TriggeredTargetGuaranteed;
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
				extraItem_.AddEntriesFrom(ref input, _repeated_extraItem_codec);
				break;
			case 24u:
				CharacterMaxConstellation = input.ReadBool();
				break;
			case 32u:
				TiggeredFirstGuaranteed = input.ReadBool();
				break;
			case 40u:
				TriggeredTargetGuaranteed = input.ReadBool();
				break;
			}
		}
	}
}
