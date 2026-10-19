using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class LoungeDbModel : IMessage<LoungeDbModel>, IMessage, IEquatable<LoungeDbModel>, IDeepCloneable<LoungeDbModel>, IBufferMessage
{
	private static readonly MessageParser<LoungeDbModel> _parser = new MessageParser<LoungeDbModel>(() => new LoungeDbModel());

	private UnknownFieldSet _unknownFields;

	public const int LastRefreshTsFieldNumber = 1;

	private int lastRefreshTs_;

	public const int LobbyInfoFieldNumber = 2;

	private Lounge lobbyInfo_;

	public const int NormalIdleRecordFieldNumber = 3;

	private static readonly MapField<int, LoungeNormalIdleRecord>.Codec _map_normalIdleRecord_codec = new MapField<int, LoungeNormalIdleRecord>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, LoungeNormalIdleRecord.Parser), 26u);

	private readonly MapField<int, LoungeNormalIdleRecord> normalIdleRecord_ = new MapField<int, LoungeNormalIdleRecord>();

	public const int LastResetTsFieldNumber = 4;

	private int lastResetTs_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<LoungeDbModel> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[289];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int LastRefreshTs
	{
		get
		{
			return lastRefreshTs_;
		}
		set
		{
			lastRefreshTs_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Lounge LobbyInfo
	{
		get
		{
			return lobbyInfo_;
		}
		set
		{
			lobbyInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, LoungeNormalIdleRecord> NormalIdleRecord => normalIdleRecord_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int LastResetTs
	{
		get
		{
			return lastResetTs_;
		}
		set
		{
			lastResetTs_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LoungeDbModel()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LoungeDbModel(LoungeDbModel other)
		: this()
	{
		lastRefreshTs_ = other.lastRefreshTs_;
		lobbyInfo_ = ((other.lobbyInfo_ != null) ? other.lobbyInfo_.Clone() : null);
		normalIdleRecord_ = other.normalIdleRecord_.Clone();
		lastResetTs_ = other.lastResetTs_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LoungeDbModel Clone()
	{
		return new LoungeDbModel(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as LoungeDbModel);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(LoungeDbModel other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (LastRefreshTs != other.LastRefreshTs)
		{
			return false;
		}
		if (!object.Equals(LobbyInfo, other.LobbyInfo))
		{
			return false;
		}
		if (!NormalIdleRecord.Equals(other.NormalIdleRecord))
		{
			return false;
		}
		if (LastResetTs != other.LastResetTs)
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
		if (LastRefreshTs != 0)
		{
			num ^= LastRefreshTs.GetHashCode();
		}
		if (lobbyInfo_ != null)
		{
			num ^= LobbyInfo.GetHashCode();
		}
		num ^= NormalIdleRecord.GetHashCode();
		if (LastResetTs != 0)
		{
			num ^= LastResetTs.GetHashCode();
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
		if (LastRefreshTs != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(LastRefreshTs);
		}
		if (lobbyInfo_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(LobbyInfo);
		}
		normalIdleRecord_.WriteTo(ref output, _map_normalIdleRecord_codec);
		if (LastResetTs != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(LastResetTs);
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
		if (LastRefreshTs != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LastRefreshTs);
		}
		if (lobbyInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(LobbyInfo);
		}
		num += normalIdleRecord_.CalculateSize(_map_normalIdleRecord_codec);
		if (LastResetTs != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LastResetTs);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(LoungeDbModel other)
	{
		if (other == null)
		{
			return;
		}
		if (other.LastRefreshTs != 0)
		{
			LastRefreshTs = other.LastRefreshTs;
		}
		if (other.lobbyInfo_ != null)
		{
			if (lobbyInfo_ == null)
			{
				LobbyInfo = new Lounge();
			}
			LobbyInfo.MergeFrom(other.LobbyInfo);
		}
		normalIdleRecord_.Add(other.normalIdleRecord_);
		if (other.LastResetTs != 0)
		{
			LastResetTs = other.LastResetTs;
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
				LastRefreshTs = input.ReadInt32();
				break;
			case 18u:
				if (lobbyInfo_ == null)
				{
					LobbyInfo = new Lounge();
				}
				input.ReadMessage(LobbyInfo);
				break;
			case 26u:
				normalIdleRecord_.AddEntriesFrom(ref input, _map_normalIdleRecord_codec);
				break;
			case 32u:
				LastResetTs = input.ReadInt32();
				break;
			}
		}
	}
}
