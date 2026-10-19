using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class RogueInfo : IMessage<RogueInfo>, IMessage, IEquatable<RogueInfo>, IDeepCloneable<RogueInfo>, IBufferMessage
{
	private static readonly MessageParser<RogueInfo> _parser = new MessageParser<RogueInfo>(() => new RogueInfo());

	private UnknownFieldSet _unknownFields;

	public const int SeasonIdFieldNumber = 1;

	private int seasonId_;

	public const int GameStateFieldNumber = 2;

	private StageStateEnum gameState_;

	public const int ClearedModeFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_clearedMode_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> clearedMode_ = new RepeatedField<int>();

	public const int TalentTreePointFieldNumber = 4;

	private int talentTreePoint_;

	public const int TalentTreeFieldNumber = 5;

	private RogueTalentTree talentTree_;

	public const int GameInfoFieldNumber = 6;

	private RogueGameInfo gameInfo_;

	public const int WeeklyCoinGainFieldNumber = 7;

	private int weeklyCoinGain_;

	public const int LastUpdateTimeFieldNumber = 8;

	private long lastUpdateTime_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<RogueInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[239];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int SeasonId
	{
		get
		{
			return seasonId_;
		}
		set
		{
			seasonId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public StageStateEnum GameState
	{
		get
		{
			return gameState_;
		}
		set
		{
			gameState_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> ClearedMode => clearedMode_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int TalentTreePoint
	{
		get
		{
			return talentTreePoint_;
		}
		set
		{
			talentTreePoint_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueTalentTree TalentTree
	{
		get
		{
			return talentTree_;
		}
		set
		{
			talentTree_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueGameInfo GameInfo
	{
		get
		{
			return gameInfo_;
		}
		set
		{
			gameInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int WeeklyCoinGain
	{
		get
		{
			return weeklyCoinGain_;
		}
		set
		{
			weeklyCoinGain_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long LastUpdateTime
	{
		get
		{
			return lastUpdateTime_;
		}
		set
		{
			lastUpdateTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueInfo(RogueInfo other)
		: this()
	{
		seasonId_ = other.seasonId_;
		gameState_ = other.gameState_;
		clearedMode_ = other.clearedMode_.Clone();
		talentTreePoint_ = other.talentTreePoint_;
		talentTree_ = ((other.talentTree_ != null) ? other.talentTree_.Clone() : null);
		gameInfo_ = ((other.gameInfo_ != null) ? other.gameInfo_.Clone() : null);
		weeklyCoinGain_ = other.weeklyCoinGain_;
		lastUpdateTime_ = other.lastUpdateTime_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueInfo Clone()
	{
		return new RogueInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as RogueInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(RogueInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (SeasonId != other.SeasonId)
		{
			return false;
		}
		if (GameState != other.GameState)
		{
			return false;
		}
		if (!clearedMode_.Equals(other.clearedMode_))
		{
			return false;
		}
		if (TalentTreePoint != other.TalentTreePoint)
		{
			return false;
		}
		if (!object.Equals(TalentTree, other.TalentTree))
		{
			return false;
		}
		if (!object.Equals(GameInfo, other.GameInfo))
		{
			return false;
		}
		if (WeeklyCoinGain != other.WeeklyCoinGain)
		{
			return false;
		}
		if (LastUpdateTime != other.LastUpdateTime)
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
		if (SeasonId != 0)
		{
			num ^= SeasonId.GetHashCode();
		}
		if (GameState != StageStateEnum.StageStateOut)
		{
			num ^= GameState.GetHashCode();
		}
		num ^= clearedMode_.GetHashCode();
		if (TalentTreePoint != 0)
		{
			num ^= TalentTreePoint.GetHashCode();
		}
		if (talentTree_ != null)
		{
			num ^= TalentTree.GetHashCode();
		}
		if (gameInfo_ != null)
		{
			num ^= GameInfo.GetHashCode();
		}
		if (WeeklyCoinGain != 0)
		{
			num ^= WeeklyCoinGain.GetHashCode();
		}
		if (LastUpdateTime != 0L)
		{
			num ^= LastUpdateTime.GetHashCode();
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
		if (SeasonId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(SeasonId);
		}
		if (GameState != StageStateEnum.StageStateOut)
		{
			output.WriteRawTag(16);
			output.WriteEnum((int)GameState);
		}
		clearedMode_.WriteTo(ref output, _repeated_clearedMode_codec);
		if (TalentTreePoint != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(TalentTreePoint);
		}
		if (talentTree_ != null)
		{
			output.WriteRawTag(42);
			output.WriteMessage(TalentTree);
		}
		if (gameInfo_ != null)
		{
			output.WriteRawTag(50);
			output.WriteMessage(GameInfo);
		}
		if (WeeklyCoinGain != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(WeeklyCoinGain);
		}
		if (LastUpdateTime != 0L)
		{
			output.WriteRawTag(64);
			output.WriteInt64(LastUpdateTime);
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
		if (SeasonId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SeasonId);
		}
		if (GameState != StageStateEnum.StageStateOut)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)GameState);
		}
		num += clearedMode_.CalculateSize(_repeated_clearedMode_codec);
		if (TalentTreePoint != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TalentTreePoint);
		}
		if (talentTree_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(TalentTree);
		}
		if (gameInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(GameInfo);
		}
		if (WeeklyCoinGain != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WeeklyCoinGain);
		}
		if (LastUpdateTime != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(LastUpdateTime);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(RogueInfo other)
	{
		if (other == null)
		{
			return;
		}
		if (other.SeasonId != 0)
		{
			SeasonId = other.SeasonId;
		}
		if (other.GameState != StageStateEnum.StageStateOut)
		{
			GameState = other.GameState;
		}
		clearedMode_.Add(other.clearedMode_);
		if (other.TalentTreePoint != 0)
		{
			TalentTreePoint = other.TalentTreePoint;
		}
		if (other.talentTree_ != null)
		{
			if (talentTree_ == null)
			{
				TalentTree = new RogueTalentTree();
			}
			TalentTree.MergeFrom(other.TalentTree);
		}
		if (other.gameInfo_ != null)
		{
			if (gameInfo_ == null)
			{
				GameInfo = new RogueGameInfo();
			}
			GameInfo.MergeFrom(other.GameInfo);
		}
		if (other.WeeklyCoinGain != 0)
		{
			WeeklyCoinGain = other.WeeklyCoinGain;
		}
		if (other.LastUpdateTime != 0L)
		{
			LastUpdateTime = other.LastUpdateTime;
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
				SeasonId = input.ReadInt32();
				break;
			case 16u:
				GameState = (StageStateEnum)input.ReadEnum();
				break;
			case 24u:
			case 26u:
				clearedMode_.AddEntriesFrom(ref input, _repeated_clearedMode_codec);
				break;
			case 32u:
				TalentTreePoint = input.ReadInt32();
				break;
			case 42u:
				if (talentTree_ == null)
				{
					TalentTree = new RogueTalentTree();
				}
				input.ReadMessage(TalentTree);
				break;
			case 50u:
				if (gameInfo_ == null)
				{
					GameInfo = new RogueGameInfo();
				}
				input.ReadMessage(GameInfo);
				break;
			case 56u:
				WeeklyCoinGain = input.ReadInt32();
				break;
			case 64u:
				LastUpdateTime = input.ReadInt64();
				break;
			}
		}
	}
}
