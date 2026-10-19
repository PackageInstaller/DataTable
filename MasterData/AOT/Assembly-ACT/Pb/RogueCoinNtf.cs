using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class RogueCoinNtf : IMessage<RogueCoinNtf>, IMessage, IEquatable<RogueCoinNtf>, IDeepCloneable<RogueCoinNtf>, IBufferMessage
{
	private static readonly MessageParser<RogueCoinNtf> _parser = new MessageParser<RogueCoinNtf>(() => new RogueCoinNtf());

	private UnknownFieldSet _unknownFields;

	public const int CoinFieldNumber = 1;

	private int coin_;

	public const int GainCoinFieldNumber = 2;

	private int gainCoin_;

	public const int CostCoinFieldNumber = 3;

	private int costCoin_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<RogueCoinNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => RogueReflection.Descriptor.MessageTypes[21];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Coin
	{
		get
		{
			return coin_;
		}
		set
		{
			coin_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int GainCoin
	{
		get
		{
			return gainCoin_;
		}
		set
		{
			gainCoin_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CostCoin
	{
		get
		{
			return costCoin_;
		}
		set
		{
			costCoin_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueCoinNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueCoinNtf(RogueCoinNtf other)
		: this()
	{
		coin_ = other.coin_;
		gainCoin_ = other.gainCoin_;
		costCoin_ = other.costCoin_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueCoinNtf Clone()
	{
		return new RogueCoinNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as RogueCoinNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(RogueCoinNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Coin != other.Coin)
		{
			return false;
		}
		if (GainCoin != other.GainCoin)
		{
			return false;
		}
		if (CostCoin != other.CostCoin)
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
		if (Coin != 0)
		{
			num ^= Coin.GetHashCode();
		}
		if (GainCoin != 0)
		{
			num ^= GainCoin.GetHashCode();
		}
		if (CostCoin != 0)
		{
			num ^= CostCoin.GetHashCode();
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
		if (Coin != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Coin);
		}
		if (GainCoin != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(GainCoin);
		}
		if (CostCoin != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(CostCoin);
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
		if (Coin != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Coin);
		}
		if (GainCoin != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GainCoin);
		}
		if (CostCoin != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CostCoin);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(RogueCoinNtf other)
	{
		if (other != null)
		{
			if (other.Coin != 0)
			{
				Coin = other.Coin;
			}
			if (other.GainCoin != 0)
			{
				GainCoin = other.GainCoin;
			}
			if (other.CostCoin != 0)
			{
				CostCoin = other.CostCoin;
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
				Coin = input.ReadInt32();
				break;
			case 16u:
				GainCoin = input.ReadInt32();
				break;
			case 24u:
				CostCoin = input.ReadInt32();
				break;
			}
		}
	}
}
