using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class RaidTakeRewardsReq : IMessage<RaidTakeRewardsReq>, IMessage, IEquatable<RaidTakeRewardsReq>, IDeepCloneable<RaidTakeRewardsReq>, IBufferMessage
{
	private static readonly MessageParser<RaidTakeRewardsReq> _parser = new MessageParser<RaidTakeRewardsReq>(() => new RaidTakeRewardsReq());

	private UnknownFieldSet _unknownFields;

	public const int RewardRateFieldNumber = 1;

	private int rewardRate_;

	public const int SettleInfoFieldNumber = 2;

	private StageSettleInfo settleInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<RaidTakeRewardsReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => RaidReflection.Descriptor.MessageTypes[6];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int RewardRate
	{
		get
		{
			return rewardRate_;
		}
		set
		{
			rewardRate_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public StageSettleInfo SettleInfo
	{
		get
		{
			return settleInfo_;
		}
		set
		{
			settleInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RaidTakeRewardsReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RaidTakeRewardsReq(RaidTakeRewardsReq other)
		: this()
	{
		rewardRate_ = other.rewardRate_;
		settleInfo_ = ((other.settleInfo_ != null) ? other.settleInfo_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RaidTakeRewardsReq Clone()
	{
		return new RaidTakeRewardsReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as RaidTakeRewardsReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(RaidTakeRewardsReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (RewardRate != other.RewardRate)
		{
			return false;
		}
		if (!object.Equals(SettleInfo, other.SettleInfo))
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
		if (RewardRate != 0)
		{
			num ^= RewardRate.GetHashCode();
		}
		if (settleInfo_ != null)
		{
			num ^= SettleInfo.GetHashCode();
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
		if (RewardRate != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(RewardRate);
		}
		if (settleInfo_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(SettleInfo);
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
		if (RewardRate != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardRate);
		}
		if (settleInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(SettleInfo);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(RaidTakeRewardsReq other)
	{
		if (other == null)
		{
			return;
		}
		if (other.RewardRate != 0)
		{
			RewardRate = other.RewardRate;
		}
		if (other.settleInfo_ != null)
		{
			if (settleInfo_ == null)
			{
				SettleInfo = new StageSettleInfo();
			}
			SettleInfo.MergeFrom(other.SettleInfo);
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
			case 8u:
				RewardRate = input.ReadInt32();
				break;
			case 18u:
				if (settleInfo_ == null)
				{
					SettleInfo = new StageSettleInfo();
				}
				input.ReadMessage(SettleInfo);
				break;
			}
		}
	}
}
