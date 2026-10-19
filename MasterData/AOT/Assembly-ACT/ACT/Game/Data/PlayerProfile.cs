using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class PlayerProfile : IMessage<PlayerProfile>, IMessage, IEquatable<PlayerProfile>, IDeepCloneable<PlayerProfile>, IBufferMessage
{
	private static readonly MessageParser<PlayerProfile> _parser = new MessageParser<PlayerProfile>(() => new PlayerProfile());

	private UnknownFieldSet _unknownFields;

	public const int PowerRecoverTsFieldNumber = 4;

	private long powerRecoverTs_;

	public const int PowerDailyBuyNumFieldNumber = 5;

	private int powerDailyBuyNum_;

	public const int EscInfoFieldNumber = 6;

	private EscInfo escInfo_;

	public const int SceneStatusFieldNumber = 7;

	private SceneStatus sceneStatus_;

	public const int SceneInfosFieldNumber = 8;

	private static readonly MapField<int, SceneInfo>.Codec _map_sceneInfos_codec = new MapField<int, SceneInfo>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, SceneInfo.Parser), 66u);

	private readonly MapField<int, SceneInfo> sceneInfos_ = new MapField<int, SceneInfo>();

	public const int BuffFieldNumber = 9;

	private Buff buff_;

	public const int PlayingMusicFieldNumber = 10;

	private int playingMusic_;

	public const int SettingOptionsFieldNumber = 11;

	private string settingOptions_ = "";

	public const int RoomIdFieldNumber = 12;

	private ulong roomId_;

	public const int RedeemCodeFieldNumber = 13;

	private RedeemCode redeemCode_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<PlayerProfile> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[67];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long PowerRecoverTs
	{
		get
		{
			return powerRecoverTs_;
		}
		set
		{
			powerRecoverTs_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int PowerDailyBuyNum
	{
		get
		{
			return powerDailyBuyNum_;
		}
		set
		{
			powerDailyBuyNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public EscInfo EscInfo
	{
		get
		{
			return escInfo_;
		}
		set
		{
			escInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SceneStatus SceneStatus
	{
		get
		{
			return sceneStatus_;
		}
		set
		{
			sceneStatus_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, SceneInfo> SceneInfos => sceneInfos_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Buff Buff
	{
		get
		{
			return buff_;
		}
		set
		{
			buff_ = value;
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
	public string SettingOptions
	{
		get
		{
			return settingOptions_;
		}
		set
		{
			settingOptions_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ulong RoomId
	{
		get
		{
			return roomId_;
		}
		set
		{
			roomId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RedeemCode RedeemCode
	{
		get
		{
			return redeemCode_;
		}
		set
		{
			redeemCode_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PlayerProfile()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PlayerProfile(PlayerProfile other)
		: this()
	{
		powerRecoverTs_ = other.powerRecoverTs_;
		powerDailyBuyNum_ = other.powerDailyBuyNum_;
		escInfo_ = ((other.escInfo_ != null) ? other.escInfo_.Clone() : null);
		sceneStatus_ = other.sceneStatus_;
		sceneInfos_ = other.sceneInfos_.Clone();
		buff_ = ((other.buff_ != null) ? other.buff_.Clone() : null);
		playingMusic_ = other.playingMusic_;
		settingOptions_ = other.settingOptions_;
		roomId_ = other.roomId_;
		redeemCode_ = ((other.redeemCode_ != null) ? other.redeemCode_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PlayerProfile Clone()
	{
		return new PlayerProfile(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as PlayerProfile);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(PlayerProfile other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (PowerRecoverTs != other.PowerRecoverTs)
		{
			return false;
		}
		if (PowerDailyBuyNum != other.PowerDailyBuyNum)
		{
			return false;
		}
		if (!object.Equals(EscInfo, other.EscInfo))
		{
			return false;
		}
		if (SceneStatus != other.SceneStatus)
		{
			return false;
		}
		if (!SceneInfos.Equals(other.SceneInfos))
		{
			return false;
		}
		if (!object.Equals(Buff, other.Buff))
		{
			return false;
		}
		if (PlayingMusic != other.PlayingMusic)
		{
			return false;
		}
		if (SettingOptions != other.SettingOptions)
		{
			return false;
		}
		if (RoomId != other.RoomId)
		{
			return false;
		}
		if (!object.Equals(RedeemCode, other.RedeemCode))
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
		if (PowerRecoverTs != 0L)
		{
			num ^= PowerRecoverTs.GetHashCode();
		}
		if (PowerDailyBuyNum != 0)
		{
			num ^= PowerDailyBuyNum.GetHashCode();
		}
		if (escInfo_ != null)
		{
			num ^= EscInfo.GetHashCode();
		}
		if (SceneStatus != SceneStatus.Main)
		{
			num ^= SceneStatus.GetHashCode();
		}
		num ^= SceneInfos.GetHashCode();
		if (buff_ != null)
		{
			num ^= Buff.GetHashCode();
		}
		if (PlayingMusic != 0)
		{
			num ^= PlayingMusic.GetHashCode();
		}
		if (SettingOptions.Length != 0)
		{
			num ^= SettingOptions.GetHashCode();
		}
		if (RoomId != 0L)
		{
			num ^= RoomId.GetHashCode();
		}
		if (redeemCode_ != null)
		{
			num ^= RedeemCode.GetHashCode();
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
		if (PowerRecoverTs != 0L)
		{
			output.WriteRawTag(32);
			output.WriteInt64(PowerRecoverTs);
		}
		if (PowerDailyBuyNum != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(PowerDailyBuyNum);
		}
		if (escInfo_ != null)
		{
			output.WriteRawTag(50);
			output.WriteMessage(EscInfo);
		}
		if (SceneStatus != SceneStatus.Main)
		{
			output.WriteRawTag(56);
			output.WriteEnum((int)SceneStatus);
		}
		sceneInfos_.WriteTo(ref output, _map_sceneInfos_codec);
		if (buff_ != null)
		{
			output.WriteRawTag(74);
			output.WriteMessage(Buff);
		}
		if (PlayingMusic != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(PlayingMusic);
		}
		if (SettingOptions.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(SettingOptions);
		}
		if (RoomId != 0L)
		{
			output.WriteRawTag(96);
			output.WriteUInt64(RoomId);
		}
		if (redeemCode_ != null)
		{
			output.WriteRawTag(106);
			output.WriteMessage(RedeemCode);
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
		if (PowerRecoverTs != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(PowerRecoverTs);
		}
		if (PowerDailyBuyNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PowerDailyBuyNum);
		}
		if (escInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(EscInfo);
		}
		if (SceneStatus != SceneStatus.Main)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)SceneStatus);
		}
		num += sceneInfos_.CalculateSize(_map_sceneInfos_codec);
		if (buff_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Buff);
		}
		if (PlayingMusic != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PlayingMusic);
		}
		if (SettingOptions.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SettingOptions);
		}
		if (RoomId != 0L)
		{
			num += 1 + CodedOutputStream.ComputeUInt64Size(RoomId);
		}
		if (redeemCode_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(RedeemCode);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(PlayerProfile other)
	{
		if (other == null)
		{
			return;
		}
		if (other.PowerRecoverTs != 0L)
		{
			PowerRecoverTs = other.PowerRecoverTs;
		}
		if (other.PowerDailyBuyNum != 0)
		{
			PowerDailyBuyNum = other.PowerDailyBuyNum;
		}
		if (other.escInfo_ != null)
		{
			if (escInfo_ == null)
			{
				EscInfo = new EscInfo();
			}
			EscInfo.MergeFrom(other.EscInfo);
		}
		if (other.SceneStatus != SceneStatus.Main)
		{
			SceneStatus = other.SceneStatus;
		}
		sceneInfos_.Add(other.sceneInfos_);
		if (other.buff_ != null)
		{
			if (buff_ == null)
			{
				Buff = new Buff();
			}
			Buff.MergeFrom(other.Buff);
		}
		if (other.PlayingMusic != 0)
		{
			PlayingMusic = other.PlayingMusic;
		}
		if (other.SettingOptions.Length != 0)
		{
			SettingOptions = other.SettingOptions;
		}
		if (other.RoomId != 0L)
		{
			RoomId = other.RoomId;
		}
		if (other.redeemCode_ != null)
		{
			if (redeemCode_ == null)
			{
				RedeemCode = new RedeemCode();
			}
			RedeemCode.MergeFrom(other.RedeemCode);
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
			case 32u:
				PowerRecoverTs = input.ReadInt64();
				break;
			case 40u:
				PowerDailyBuyNum = input.ReadInt32();
				break;
			case 50u:
				if (escInfo_ == null)
				{
					EscInfo = new EscInfo();
				}
				input.ReadMessage(EscInfo);
				break;
			case 56u:
				SceneStatus = (SceneStatus)input.ReadEnum();
				break;
			case 66u:
				sceneInfos_.AddEntriesFrom(ref input, _map_sceneInfos_codec);
				break;
			case 74u:
				if (buff_ == null)
				{
					Buff = new Buff();
				}
				input.ReadMessage(Buff);
				break;
			case 80u:
				PlayingMusic = input.ReadInt32();
				break;
			case 90u:
				SettingOptions = input.ReadString();
				break;
			case 96u:
				RoomId = input.ReadUInt64();
				break;
			case 106u:
				if (redeemCode_ == null)
				{
					RedeemCode = new RedeemCode();
				}
				input.ReadMessage(RedeemCode);
				break;
			}
		}
	}
}
