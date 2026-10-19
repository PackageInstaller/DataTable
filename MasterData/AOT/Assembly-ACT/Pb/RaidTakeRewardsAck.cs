using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class RaidTakeRewardsAck : IMessage<RaidTakeRewardsAck>, IMessage, IEquatable<RaidTakeRewardsAck>, IDeepCloneable<RaidTakeRewardsAck>, IBufferMessage
{
	private static readonly MessageParser<RaidTakeRewardsAck> _parser = new MessageParser<RaidTakeRewardsAck>(() => new RaidTakeRewardsAck());

	private UnknownFieldSet _unknownFields;

	public const int ItemsFieldNumber = 1;

	private static readonly FieldCodec<Item> _repeated_items_codec = FieldCodec.ForMessage(10u, Item.Parser);

	private readonly RepeatedField<Item> items_ = new RepeatedField<Item>();

	public const int GotItemsFieldNumber = 2;

	private static readonly FieldCodec<UniversalItem> _repeated_gotItems_codec = FieldCodec.ForMessage(18u, UniversalItem.Parser);

	private readonly RepeatedField<UniversalItem> gotItems_ = new RepeatedField<UniversalItem>();

	public const int RaidInfoFieldNumber = 3;

	private Raid raidInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<RaidTakeRewardsAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => RaidReflection.Descriptor.MessageTypes[7];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<Item> Items => items_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<UniversalItem> GotItems => gotItems_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Raid RaidInfo
	{
		get
		{
			return raidInfo_;
		}
		set
		{
			raidInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RaidTakeRewardsAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RaidTakeRewardsAck(RaidTakeRewardsAck other)
		: this()
	{
		items_ = other.items_.Clone();
		gotItems_ = other.gotItems_.Clone();
		raidInfo_ = ((other.raidInfo_ != null) ? other.raidInfo_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RaidTakeRewardsAck Clone()
	{
		return new RaidTakeRewardsAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as RaidTakeRewardsAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(RaidTakeRewardsAck other)
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
		if (!object.Equals(RaidInfo, other.RaidInfo))
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
		if (raidInfo_ != null)
		{
			num ^= RaidInfo.GetHashCode();
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
		items_.WriteTo(ref output, _repeated_items_codec);
		gotItems_.WriteTo(ref output, _repeated_gotItems_codec);
		if (raidInfo_ != null)
		{
			output.WriteRawTag(26);
			output.WriteMessage(RaidInfo);
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
		num += items_.CalculateSize(_repeated_items_codec);
		num += gotItems_.CalculateSize(_repeated_gotItems_codec);
		if (raidInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(RaidInfo);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(RaidTakeRewardsAck other)
	{
		if (other == null)
		{
			return;
		}
		items_.Add(other.items_);
		gotItems_.Add(other.gotItems_);
		if (other.raidInfo_ != null)
		{
			if (raidInfo_ == null)
			{
				RaidInfo = new Raid();
			}
			RaidInfo.MergeFrom(other.RaidInfo);
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
				items_.AddEntriesFrom(ref input, _repeated_items_codec);
				break;
			case 18u:
				gotItems_.AddEntriesFrom(ref input, _repeated_gotItems_codec);
				break;
			case 26u:
				if (raidInfo_ == null)
				{
					RaidInfo = new Raid();
				}
				input.ReadMessage(RaidInfo);
				break;
			}
		}
	}
}
