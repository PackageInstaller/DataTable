using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class LittleItemsShortcutInfo : IMessage<LittleItemsShortcutInfo>, IMessage, IEquatable<LittleItemsShortcutInfo>, IDeepCloneable<LittleItemsShortcutInfo>, IBufferMessage
{
	private static readonly MessageParser<LittleItemsShortcutInfo> _parser = new MessageParser<LittleItemsShortcutInfo>(() => new LittleItemsShortcutInfo());

	private UnknownFieldSet _unknownFields;

	public const int ShortcutItemsFieldNumber = 1;

	private static readonly FieldCodec<int> _repeated_shortcutItems_codec = FieldCodec.ForInt32(10u);

	private readonly RepeatedField<int> shortcutItems_ = new RepeatedField<int>();

	public const int CurShortcutIdxFieldNumber = 2;

	private int curShortcutIdx_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<LittleItemsShortcutInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[31];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> ShortcutItems => shortcutItems_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CurShortcutIdx
	{
		get
		{
			return curShortcutIdx_;
		}
		set
		{
			curShortcutIdx_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LittleItemsShortcutInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LittleItemsShortcutInfo(LittleItemsShortcutInfo other)
		: this()
	{
		shortcutItems_ = other.shortcutItems_.Clone();
		curShortcutIdx_ = other.curShortcutIdx_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LittleItemsShortcutInfo Clone()
	{
		return new LittleItemsShortcutInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as LittleItemsShortcutInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(LittleItemsShortcutInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!shortcutItems_.Equals(other.shortcutItems_))
		{
			return false;
		}
		if (CurShortcutIdx != other.CurShortcutIdx)
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
		num ^= shortcutItems_.GetHashCode();
		if (CurShortcutIdx != 0)
		{
			num ^= CurShortcutIdx.GetHashCode();
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
		shortcutItems_.WriteTo(ref output, _repeated_shortcutItems_codec);
		if (CurShortcutIdx != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(CurShortcutIdx);
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
		num += shortcutItems_.CalculateSize(_repeated_shortcutItems_codec);
		if (CurShortcutIdx != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CurShortcutIdx);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(LittleItemsShortcutInfo other)
	{
		if (other != null)
		{
			shortcutItems_.Add(other.shortcutItems_);
			if (other.CurShortcutIdx != 0)
			{
				CurShortcutIdx = other.CurShortcutIdx;
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
			case 8u:
			case 10u:
				shortcutItems_.AddEntriesFrom(ref input, _repeated_shortcutItems_codec);
				break;
			case 16u:
				CurShortcutIdx = input.ReadInt32();
				break;
			}
		}
	}
}
