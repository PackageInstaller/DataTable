using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class SceneMessageInfo : IMessage<SceneMessageInfo>, IMessage, IEquatable<SceneMessageInfo>, IDeepCloneable<SceneMessageInfo>, IBufferMessage
{
	private static readonly MessageParser<SceneMessageInfo> _parser = new MessageParser<SceneMessageInfo>(() => new SceneMessageInfo());

	private UnknownFieldSet _unknownFields;

	public const int MessageIdFieldNumber = 1;

	private long messageId_;

	public const int AccountIdFieldNumber = 2;

	private long accountId_;

	public const int SyntaxIdFieldNumber = 3;

	private int syntaxId_;

	public const int ContentIdsFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_contentIds_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> contentIds_ = new RepeatedField<int>();

	public const int StyleIdFieldNumber = 5;

	private int styleId_;

	public const int ChunkIdFieldNumber = 6;

	private int chunkId_;

	public const int PositionFieldNumber = 7;

	private PBVector3 position_;

	public const int ExpireTsFieldNumber = 8;

	private long expireTs_;

	public const int LikeInfoFieldNumber = 9;

	private static readonly MapField<int, int>.Codec _map_likeInfo_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 74u);

	private readonly MapField<int, int> likeInfo_ = new MapField<int, int>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<SceneMessageInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[299];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long MessageId
	{
		get
		{
			return messageId_;
		}
		set
		{
			messageId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long AccountId
	{
		get
		{
			return accountId_;
		}
		set
		{
			accountId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int SyntaxId
	{
		get
		{
			return syntaxId_;
		}
		set
		{
			syntaxId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> ContentIds => contentIds_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int StyleId
	{
		get
		{
			return styleId_;
		}
		set
		{
			styleId_ = value;
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
	public long ExpireTs
	{
		get
		{
			return expireTs_;
		}
		set
		{
			expireTs_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> LikeInfo => likeInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SceneMessageInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SceneMessageInfo(SceneMessageInfo other)
		: this()
	{
		messageId_ = other.messageId_;
		accountId_ = other.accountId_;
		syntaxId_ = other.syntaxId_;
		contentIds_ = other.contentIds_.Clone();
		styleId_ = other.styleId_;
		chunkId_ = other.chunkId_;
		position_ = ((other.position_ != null) ? other.position_.Clone() : null);
		expireTs_ = other.expireTs_;
		likeInfo_ = other.likeInfo_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SceneMessageInfo Clone()
	{
		return new SceneMessageInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as SceneMessageInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(SceneMessageInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (MessageId != other.MessageId)
		{
			return false;
		}
		if (AccountId != other.AccountId)
		{
			return false;
		}
		if (SyntaxId != other.SyntaxId)
		{
			return false;
		}
		if (!contentIds_.Equals(other.contentIds_))
		{
			return false;
		}
		if (StyleId != other.StyleId)
		{
			return false;
		}
		if (ChunkId != other.ChunkId)
		{
			return false;
		}
		if (!object.Equals(Position, other.Position))
		{
			return false;
		}
		if (ExpireTs != other.ExpireTs)
		{
			return false;
		}
		if (!LikeInfo.Equals(other.LikeInfo))
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
		if (MessageId != 0L)
		{
			num ^= MessageId.GetHashCode();
		}
		if (AccountId != 0L)
		{
			num ^= AccountId.GetHashCode();
		}
		if (SyntaxId != 0)
		{
			num ^= SyntaxId.GetHashCode();
		}
		num ^= contentIds_.GetHashCode();
		if (StyleId != 0)
		{
			num ^= StyleId.GetHashCode();
		}
		if (ChunkId != 0)
		{
			num ^= ChunkId.GetHashCode();
		}
		if (position_ != null)
		{
			num ^= Position.GetHashCode();
		}
		if (ExpireTs != 0L)
		{
			num ^= ExpireTs.GetHashCode();
		}
		num ^= LikeInfo.GetHashCode();
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
		if (MessageId != 0L)
		{
			output.WriteRawTag(8);
			output.WriteInt64(MessageId);
		}
		if (AccountId != 0L)
		{
			output.WriteRawTag(16);
			output.WriteInt64(AccountId);
		}
		if (SyntaxId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(SyntaxId);
		}
		contentIds_.WriteTo(ref output, _repeated_contentIds_codec);
		if (StyleId != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(StyleId);
		}
		if (ChunkId != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(ChunkId);
		}
		if (position_ != null)
		{
			output.WriteRawTag(58);
			output.WriteMessage(Position);
		}
		if (ExpireTs != 0L)
		{
			output.WriteRawTag(64);
			output.WriteInt64(ExpireTs);
		}
		likeInfo_.WriteTo(ref output, _map_likeInfo_codec);
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
		if (MessageId != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(MessageId);
		}
		if (AccountId != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(AccountId);
		}
		if (SyntaxId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SyntaxId);
		}
		num += contentIds_.CalculateSize(_repeated_contentIds_codec);
		if (StyleId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StyleId);
		}
		if (ChunkId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ChunkId);
		}
		if (position_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Position);
		}
		if (ExpireTs != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(ExpireTs);
		}
		num += likeInfo_.CalculateSize(_map_likeInfo_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(SceneMessageInfo other)
	{
		if (other == null)
		{
			return;
		}
		if (other.MessageId != 0L)
		{
			MessageId = other.MessageId;
		}
		if (other.AccountId != 0L)
		{
			AccountId = other.AccountId;
		}
		if (other.SyntaxId != 0)
		{
			SyntaxId = other.SyntaxId;
		}
		contentIds_.Add(other.contentIds_);
		if (other.StyleId != 0)
		{
			StyleId = other.StyleId;
		}
		if (other.ChunkId != 0)
		{
			ChunkId = other.ChunkId;
		}
		if (other.position_ != null)
		{
			if (position_ == null)
			{
				Position = new PBVector3();
			}
			Position.MergeFrom(other.Position);
		}
		if (other.ExpireTs != 0L)
		{
			ExpireTs = other.ExpireTs;
		}
		likeInfo_.Add(other.likeInfo_);
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
				MessageId = input.ReadInt64();
				break;
			case 16u:
				AccountId = input.ReadInt64();
				break;
			case 24u:
				SyntaxId = input.ReadInt32();
				break;
			case 32u:
			case 34u:
				contentIds_.AddEntriesFrom(ref input, _repeated_contentIds_codec);
				break;
			case 40u:
				StyleId = input.ReadInt32();
				break;
			case 48u:
				ChunkId = input.ReadInt32();
				break;
			case 58u:
				if (position_ == null)
				{
					Position = new PBVector3();
				}
				input.ReadMessage(Position);
				break;
			case 64u:
				ExpireTs = input.ReadInt64();
				break;
			case 74u:
				likeInfo_.AddEntriesFrom(ref input, _map_likeInfo_codec);
				break;
			}
		}
	}
}
