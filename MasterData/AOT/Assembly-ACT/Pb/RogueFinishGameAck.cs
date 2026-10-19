using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class RogueFinishGameAck : IMessage<RogueFinishGameAck>, IMessage, IEquatable<RogueFinishGameAck>, IDeepCloneable<RogueFinishGameAck>, IBufferMessage
{
	private static readonly MessageParser<RogueFinishGameAck> _parser = new MessageParser<RogueFinishGameAck>(() => new RogueFinishGameAck());

	private UnknownFieldSet _unknownFields;

	public const int TalentTreePointFieldNumber = 1;

	private int talentTreePoint_;

	public const int ItemsFieldNumber = 2;

	private static readonly FieldCodec<Item> _repeated_items_codec = FieldCodec.ForMessage(18u, Item.Parser);

	private readonly RepeatedField<Item> items_ = new RepeatedField<Item>();

	public const int ClearedModeFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_clearedMode_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> clearedMode_ = new RepeatedField<int>();

	public const int WeeklyCoinGainFieldNumber = 4;

	private int weeklyCoinGain_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<RogueFinishGameAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => RogueReflection.Descriptor.MessageTypes[18];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int TalentTreePoint
	{
		get
		{
			return talentTreePoint_;
		}
		set
		{
			talentTreePoint_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<Item> Items => items_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> ClearedMode => clearedMode_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int WeeklyCoinGain
	{
		get
		{
			return weeklyCoinGain_;
		}
		set
		{
			weeklyCoinGain_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueFinishGameAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueFinishGameAck(RogueFinishGameAck other)
		: this()
	{
		talentTreePoint_ = other.talentTreePoint_;
		items_ = other.items_.Clone();
		clearedMode_ = other.clearedMode_.Clone();
		weeklyCoinGain_ = other.weeklyCoinGain_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueFinishGameAck Clone()
	{
		return new RogueFinishGameAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as RogueFinishGameAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(RogueFinishGameAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (TalentTreePoint != other.TalentTreePoint)
		{
			return false;
		}
		if (!items_.Equals(other.items_))
		{
			return false;
		}
		if (!clearedMode_.Equals(other.clearedMode_))
		{
			return false;
		}
		if (WeeklyCoinGain != other.WeeklyCoinGain)
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
		if (TalentTreePoint != 0)
		{
			num ^= TalentTreePoint.GetHashCode();
		}
		num ^= items_.GetHashCode();
		num ^= clearedMode_.GetHashCode();
		if (WeeklyCoinGain != 0)
		{
			num ^= WeeklyCoinGain.GetHashCode();
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
		if (TalentTreePoint != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(TalentTreePoint);
		}
		items_.WriteTo(ref output, _repeated_items_codec);
		clearedMode_.WriteTo(ref output, _repeated_clearedMode_codec);
		if (WeeklyCoinGain != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(WeeklyCoinGain);
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
		if (TalentTreePoint != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TalentTreePoint);
		}
		num += items_.CalculateSize(_repeated_items_codec);
		num += clearedMode_.CalculateSize(_repeated_clearedMode_codec);
		if (WeeklyCoinGain != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WeeklyCoinGain);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(RogueFinishGameAck other)
	{
		if (other != null)
		{
			if (other.TalentTreePoint != 0)
			{
				TalentTreePoint = other.TalentTreePoint;
			}
			items_.Add(other.items_);
			clearedMode_.Add(other.clearedMode_);
			if (other.WeeklyCoinGain != 0)
			{
				WeeklyCoinGain = other.WeeklyCoinGain;
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
				TalentTreePoint = input.ReadInt32();
				break;
			case 18u:
				items_.AddEntriesFrom(ref input, _repeated_items_codec);
				break;
			case 24u:
			case 26u:
				clearedMode_.AddEntriesFrom(ref input, _repeated_clearedMode_codec);
				break;
			case 32u:
				WeeklyCoinGain = input.ReadInt32();
				break;
			}
		}
	}
}
