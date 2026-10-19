using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class VocabularyUnlockContentAck : IMessage<VocabularyUnlockContentAck>, IMessage, IEquatable<VocabularyUnlockContentAck>, IDeepCloneable<VocabularyUnlockContentAck>, IBufferMessage
{
	private static readonly MessageParser<VocabularyUnlockContentAck> _parser = new MessageParser<VocabularyUnlockContentAck>(() => new VocabularyUnlockContentAck());

	private UnknownFieldSet _unknownFields;

	public const int GroupStateFieldNumber = 1;

	private static readonly MapField<int, bool>.Codec _map_groupState_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 10u);

	private readonly MapField<int, bool> groupState_ = new MapField<int, bool>();

	public const int ContentStateFieldNumber = 2;

	private static readonly MapField<int, bool>.Codec _map_contentState_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 18u);

	private readonly MapField<int, bool> contentState_ = new MapField<int, bool>();

	public const int ContentInfoFieldNumber = 3;

	private static readonly MapField<int, TextLibraryContent>.Codec _map_contentInfo_codec = new MapField<int, TextLibraryContent>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, TextLibraryContent.Parser), 26u);

	private readonly MapField<int, TextLibraryContent> contentInfo_ = new MapField<int, TextLibraryContent>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<VocabularyUnlockContentAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => VocabularyReflection.Descriptor.MessageTypes[2];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> GroupState => groupState_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> ContentState => contentState_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, TextLibraryContent> ContentInfo => contentInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public VocabularyUnlockContentAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public VocabularyUnlockContentAck(VocabularyUnlockContentAck other)
		: this()
	{
		groupState_ = other.groupState_.Clone();
		contentState_ = other.contentState_.Clone();
		contentInfo_ = other.contentInfo_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public VocabularyUnlockContentAck Clone()
	{
		return new VocabularyUnlockContentAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as VocabularyUnlockContentAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(VocabularyUnlockContentAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!GroupState.Equals(other.GroupState))
		{
			return false;
		}
		if (!ContentState.Equals(other.ContentState))
		{
			return false;
		}
		if (!ContentInfo.Equals(other.ContentInfo))
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
		num ^= GroupState.GetHashCode();
		num ^= ContentState.GetHashCode();
		num ^= ContentInfo.GetHashCode();
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
		groupState_.WriteTo(ref output, _map_groupState_codec);
		contentState_.WriteTo(ref output, _map_contentState_codec);
		contentInfo_.WriteTo(ref output, _map_contentInfo_codec);
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
		num += groupState_.CalculateSize(_map_groupState_codec);
		num += contentState_.CalculateSize(_map_contentState_codec);
		num += contentInfo_.CalculateSize(_map_contentInfo_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(VocabularyUnlockContentAck other)
	{
		if (other != null)
		{
			groupState_.Add(other.groupState_);
			contentState_.Add(other.contentState_);
			contentInfo_.Add(other.contentInfo_);
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
				groupState_.AddEntriesFrom(ref input, _map_groupState_codec);
				break;
			case 18u:
				contentState_.AddEntriesFrom(ref input, _map_contentState_codec);
				break;
			case 26u:
				contentInfo_.AddEntriesFrom(ref input, _map_contentInfo_codec);
				break;
			}
		}
	}
}
