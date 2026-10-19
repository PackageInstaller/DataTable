using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class SyncGameInfoReq : IMessage<SyncGameInfoReq>, IMessage, IEquatable<SyncGameInfoReq>, IDeepCloneable<SyncGameInfoReq>, IBufferMessage
{
	private static readonly MessageParser<SyncGameInfoReq> _parser = new MessageParser<SyncGameInfoReq>(() => new SyncGameInfoReq());

	private UnknownFieldSet _unknownFields;

	public const int PositionFieldNumber = 1;

	private PBVector3 position_;

	public const int CharacterInfoFieldNumber = 2;

	private CharacterSyncInfo characterInfo_;

	public const int PlayingMusicFieldNumber = 3;

	private int playingMusic_;

	public const int AchievementInfoFieldNumber = 4;

	private AchievementSyncInfo achievementInfo_;

	public const int MapViewLogInfoFieldNumber = 5;

	private static readonly FieldCodec<MapViewLogInfo> _repeated_mapViewLogInfo_codec = FieldCodec.ForMessage(42u, ACT.Game.Data.MapViewLogInfo.Parser);

	private readonly RepeatedField<MapViewLogInfo> mapViewLogInfo_ = new RepeatedField<MapViewLogInfo>();

	public const int LittleItemsShortcutFieldNumber = 6;

	private LittleItemsShortcutInfo littleItemsShortcut_;

	public const int ChunkIdFieldNumber = 7;

	private int chunkId_;

	public const int WidFieldNumber = 8;

	private int wid_;

	public const int MapViewRecordParamFieldNumber = 9;

	private MapViewRecordParam mapViewRecordParam_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<SyncGameInfoReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[72];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PBVector3 Position
	{
		get
		{
			return position_;
		}
		set
		{
			position_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterSyncInfo CharacterInfo
	{
		get
		{
			return characterInfo_;
		}
		set
		{
			characterInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int PlayingMusic
	{
		get
		{
			return playingMusic_;
		}
		set
		{
			playingMusic_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AchievementSyncInfo AchievementInfo
	{
		get
		{
			return achievementInfo_;
		}
		set
		{
			achievementInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<MapViewLogInfo> MapViewLogInfo => mapViewLogInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LittleItemsShortcutInfo LittleItemsShortcut
	{
		get
		{
			return littleItemsShortcut_;
		}
		set
		{
			littleItemsShortcut_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ChunkId
	{
		get
		{
			return chunkId_;
		}
		set
		{
			chunkId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Wid
	{
		get
		{
			return wid_;
		}
		set
		{
			wid_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapViewRecordParam MapViewRecordParam
	{
		get
		{
			return mapViewRecordParam_;
		}
		set
		{
			mapViewRecordParam_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SyncGameInfoReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SyncGameInfoReq(SyncGameInfoReq other)
		: this()
	{
		position_ = ((other.position_ != null) ? other.position_.Clone() : null);
		characterInfo_ = ((other.characterInfo_ != null) ? other.characterInfo_.Clone() : null);
		playingMusic_ = other.playingMusic_;
		achievementInfo_ = ((other.achievementInfo_ != null) ? other.achievementInfo_.Clone() : null);
		mapViewLogInfo_ = other.mapViewLogInfo_.Clone();
		littleItemsShortcut_ = ((other.littleItemsShortcut_ != null) ? other.littleItemsShortcut_.Clone() : null);
		chunkId_ = other.chunkId_;
		wid_ = other.wid_;
		mapViewRecordParam_ = ((other.mapViewRecordParam_ != null) ? other.mapViewRecordParam_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SyncGameInfoReq Clone()
	{
		return new SyncGameInfoReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as SyncGameInfoReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(SyncGameInfoReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(Position, other.Position))
		{
			return false;
		}
		if (!object.Equals(CharacterInfo, other.CharacterInfo))
		{
			return false;
		}
		if (PlayingMusic != other.PlayingMusic)
		{
			return false;
		}
		if (!object.Equals(AchievementInfo, other.AchievementInfo))
		{
			return false;
		}
		if (!mapViewLogInfo_.Equals(other.mapViewLogInfo_))
		{
			return false;
		}
		if (!object.Equals(LittleItemsShortcut, other.LittleItemsShortcut))
		{
			return false;
		}
		if (ChunkId != other.ChunkId)
		{
			return false;
		}
		if (Wid != other.Wid)
		{
			return false;
		}
		if (!object.Equals(MapViewRecordParam, other.MapViewRecordParam))
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
		if (position_ != null)
		{
			num ^= Position.GetHashCode();
		}
		if (characterInfo_ != null)
		{
			num ^= CharacterInfo.GetHashCode();
		}
		if (PlayingMusic != 0)
		{
			num ^= PlayingMusic.GetHashCode();
		}
		if (achievementInfo_ != null)
		{
			num ^= AchievementInfo.GetHashCode();
		}
		num ^= mapViewLogInfo_.GetHashCode();
		if (littleItemsShortcut_ != null)
		{
			num ^= LittleItemsShortcut.GetHashCode();
		}
		if (ChunkId != 0)
		{
			num ^= ChunkId.GetHashCode();
		}
		if (Wid != 0)
		{
			num ^= Wid.GetHashCode();
		}
		if (mapViewRecordParam_ != null)
		{
			num ^= MapViewRecordParam.GetHashCode();
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
		if (position_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(Position);
		}
		if (characterInfo_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(CharacterInfo);
		}
		if (PlayingMusic != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(PlayingMusic);
		}
		if (achievementInfo_ != null)
		{
			output.WriteRawTag(34);
			output.WriteMessage(AchievementInfo);
		}
		mapViewLogInfo_.WriteTo(ref output, _repeated_mapViewLogInfo_codec);
		if (littleItemsShortcut_ != null)
		{
			output.WriteRawTag(50);
			output.WriteMessage(LittleItemsShortcut);
		}
		if (ChunkId != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(ChunkId);
		}
		if (Wid != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Wid);
		}
		if (mapViewRecordParam_ != null)
		{
			output.WriteRawTag(74);
			output.WriteMessage(MapViewRecordParam);
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
		if (position_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Position);
		}
		if (characterInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(CharacterInfo);
		}
		if (PlayingMusic != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PlayingMusic);
		}
		if (achievementInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(AchievementInfo);
		}
		num += mapViewLogInfo_.CalculateSize(_repeated_mapViewLogInfo_codec);
		if (littleItemsShortcut_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(LittleItemsShortcut);
		}
		if (ChunkId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ChunkId);
		}
		if (Wid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Wid);
		}
		if (mapViewRecordParam_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(MapViewRecordParam);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(SyncGameInfoReq other)
	{
		if (other == null)
		{
			return;
		}
		if (other.position_ != null)
		{
			if (position_ == null)
			{
				Position = new PBVector3();
			}
			Position.MergeFrom(other.Position);
		}
		if (other.characterInfo_ != null)
		{
			if (characterInfo_ == null)
			{
				CharacterInfo = new CharacterSyncInfo();
			}
			CharacterInfo.MergeFrom(other.CharacterInfo);
		}
		if (other.PlayingMusic != 0)
		{
			PlayingMusic = other.PlayingMusic;
		}
		if (other.achievementInfo_ != null)
		{
			if (achievementInfo_ == null)
			{
				AchievementInfo = new AchievementSyncInfo();
			}
			AchievementInfo.MergeFrom(other.AchievementInfo);
		}
		mapViewLogInfo_.Add(other.mapViewLogInfo_);
		if (other.littleItemsShortcut_ != null)
		{
			if (littleItemsShortcut_ == null)
			{
				LittleItemsShortcut = new LittleItemsShortcutInfo();
			}
			LittleItemsShortcut.MergeFrom(other.LittleItemsShortcut);
		}
		if (other.ChunkId != 0)
		{
			ChunkId = other.ChunkId;
		}
		if (other.Wid != 0)
		{
			Wid = other.Wid;
		}
		if (other.mapViewRecordParam_ != null)
		{
			if (mapViewRecordParam_ == null)
			{
				MapViewRecordParam = new MapViewRecordParam();
			}
			MapViewRecordParam.MergeFrom(other.MapViewRecordParam);
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
				if (position_ == null)
				{
					Position = new PBVector3();
				}
				input.ReadMessage(Position);
				break;
			case 18u:
				if (characterInfo_ == null)
				{
					CharacterInfo = new CharacterSyncInfo();
				}
				input.ReadMessage(CharacterInfo);
				break;
			case 24u:
				PlayingMusic = input.ReadInt32();
				break;
			case 34u:
				if (achievementInfo_ == null)
				{
					AchievementInfo = new AchievementSyncInfo();
				}
				input.ReadMessage(AchievementInfo);
				break;
			case 42u:
				mapViewLogInfo_.AddEntriesFrom(ref input, _repeated_mapViewLogInfo_codec);
				break;
			case 50u:
				if (littleItemsShortcut_ == null)
				{
					LittleItemsShortcut = new LittleItemsShortcutInfo();
				}
				input.ReadMessage(LittleItemsShortcut);
				break;
			case 56u:
				ChunkId = input.ReadInt32();
				break;
			case 64u:
				Wid = input.ReadInt32();
				break;
			case 74u:
				if (mapViewRecordParam_ == null)
				{
					MapViewRecordParam = new MapViewRecordParam();
				}
				input.ReadMessage(MapViewRecordParam);
				break;
			}
		}
	}
}
