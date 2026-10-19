using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class CookReq : IMessage<CookReq>, IMessage, IEquatable<CookReq>, IDeepCloneable<CookReq>, IBufferMessage
{
	private static readonly MessageParser<CookReq> _parser = new MessageParser<CookReq>(() => new CookReq());

	private UnknownFieldSet _unknownFields;

	public const int MainItemsFieldNumber = 1;

	private static readonly FieldCodec<Item> _repeated_mainItems_codec = FieldCodec.ForMessage(10u, Item.Parser);

	private readonly RepeatedField<Item> mainItems_ = new RepeatedField<Item>();

	public const int MinorItemsFieldNumber = 2;

	private static readonly FieldCodec<Item> _repeated_minorItems_codec = FieldCodec.ForMessage(18u, Item.Parser);

	private readonly RepeatedField<Item> minorItems_ = new RepeatedField<Item>();

	public const int CookWayFieldNumber = 3;

	private CookWay cookWay_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<CookReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[61];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<Item> MainItems => mainItems_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<Item> MinorItems => minorItems_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CookWay CookWay
	{
		get
		{
			return cookWay_;
		}
		set
		{
			cookWay_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CookReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CookReq(CookReq other)
		: this()
	{
		mainItems_ = other.mainItems_.Clone();
		minorItems_ = other.minorItems_.Clone();
		cookWay_ = other.cookWay_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CookReq Clone()
	{
		return new CookReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as CookReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(CookReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!mainItems_.Equals(other.mainItems_))
		{
			return false;
		}
		if (!minorItems_.Equals(other.minorItems_))
		{
			return false;
		}
		if (CookWay != other.CookWay)
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
		num ^= mainItems_.GetHashCode();
		num ^= minorItems_.GetHashCode();
		if (CookWay != CookWay.Menu)
		{
			num ^= CookWay.GetHashCode();
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
		mainItems_.WriteTo(ref output, _repeated_mainItems_codec);
		minorItems_.WriteTo(ref output, _repeated_minorItems_codec);
		if (CookWay != CookWay.Menu)
		{
			output.WriteRawTag(24);
			output.WriteEnum((int)CookWay);
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
		num += mainItems_.CalculateSize(_repeated_mainItems_codec);
		num += minorItems_.CalculateSize(_repeated_minorItems_codec);
		if (CookWay != CookWay.Menu)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)CookWay);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CookReq other)
	{
		if (other != null)
		{
			mainItems_.Add(other.mainItems_);
			minorItems_.Add(other.minorItems_);
			if (other.CookWay != CookWay.Menu)
			{
				CookWay = other.CookWay;
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
				mainItems_.AddEntriesFrom(ref input, _repeated_mainItems_codec);
				break;
			case 18u:
				minorItems_.AddEntriesFrom(ref input, _repeated_minorItems_codec);
				break;
			case 24u:
				CookWay = (CookWay)input.ReadEnum();
				break;
			}
		}
	}
}
