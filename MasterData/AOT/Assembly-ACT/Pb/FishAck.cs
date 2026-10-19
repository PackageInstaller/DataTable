using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class FishAck : IMessage<FishAck>, IMessage, IEquatable<FishAck>, IDeepCloneable<FishAck>, IBufferMessage
{
	private static readonly MessageParser<FishAck> _parser = new MessageParser<FishAck>(() => new FishAck());

	private UnknownFieldSet _unknownFields;

	public const int FishFieldNumber = 1;

	private int fish_;

	public const int SizeFieldNumber = 2;

	private float size_;

	public const int ChangesFieldNumber = 3;

	private static readonly FieldCodec<Item> _repeated_changes_codec = FieldCodec.ForMessage(26u, Item.Parser);

	private readonly RepeatedField<Item> changes_ = new RepeatedField<Item>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<FishAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => FishReflection.Descriptor.MessageTypes[5];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Fish
	{
		get
		{
			return fish_;
		}
		set
		{
			fish_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public float Size
	{
		get
		{
			return size_;
		}
		set
		{
			size_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<Item> Changes => changes_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public FishAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public FishAck(FishAck other)
		: this()
	{
		fish_ = other.fish_;
		size_ = other.size_;
		changes_ = other.changes_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public FishAck Clone()
	{
		return new FishAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as FishAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(FishAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Fish != other.Fish)
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(Size, other.Size))
		{
			return false;
		}
		if (!changes_.Equals(other.changes_))
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
		if (Fish != 0)
		{
			num ^= Fish.GetHashCode();
		}
		if (Size != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(Size);
		}
		num ^= changes_.GetHashCode();
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
		if (Fish != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Fish);
		}
		if (Size != 0f)
		{
			output.WriteRawTag(21);
			output.WriteFloat(Size);
		}
		changes_.WriteTo(ref output, _repeated_changes_codec);
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
		if (Fish != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Fish);
		}
		if (Size != 0f)
		{
			num += 5;
		}
		num += changes_.CalculateSize(_repeated_changes_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(FishAck other)
	{
		if (other != null)
		{
			if (other.Fish != 0)
			{
				Fish = other.Fish;
			}
			if (other.Size != 0f)
			{
				Size = other.Size;
			}
			changes_.Add(other.changes_);
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
				Fish = input.ReadInt32();
				break;
			case 21u:
				Size = input.ReadFloat();
				break;
			case 26u:
				changes_.AddEntriesFrom(ref input, _repeated_changes_codec);
				break;
			}
		}
	}
}
