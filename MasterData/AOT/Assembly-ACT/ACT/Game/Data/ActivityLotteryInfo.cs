using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class ActivityLotteryInfo : IMessage<ActivityLotteryInfo>, IMessage, IEquatable<ActivityLotteryInfo>, IDeepCloneable<ActivityLotteryInfo>, IBufferMessage
{
	private static readonly MessageParser<ActivityLotteryInfo> _parser = new MessageParser<ActivityLotteryInfo>(() => new ActivityLotteryInfo());

	private UnknownFieldSet _unknownFields;

	public const int LotteryPoolIdFieldNumber = 1;

	private int lotteryPoolId_;

	public const int TotalGachaConutFieldNumber = 2;

	private int totalGachaConut_;

	public const int TodayGachaConutFieldNumber = 4;

	private int todayGachaConut_;

	public const int LeftGachaConutFieldNumber = 5;

	private int leftGachaConut_;

	public const int GachaConutFieldNumber = 6;

	private int gachaConut_;

	public const int PityConutFieldNumber = 7;

	private int pityConut_;

	public const int PrizeInfoFieldNumber = 8;

	private static readonly MapField<int, int>.Codec _map_prizeInfo_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 66u);

	private readonly MapField<int, int> prizeInfo_ = new MapField<int, int>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ActivityLotteryInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[264];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int LotteryPoolId
	{
		get
		{
			return lotteryPoolId_;
		}
		set
		{
			lotteryPoolId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int TotalGachaConut
	{
		get
		{
			return totalGachaConut_;
		}
		set
		{
			totalGachaConut_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int TodayGachaConut
	{
		get
		{
			return todayGachaConut_;
		}
		set
		{
			todayGachaConut_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int LeftGachaConut
	{
		get
		{
			return leftGachaConut_;
		}
		set
		{
			leftGachaConut_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int GachaConut
	{
		get
		{
			return gachaConut_;
		}
		set
		{
			gachaConut_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int PityConut
	{
		get
		{
			return pityConut_;
		}
		set
		{
			pityConut_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> PrizeInfo => prizeInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityLotteryInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityLotteryInfo(ActivityLotteryInfo other)
		: this()
	{
		lotteryPoolId_ = other.lotteryPoolId_;
		totalGachaConut_ = other.totalGachaConut_;
		todayGachaConut_ = other.todayGachaConut_;
		leftGachaConut_ = other.leftGachaConut_;
		gachaConut_ = other.gachaConut_;
		pityConut_ = other.pityConut_;
		prizeInfo_ = other.prizeInfo_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityLotteryInfo Clone()
	{
		return new ActivityLotteryInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityLotteryInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ActivityLotteryInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (LotteryPoolId != other.LotteryPoolId)
		{
			return false;
		}
		if (TotalGachaConut != other.TotalGachaConut)
		{
			return false;
		}
		if (TodayGachaConut != other.TodayGachaConut)
		{
			return false;
		}
		if (LeftGachaConut != other.LeftGachaConut)
		{
			return false;
		}
		if (GachaConut != other.GachaConut)
		{
			return false;
		}
		if (PityConut != other.PityConut)
		{
			return false;
		}
		if (!PrizeInfo.Equals(other.PrizeInfo))
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
		if (LotteryPoolId != 0)
		{
			num ^= LotteryPoolId.GetHashCode();
		}
		if (TotalGachaConut != 0)
		{
			num ^= TotalGachaConut.GetHashCode();
		}
		if (TodayGachaConut != 0)
		{
			num ^= TodayGachaConut.GetHashCode();
		}
		if (LeftGachaConut != 0)
		{
			num ^= LeftGachaConut.GetHashCode();
		}
		if (GachaConut != 0)
		{
			num ^= GachaConut.GetHashCode();
		}
		if (PityConut != 0)
		{
			num ^= PityConut.GetHashCode();
		}
		num ^= PrizeInfo.GetHashCode();
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
		if (LotteryPoolId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(LotteryPoolId);
		}
		if (TotalGachaConut != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(TotalGachaConut);
		}
		if (TodayGachaConut != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(TodayGachaConut);
		}
		if (LeftGachaConut != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(LeftGachaConut);
		}
		if (GachaConut != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(GachaConut);
		}
		if (PityConut != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(PityConut);
		}
		prizeInfo_.WriteTo(ref output, _map_prizeInfo_codec);
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
		if (LotteryPoolId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LotteryPoolId);
		}
		if (TotalGachaConut != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TotalGachaConut);
		}
		if (TodayGachaConut != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TodayGachaConut);
		}
		if (LeftGachaConut != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LeftGachaConut);
		}
		if (GachaConut != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GachaConut);
		}
		if (PityConut != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PityConut);
		}
		num += prizeInfo_.CalculateSize(_map_prizeInfo_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ActivityLotteryInfo other)
	{
		if (other != null)
		{
			if (other.LotteryPoolId != 0)
			{
				LotteryPoolId = other.LotteryPoolId;
			}
			if (other.TotalGachaConut != 0)
			{
				TotalGachaConut = other.TotalGachaConut;
			}
			if (other.TodayGachaConut != 0)
			{
				TodayGachaConut = other.TodayGachaConut;
			}
			if (other.LeftGachaConut != 0)
			{
				LeftGachaConut = other.LeftGachaConut;
			}
			if (other.GachaConut != 0)
			{
				GachaConut = other.GachaConut;
			}
			if (other.PityConut != 0)
			{
				PityConut = other.PityConut;
			}
			prizeInfo_.Add(other.prizeInfo_);
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
				LotteryPoolId = input.ReadInt32();
				break;
			case 16u:
				TotalGachaConut = input.ReadInt32();
				break;
			case 32u:
				TodayGachaConut = input.ReadInt32();
				break;
			case 40u:
				LeftGachaConut = input.ReadInt32();
				break;
			case 48u:
				GachaConut = input.ReadInt32();
				break;
			case 56u:
				PityConut = input.ReadInt32();
				break;
			case 66u:
				prizeInfo_.AddEntriesFrom(ref input, _map_prizeInfo_codec);
				break;
			}
		}
	}
}
