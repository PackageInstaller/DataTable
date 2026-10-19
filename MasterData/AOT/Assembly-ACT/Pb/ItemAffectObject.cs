using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class ItemAffectObject : IMessage<ItemAffectObject>, IMessage, IEquatable<ItemAffectObject>, IDeepCloneable<ItemAffectObject>, IBufferMessage
{
	private static readonly MessageParser<ItemAffectObject> _parser = new MessageParser<ItemAffectObject>(() => new ItemAffectObject());

	private UnknownFieldSet _unknownFields;

	public const int ObjectTypeFieldNumber = 1;

	private int objectType_;

	public const int ObjIDsFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_objIDs_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> objIDs_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ItemAffectObject> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => ItemReflection.Descriptor.MessageTypes[1];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ObjectType
	{
		get
		{
			return objectType_;
		}
		set
		{
			objectType_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> ObjIDs => objIDs_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ItemAffectObject()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ItemAffectObject(ItemAffectObject other)
		: this()
	{
		objectType_ = other.objectType_;
		objIDs_ = other.objIDs_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ItemAffectObject Clone()
	{
		return new ItemAffectObject(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ItemAffectObject);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ItemAffectObject other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ObjectType != other.ObjectType)
		{
			return false;
		}
		if (!objIDs_.Equals(other.objIDs_))
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
		if (ObjectType != 0)
		{
			num ^= ObjectType.GetHashCode();
		}
		num ^= objIDs_.GetHashCode();
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
		if (ObjectType != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ObjectType);
		}
		objIDs_.WriteTo(ref output, _repeated_objIDs_codec);
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
		if (ObjectType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ObjectType);
		}
		num += objIDs_.CalculateSize(_repeated_objIDs_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ItemAffectObject other)
	{
		if (other != null)
		{
			if (other.ObjectType != 0)
			{
				ObjectType = other.ObjectType;
			}
			objIDs_.Add(other.objIDs_);
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
				ObjectType = input.ReadInt32();
				break;
			case 16u:
			case 18u:
				objIDs_.AddEntriesFrom(ref input, _repeated_objIDs_codec);
				break;
			}
		}
	}
}
