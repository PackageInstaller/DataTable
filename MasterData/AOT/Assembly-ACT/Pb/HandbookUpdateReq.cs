using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class HandbookUpdateReq : IMessage<HandbookUpdateReq>, IMessage, IEquatable<HandbookUpdateReq>, IDeepCloneable<HandbookUpdateReq>, IBufferMessage
{
	private static readonly MessageParser<HandbookUpdateReq> _parser = new MessageParser<HandbookUpdateReq>(() => new HandbookUpdateReq());

	private UnknownFieldSet _unknownFields;

	public const int UnlockMonstersFieldNumber = 1;

	private static readonly FieldCodec<int> _repeated_unlockMonsters_codec = FieldCodec.ForInt32(10u);

	private readonly RepeatedField<int> unlockMonsters_ = new RepeatedField<int>();

	public const int KilledMonstersFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_killedMonsters_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> killedMonsters_ = new RepeatedField<int>();

	public const int UnlockWildBossFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_unlockWildBoss_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> unlockWildBoss_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<HandbookUpdateReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => HandbookReflection.Descriptor.MessageTypes[2];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> UnlockMonsters => unlockMonsters_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> KilledMonsters => killedMonsters_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> UnlockWildBoss => unlockWildBoss_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public HandbookUpdateReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public HandbookUpdateReq(HandbookUpdateReq other)
		: this()
	{
		unlockMonsters_ = other.unlockMonsters_.Clone();
		killedMonsters_ = other.killedMonsters_.Clone();
		unlockWildBoss_ = other.unlockWildBoss_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public HandbookUpdateReq Clone()
	{
		return new HandbookUpdateReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as HandbookUpdateReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(HandbookUpdateReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!unlockMonsters_.Equals(other.unlockMonsters_))
		{
			return false;
		}
		if (!killedMonsters_.Equals(other.killedMonsters_))
		{
			return false;
		}
		if (!unlockWildBoss_.Equals(other.unlockWildBoss_))
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
		num ^= unlockMonsters_.GetHashCode();
		num ^= killedMonsters_.GetHashCode();
		num ^= unlockWildBoss_.GetHashCode();
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
		unlockMonsters_.WriteTo(ref output, _repeated_unlockMonsters_codec);
		killedMonsters_.WriteTo(ref output, _repeated_killedMonsters_codec);
		unlockWildBoss_.WriteTo(ref output, _repeated_unlockWildBoss_codec);
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
		num += unlockMonsters_.CalculateSize(_repeated_unlockMonsters_codec);
		num += killedMonsters_.CalculateSize(_repeated_killedMonsters_codec);
		num += unlockWildBoss_.CalculateSize(_repeated_unlockWildBoss_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(HandbookUpdateReq other)
	{
		if (other != null)
		{
			unlockMonsters_.Add(other.unlockMonsters_);
			killedMonsters_.Add(other.killedMonsters_);
			unlockWildBoss_.Add(other.unlockWildBoss_);
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
			case 10u:
				unlockMonsters_.AddEntriesFrom(ref input, _repeated_unlockMonsters_codec);
				break;
			case 16u:
			case 18u:
				killedMonsters_.AddEntriesFrom(ref input, _repeated_killedMonsters_codec);
				break;
			case 24u:
			case 26u:
				unlockWildBoss_.AddEntriesFrom(ref input, _repeated_unlockWildBoss_codec);
				break;
			}
		}
	}
}
