using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class Rank : IMessage<Rank>, IMessage, IEquatable<Rank>, IDeepCloneable<Rank>, IBufferMessage
{
	private static readonly MessageParser<Rank> _parser = new MessageParser<Rank>(() => new Rank());

	private UnknownFieldSet _unknownFields;

	public const int RankInfoFieldNumber = 1;

	private static readonly FieldCodec<RankInfo> _repeated_rankInfo_codec = FieldCodec.ForMessage(10u, ACT.Game.Data.RankInfo.Parser);

	private readonly RepeatedField<RankInfo> rankInfo_ = new RepeatedField<RankInfo>();

	public const int TotalNumFieldNumber = 2;

	private int totalNum_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<Rank> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[229];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<RankInfo> RankInfo => rankInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int TotalNum
	{
		get
		{
			return totalNum_;
		}
		set
		{
			totalNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Rank()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Rank(Rank other)
		: this()
	{
		rankInfo_ = other.rankInfo_.Clone();
		totalNum_ = other.totalNum_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Rank Clone()
	{
		return new Rank(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as Rank);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(Rank other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!rankInfo_.Equals(other.rankInfo_))
		{
			return false;
		}
		if (TotalNum != other.TotalNum)
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
		num ^= rankInfo_.GetHashCode();
		if (TotalNum != 0)
		{
			num ^= TotalNum.GetHashCode();
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
		rankInfo_.WriteTo(ref output, _repeated_rankInfo_codec);
		if (TotalNum != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(TotalNum);
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
		num += rankInfo_.CalculateSize(_repeated_rankInfo_codec);
		if (TotalNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TotalNum);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(Rank other)
	{
		if (other != null)
		{
			rankInfo_.Add(other.rankInfo_);
			if (other.TotalNum != 0)
			{
				TotalNum = other.TotalNum;
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
			case 10u:
				rankInfo_.AddEntriesFrom(ref input, _repeated_rankInfo_codec);
				break;
			case 16u:
				TotalNum = input.ReadInt32();
				break;
			}
		}
	}
}
