using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class RogueModifyCoinReq : IMessage<RogueModifyCoinReq>, IMessage, IEquatable<RogueModifyCoinReq>, IDeepCloneable<RogueModifyCoinReq>, IBufferMessage
{
	private static readonly MessageParser<RogueModifyCoinReq> _parser = new MessageParser<RogueModifyCoinReq>(() => new RogueModifyCoinReq());

	private UnknownFieldSet _unknownFields;

	public const int IsAddFieldNumber = 1;

	private bool isAdd_;

	public const int CoinNumFieldNumber = 2;

	private int coinNum_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<RogueModifyCoinReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => RogueReflection.Descriptor.MessageTypes[26];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool IsAdd
	{
		get
		{
			return isAdd_;
		}
		set
		{
			isAdd_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CoinNum
	{
		get
		{
			return coinNum_;
		}
		set
		{
			coinNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueModifyCoinReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueModifyCoinReq(RogueModifyCoinReq other)
		: this()
	{
		isAdd_ = other.isAdd_;
		coinNum_ = other.coinNum_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueModifyCoinReq Clone()
	{
		return new RogueModifyCoinReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as RogueModifyCoinReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(RogueModifyCoinReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (IsAdd != other.IsAdd)
		{
			return false;
		}
		if (CoinNum != other.CoinNum)
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
		if (IsAdd)
		{
			num ^= IsAdd.GetHashCode();
		}
		if (CoinNum != 0)
		{
			num ^= CoinNum.GetHashCode();
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
		if (IsAdd)
		{
			output.WriteRawTag(8);
			output.WriteBool(IsAdd);
		}
		if (CoinNum != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(CoinNum);
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
		if (IsAdd)
		{
			num += 2;
		}
		if (CoinNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CoinNum);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(RogueModifyCoinReq other)
	{
		if (other != null)
		{
			if (other.IsAdd)
			{
				IsAdd = other.IsAdd;
			}
			if (other.CoinNum != 0)
			{
				CoinNum = other.CoinNum;
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
				IsAdd = input.ReadBool();
				break;
			case 16u:
				CoinNum = input.ReadInt32();
				break;
			}
		}
	}
}
