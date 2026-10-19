using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class RoguePickUpItemReq : IMessage<RoguePickUpItemReq>, IMessage, IEquatable<RoguePickUpItemReq>, IDeepCloneable<RoguePickUpItemReq>, IBufferMessage
{
	private static readonly MessageParser<RoguePickUpItemReq> _parser = new MessageParser<RoguePickUpItemReq>(() => new RoguePickUpItemReq());

	private UnknownFieldSet _unknownFields;

	public const int ItemIdFieldNumber = 1;

	private int itemId_;

	public const int IsReplaceFieldNumber = 2;

	private bool isReplace_;

	public const int ReplacePositionFieldNumber = 3;

	private int replacePosition_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<RoguePickUpItemReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => RogueReflection.Descriptor.MessageTypes[24];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

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
	public RoguePickUpItemReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RoguePickUpItemReq(RoguePickUpItemReq other)
		: this()
	{
		itemId_ = other.itemId_;
		isReplace_ = other.isReplace_;
		replacePosition_ = other.replacePosition_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RoguePickUpItemReq Clone()
	{
		return new RoguePickUpItemReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as RoguePickUpItemReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(RoguePickUpItemReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
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
		if (ItemId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ItemId);
		}
		if (IsReplace)
		{
			output.WriteRawTag(16);
			output.WriteBool(IsReplace);
		}
		if (ReplacePosition != 0)
		{
			output.WriteRawTag(24);
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
	public void MergeFrom(RoguePickUpItemReq other)
	{
		if (other != null)
		{
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
				ItemId = input.ReadInt32();
				break;
			case 16u:
				IsReplace = input.ReadBool();
				break;
			case 24u:
				ReplacePosition = input.ReadInt32();
				break;
			}
		}
	}
}
