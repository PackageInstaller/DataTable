using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class TreasureInfoNtf : IMessage<TreasureInfoNtf>, IMessage, IEquatable<TreasureInfoNtf>, IDeepCloneable<TreasureInfoNtf>, IBufferMessage
{
	private static readonly MessageParser<TreasureInfoNtf> _parser = new MessageParser<TreasureInfoNtf>(() => new TreasureInfoNtf());

	private UnknownFieldSet _unknownFields;

	public const int TreasureInfoFieldNumber = 1;

	private TreasureInfo treasureInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<TreasureInfoNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => ItemReflection.Descriptor.MessageTypes[24];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TreasureInfo TreasureInfo
	{
		get
		{
			return treasureInfo_;
		}
		set
		{
			treasureInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TreasureInfoNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TreasureInfoNtf(TreasureInfoNtf other)
		: this()
	{
		treasureInfo_ = ((other.treasureInfo_ != null) ? other.treasureInfo_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TreasureInfoNtf Clone()
	{
		return new TreasureInfoNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as TreasureInfoNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(TreasureInfoNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(TreasureInfo, other.TreasureInfo))
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
		if (treasureInfo_ != null)
		{
			num ^= TreasureInfo.GetHashCode();
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
		if (treasureInfo_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(TreasureInfo);
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
		if (treasureInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(TreasureInfo);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(TreasureInfoNtf other)
	{
		if (other == null)
		{
			return;
		}
		if (other.treasureInfo_ != null)
		{
			if (treasureInfo_ == null)
			{
				TreasureInfo = new TreasureInfo();
			}
			TreasureInfo.MergeFrom(other.TreasureInfo);
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
			if (num != 10)
			{
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				continue;
			}
			if (treasureInfo_ == null)
			{
				TreasureInfo = new TreasureInfo();
			}
			input.ReadMessage(TreasureInfo);
		}
	}
}
