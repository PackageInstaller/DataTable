using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class UseItemsReq : IMessage<UseItemsReq>, IMessage, IEquatable<UseItemsReq>, IDeepCloneable<UseItemsReq>, IBufferMessage
{
	private static readonly MessageParser<UseItemsReq> _parser = new MessageParser<UseItemsReq>(() => new UseItemsReq());

	private UnknownFieldSet _unknownFields;

	public const int ItemFieldNumber = 1;

	private OperationItem item_;

	public const int AffectObjFieldNumber = 2;

	private ItemAffectObject affectObj_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<UseItemsReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => ItemReflection.Descriptor.MessageTypes[2];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public OperationItem Item
	{
		get
		{
			return item_;
		}
		set
		{
			item_ = value;
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
	public UseItemsReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public UseItemsReq(UseItemsReq other)
		: this()
	{
		item_ = ((other.item_ != null) ? other.item_.Clone() : null);
		affectObj_ = ((other.affectObj_ != null) ? other.affectObj_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public UseItemsReq Clone()
	{
		return new UseItemsReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as UseItemsReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(UseItemsReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(Item, other.Item))
		{
			return false;
		}
		if (!object.Equals(AffectObj, other.AffectObj))
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
		if (item_ != null)
		{
			num ^= Item.GetHashCode();
		}
		if (affectObj_ != null)
		{
			num ^= AffectObj.GetHashCode();
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
		if (item_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(Item);
		}
		if (affectObj_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(AffectObj);
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
		if (item_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Item);
		}
		if (affectObj_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(AffectObj);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(UseItemsReq other)
	{
		if (other == null)
		{
			return;
		}
		if (other.item_ != null)
		{
			if (item_ == null)
			{
				Item = new OperationItem();
			}
			Item.MergeFrom(other.Item);
		}
		if (other.affectObj_ != null)
		{
			if (affectObj_ == null)
			{
				AffectObj = new ItemAffectObject();
			}
			AffectObj.MergeFrom(other.AffectObj);
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
			case 10u:
				if (item_ == null)
				{
					Item = new OperationItem();
				}
				input.ReadMessage(Item);
				break;
			case 18u:
				if (affectObj_ == null)
				{
					AffectObj = new ItemAffectObject();
				}
				input.ReadMessage(AffectObj);
				break;
			}
		}
	}
}
