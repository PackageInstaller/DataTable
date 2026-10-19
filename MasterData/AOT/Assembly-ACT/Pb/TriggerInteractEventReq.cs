using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class TriggerInteractEventReq : IMessage<TriggerInteractEventReq>, IMessage, IEquatable<TriggerInteractEventReq>, IDeepCloneable<TriggerInteractEventReq>, IBufferMessage
{
	private static readonly MessageParser<TriggerInteractEventReq> _parser = new MessageParser<TriggerInteractEventReq>(() => new TriggerInteractEventReq());

	private UnknownFieldSet _unknownFields;

	public const int WidFieldNumber = 1;

	private int wid_;

	public const int StatesFieldNumber = 2;

	private static readonly FieldCodec<StateChangeInfo> _repeated_states_codec = FieldCodec.ForMessage(18u, StateChangeInfo.Parser);

	private readonly RepeatedField<StateChangeInfo> states_ = new RepeatedField<StateChangeInfo>();

	public const int ItemsFieldNumber = 3;

	private static readonly FieldCodec<Item> _repeated_items_codec = FieldCodec.ForMessage(26u, Item.Parser);

	private readonly RepeatedField<Item> items_ = new RepeatedField<Item>();

	public const int PositionFieldNumber = 4;

	private PBVector3 position_;

	public const int CharacterInfoFieldNumber = 5;

	private CharacterSyncInfo characterInfo_;

	public const int MapViewLogInfoFieldNumber = 6;

	private static readonly FieldCodec<MapViewLogInfo> _repeated_mapViewLogInfo_codec = FieldCodec.ForMessage(50u, ACT.Game.Data.MapViewLogInfo.Parser);

	private readonly RepeatedField<MapViewLogInfo> mapViewLogInfo_ = new RepeatedField<MapViewLogInfo>();

	public const int MapViewRecordParamFieldNumber = 7;

	private MapViewRecordParam mapViewRecordParam_;

	public const int ChunkIDFieldNumber = 8;

	private int chunkID_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<TriggerInteractEventReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => InteracteventReflection.Descriptor.MessageTypes[0];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

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
	public RepeatedField<StateChangeInfo> States => states_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<Item> Items => items_;

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
	public RepeatedField<MapViewLogInfo> MapViewLogInfo => mapViewLogInfo_;

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
	public TriggerInteractEventReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TriggerInteractEventReq(TriggerInteractEventReq other)
		: this()
	{
		wid_ = other.wid_;
		states_ = other.states_.Clone();
		items_ = other.items_.Clone();
		position_ = ((other.position_ != null) ? other.position_.Clone() : null);
		characterInfo_ = ((other.characterInfo_ != null) ? other.characterInfo_.Clone() : null);
		mapViewLogInfo_ = other.mapViewLogInfo_.Clone();
		mapViewRecordParam_ = ((other.mapViewRecordParam_ != null) ? other.mapViewRecordParam_.Clone() : null);
		chunkID_ = other.chunkID_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TriggerInteractEventReq Clone()
	{
		return new TriggerInteractEventReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as TriggerInteractEventReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(TriggerInteractEventReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Wid != other.Wid)
		{
			return false;
		}
		if (!states_.Equals(other.states_))
		{
			return false;
		}
		if (!items_.Equals(other.items_))
		{
			return false;
		}
		if (!object.Equals(Position, other.Position))
		{
			return false;
		}
		if (!object.Equals(CharacterInfo, other.CharacterInfo))
		{
			return false;
		}
		if (!mapViewLogInfo_.Equals(other.mapViewLogInfo_))
		{
			return false;
		}
		if (!object.Equals(MapViewRecordParam, other.MapViewRecordParam))
		{
			return false;
		}
		if (ChunkID != other.ChunkID)
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
		if (Wid != 0)
		{
			num ^= Wid.GetHashCode();
		}
		num ^= states_.GetHashCode();
		num ^= items_.GetHashCode();
		if (position_ != null)
		{
			num ^= Position.GetHashCode();
		}
		if (characterInfo_ != null)
		{
			num ^= CharacterInfo.GetHashCode();
		}
		num ^= mapViewLogInfo_.GetHashCode();
		if (mapViewRecordParam_ != null)
		{
			num ^= MapViewRecordParam.GetHashCode();
		}
		if (ChunkID != 0)
		{
			num ^= ChunkID.GetHashCode();
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
		if (Wid != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Wid);
		}
		states_.WriteTo(ref output, _repeated_states_codec);
		items_.WriteTo(ref output, _repeated_items_codec);
		if (position_ != null)
		{
			output.WriteRawTag(34);
			output.WriteMessage(Position);
		}
		if (characterInfo_ != null)
		{
			output.WriteRawTag(42);
			output.WriteMessage(CharacterInfo);
		}
		mapViewLogInfo_.WriteTo(ref output, _repeated_mapViewLogInfo_codec);
		if (mapViewRecordParam_ != null)
		{
			output.WriteRawTag(58);
			output.WriteMessage(MapViewRecordParam);
		}
		if (ChunkID != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(ChunkID);
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
		if (Wid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Wid);
		}
		num += states_.CalculateSize(_repeated_states_codec);
		num += items_.CalculateSize(_repeated_items_codec);
		if (position_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Position);
		}
		if (characterInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(CharacterInfo);
		}
		num += mapViewLogInfo_.CalculateSize(_repeated_mapViewLogInfo_codec);
		if (mapViewRecordParam_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(MapViewRecordParam);
		}
		if (ChunkID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ChunkID);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(TriggerInteractEventReq other)
	{
		if (other == null)
		{
			return;
		}
		if (other.Wid != 0)
		{
			Wid = other.Wid;
		}
		states_.Add(other.states_);
		items_.Add(other.items_);
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
		mapViewLogInfo_.Add(other.mapViewLogInfo_);
		if (other.mapViewRecordParam_ != null)
		{
			if (mapViewRecordParam_ == null)
			{
				MapViewRecordParam = new MapViewRecordParam();
			}
			MapViewRecordParam.MergeFrom(other.MapViewRecordParam);
		}
		if (other.ChunkID != 0)
		{
			ChunkID = other.ChunkID;
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
				Wid = input.ReadInt32();
				break;
			case 18u:
				states_.AddEntriesFrom(ref input, _repeated_states_codec);
				break;
			case 26u:
				items_.AddEntriesFrom(ref input, _repeated_items_codec);
				break;
			case 34u:
				if (position_ == null)
				{
					Position = new PBVector3();
				}
				input.ReadMessage(Position);
				break;
			case 42u:
				if (characterInfo_ == null)
				{
					CharacterInfo = new CharacterSyncInfo();
				}
				input.ReadMessage(CharacterInfo);
				break;
			case 50u:
				mapViewLogInfo_.AddEntriesFrom(ref input, _repeated_mapViewLogInfo_codec);
				break;
			case 58u:
				if (mapViewRecordParam_ == null)
				{
					MapViewRecordParam = new MapViewRecordParam();
				}
				input.ReadMessage(MapViewRecordParam);
				break;
			case 64u:
				ChunkID = input.ReadInt32();
				break;
			}
		}
	}
}
