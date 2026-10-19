using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class UniversalItem : IMessage<UniversalItem>, IMessage, IEquatable<UniversalItem>, IDeepCloneable<UniversalItem>, IBufferMessage
{
	private static readonly MessageParser<UniversalItem> _parser = new MessageParser<UniversalItem>(() => new UniversalItem());

	private UnknownFieldSet _unknownFields;

	public const int TypeFieldNumber = 1;

	private UniversalItemType type_;

	public const int UidFieldNumber = 2;

	private int uid_;

	public const int IndexFieldNumber = 3;

	private int index_;

	public const int CountFieldNumber = 4;

	private int count_;

	public const int IsNewFieldNumber = 5;

	private bool isNew_;

	public const int ExtraItemsFieldNumber = 6;

	private static readonly FieldCodec<UniversalItem> _repeated_extraItems_codec = FieldCodec.ForMessage(50u, Parser);

	private readonly RepeatedField<UniversalItem> extraItems_ = new RepeatedField<UniversalItem>();

	public const int ExpireTimeFieldNumber = 7;

	private long expireTime_;

	public const int TagFieldNumber = 8;

	private UniversalItemTag tag_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<UniversalItem> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[19];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public UniversalItemType Type
	{
		get
		{
			return type_;
		}
		set
		{
			type_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Uid
	{
		get
		{
			return uid_;
		}
		set
		{
			uid_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Index
	{
		get
		{
			return index_;
		}
		set
		{
			index_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Count
	{
		get
		{
			return count_;
		}
		set
		{
			count_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool IsNew
	{
		get
		{
			return isNew_;
		}
		set
		{
			isNew_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<UniversalItem> ExtraItems => extraItems_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long ExpireTime
	{
		get
		{
			return expireTime_;
		}
		set
		{
			expireTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public UniversalItemTag Tag
	{
		get
		{
			return tag_;
		}
		set
		{
			tag_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public UniversalItem()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public UniversalItem(UniversalItem other)
		: this()
	{
		type_ = other.type_;
		uid_ = other.uid_;
		index_ = other.index_;
		count_ = other.count_;
		isNew_ = other.isNew_;
		extraItems_ = other.extraItems_.Clone();
		expireTime_ = other.expireTime_;
		tag_ = other.tag_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public UniversalItem Clone()
	{
		return new UniversalItem(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as UniversalItem);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(UniversalItem other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Type != other.Type)
		{
			return false;
		}
		if (Uid != other.Uid)
		{
			return false;
		}
		if (Index != other.Index)
		{
			return false;
		}
		if (Count != other.Count)
		{
			return false;
		}
		if (IsNew != other.IsNew)
		{
			return false;
		}
		if (!extraItems_.Equals(other.extraItems_))
		{
			return false;
		}
		if (ExpireTime != other.ExpireTime)
		{
			return false;
		}
		if (Tag != other.Tag)
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
		if (Type != UniversalItemType.UniversalItemNormal)
		{
			num ^= Type.GetHashCode();
		}
		if (Uid != 0)
		{
			num ^= Uid.GetHashCode();
		}
		if (Index != 0)
		{
			num ^= Index.GetHashCode();
		}
		if (Count != 0)
		{
			num ^= Count.GetHashCode();
		}
		if (IsNew)
		{
			num ^= IsNew.GetHashCode();
		}
		num ^= extraItems_.GetHashCode();
		if (ExpireTime != 0L)
		{
			num ^= ExpireTime.GetHashCode();
		}
		if (Tag != UniversalItemTag.Default)
		{
			num ^= Tag.GetHashCode();
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
		if (Type != UniversalItemType.UniversalItemNormal)
		{
			output.WriteRawTag(8);
			output.WriteEnum((int)Type);
		}
		if (Uid != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Uid);
		}
		if (Index != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Index);
		}
		if (Count != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Count);
		}
		if (IsNew)
		{
			output.WriteRawTag(40);
			output.WriteBool(IsNew);
		}
		extraItems_.WriteTo(ref output, _repeated_extraItems_codec);
		if (ExpireTime != 0L)
		{
			output.WriteRawTag(56);
			output.WriteInt64(ExpireTime);
		}
		if (Tag != UniversalItemTag.Default)
		{
			output.WriteRawTag(64);
			output.WriteEnum((int)Tag);
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
		if (Type != UniversalItemType.UniversalItemNormal)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)Type);
		}
		if (Uid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Uid);
		}
		if (Index != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Index);
		}
		if (Count != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Count);
		}
		if (IsNew)
		{
			num += 2;
		}
		num += extraItems_.CalculateSize(_repeated_extraItems_codec);
		if (ExpireTime != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(ExpireTime);
		}
		if (Tag != UniversalItemTag.Default)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)Tag);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(UniversalItem other)
	{
		if (other != null)
		{
			if (other.Type != UniversalItemType.UniversalItemNormal)
			{
				Type = other.Type;
			}
			if (other.Uid != 0)
			{
				Uid = other.Uid;
			}
			if (other.Index != 0)
			{
				Index = other.Index;
			}
			if (other.Count != 0)
			{
				Count = other.Count;
			}
			if (other.IsNew)
			{
				IsNew = other.IsNew;
			}
			extraItems_.Add(other.extraItems_);
			if (other.ExpireTime != 0L)
			{
				ExpireTime = other.ExpireTime;
			}
			if (other.Tag != UniversalItemTag.Default)
			{
				Tag = other.Tag;
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
				Type = (UniversalItemType)input.ReadEnum();
				break;
			case 16u:
				Uid = input.ReadInt32();
				break;
			case 24u:
				Index = input.ReadInt32();
				break;
			case 32u:
				Count = input.ReadInt32();
				break;
			case 40u:
				IsNew = input.ReadBool();
				break;
			case 50u:
				extraItems_.AddEntriesFrom(ref input, _repeated_extraItems_codec);
				break;
			case 56u:
				ExpireTime = input.ReadInt64();
				break;
			case 64u:
				Tag = (UniversalItemTag)input.ReadEnum();
				break;
			}
		}
	}
}
