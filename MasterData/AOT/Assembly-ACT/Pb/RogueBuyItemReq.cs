using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class RogueBuyItemReq : IMessage<RogueBuyItemReq>, IMessage, IEquatable<RogueBuyItemReq>, IDeepCloneable<RogueBuyItemReq>, IBufferMessage
{
	private static readonly MessageParser<RogueBuyItemReq> _parser = new MessageParser<RogueBuyItemReq>(() => new RogueBuyItemReq());

	private UnknownFieldSet _unknownFields;

	public const int IsBuyFieldNumber = 1;

	private bool isBuy_;

	public const int ItemIdFieldNumber = 2;

	private int itemId_;

	public const int IsReplaceFieldNumber = 3;

	private bool isReplace_;

	public const int ReplacePositionFieldNumber = 4;

	private int replacePosition_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<RogueBuyItemReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => RogueReflection.Descriptor.MessageTypes[9];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool IsBuy
	{
		get
		{
			return isBuy_;
		}
		set
		{
			isBuy_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ItemId
	{
		get
		{
			return itemId_;
		}
		set
		{
			itemId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool IsReplace
	{
		get
		{
			return isReplace_;
		}
		set
		{
			isReplace_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ReplacePosition
	{
		get
		{
			return replacePosition_;
		}
		set
		{
			replacePosition_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueBuyItemReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueBuyItemReq(RogueBuyItemReq other)
		: this()
	{
		isBuy_ = other.isBuy_;
		itemId_ = other.itemId_;
		isReplace_ = other.isReplace_;
		replacePosition_ = other.replacePosition_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueBuyItemReq Clone()
	{
		return new RogueBuyItemReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as RogueBuyItemReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(RogueBuyItemReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (IsBuy != other.IsBuy)
		{
			return false;
		}
		if (ItemId != other.ItemId)
		{
			return false;
		}
		if (IsReplace != other.IsReplace)
		{
			return false;
		}
		if (ReplacePosition != other.ReplacePosition)
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
		if (IsBuy)
		{
			num ^= IsBuy.GetHashCode();
		}
		if (ItemId != 0)
		{
			num ^= ItemId.GetHashCode();
		}
		if (IsReplace)
		{
			num ^= IsReplace.GetHashCode();
		}
		if (ReplacePosition != 0)
		{
			num ^= ReplacePosition.GetHashCode();
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
		if (IsBuy)
		{
			output.WriteRawTag(8);
			output.WriteBool(IsBuy);
		}
		if (ItemId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ItemId);
		}
		if (IsReplace)
		{
			output.WriteRawTag(24);
			output.WriteBool(IsReplace);
		}
		if (ReplacePosition != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(ReplacePosition);
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
		if (IsBuy)
		{
			num += 2;
		}
		if (ItemId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemId);
		}
		if (IsReplace)
		{
			num += 2;
		}
		if (ReplacePosition != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ReplacePosition);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(RogueBuyItemReq other)
	{
		if (other != null)
		{
			if (other.IsBuy)
			{
				IsBuy = other.IsBuy;
			}
			if (other.ItemId != 0)
			{
				ItemId = other.ItemId;
			}
			if (other.IsReplace)
			{
				IsReplace = other.IsReplace;
			}
			if (other.ReplacePosition != 0)
			{
				ReplacePosition = other.ReplacePosition;
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
				IsBuy = input.ReadBool();
				break;
			case 16u:
				ItemId = input.ReadInt32();
				break;
			case 24u:
				IsReplace = input.ReadBool();
				break;
			case 32u:
				ReplacePosition = input.ReadInt32();
				break;
			}
		}
	}
}
