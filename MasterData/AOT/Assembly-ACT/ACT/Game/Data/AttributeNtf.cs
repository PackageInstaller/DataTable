using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class AttributeNtf : IMessage<AttributeNtf>, IMessage, IEquatable<AttributeNtf>, IDeepCloneable<AttributeNtf>, IBufferMessage
{
	private static readonly MessageParser<AttributeNtf> _parser = new MessageParser<AttributeNtf>(() => new AttributeNtf());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ChangesFieldNumber = 2;

	private static readonly MapField<int, long>.Codec _map_changes_codec = new MapField<int, long>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt64(16u, 0L), 18u);

	private readonly MapField<int, long> changes_ = new MapField<int, long>();

	public const int ChangeWayFieldNumber = 3;

	private ItemsWays changeWay_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<AttributeNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[4];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Id
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
	public MapField<int, long> Changes => changes_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ItemsWays ChangeWay
	{
		get
		{
			return changeWay_;
		}
		set
		{
			changeWay_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AttributeNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AttributeNtf(AttributeNtf other)
		: this()
	{
		id_ = other.id_;
		changes_ = other.changes_.Clone();
		changeWay_ = other.changeWay_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AttributeNtf Clone()
	{
		return new AttributeNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as AttributeNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(AttributeNtf other)
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
		if (!Changes.Equals(other.Changes))
		{
			return false;
		}
		if (ChangeWay != other.ChangeWay)
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
		num ^= Changes.GetHashCode();
		if (ChangeWay != ItemsWays.ItemswayEntergame)
		{
			num ^= ChangeWay.GetHashCode();
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
			output.WriteInt32(Id);
		}
		changes_.WriteTo(ref output, _map_changes_codec);
		if (ChangeWay != ItemsWays.ItemswayEntergame)
		{
			output.WriteRawTag(24);
			output.WriteEnum((int)ChangeWay);
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
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		num += changes_.CalculateSize(_map_changes_codec);
		if (ChangeWay != ItemsWays.ItemswayEntergame)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)ChangeWay);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(AttributeNtf other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			changes_.Add(other.changes_);
			if (other.ChangeWay != ItemsWays.ItemswayEntergame)
			{
				ChangeWay = other.ChangeWay;
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
				Id = input.ReadInt32();
				break;
			case 18u:
				changes_.AddEntriesFrom(ref input, _map_changes_codec);
				break;
			case 24u:
				ChangeWay = (ItemsWays)input.ReadEnum();
				break;
			}
		}
	}
}
