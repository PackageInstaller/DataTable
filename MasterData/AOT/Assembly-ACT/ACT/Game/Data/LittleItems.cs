using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class LittleItems : IMessage<LittleItems>, IMessage, IEquatable<LittleItems>, IDeepCloneable<LittleItems>, IBufferMessage
{
	private static readonly MessageParser<LittleItems> _parser = new MessageParser<LittleItems>(() => new LittleItems());

	private UnknownFieldSet _unknownFields;

	public const int ShortcutInfoFieldNumber = 1;

	private LittleItemsShortcutInfo shortcutInfo_;

	public const int BloodBottleItemsFieldNumber = 2;

	private static readonly FieldCodec<BloodBottleItem> _repeated_bloodBottleItems_codec = FieldCodec.ForMessage(18u, BloodBottleItem.Parser);

	private readonly RepeatedField<BloodBottleItem> bloodBottleItems_ = new RepeatedField<BloodBottleItem>();

	public const int PotionInfoFieldNumber = 3;

	private PotionInfo potionInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<LittleItems> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[32];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LittleItemsShortcutInfo ShortcutInfo
	{
		get
		{
			return shortcutInfo_;
		}
		set
		{
			shortcutInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<BloodBottleItem> BloodBottleItems => bloodBottleItems_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PotionInfo PotionInfo
	{
		get
		{
			return potionInfo_;
		}
		set
		{
			potionInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LittleItems()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LittleItems(LittleItems other)
		: this()
	{
		shortcutInfo_ = ((other.shortcutInfo_ != null) ? other.shortcutInfo_.Clone() : null);
		bloodBottleItems_ = other.bloodBottleItems_.Clone();
		potionInfo_ = ((other.potionInfo_ != null) ? other.potionInfo_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LittleItems Clone()
	{
		return new LittleItems(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as LittleItems);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(LittleItems other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(ShortcutInfo, other.ShortcutInfo))
		{
			return false;
		}
		if (!bloodBottleItems_.Equals(other.bloodBottleItems_))
		{
			return false;
		}
		if (!object.Equals(PotionInfo, other.PotionInfo))
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
		if (shortcutInfo_ != null)
		{
			num ^= ShortcutInfo.GetHashCode();
		}
		num ^= bloodBottleItems_.GetHashCode();
		if (potionInfo_ != null)
		{
			num ^= PotionInfo.GetHashCode();
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
		if (shortcutInfo_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(ShortcutInfo);
		}
		bloodBottleItems_.WriteTo(ref output, _repeated_bloodBottleItems_codec);
		if (potionInfo_ != null)
		{
			output.WriteRawTag(26);
			output.WriteMessage(PotionInfo);
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
		if (shortcutInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(ShortcutInfo);
		}
		num += bloodBottleItems_.CalculateSize(_repeated_bloodBottleItems_codec);
		if (potionInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(PotionInfo);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(LittleItems other)
	{
		if (other == null)
		{
			return;
		}
		if (other.shortcutInfo_ != null)
		{
			if (shortcutInfo_ == null)
			{
				ShortcutInfo = new LittleItemsShortcutInfo();
			}
			ShortcutInfo.MergeFrom(other.ShortcutInfo);
		}
		bloodBottleItems_.Add(other.bloodBottleItems_);
		if (other.potionInfo_ != null)
		{
			if (potionInfo_ == null)
			{
				PotionInfo = new PotionInfo();
			}
			PotionInfo.MergeFrom(other.PotionInfo);
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
				if (shortcutInfo_ == null)
				{
					ShortcutInfo = new LittleItemsShortcutInfo();
				}
				input.ReadMessage(ShortcutInfo);
				break;
			case 18u:
				bloodBottleItems_.AddEntriesFrom(ref input, _repeated_bloodBottleItems_codec);
				break;
			case 26u:
				if (potionInfo_ == null)
				{
					PotionInfo = new PotionInfo();
				}
				input.ReadMessage(PotionInfo);
				break;
			}
		}
	}
}
