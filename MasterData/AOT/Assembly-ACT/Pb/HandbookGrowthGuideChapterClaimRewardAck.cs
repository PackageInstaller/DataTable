using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class HandbookGrowthGuideChapterClaimRewardAck : IMessage<HandbookGrowthGuideChapterClaimRewardAck>, IMessage, IEquatable<HandbookGrowthGuideChapterClaimRewardAck>, IDeepCloneable<HandbookGrowthGuideChapterClaimRewardAck>, IBufferMessage
{
	private static readonly MessageParser<HandbookGrowthGuideChapterClaimRewardAck> _parser = new MessageParser<HandbookGrowthGuideChapterClaimRewardAck>(() => new HandbookGrowthGuideChapterClaimRewardAck());

	private UnknownFieldSet _unknownFields;

	public const int ItemsFieldNumber = 1;

	private static readonly FieldCodec<UniversalItem> _repeated_items_codec = FieldCodec.ForMessage(10u, UniversalItem.Parser);

	private readonly RepeatedField<UniversalItem> items_ = new RepeatedField<UniversalItem>();

	public const int GrowthGuideFieldNumber = 2;

	private PlayerGrowthGuide growthGuide_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<HandbookGrowthGuideChapterClaimRewardAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => HandbookReflection.Descriptor.MessageTypes[11];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<UniversalItem> Items => items_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PlayerGrowthGuide GrowthGuide
	{
		get
		{
			return growthGuide_;
		}
		set
		{
			growthGuide_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public HandbookGrowthGuideChapterClaimRewardAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public HandbookGrowthGuideChapterClaimRewardAck(HandbookGrowthGuideChapterClaimRewardAck other)
		: this()
	{
		items_ = other.items_.Clone();
		growthGuide_ = ((other.growthGuide_ != null) ? other.growthGuide_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public HandbookGrowthGuideChapterClaimRewardAck Clone()
	{
		return new HandbookGrowthGuideChapterClaimRewardAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as HandbookGrowthGuideChapterClaimRewardAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(HandbookGrowthGuideChapterClaimRewardAck other)
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
		if (!object.Equals(GrowthGuide, other.GrowthGuide))
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
		if (growthGuide_ != null)
		{
			num ^= GrowthGuide.GetHashCode();
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
		if (growthGuide_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(GrowthGuide);
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
		if (growthGuide_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(GrowthGuide);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(HandbookGrowthGuideChapterClaimRewardAck other)
	{
		if (other == null)
		{
			return;
		}
		items_.Add(other.items_);
		if (other.growthGuide_ != null)
		{
			if (growthGuide_ == null)
			{
				GrowthGuide = new PlayerGrowthGuide();
			}
			GrowthGuide.MergeFrom(other.GrowthGuide);
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
				if (growthGuide_ == null)
				{
					GrowthGuide = new PlayerGrowthGuide();
				}
				input.ReadMessage(GrowthGuide);
				break;
			}
		}
	}
}
