using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class SceneInfo : IMessage<SceneInfo>, IMessage, IEquatable<SceneInfo>, IDeepCloneable<SceneInfo>, IBufferMessage
{
	private static readonly MessageParser<SceneInfo> _parser = new MessageParser<SceneInfo>(() => new SceneInfo());

	private UnknownFieldSet _unknownFields;

	public const int WorldIDFieldNumber = 1;

	private int worldID_;

	public const int LastPosFieldNumber = 3;

	private PBVector3 lastPos_;

	public const int CheckPosUidFieldNumber = 4;

	private int checkPosUid_;

	public const int PlayingMusicFieldNumber = 5;

	private int playingMusic_;

	public const int InstIdFieldNumber = 6;

	private long instId_;

	public const int TransNoFieldNumber = 7;

	private string transNo_ = "";

	public const int SpawnInfoFieldNumber = 9;

	private SceneSpawnInfo spawnInfo_;

	public const int ChunkIDFieldNumber = 10;

	private int chunkID_;

	public const int ConfigIDFieldNumber = 11;

	private int configID_;

	public const int TmpArchiveInfoFieldNumber = 12;

	private SceneTempArchiveInfo tmpArchiveInfo_;

	public const int WorldLayerFieldNumber = 13;

	private SceneWorldLayer worldLayer_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<SceneInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[62];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int WorldID
	{
		get
		{
			return worldID_;
		}
		set
		{
			worldID_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PBVector3 LastPos
	{
		get
		{
			return lastPos_;
		}
		set
		{
			lastPos_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CheckPosUid
	{
		get
		{
			return checkPosUid_;
		}
		set
		{
			checkPosUid_ = value;
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
	public long InstId
	{
		get
		{
			return instId_;
		}
		set
		{
			instId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string TransNo
	{
		get
		{
			return transNo_;
		}
		set
		{
			transNo_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SceneSpawnInfo SpawnInfo
	{
		get
		{
			return spawnInfo_;
		}
		set
		{
			spawnInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ChunkID
	{
		get
		{
			return chunkID_;
		}
		set
		{
			chunkID_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ConfigID
	{
		get
		{
			return configID_;
		}
		set
		{
			configID_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SceneTempArchiveInfo TmpArchiveInfo
	{
		get
		{
			return tmpArchiveInfo_;
		}
		set
		{
			tmpArchiveInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SceneWorldLayer WorldLayer
	{
		get
		{
			return worldLayer_;
		}
		set
		{
			worldLayer_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SceneInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SceneInfo(SceneInfo other)
		: this()
	{
		worldID_ = other.worldID_;
		lastPos_ = ((other.lastPos_ != null) ? other.lastPos_.Clone() : null);
		checkPosUid_ = other.checkPosUid_;
		playingMusic_ = other.playingMusic_;
		instId_ = other.instId_;
		transNo_ = other.transNo_;
		spawnInfo_ = ((other.spawnInfo_ != null) ? other.spawnInfo_.Clone() : null);
		chunkID_ = other.chunkID_;
		configID_ = other.configID_;
		tmpArchiveInfo_ = ((other.tmpArchiveInfo_ != null) ? other.tmpArchiveInfo_.Clone() : null);
		worldLayer_ = other.worldLayer_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SceneInfo Clone()
	{
		return new SceneInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as SceneInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(SceneInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (WorldID != other.WorldID)
		{
			return false;
		}
		if (!object.Equals(LastPos, other.LastPos))
		{
			return false;
		}
		if (CheckPosUid != other.CheckPosUid)
		{
			return false;
		}
		if (PlayingMusic != other.PlayingMusic)
		{
			return false;
		}
		if (InstId != other.InstId)
		{
			return false;
		}
		if (TransNo != other.TransNo)
		{
			return false;
		}
		if (!object.Equals(SpawnInfo, other.SpawnInfo))
		{
			return false;
		}
		if (ChunkID != other.ChunkID)
		{
			return false;
		}
		if (ConfigID != other.ConfigID)
		{
			return false;
		}
		if (!object.Equals(TmpArchiveInfo, other.TmpArchiveInfo))
		{
			return false;
		}
		if (WorldLayer != other.WorldLayer)
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
		if (WorldID != 0)
		{
			num ^= WorldID.GetHashCode();
		}
		if (lastPos_ != null)
		{
			num ^= LastPos.GetHashCode();
		}
		if (CheckPosUid != 0)
		{
			num ^= CheckPosUid.GetHashCode();
		}
		if (PlayingMusic != 0)
		{
			num ^= PlayingMusic.GetHashCode();
		}
		if (InstId != 0L)
		{
			num ^= InstId.GetHashCode();
		}
		if (TransNo.Length != 0)
		{
			num ^= TransNo.GetHashCode();
		}
		if (spawnInfo_ != null)
		{
			num ^= SpawnInfo.GetHashCode();
		}
		if (ChunkID != 0)
		{
			num ^= ChunkID.GetHashCode();
		}
		if (ConfigID != 0)
		{
			num ^= ConfigID.GetHashCode();
		}
		if (tmpArchiveInfo_ != null)
		{
			num ^= TmpArchiveInfo.GetHashCode();
		}
		if (WorldLayer != SceneWorldLayer.Surface)
		{
			num ^= WorldLayer.GetHashCode();
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
		if (WorldID != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(WorldID);
		}
		if (lastPos_ != null)
		{
			output.WriteRawTag(26);
			output.WriteMessage(LastPos);
		}
		if (CheckPosUid != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(CheckPosUid);
		}
		if (PlayingMusic != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(PlayingMusic);
		}
		if (InstId != 0L)
		{
			output.WriteRawTag(48);
			output.WriteInt64(InstId);
		}
		if (TransNo.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(TransNo);
		}
		if (spawnInfo_ != null)
		{
			output.WriteRawTag(74);
			output.WriteMessage(SpawnInfo);
		}
		if (ChunkID != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(ChunkID);
		}
		if (ConfigID != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(ConfigID);
		}
		if (tmpArchiveInfo_ != null)
		{
			output.WriteRawTag(98);
			output.WriteMessage(TmpArchiveInfo);
		}
		if (WorldLayer != SceneWorldLayer.Surface)
		{
			output.WriteRawTag(104);
			output.WriteEnum((int)WorldLayer);
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
		if (WorldID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WorldID);
		}
		if (lastPos_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(LastPos);
		}
		if (CheckPosUid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CheckPosUid);
		}
		if (PlayingMusic != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PlayingMusic);
		}
		if (InstId != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(InstId);
		}
		if (TransNo.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(TransNo);
		}
		if (spawnInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(SpawnInfo);
		}
		if (ChunkID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ChunkID);
		}
		if (ConfigID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ConfigID);
		}
		if (tmpArchiveInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(TmpArchiveInfo);
		}
		if (WorldLayer != SceneWorldLayer.Surface)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)WorldLayer);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(SceneInfo other)
	{
		if (other == null)
		{
			return;
		}
		if (other.WorldID != 0)
		{
			WorldID = other.WorldID;
		}
		if (other.lastPos_ != null)
		{
			if (lastPos_ == null)
			{
				LastPos = new PBVector3();
			}
			LastPos.MergeFrom(other.LastPos);
		}
		if (other.CheckPosUid != 0)
		{
			CheckPosUid = other.CheckPosUid;
		}
		if (other.PlayingMusic != 0)
		{
			PlayingMusic = other.PlayingMusic;
		}
		if (other.InstId != 0L)
		{
			InstId = other.InstId;
		}
		if (other.TransNo.Length != 0)
		{
			TransNo = other.TransNo;
		}
		if (other.spawnInfo_ != null)
		{
			if (spawnInfo_ == null)
			{
				SpawnInfo = new SceneSpawnInfo();
			}
			SpawnInfo.MergeFrom(other.SpawnInfo);
		}
		if (other.ChunkID != 0)
		{
			ChunkID = other.ChunkID;
		}
		if (other.ConfigID != 0)
		{
			ConfigID = other.ConfigID;
		}
		if (other.tmpArchiveInfo_ != null)
		{
			if (tmpArchiveInfo_ == null)
			{
				TmpArchiveInfo = new SceneTempArchiveInfo();
			}
			TmpArchiveInfo.MergeFrom(other.TmpArchiveInfo);
		}
		if (other.WorldLayer != SceneWorldLayer.Surface)
		{
			WorldLayer = other.WorldLayer;
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
				WorldID = input.ReadInt32();
				break;
			case 26u:
				if (lastPos_ == null)
				{
					LastPos = new PBVector3();
				}
				input.ReadMessage(LastPos);
				break;
			case 32u:
				CheckPosUid = input.ReadInt32();
				break;
			case 40u:
				PlayingMusic = input.ReadInt32();
				break;
			case 48u:
				InstId = input.ReadInt64();
				break;
			case 58u:
				TransNo = input.ReadString();
				break;
			case 74u:
				if (spawnInfo_ == null)
				{
					SpawnInfo = new SceneSpawnInfo();
				}
				input.ReadMessage(SpawnInfo);
				break;
			case 80u:
				ChunkID = input.ReadInt32();
				break;
			case 88u:
				ConfigID = input.ReadInt32();
				break;
			case 98u:
				if (tmpArchiveInfo_ == null)
				{
					TmpArchiveInfo = new SceneTempArchiveInfo();
				}
				input.ReadMessage(TmpArchiveInfo);
				break;
			case 104u:
				WorldLayer = (SceneWorldLayer)input.ReadEnum();
				break;
			}
		}
	}
}
