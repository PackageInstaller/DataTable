using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class Commodity : IMessage<Commodity>, IMessage, IEquatable<Commodity>, IDeepCloneable<Commodity>, IBufferMessage
{
	private static readonly MessageParser<Commodity> _parser = new MessageParser<Commodity>(() => new Commodity());

	private UnknownFieldSet _unknownFields;

	public const int IdxFieldNumber = 1;

	private int idx_;

	public const int BoughtNumFieldNumber = 2;

	private int boughtNum_;

	public const int LastRefreshTsFieldNumber = 3;

	private long lastRefreshTs_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<Commodity> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[101];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Idx
	{
		get
		{
			return idx_;
		}
		set
		{
			idx_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int BoughtNum
	{
		get
		{
			return boughtNum_;
		}
		set
		{
			boughtNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long LastRefreshTs
	{
		get
		{
			return lastRefreshTs_;
		}
		set
		{
			lastRefreshTs_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Commodity()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Commodity(Commodity other)
		: this()
	{
		idx_ = other.idx_;
		boughtNum_ = other.boughtNum_;
		lastRefreshTs_ = other.lastRefreshTs_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Commodity Clone()
	{
		return new Commodity(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as Commodity);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(Commodity other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Idx != other.Idx)
		{
			return false;
		}
		if (BoughtNum != other.BoughtNum)
		{
			return false;
		}
		if (LastRefreshTs != other.LastRefreshTs)
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
		if (Idx != 0)
		{
			num ^= Idx.GetHashCode();
		}
		if (BoughtNum != 0)
		{
			num ^= BoughtNum.GetHashCode();
		}
		if (LastRefreshTs != 0L)
		{
			num ^= LastRefreshTs.GetHashCode();
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
		if (Idx != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Idx);
		}
		if (BoughtNum != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(BoughtNum);
		}
		if (LastRefreshTs != 0L)
		{
			output.WriteRawTag(24);
			output.WriteInt64(LastRefreshTs);
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
		if (Idx != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Idx);
		}
		if (BoughtNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BoughtNum);
		}
		if (LastRefreshTs != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(LastRefreshTs);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(Commodity other)
	{
		if (other != null)
		{
			if (other.Idx != 0)
			{
				Idx = other.Idx;
			}
			if (other.BoughtNum != 0)
			{
				BoughtNum = other.BoughtNum;
			}
			if (other.LastRefreshTs != 0L)
			{
				LastRefreshTs = other.LastRefreshTs;
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
				Idx = input.ReadInt32();
				break;
			case 16u:
				BoughtNum = input.ReadInt32();
				break;
			case 24u:
				LastRefreshTs = input.ReadInt64();
				break;
			}
		}
	}
}
