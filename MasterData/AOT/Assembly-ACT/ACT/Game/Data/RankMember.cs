using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class RankMember : IMessage<RankMember>, IMessage, IEquatable<RankMember>, IDeepCloneable<RankMember>, IBufferMessage
{
	private static readonly MessageParser<RankMember> _parser = new MessageParser<RankMember>(() => new RankMember());

	private UnknownFieldSet _unknownFields;

	public const int BriefFieldNumber = 1;

	private BriefUserInfo brief_;

	public const int DataFieldNumber = 2;

	private long data_;

	public const int RankFieldNumber = 3;

	private int rank_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<RankMember> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[13];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BriefUserInfo Brief
	{
		get
		{
			return brief_;
		}
		set
		{
			brief_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long Data
	{
		get
		{
			return data_;
		}
		set
		{
			data_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Rank
	{
		get
		{
			return rank_;
		}
		set
		{
			rank_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RankMember()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RankMember(RankMember other)
		: this()
	{
		brief_ = ((other.brief_ != null) ? other.brief_.Clone() : null);
		data_ = other.data_;
		rank_ = other.rank_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RankMember Clone()
	{
		return new RankMember(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as RankMember);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(RankMember other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(Brief, other.Brief))
		{
			return false;
		}
		if (Data != other.Data)
		{
			return false;
		}
		if (Rank != other.Rank)
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
		if (brief_ != null)
		{
			num ^= Brief.GetHashCode();
		}
		if (Data != 0L)
		{
			num ^= Data.GetHashCode();
		}
		if (Rank != 0)
		{
			num ^= Rank.GetHashCode();
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
		if (brief_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(Brief);
		}
		if (Data != 0L)
		{
			output.WriteRawTag(16);
			output.WriteInt64(Data);
		}
		if (Rank != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Rank);
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
		if (brief_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Brief);
		}
		if (Data != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(Data);
		}
		if (Rank != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Rank);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(RankMember other)
	{
		if (other == null)
		{
			return;
		}
		if (other.brief_ != null)
		{
			if (brief_ == null)
			{
				Brief = new BriefUserInfo();
			}
			Brief.MergeFrom(other.Brief);
		}
		if (other.Data != 0L)
		{
			Data = other.Data;
		}
		if (other.Rank != 0)
		{
			Rank = other.Rank;
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
				if (brief_ == null)
				{
					Brief = new BriefUserInfo();
				}
				input.ReadMessage(Brief);
				break;
			case 16u:
				Data = input.ReadInt64();
				break;
			case 24u:
				Rank = input.ReadInt32();
				break;
			}
		}
	}
}
