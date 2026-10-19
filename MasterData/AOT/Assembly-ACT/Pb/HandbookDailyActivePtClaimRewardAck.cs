using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class HandbookDailyActivePtClaimRewardAck : IMessage<HandbookDailyActivePtClaimRewardAck>, IMessage, IEquatable<HandbookDailyActivePtClaimRewardAck>, IDeepCloneable<HandbookDailyActivePtClaimRewardAck>, IBufferMessage
{
	private static readonly MessageParser<HandbookDailyActivePtClaimRewardAck> _parser = new MessageParser<HandbookDailyActivePtClaimRewardAck>(() => new HandbookDailyActivePtClaimRewardAck());

	private UnknownFieldSet _unknownFields;

	public const int ItemsFieldNumber = 1;

	private static readonly FieldCodec<UniversalItem> _repeated_items_codec = FieldCodec.ForMessage(10u, UniversalItem.Parser);

	private readonly RepeatedField<UniversalItem> items_ = new RepeatedField<UniversalItem>();

	public const int RewardStatusFieldNumber = 2;

	private HandbookRewardStatus rewardStatus_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<HandbookDailyActivePtClaimRewardAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => HandbookReflection.Descriptor.MessageTypes[7];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<UniversalItem> Items => items_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public HandbookRewardStatus RewardStatus
	{
		get
		{
			return rewardStatus_;
		}
		set
		{
			rewardStatus_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public HandbookDailyActivePtClaimRewardAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public HandbookDailyActivePtClaimRewardAck(HandbookDailyActivePtClaimRewardAck other)
		: this()
	{
		items_ = other.items_.Clone();
		rewardStatus_ = ((other.rewardStatus_ != null) ? other.rewardStatus_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public HandbookDailyActivePtClaimRewardAck Clone()
	{
		return new HandbookDailyActivePtClaimRewardAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as HandbookDailyActivePtClaimRewardAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(HandbookDailyActivePtClaimRewardAck other)
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
		if (!object.Equals(RewardStatus, other.RewardStatus))
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
		if (rewardStatus_ != null)
		{
			num ^= RewardStatus.GetHashCode();
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
		if (rewardStatus_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(RewardStatus);
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
		if (rewardStatus_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(RewardStatus);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(HandbookDailyActivePtClaimRewardAck other)
	{
		if (other == null)
		{
			return;
		}
		items_.Add(other.items_);
		if (other.rewardStatus_ != null)
		{
			if (rewardStatus_ == null)
			{
				RewardStatus = new HandbookRewardStatus();
			}
			RewardStatus.MergeFrom(other.RewardStatus);
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
				if (rewardStatus_ == null)
				{
					RewardStatus = new HandbookRewardStatus();
				}
				input.ReadMessage(RewardStatus);
				break;
			}
		}
	}
}
