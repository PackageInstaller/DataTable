using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class WildBossTakeRewardAck : IMessage<WildBossTakeRewardAck>, IMessage, IEquatable<WildBossTakeRewardAck>, IDeepCloneable<WildBossTakeRewardAck>, IBufferMessage
{
	private static readonly MessageParser<WildBossTakeRewardAck> _parser = new MessageParser<WildBossTakeRewardAck>(() => new WildBossTakeRewardAck());

	private UnknownFieldSet _unknownFields;

	public const int GotRewardsFieldNumber = 3;

	private static readonly FieldCodec<UniversalItem> _repeated_gotRewards_codec = FieldCodec.ForMessage(26u, UniversalItem.Parser);

	private readonly RepeatedField<UniversalItem> gotRewards_ = new RepeatedField<UniversalItem>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<WildBossTakeRewardAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => WildbossReflection.Descriptor.MessageTypes[1];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<UniversalItem> GotRewards => gotRewards_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public WildBossTakeRewardAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public WildBossTakeRewardAck(WildBossTakeRewardAck other)
		: this()
	{
		gotRewards_ = other.gotRewards_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public WildBossTakeRewardAck Clone()
	{
		return new WildBossTakeRewardAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as WildBossTakeRewardAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(WildBossTakeRewardAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
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
		num += gotRewards_.CalculateSize(_repeated_gotRewards_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(WildBossTakeRewardAck other)
	{
		if (other != null)
		{
			gotRewards_.Add(other.gotRewards_);
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
			if (num != 26)
			{
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
			}
			else
			{
				gotRewards_.AddEntriesFrom(ref input, _repeated_gotRewards_codec);
			}
		}
	}
}
