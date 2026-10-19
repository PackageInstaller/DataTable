using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class RogueGameInfo : IMessage<RogueGameInfo>, IMessage, IEquatable<RogueGameInfo>, IDeepCloneable<RogueGameInfo>, IBufferMessage
{
	private static readonly MessageParser<RogueGameInfo> _parser = new MessageParser<RogueGameInfo>(() => new RogueGameInfo());

	private UnknownFieldSet _unknownFields;

	public const int SeedFieldNumber = 1;

	private long seed_;

	public const int ModeIdFieldNumber = 2;

	private int modeId_;

	public const int IndexFieldNumber = 3;

	private int index_;

	public const int CoreIdFieldNumber = 4;

	private int coreId_;

	public const int RoomInfoFieldNumber = 6;

	private RogueRoomInfo roomInfo_;

	public const int CoinFieldNumber = 7;

	private int coin_;

	public const int ItemFieldNumber = 8;

	private static readonly MapField<int, RogueItem>.Codec _map_item_codec = new MapField<int, RogueItem>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, RogueItem.Parser), 66u);

	private readonly MapField<int, RogueItem> item_ = new MapField<int, RogueItem>();

	public const int LeftUseFieldNumber = 9;

	private static readonly MapField<int, int>.Codec _map_leftUse_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 74u);

	private readonly MapField<int, int> leftUse_ = new MapField<int, int>();

	public const int BattleCharacterFieldNumber = 10;

	private CharacterRepository battleCharacter_;

	public const int GainCoinFieldNumber = 11;

	private int gainCoin_;

	public const int CostCoinFieldNumber = 12;

	private int costCoin_;

	public const int RoomRecordFieldNumber = 13;

	private static readonly MapField<int, RogueRoomRecord>.Codec _map_roomRecord_codec = new MapField<int, RogueRoomRecord>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, RogueRoomRecord.Parser), 106u);

	private readonly MapField<int, RogueRoomRecord> roomRecord_ = new MapField<int, RogueRoomRecord>();

	public const int BattleInfoFieldNumber = 14;

	private static readonly MapField<int, int>.Codec _map_battleInfo_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 114u);

	private readonly MapField<int, int> battleInfo_ = new MapField<int, int>();

	public const int EffectInfoFieldNumber = 15;

	private static readonly MapField<int, int>.Codec _map_effectInfo_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 122u);

	private readonly MapField<int, int> effectInfo_ = new MapField<int, int>();

	public const int TempInfoFieldNumber = 16;

	private RogueTempInfo tempInfo_;

	public const int CharacterProbationIdFieldNumber = 17;

	private int characterProbationId_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<RogueGameInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[238];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long Seed
	{
		get
		{
			return seed_;
		}
		set
		{
			seed_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ModeId
	{
		get
		{
			return modeId_;
		}
		set
		{
			modeId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Index
	{
		get
		{
			return index_;
		}
		set
		{
			index_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CoreId
	{
		get
		{
			return coreId_;
		}
		set
		{
			coreId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueRoomInfo RoomInfo
	{
		get
		{
			return roomInfo_;
		}
		set
		{
			roomInfo_ = value;
		}
	}

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
	public MapField<int, RogueItem> Item => item_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> LeftUse => leftUse_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterRepository BattleCharacter
	{
		get
		{
			return battleCharacter_;
		}
		set
		{
			battleCharacter_ = value;
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
	public MapField<int, RogueRoomRecord> RoomRecord => roomRecord_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> BattleInfo => battleInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> EffectInfo => effectInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueTempInfo TempInfo
	{
		get
		{
			return tempInfo_;
		}
		set
		{
			tempInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CharacterProbationId
	{
		get
		{
			return characterProbationId_;
		}
		set
		{
			characterProbationId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueGameInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueGameInfo(RogueGameInfo other)
		: this()
	{
		seed_ = other.seed_;
		modeId_ = other.modeId_;
		index_ = other.index_;
		coreId_ = other.coreId_;
		roomInfo_ = ((other.roomInfo_ != null) ? other.roomInfo_.Clone() : null);
		coin_ = other.coin_;
		item_ = other.item_.Clone();
		leftUse_ = other.leftUse_.Clone();
		battleCharacter_ = ((other.battleCharacter_ != null) ? other.battleCharacter_.Clone() : null);
		gainCoin_ = other.gainCoin_;
		costCoin_ = other.costCoin_;
		roomRecord_ = other.roomRecord_.Clone();
		battleInfo_ = other.battleInfo_.Clone();
		effectInfo_ = other.effectInfo_.Clone();
		tempInfo_ = ((other.tempInfo_ != null) ? other.tempInfo_.Clone() : null);
		characterProbationId_ = other.characterProbationId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueGameInfo Clone()
	{
		return new RogueGameInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as RogueGameInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(RogueGameInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Seed != other.Seed)
		{
			return false;
		}
		if (ModeId != other.ModeId)
		{
			return false;
		}
		if (Index != other.Index)
		{
			return false;
		}
		if (CoreId != other.CoreId)
		{
			return false;
		}
		if (!object.Equals(RoomInfo, other.RoomInfo))
		{
			return false;
		}
		if (Coin != other.Coin)
		{
			return false;
		}
		if (!Item.Equals(other.Item))
		{
			return false;
		}
		if (!LeftUse.Equals(other.LeftUse))
		{
			return false;
		}
		if (!object.Equals(BattleCharacter, other.BattleCharacter))
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
		if (!RoomRecord.Equals(other.RoomRecord))
		{
			return false;
		}
		if (!BattleInfo.Equals(other.BattleInfo))
		{
			return false;
		}
		if (!EffectInfo.Equals(other.EffectInfo))
		{
			return false;
		}
		if (!object.Equals(TempInfo, other.TempInfo))
		{
			return false;
		}
		if (CharacterProbationId != other.CharacterProbationId)
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
		if (Seed != 0L)
		{
			num ^= Seed.GetHashCode();
		}
		if (ModeId != 0)
		{
			num ^= ModeId.GetHashCode();
		}
		if (Index != 0)
		{
			num ^= Index.GetHashCode();
		}
		if (CoreId != 0)
		{
			num ^= CoreId.GetHashCode();
		}
		if (roomInfo_ != null)
		{
			num ^= RoomInfo.GetHashCode();
		}
		if (Coin != 0)
		{
			num ^= Coin.GetHashCode();
		}
		num ^= Item.GetHashCode();
		num ^= LeftUse.GetHashCode();
		if (battleCharacter_ != null)
		{
			num ^= BattleCharacter.GetHashCode();
		}
		if (GainCoin != 0)
		{
			num ^= GainCoin.GetHashCode();
		}
		if (CostCoin != 0)
		{
			num ^= CostCoin.GetHashCode();
		}
		num ^= RoomRecord.GetHashCode();
		num ^= BattleInfo.GetHashCode();
		num ^= EffectInfo.GetHashCode();
		if (tempInfo_ != null)
		{
			num ^= TempInfo.GetHashCode();
		}
		if (CharacterProbationId != 0)
		{
			num ^= CharacterProbationId.GetHashCode();
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
		if (Seed != 0L)
		{
			output.WriteRawTag(8);
			output.WriteInt64(Seed);
		}
		if (ModeId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ModeId);
		}
		if (Index != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Index);
		}
		if (CoreId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(CoreId);
		}
		if (roomInfo_ != null)
		{
			output.WriteRawTag(50);
			output.WriteMessage(RoomInfo);
		}
		if (Coin != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Coin);
		}
		item_.WriteTo(ref output, _map_item_codec);
		leftUse_.WriteTo(ref output, _map_leftUse_codec);
		if (battleCharacter_ != null)
		{
			output.WriteRawTag(82);
			output.WriteMessage(BattleCharacter);
		}
		if (GainCoin != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(GainCoin);
		}
		if (CostCoin != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(CostCoin);
		}
		roomRecord_.WriteTo(ref output, _map_roomRecord_codec);
		battleInfo_.WriteTo(ref output, _map_battleInfo_codec);
		effectInfo_.WriteTo(ref output, _map_effectInfo_codec);
		if (tempInfo_ != null)
		{
			output.WriteRawTag(130, 1);
			output.WriteMessage(TempInfo);
		}
		if (CharacterProbationId != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(CharacterProbationId);
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
		if (Seed != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(Seed);
		}
		if (ModeId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ModeId);
		}
		if (Index != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Index);
		}
		if (CoreId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CoreId);
		}
		if (roomInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(RoomInfo);
		}
		if (Coin != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Coin);
		}
		num += item_.CalculateSize(_map_item_codec);
		num += leftUse_.CalculateSize(_map_leftUse_codec);
		if (battleCharacter_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(BattleCharacter);
		}
		if (GainCoin != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GainCoin);
		}
		if (CostCoin != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CostCoin);
		}
		num += roomRecord_.CalculateSize(_map_roomRecord_codec);
		num += battleInfo_.CalculateSize(_map_battleInfo_codec);
		num += effectInfo_.CalculateSize(_map_effectInfo_codec);
		if (tempInfo_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(TempInfo);
		}
		if (CharacterProbationId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(CharacterProbationId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(RogueGameInfo other)
	{
		if (other == null)
		{
			return;
		}
		if (other.Seed != 0L)
		{
			Seed = other.Seed;
		}
		if (other.ModeId != 0)
		{
			ModeId = other.ModeId;
		}
		if (other.Index != 0)
		{
			Index = other.Index;
		}
		if (other.CoreId != 0)
		{
			CoreId = other.CoreId;
		}
		if (other.roomInfo_ != null)
		{
			if (roomInfo_ == null)
			{
				RoomInfo = new RogueRoomInfo();
			}
			RoomInfo.MergeFrom(other.RoomInfo);
		}
		if (other.Coin != 0)
		{
			Coin = other.Coin;
		}
		item_.Add(other.item_);
		leftUse_.Add(other.leftUse_);
		if (other.battleCharacter_ != null)
		{
			if (battleCharacter_ == null)
			{
				BattleCharacter = new CharacterRepository();
			}
			BattleCharacter.MergeFrom(other.BattleCharacter);
		}
		if (other.GainCoin != 0)
		{
			GainCoin = other.GainCoin;
		}
		if (other.CostCoin != 0)
		{
			CostCoin = other.CostCoin;
		}
		roomRecord_.Add(other.roomRecord_);
		battleInfo_.Add(other.battleInfo_);
		effectInfo_.Add(other.effectInfo_);
		if (other.tempInfo_ != null)
		{
			if (tempInfo_ == null)
			{
				TempInfo = new RogueTempInfo();
			}
			TempInfo.MergeFrom(other.TempInfo);
		}
		if (other.CharacterProbationId != 0)
		{
			CharacterProbationId = other.CharacterProbationId;
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
				Seed = input.ReadInt64();
				break;
			case 16u:
				ModeId = input.ReadInt32();
				break;
			case 24u:
				Index = input.ReadInt32();
				break;
			case 32u:
				CoreId = input.ReadInt32();
				break;
			case 50u:
				if (roomInfo_ == null)
				{
					RoomInfo = new RogueRoomInfo();
				}
				input.ReadMessage(RoomInfo);
				break;
			case 56u:
				Coin = input.ReadInt32();
				break;
			case 66u:
				item_.AddEntriesFrom(ref input, _map_item_codec);
				break;
			case 74u:
				leftUse_.AddEntriesFrom(ref input, _map_leftUse_codec);
				break;
			case 82u:
				if (battleCharacter_ == null)
				{
					BattleCharacter = new CharacterRepository();
				}
				input.ReadMessage(BattleCharacter);
				break;
			case 88u:
				GainCoin = input.ReadInt32();
				break;
			case 96u:
				CostCoin = input.ReadInt32();
				break;
			case 106u:
				roomRecord_.AddEntriesFrom(ref input, _map_roomRecord_codec);
				break;
			case 114u:
				battleInfo_.AddEntriesFrom(ref input, _map_battleInfo_codec);
				break;
			case 122u:
				effectInfo_.AddEntriesFrom(ref input, _map_effectInfo_codec);
				break;
			case 130u:
				if (tempInfo_ == null)
				{
					TempInfo = new RogueTempInfo();
				}
				input.ReadMessage(TempInfo);
				break;
			case 136u:
				CharacterProbationId = input.ReadInt32();
				break;
			}
		}
	}
}
