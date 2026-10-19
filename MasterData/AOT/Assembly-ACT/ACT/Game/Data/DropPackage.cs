using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class DropPackage : IMessage<DropPackage>, IMessage, IEquatable<DropPackage>, IDeepCloneable<DropPackage>, IBufferMessage
{
	private static readonly MessageParser<DropPackage> _parser = new MessageParser<DropPackage>(() => new DropPackage());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private uint id_;

	public const int ItemsFieldNumber = 2;

	private static readonly MapField<int, DropItem>.Codec _map_items_codec = new MapField<int, DropItem>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, DropItem.Parser), 18u);

	private readonly MapField<int, DropItem> items_ = new MapField<int, DropItem>();

	public const int SourceFieldNumber = 3;

	private int source_;

	public const int CollectionIDFieldNumber = 4;

	private int collectionID_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<DropPackage> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[99];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public uint Id
	{
		get
		{
			return id_;
		}
		set
		{
			id_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, DropItem> Items => items_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Source
	{
		get
		{
			return source_;
		}
		set
		{
			source_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CollectionID
	{
		get
		{
			return collectionID_;
		}
		set
		{
			collectionID_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DropPackage()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DropPackage(DropPackage other)
		: this()
	{
		id_ = other.id_;
		items_ = other.items_.Clone();
		source_ = other.source_;
		collectionID_ = other.collectionID_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DropPackage Clone()
	{
		return new DropPackage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as DropPackage);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(DropPackage other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Id != other.Id)
		{
			return false;
		}
		if (!Items.Equals(other.Items))
		{
			return false;
		}
		if (Source != other.Source)
		{
			return false;
		}
		if (CollectionID != other.CollectionID)
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
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		num ^= Items.GetHashCode();
		if (Source != 0)
		{
			num ^= Source.GetHashCode();
		}
		if (CollectionID != 0)
		{
			num ^= CollectionID.GetHashCode();
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
		if (Id != 0)
		{
			output.WriteRawTag(8);
			output.WriteUInt32(Id);
		}
		items_.WriteTo(ref output, _map_items_codec);
		if (Source != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Source);
		}
		if (CollectionID != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(CollectionID);
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
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeUInt32Size(Id);
		}
		num += items_.CalculateSize(_map_items_codec);
		if (Source != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Source);
		}
		if (CollectionID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CollectionID);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(DropPackage other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			items_.Add(other.items_);
			if (other.Source != 0)
			{
				Source = other.Source;
			}
			if (other.CollectionID != 0)
			{
				CollectionID = other.CollectionID;
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
				Id = input.ReadUInt32();
				break;
			case 18u:
				items_.AddEntriesFrom(ref input, _map_items_codec);
				break;
			case 24u:
				Source = input.ReadInt32();
				break;
			case 32u:
				CollectionID = input.ReadInt32();
				break;
			}
		}
	}
}
