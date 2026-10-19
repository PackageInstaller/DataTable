using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Core;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class DailyData : IMessage<DailyData>, IMessage, IEquatable<DailyData>, IDeepCloneable<DailyData>, IBufferMessage
{
	private static readonly MessageParser<DailyData> _parser = new MessageParser<DailyData>(() => new DailyData());

	private UnknownFieldSet _unknownFields;

	public const int LastUpdateTSFieldNumber = 1;

	private int lastUpdateTS_;

	public const int GachaNumFieldNumber = 2;

	private int gachaNum_;

	public const int LoginDayCountFieldNumber = 3;

	private int loginDayCount_;

	public const int LastWeeklyUpdateTSFieldNumber = 5;

	private int lastWeeklyUpdateTS_;

	public const int DailySentCharacterGiftCountFieldNumber = 8;

	private int dailySentCharacterGiftCount_;

	public const int HandbookRewardStatusFieldNumber = 9;

	private HandbookRewardStatus handbookRewardStatus_;

	public const int WildBossTakeRewardCountFieldNumber = 10;

	private int wildBossTakeRewardCount_;

	public const int WildBossRewardBoughtCountFieldNumber = 11;

	private int wildBossRewardBoughtCount_;

	public const int WildBossRewardExtraCountFieldNumber = 12;

	private int wildBossRewardExtraCount_;

	public const int CollectionGetItemsFieldNumber = 13;

	private static readonly MapField<int, int>.Codec _map_collectionGetItems_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 106u);

	private readonly MapField<int, int> collectionGetItems_ = new MapField<int, int>();

	public const int WildBossRewardCycleTakeCountFieldNumber = 14;

	private int wildBossRewardCycleTakeCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<DailyData> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[148];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int LastUpdateTS
	{
		get
		{
			return lastUpdateTS_;
		}
		set
		{
			lastUpdateTS_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int GachaNum
	{
		get
		{
			return gachaNum_;
		}
		set
		{
			gachaNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int LoginDayCount
	{
		get
		{
			return loginDayCount_;
		}
		set
		{
			loginDayCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int LastWeeklyUpdateTS
	{
		get
		{
			return lastWeeklyUpdateTS_;
		}
		set
		{
			lastWeeklyUpdateTS_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int DailySentCharacterGiftCount
	{
		get
		{
			return dailySentCharacterGiftCount_;
		}
		set
		{
			dailySentCharacterGiftCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public HandbookRewardStatus HandbookRewardStatus
	{
		get
		{
			return handbookRewardStatus_;
		}
		set
		{
			handbookRewardStatus_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int WildBossTakeRewardCount
	{
		get
		{
			return wildBossTakeRewardCount_;
		}
		set
		{
			wildBossTakeRewardCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int WildBossRewardBoughtCount
	{
		get
		{
			return wildBossRewardBoughtCount_;
		}
		set
		{
			wildBossRewardBoughtCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int WildBossRewardExtraCount
	{
		get
		{
			return wildBossRewardExtraCount_;
		}
		set
		{
			wildBossRewardExtraCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> CollectionGetItems => collectionGetItems_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int WildBossRewardCycleTakeCount
	{
		get
		{
			return wildBossRewardCycleTakeCount_;
		}
		set
		{
			wildBossRewardCycleTakeCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DailyData()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DailyData(DailyData other)
		: this()
	{
		lastUpdateTS_ = other.lastUpdateTS_;
		gachaNum_ = other.gachaNum_;
		loginDayCount_ = other.loginDayCount_;
		lastWeeklyUpdateTS_ = other.lastWeeklyUpdateTS_;
		dailySentCharacterGiftCount_ = other.dailySentCharacterGiftCount_;
		handbookRewardStatus_ = ((other.handbookRewardStatus_ != null) ? other.handbookRewardStatus_.Clone() : null);
		wildBossTakeRewardCount_ = other.wildBossTakeRewardCount_;
		wildBossRewardBoughtCount_ = other.wildBossRewardBoughtCount_;
		wildBossRewardExtraCount_ = other.wildBossRewardExtraCount_;
		collectionGetItems_ = other.collectionGetItems_.Clone();
		wildBossRewardCycleTakeCount_ = other.wildBossRewardCycleTakeCount_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DailyData Clone()
	{
		return new DailyData(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as DailyData);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(DailyData other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (LastUpdateTS != other.LastUpdateTS)
		{
			return false;
		}
		if (GachaNum != other.GachaNum)
		{
			return false;
		}
		if (LoginDayCount != other.LoginDayCount)
		{
			return false;
		}
		if (LastWeeklyUpdateTS != other.LastWeeklyUpdateTS)
		{
			return false;
		}
		if (DailySentCharacterGiftCount != other.DailySentCharacterGiftCount)
		{
			return false;
		}
		if (!object.Equals(HandbookRewardStatus, other.HandbookRewardStatus))
		{
			return false;
		}
		if (WildBossTakeRewardCount != other.WildBossTakeRewardCount)
		{
			return false;
		}
		if (WildBossRewardBoughtCount != other.WildBossRewardBoughtCount)
		{
			return false;
		}
		if (WildBossRewardExtraCount != other.WildBossRewardExtraCount)
		{
			return false;
		}
		if (!CollectionGetItems.Equals(other.CollectionGetItems))
		{
			return false;
		}
		if (WildBossRewardCycleTakeCount != other.WildBossRewardCycleTakeCount)
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
		if (LastUpdateTS != 0)
		{
			num ^= LastUpdateTS.GetHashCode();
		}
		if (GachaNum != 0)
		{
			num ^= GachaNum.GetHashCode();
		}
		if (LoginDayCount != 0)
		{
			num ^= LoginDayCount.GetHashCode();
		}
		if (LastWeeklyUpdateTS != 0)
		{
			num ^= LastWeeklyUpdateTS.GetHashCode();
		}
		if (DailySentCharacterGiftCount != 0)
		{
			num ^= DailySentCharacterGiftCount.GetHashCode();
		}
		if (handbookRewardStatus_ != null)
		{
			num ^= HandbookRewardStatus.GetHashCode();
		}
		if (WildBossTakeRewardCount != 0)
		{
			num ^= WildBossTakeRewardCount.GetHashCode();
		}
		if (WildBossRewardBoughtCount != 0)
		{
			num ^= WildBossRewardBoughtCount.GetHashCode();
		}
		if (WildBossRewardExtraCount != 0)
		{
			num ^= WildBossRewardExtraCount.GetHashCode();
		}
		num ^= CollectionGetItems.GetHashCode();
		if (WildBossRewardCycleTakeCount != 0)
		{
			num ^= WildBossRewardCycleTakeCount.GetHashCode();
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
		if (LastUpdateTS != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(LastUpdateTS);
		}
		if (GachaNum != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(GachaNum);
		}
		if (LoginDayCount != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(LoginDayCount);
		}
		if (LastWeeklyUpdateTS != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(LastWeeklyUpdateTS);
		}
		if (DailySentCharacterGiftCount != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(DailySentCharacterGiftCount);
		}
		if (handbookRewardStatus_ != null)
		{
			output.WriteRawTag(74);
			output.WriteMessage(HandbookRewardStatus);
		}
		if (WildBossTakeRewardCount != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(WildBossTakeRewardCount);
		}
		if (WildBossRewardBoughtCount != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(WildBossRewardBoughtCount);
		}
		if (WildBossRewardExtraCount != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(WildBossRewardExtraCount);
		}
		collectionGetItems_.WriteTo(ref output, _map_collectionGetItems_codec);
		if (WildBossRewardCycleTakeCount != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(WildBossRewardCycleTakeCount);
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
		if (LastUpdateTS != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LastUpdateTS);
		}
		if (GachaNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GachaNum);
		}
		if (LoginDayCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LoginDayCount);
		}
		if (LastWeeklyUpdateTS != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LastWeeklyUpdateTS);
		}
		if (DailySentCharacterGiftCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DailySentCharacterGiftCount);
		}
		if (handbookRewardStatus_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(HandbookRewardStatus);
		}
		if (WildBossTakeRewardCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WildBossTakeRewardCount);
		}
		if (WildBossRewardBoughtCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WildBossRewardBoughtCount);
		}
		if (WildBossRewardExtraCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WildBossRewardExtraCount);
		}
		num += collectionGetItems_.CalculateSize(_map_collectionGetItems_codec);
		if (WildBossRewardCycleTakeCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WildBossRewardCycleTakeCount);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(DailyData other)
	{
		if (other == null)
		{
			return;
		}
		if (other.LastUpdateTS != 0)
		{
			LastUpdateTS = other.LastUpdateTS;
		}
		if (other.GachaNum != 0)
		{
			GachaNum = other.GachaNum;
		}
		if (other.LoginDayCount != 0)
		{
			LoginDayCount = other.LoginDayCount;
		}
		if (other.LastWeeklyUpdateTS != 0)
		{
			LastWeeklyUpdateTS = other.LastWeeklyUpdateTS;
		}
		if (other.DailySentCharacterGiftCount != 0)
		{
			DailySentCharacterGiftCount = other.DailySentCharacterGiftCount;
		}
		if (other.handbookRewardStatus_ != null)
		{
			if (handbookRewardStatus_ == null)
			{
				HandbookRewardStatus = new HandbookRewardStatus();
			}
			HandbookRewardStatus.MergeFrom(other.HandbookRewardStatus);
		}
		if (other.WildBossTakeRewardCount != 0)
		{
			WildBossTakeRewardCount = other.WildBossTakeRewardCount;
		}
		if (other.WildBossRewardBoughtCount != 0)
		{
			WildBossRewardBoughtCount = other.WildBossRewardBoughtCount;
		}
		if (other.WildBossRewardExtraCount != 0)
		{
			WildBossRewardExtraCount = other.WildBossRewardExtraCount;
		}
		collectionGetItems_.Add(other.collectionGetItems_);
		if (other.WildBossRewardCycleTakeCount != 0)
		{
			WildBossRewardCycleTakeCount = other.WildBossRewardCycleTakeCount;
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
				LastUpdateTS = input.ReadInt32();
				break;
			case 16u:
				GachaNum = input.ReadInt32();
				break;
			case 24u:
				LoginDayCount = input.ReadInt32();
				break;
			case 40u:
				LastWeeklyUpdateTS = input.ReadInt32();
				break;
			case 64u:
				DailySentCharacterGiftCount = input.ReadInt32();
				break;
			case 74u:
				if (handbookRewardStatus_ == null)
				{
					HandbookRewardStatus = new HandbookRewardStatus();
				}
				input.ReadMessage(HandbookRewardStatus);
				break;
			case 80u:
				WildBossTakeRewardCount = input.ReadInt32();
				break;
			case 88u:
				WildBossRewardBoughtCount = input.ReadInt32();
				break;
			case 96u:
				WildBossRewardExtraCount = input.ReadInt32();
				break;
			case 106u:
				collectionGetItems_.AddEntriesFrom(ref input, _map_collectionGetItems_codec);
				break;
			case 112u:
				WildBossRewardCycleTakeCount = input.ReadInt32();
				break;
			}
		}
	}

	public int GetTotalWeeklyBossDiscountTimes()
	{
		return RuntimeConfigs.data.game.WeekBossDiscount.count;
	}

	public int GetAvailableWeeklyBossDiscountTimes()
	{
		return RuntimeConfigs.data.game.WeekBossDiscount.count;
	}

	public bool HasWeeklyBossGetRewardCount(int weeklyBossId)
	{
		return true;
	}
}
