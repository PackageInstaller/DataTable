using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class TempleCompleteStageAck : IMessage<TempleCompleteStageAck>, IMessage, IEquatable<TempleCompleteStageAck>, IDeepCloneable<TempleCompleteStageAck>, IBufferMessage
{
	private static readonly MessageParser<TempleCompleteStageAck> _parser = new MessageParser<TempleCompleteStageAck>(() => new TempleCompleteStageAck());

	private UnknownFieldSet _unknownFields;

	public const int RewardsFieldNumber = 1;

	private static readonly FieldCodec<Item> _repeated_rewards_codec = FieldCodec.ForMessage(10u, Item.Parser);

	private readonly RepeatedField<Item> rewards_ = new RepeatedField<Item>();

	public const int NewInfoFieldNumber = 2;

	private Temple newInfo_;

	public const int GotRewardsFieldNumber = 3;

	private static readonly FieldCodec<UniversalItem> _repeated_gotRewards_codec = FieldCodec.ForMessage(26u, UniversalItem.Parser);

	private readonly RepeatedField<UniversalItem> gotRewards_ = new RepeatedField<UniversalItem>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<TempleCompleteStageAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => TempleReflection.Descriptor.MessageTypes[9];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<Item> Rewards => rewards_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Temple NewInfo
	{
		get
		{
			return newInfo_;
		}
		set
		{
			newInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<UniversalItem> GotRewards => gotRewards_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TempleCompleteStageAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TempleCompleteStageAck(TempleCompleteStageAck other)
		: this()
	{
		rewards_ = other.rewards_.Clone();
		newInfo_ = ((other.newInfo_ != null) ? other.newInfo_.Clone() : null);
		gotRewards_ = other.gotRewards_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TempleCompleteStageAck Clone()
	{
		return new TempleCompleteStageAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as TempleCompleteStageAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(TempleCompleteStageAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!rewards_.Equals(other.rewards_))
		{
			return false;
		}
		if (!object.Equals(NewInfo, other.NewInfo))
		{
			return false;
		}
		if (!gotRewards_.Equals(other.gotRewards_))
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
		num ^= rewards_.GetHashCode();
		if (newInfo_ != null)
		{
			num ^= NewInfo.GetHashCode();
		}
		num ^= gotRewards_.GetHashCode();
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
		rewards_.WriteTo(ref output, _repeated_rewards_codec);
		if (newInfo_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(NewInfo);
		}
		gotRewards_.WriteTo(ref output, _repeated_gotRewards_codec);
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
		num += rewards_.CalculateSize(_repeated_rewards_codec);
		if (newInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(NewInfo);
		}
		num += gotRewards_.CalculateSize(_repeated_gotRewards_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(TempleCompleteStageAck other)
	{
		if (other == null)
		{
			return;
		}
		rewards_.Add(other.rewards_);
		if (other.newInfo_ != null)
		{
			if (newInfo_ == null)
			{
				NewInfo = new Temple();
			}
			NewInfo.MergeFrom(other.NewInfo);
		}
		gotRewards_.Add(other.gotRewards_);
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
				rewards_.AddEntriesFrom(ref input, _repeated_rewards_codec);
				break;
			case 18u:
				if (newInfo_ == null)
				{
					NewInfo = new Temple();
				}
				input.ReadMessage(NewInfo);
				break;
			case 26u:
				gotRewards_.AddEntriesFrom(ref input, _repeated_gotRewards_codec);
				break;
			}
		}
	}
}
