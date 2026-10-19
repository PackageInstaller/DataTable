using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class GachaQueryHistoryAck : IMessage<GachaQueryHistoryAck>, IMessage, IEquatable<GachaQueryHistoryAck>, IDeepCloneable<GachaQueryHistoryAck>, IBufferMessage
{
	private static readonly MessageParser<GachaQueryHistoryAck> _parser = new MessageParser<GachaQueryHistoryAck>(() => new GachaQueryHistoryAck());

	private UnknownFieldSet _unknownFields;

	public const int CodeFieldNumber = 1;

	private int code_;

	public const int PageItemsFieldNumber = 2;

	private static readonly FieldCodec<GachaHistoryItem> _repeated_pageItems_codec = FieldCodec.ForMessage(18u, GachaHistoryItem.Parser);

	private readonly RepeatedField<GachaHistoryItem> pageItems_ = new RepeatedField<GachaHistoryItem>();

	public const int TotalPageFieldNumber = 3;

	private int totalPage_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<GachaQueryHistoryAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[14];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Code
	{
		get
		{
			return code_;
		}
		set
		{
			code_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<GachaHistoryItem> PageItems => pageItems_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int TotalPage
	{
		get
		{
			return totalPage_;
		}
		set
		{
			totalPage_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaQueryHistoryAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaQueryHistoryAck(GachaQueryHistoryAck other)
		: this()
	{
		code_ = other.code_;
		pageItems_ = other.pageItems_.Clone();
		totalPage_ = other.totalPage_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaQueryHistoryAck Clone()
	{
		return new GachaQueryHistoryAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as GachaQueryHistoryAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(GachaQueryHistoryAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Code != other.Code)
		{
			return false;
		}
		if (!pageItems_.Equals(other.pageItems_))
		{
			return false;
		}
		if (TotalPage != other.TotalPage)
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
		if (Code != 0)
		{
			num ^= Code.GetHashCode();
		}
		num ^= pageItems_.GetHashCode();
		if (TotalPage != 0)
		{
			num ^= TotalPage.GetHashCode();
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
		if (Code != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Code);
		}
		pageItems_.WriteTo(ref output, _repeated_pageItems_codec);
		if (TotalPage != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(TotalPage);
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
		if (Code != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Code);
		}
		num += pageItems_.CalculateSize(_repeated_pageItems_codec);
		if (TotalPage != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TotalPage);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(GachaQueryHistoryAck other)
	{
		if (other != null)
		{
			if (other.Code != 0)
			{
				Code = other.Code;
			}
			pageItems_.Add(other.pageItems_);
			if (other.TotalPage != 0)
			{
				TotalPage = other.TotalPage;
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
				Code = input.ReadInt32();
				break;
			case 18u:
				pageItems_.AddEntriesFrom(ref input, _repeated_pageItems_codec);
				break;
			case 24u:
				TotalPage = input.ReadInt32();
				break;
			}
		}
	}
}
