using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class RogueTempInfo : IMessage<RogueTempInfo>, IMessage, IEquatable<RogueTempInfo>, IDeepCloneable<RogueTempInfo>, IBufferMessage
{
	private static readonly MessageParser<RogueTempInfo> _parser = new MessageParser<RogueTempInfo>(() => new RogueTempInfo());

	private UnknownFieldSet _unknownFields;

	public const int RewardFieldNumber = 1;

	private bool reward_;

	public const int GainCoinFieldNumber = 2;

	private int gainCoin_;

	public const int CostCoinFieldNumber = 3;

	private int costCoin_;

	public const int ItemFieldNumber = 4;

	private static readonly MapField<int, RogueItem>.Codec _map_item_codec = new MapField<int, RogueItem>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, RogueItem.Parser), 34u);

	private readonly MapField<int, RogueItem> item_ = new MapField<int, RogueItem>();

	public const int TeamListFieldNumber = 5;

	private TeamList teamList_;

	public const int BattleCharacterFieldNumber = 6;

	private CharacterRepository battleCharacter_;

	public const int GroundItemFieldNumber = 7;

	private static readonly MapField<int, RogueItem>.Codec _map_groundItem_codec = new MapField<int, RogueItem>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, RogueItem.Parser), 58u);

	private readonly MapField<int, RogueItem> groundItem_ = new MapField<int, RogueItem>();

	public const int ChoiceRewardIdFieldNumber = 8;

	private static readonly FieldCodec<int> _repeated_choiceRewardId_codec = FieldCodec.ForInt32(66u);

	private readonly RepeatedField<int> choiceRewardId_ = new RepeatedField<int>();

	public const int AutoChoiceIdFieldNumber = 9;

	private int autoChoiceId_;

	public const int RoomMonsterListFieldNumber = 10;

	private static readonly FieldCodec<int> _repeated_roomMonsterList_codec = FieldCodec.ForInt32(82u);

	private readonly RepeatedField<int> roomMonsterList_ = new RepeatedField<int>();

	public const int ElementChangeInfoFieldNumber = 11;

	private static readonly FieldCodec<RogueElementChangeInfo> _repeated_elementChangeInfo_codec = FieldCodec.ForMessage(90u, RogueElementChangeInfo.Parser);

	private readonly RepeatedField<RogueElementChangeInfo> elementChangeInfo_ = new RepeatedField<RogueElementChangeInfo>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<RogueTempInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[236];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Reward
	{
		get
		{
			return reward_;
		}
		set
		{
			reward_ = value;
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
	public MapField<int, RogueItem> Item => item_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TeamList TeamList
	{
		get
		{
			return teamList_;
		}
		set
		{
			teamList_ = value;
		}
	}

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
	public MapField<int, RogueItem> GroundItem => groundItem_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> ChoiceRewardId => choiceRewardId_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int AutoChoiceId
	{
		get
		{
			return autoChoiceId_;
		}
		set
		{
			autoChoiceId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> RoomMonsterList => roomMonsterList_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<RogueElementChangeInfo> ElementChangeInfo => elementChangeInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueTempInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueTempInfo(RogueTempInfo other)
		: this()
	{
		reward_ = other.reward_;
		gainCoin_ = other.gainCoin_;
		costCoin_ = other.costCoin_;
		item_ = other.item_.Clone();
		teamList_ = ((other.teamList_ != null) ? other.teamList_.Clone() : null);
		battleCharacter_ = ((other.battleCharacter_ != null) ? other.battleCharacter_.Clone() : null);
		groundItem_ = other.groundItem_.Clone();
		choiceRewardId_ = other.choiceRewardId_.Clone();
		autoChoiceId_ = other.autoChoiceId_;
		roomMonsterList_ = other.roomMonsterList_.Clone();
		elementChangeInfo_ = other.elementChangeInfo_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueTempInfo Clone()
	{
		return new RogueTempInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as RogueTempInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(RogueTempInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Reward != other.Reward)
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
		if (!Item.Equals(other.Item))
		{
			return false;
		}
		if (!object.Equals(TeamList, other.TeamList))
		{
			return false;
		}
		if (!object.Equals(BattleCharacter, other.BattleCharacter))
		{
			return false;
		}
		if (!GroundItem.Equals(other.GroundItem))
		{
			return false;
		}
		if (!choiceRewardId_.Equals(other.choiceRewardId_))
		{
			return false;
		}
		if (AutoChoiceId != other.AutoChoiceId)
		{
			return false;
		}
		if (!roomMonsterList_.Equals(other.roomMonsterList_))
		{
			return false;
		}
		if (!elementChangeInfo_.Equals(other.elementChangeInfo_))
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
		if (Reward)
		{
			num ^= Reward.GetHashCode();
		}
		if (GainCoin != 0)
		{
			num ^= GainCoin.GetHashCode();
		}
		if (CostCoin != 0)
		{
			num ^= CostCoin.GetHashCode();
		}
		num ^= Item.GetHashCode();
		if (teamList_ != null)
		{
			num ^= TeamList.GetHashCode();
		}
		if (battleCharacter_ != null)
		{
			num ^= BattleCharacter.GetHashCode();
		}
		num ^= GroundItem.GetHashCode();
		num ^= choiceRewardId_.GetHashCode();
		if (AutoChoiceId != 0)
		{
			num ^= AutoChoiceId.GetHashCode();
		}
		num ^= roomMonsterList_.GetHashCode();
		num ^= elementChangeInfo_.GetHashCode();
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
		if (Reward)
		{
			output.WriteRawTag(8);
			output.WriteBool(Reward);
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
		item_.WriteTo(ref output, _map_item_codec);
		if (teamList_ != null)
		{
			output.WriteRawTag(42);
			output.WriteMessage(TeamList);
		}
		if (battleCharacter_ != null)
		{
			output.WriteRawTag(50);
			output.WriteMessage(BattleCharacter);
		}
		groundItem_.WriteTo(ref output, _map_groundItem_codec);
		choiceRewardId_.WriteTo(ref output, _repeated_choiceRewardId_codec);
		if (AutoChoiceId != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(AutoChoiceId);
		}
		roomMonsterList_.WriteTo(ref output, _repeated_roomMonsterList_codec);
		elementChangeInfo_.WriteTo(ref output, _repeated_elementChangeInfo_codec);
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
		if (Reward)
		{
			num += 2;
		}
		if (GainCoin != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GainCoin);
		}
		if (CostCoin != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CostCoin);
		}
		num += item_.CalculateSize(_map_item_codec);
		if (teamList_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(TeamList);
		}
		if (battleCharacter_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(BattleCharacter);
		}
		num += groundItem_.CalculateSize(_map_groundItem_codec);
		num += choiceRewardId_.CalculateSize(_repeated_choiceRewardId_codec);
		if (AutoChoiceId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AutoChoiceId);
		}
		num += roomMonsterList_.CalculateSize(_repeated_roomMonsterList_codec);
		num += elementChangeInfo_.CalculateSize(_repeated_elementChangeInfo_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(RogueTempInfo other)
	{
		if (other == null)
		{
			return;
		}
		if (other.Reward)
		{
			Reward = other.Reward;
		}
		if (other.GainCoin != 0)
		{
			GainCoin = other.GainCoin;
		}
		if (other.CostCoin != 0)
		{
			CostCoin = other.CostCoin;
		}
		item_.Add(other.item_);
		if (other.teamList_ != null)
		{
			if (teamList_ == null)
			{
				TeamList = new TeamList();
			}
			TeamList.MergeFrom(other.TeamList);
		}
		if (other.battleCharacter_ != null)
		{
			if (battleCharacter_ == null)
			{
				BattleCharacter = new CharacterRepository();
			}
			BattleCharacter.MergeFrom(other.BattleCharacter);
		}
		groundItem_.Add(other.groundItem_);
		choiceRewardId_.Add(other.choiceRewardId_);
		if (other.AutoChoiceId != 0)
		{
			AutoChoiceId = other.AutoChoiceId;
		}
		roomMonsterList_.Add(other.roomMonsterList_);
		elementChangeInfo_.Add(other.elementChangeInfo_);
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
				Reward = input.ReadBool();
				break;
			case 16u:
				GainCoin = input.ReadInt32();
				break;
			case 24u:
				CostCoin = input.ReadInt32();
				break;
			case 34u:
				item_.AddEntriesFrom(ref input, _map_item_codec);
				break;
			case 42u:
				if (teamList_ == null)
				{
					TeamList = new TeamList();
				}
				input.ReadMessage(TeamList);
				break;
			case 50u:
				if (battleCharacter_ == null)
				{
					BattleCharacter = new CharacterRepository();
				}
				input.ReadMessage(BattleCharacter);
				break;
			case 58u:
				groundItem_.AddEntriesFrom(ref input, _map_groundItem_codec);
				break;
			case 64u:
			case 66u:
				choiceRewardId_.AddEntriesFrom(ref input, _repeated_choiceRewardId_codec);
				break;
			case 72u:
				AutoChoiceId = input.ReadInt32();
				break;
			case 80u:
			case 82u:
				roomMonsterList_.AddEntriesFrom(ref input, _repeated_roomMonsterList_codec);
				break;
			case 90u:
				elementChangeInfo_.AddEntriesFrom(ref input, _repeated_elementChangeInfo_codec);
				break;
			}
		}
	}
}
