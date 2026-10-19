using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class LoungeNormalIdleRecord : IMessage<LoungeNormalIdleRecord>, IMessage, IEquatable<LoungeNormalIdleRecord>, IDeepCloneable<LoungeNormalIdleRecord>, IBufferMessage
{
	private static readonly MessageParser<LoungeNormalIdleRecord> _parser = new MessageParser<LoungeNormalIdleRecord>(() => new LoungeNormalIdleRecord());

	private UnknownFieldSet _unknownFields;

	public const int LastRandTsFieldNumber = 1;

	private int lastRandTs_;

	public const int StreakCountFieldNumber = 2;

	private int streakCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<LoungeNormalIdleRecord> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[288];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int LastRandTs
	{
		get
		{
			return lastRandTs_;
		}
		set
		{
			lastRandTs_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int StreakCount
	{
		get
		{
			return streakCount_;
		}
		set
		{
			streakCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LoungeNormalIdleRecord()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LoungeNormalIdleRecord(LoungeNormalIdleRecord other)
		: this()
	{
		lastRandTs_ = other.lastRandTs_;
		streakCount_ = other.streakCount_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LoungeNormalIdleRecord Clone()
	{
		return new LoungeNormalIdleRecord(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as LoungeNormalIdleRecord);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(LoungeNormalIdleRecord other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (LastRandTs != other.LastRandTs)
		{
			return false;
		}
		if (StreakCount != other.StreakCount)
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
		if (LastRandTs != 0)
		{
			num ^= LastRandTs.GetHashCode();
		}
		if (StreakCount != 0)
		{
			num ^= StreakCount.GetHashCode();
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
		if (LastRandTs != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(LastRandTs);
		}
		if (StreakCount != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(StreakCount);
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
		if (LastRandTs != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LastRandTs);
		}
		if (StreakCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StreakCount);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(LoungeNormalIdleRecord other)
	{
		if (other != null)
		{
			if (other.LastRandTs != 0)
			{
				LastRandTs = other.LastRandTs;
			}
			if (other.StreakCount != 0)
			{
				StreakCount = other.StreakCount;
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
				LastRandTs = input.ReadInt32();
				break;
			case 16u:
				StreakCount = input.ReadInt32();
				break;
			}
		}
	}
}
