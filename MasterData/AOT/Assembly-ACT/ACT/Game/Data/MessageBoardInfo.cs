using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class MessageBoardInfo : IMessage<MessageBoardInfo>, IMessage, IEquatable<MessageBoardInfo>, IDeepCloneable<MessageBoardInfo>, IBufferMessage
{
	private static readonly MessageParser<MessageBoardInfo> _parser = new MessageParser<MessageBoardInfo>(() => new MessageBoardInfo());

	private UnknownFieldSet _unknownFields;

	public const int OwnedMessagesFieldNumber = 1;

	private static readonly MapField<long, SceneMessageInfo>.Codec _map_ownedMessages_codec = new MapField<long, SceneMessageInfo>.Codec(FieldCodec.ForInt64(8u, 0L), FieldCodec.ForMessage(18u, SceneMessageInfo.Parser), 10u);

	private readonly MapField<long, SceneMessageInfo> ownedMessages_ = new MapField<long, SceneMessageInfo>();

	public const int SyntaxIdsFieldNumber = 2;

	private static readonly MapField<int, bool>.Codec _map_syntaxIds_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 18u);

	private readonly MapField<int, bool> syntaxIds_ = new MapField<int, bool>();

	public const int ContentIdsFieldNumber = 3;

	private static readonly MapField<int, bool>.Codec _map_contentIds_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 26u);

	private readonly MapField<int, bool> contentIds_ = new MapField<int, bool>();

	public const int LikedMessageIdsFieldNumber = 4;

	private static readonly MapField<long, int>.Codec _map_likedMessageIds_codec = new MapField<long, int>.Codec(FieldCodec.ForInt64(8u, 0L), FieldCodec.ForInt32(16u, 0), 34u);

	private readonly MapField<long, int> likedMessageIds_ = new MapField<long, int>();

	public const int IsRefreshFieldNumber = 5;

	private bool isRefresh_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MessageBoardInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[300];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<long, SceneMessageInfo> OwnedMessages => ownedMessages_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> SyntaxIds => syntaxIds_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> ContentIds => contentIds_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<long, int> LikedMessageIds => likedMessageIds_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool IsRefresh
	{
		get
		{
			return isRefresh_;
		}
		set
		{
			isRefresh_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MessageBoardInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MessageBoardInfo(MessageBoardInfo other)
		: this()
	{
		ownedMessages_ = other.ownedMessages_.Clone();
		syntaxIds_ = other.syntaxIds_.Clone();
		contentIds_ = other.contentIds_.Clone();
		likedMessageIds_ = other.likedMessageIds_.Clone();
		isRefresh_ = other.isRefresh_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MessageBoardInfo Clone()
	{
		return new MessageBoardInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MessageBoardInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MessageBoardInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!OwnedMessages.Equals(other.OwnedMessages))
		{
			return false;
		}
		if (!SyntaxIds.Equals(other.SyntaxIds))
		{
			return false;
		}
		if (!ContentIds.Equals(other.ContentIds))
		{
			return false;
		}
		if (!LikedMessageIds.Equals(other.LikedMessageIds))
		{
			return false;
		}
		if (IsRefresh != other.IsRefresh)
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
		num ^= OwnedMessages.GetHashCode();
		num ^= SyntaxIds.GetHashCode();
		num ^= ContentIds.GetHashCode();
		num ^= LikedMessageIds.GetHashCode();
		if (IsRefresh)
		{
			num ^= IsRefresh.GetHashCode();
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
		ownedMessages_.WriteTo(ref output, _map_ownedMessages_codec);
		syntaxIds_.WriteTo(ref output, _map_syntaxIds_codec);
		contentIds_.WriteTo(ref output, _map_contentIds_codec);
		likedMessageIds_.WriteTo(ref output, _map_likedMessageIds_codec);
		if (IsRefresh)
		{
			output.WriteRawTag(40);
			output.WriteBool(IsRefresh);
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
		num += ownedMessages_.CalculateSize(_map_ownedMessages_codec);
		num += syntaxIds_.CalculateSize(_map_syntaxIds_codec);
		num += contentIds_.CalculateSize(_map_contentIds_codec);
		num += likedMessageIds_.CalculateSize(_map_likedMessageIds_codec);
		if (IsRefresh)
		{
			num += 2;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(MessageBoardInfo other)
	{
		if (other != null)
		{
			ownedMessages_.Add(other.ownedMessages_);
			syntaxIds_.Add(other.syntaxIds_);
			contentIds_.Add(other.contentIds_);
			likedMessageIds_.Add(other.likedMessageIds_);
			if (other.IsRefresh)
			{
				IsRefresh = other.IsRefresh;
			}
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
		}
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
				ownedMessages_.AddEntriesFrom(ref input, _map_ownedMessages_codec);
				break;
			case 18u:
				syntaxIds_.AddEntriesFrom(ref input, _map_syntaxIds_codec);
				break;
			case 26u:
				contentIds_.AddEntriesFrom(ref input, _map_contentIds_codec);
				break;
			case 34u:
				likedMessageIds_.AddEntriesFrom(ref input, _map_likedMessageIds_codec);
				break;
			case 40u:
				IsRefresh = input.ReadBool();
				break;
			}
		}
	}
}
