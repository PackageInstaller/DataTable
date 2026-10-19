using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class PotionUpdateAdditiveReq : IMessage<PotionUpdateAdditiveReq>, IMessage, IEquatable<PotionUpdateAdditiveReq>, IDeepCloneable<PotionUpdateAdditiveReq>, IBufferMessage
{
	private static readonly MessageParser<PotionUpdateAdditiveReq> _parser = new MessageParser<PotionUpdateAdditiveReq>(() => new PotionUpdateAdditiveReq());

	private UnknownFieldSet _unknownFields;

	public const int PotionIdFieldNumber = 1;

	private int potionId_;

	public const int AdditivesFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_additives_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> additives_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<PotionUpdateAdditiveReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => ItemReflection.Descriptor.MessageTypes[15];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int PotionId
	{
		get
		{
			return potionId_;
		}
		set
		{
			potionId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> Additives => additives_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PotionUpdateAdditiveReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PotionUpdateAdditiveReq(PotionUpdateAdditiveReq other)
		: this()
	{
		potionId_ = other.potionId_;
		additives_ = other.additives_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PotionUpdateAdditiveReq Clone()
	{
		return new PotionUpdateAdditiveReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as PotionUpdateAdditiveReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(PotionUpdateAdditiveReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (PotionId != other.PotionId)
		{
			return false;
		}
		if (!additives_.Equals(other.additives_))
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
		if (PotionId != 0)
		{
			num ^= PotionId.GetHashCode();
		}
		num ^= additives_.GetHashCode();
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
		if (PotionId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(PotionId);
		}
		additives_.WriteTo(ref output, _repeated_additives_codec);
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
		if (PotionId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PotionId);
		}
		num += additives_.CalculateSize(_repeated_additives_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(PotionUpdateAdditiveReq other)
	{
		if (other != null)
		{
			if (other.PotionId != 0)
			{
				PotionId = other.PotionId;
			}
			additives_.Add(other.additives_);
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
				PotionId = input.ReadInt32();
				break;
			case 16u:
			case 18u:
				additives_.AddEntriesFrom(ref input, _repeated_additives_codec);
				break;
			}
		}
	}
}
