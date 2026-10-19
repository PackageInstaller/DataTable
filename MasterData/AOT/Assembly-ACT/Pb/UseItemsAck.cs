using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class UseItemsAck : IMessage<UseItemsAck>, IMessage, IEquatable<UseItemsAck>, IDeepCloneable<UseItemsAck>, IBufferMessage
{
	private static readonly MessageParser<UseItemsAck> _parser = new MessageParser<UseItemsAck>(() => new UseItemsAck());

	private UnknownFieldSet _unknownFields;

	public const int OkFieldNumber = 1;

	private bool ok_;

	public const int AffectObjFieldNumber = 2;

	private ItemAffectObject affectObj_;

	public const int ObtainItemsFieldNumber = 3;

	private static readonly FieldCodec<Item> _repeated_obtainItems_codec = FieldCodec.ForMessage(26u, Item.Parser);

	private readonly RepeatedField<Item> obtainItems_ = new RepeatedField<Item>();

	public const int GotItemsFieldNumber = 4;

	private static readonly FieldCodec<UniversalItem> _repeated_gotItems_codec = FieldCodec.ForMessage(34u, UniversalItem.Parser);

	private readonly RepeatedField<UniversalItem> gotItems_ = new RepeatedField<UniversalItem>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<UseItemsAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => ItemReflection.Descriptor.MessageTypes[3];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Ok
	{
		get
		{
			return ok_;
		}
		set
		{
			ok_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ItemAffectObject AffectObj
	{
		get
		{
			return affectObj_;
		}
		set
		{
			affectObj_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<Item> ObtainItems => obtainItems_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<UniversalItem> GotItems => gotItems_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public UseItemsAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public UseItemsAck(UseItemsAck other)
		: this()
	{
		ok_ = other.ok_;
		affectObj_ = ((other.affectObj_ != null) ? other.affectObj_.Clone() : null);
		obtainItems_ = other.obtainItems_.Clone();
		gotItems_ = other.gotItems_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public UseItemsAck Clone()
	{
		return new UseItemsAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as UseItemsAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(UseItemsAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Ok != other.Ok)
		{
			return false;
		}
		if (!object.Equals(AffectObj, other.AffectObj))
		{
			return false;
		}
		if (!obtainItems_.Equals(other.obtainItems_))
		{
			return false;
		}
		if (!gotItems_.Equals(other.gotItems_))
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
		if (Ok)
		{
			num ^= Ok.GetHashCode();
		}
		if (affectObj_ != null)
		{
			num ^= AffectObj.GetHashCode();
		}
		num ^= obtainItems_.GetHashCode();
		num ^= gotItems_.GetHashCode();
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
		if (Ok)
		{
			output.WriteRawTag(8);
			output.WriteBool(Ok);
		}
		if (affectObj_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(AffectObj);
		}
		obtainItems_.WriteTo(ref output, _repeated_obtainItems_codec);
		gotItems_.WriteTo(ref output, _repeated_gotItems_codec);
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
		if (Ok)
		{
			num += 2;
		}
		if (affectObj_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(AffectObj);
		}
		num += obtainItems_.CalculateSize(_repeated_obtainItems_codec);
		num += gotItems_.CalculateSize(_repeated_gotItems_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(UseItemsAck other)
	{
		if (other == null)
		{
			return;
		}
		if (other.Ok)
		{
			Ok = other.Ok;
		}
		if (other.affectObj_ != null)
		{
			if (affectObj_ == null)
			{
				AffectObj = new ItemAffectObject();
			}
			AffectObj.MergeFrom(other.AffectObj);
		}
		obtainItems_.Add(other.obtainItems_);
		gotItems_.Add(other.gotItems_);
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
				Ok = input.ReadBool();
				break;
			case 18u:
				if (affectObj_ == null)
				{
					AffectObj = new ItemAffectObject();
				}
				input.ReadMessage(AffectObj);
				break;
			case 26u:
				obtainItems_.AddEntriesFrom(ref input, _repeated_obtainItems_codec);
				break;
			case 34u:
				gotItems_.AddEntriesFrom(ref input, _repeated_gotItems_codec);
				break;
			}
		}
	}
}
