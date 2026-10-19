using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class PBVector3 : IMessage<PBVector3>, IMessage, IEquatable<PBVector3>, IDeepCloneable<PBVector3>, IBufferMessage
{
	private static readonly MessageParser<PBVector3> _parser = new MessageParser<PBVector3>(() => new PBVector3());

	private UnknownFieldSet _unknownFields;

	public const int XFieldNumber = 1;

	private float x_;

	public const int YFieldNumber = 2;

	private float y_;

	public const int ZFieldNumber = 3;

	private float z_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<PBVector3> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[38];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public float X
	{
		get
		{
			return x_;
		}
		set
		{
			x_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public float Y
	{
		get
		{
			return y_;
		}
		set
		{
			y_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public float Z
	{
		get
		{
			return z_;
		}
		set
		{
			z_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PBVector3()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PBVector3(PBVector3 other)
		: this()
	{
		x_ = other.x_;
		y_ = other.y_;
		z_ = other.z_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PBVector3 Clone()
	{
		return new PBVector3(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as PBVector3);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(PBVector3 other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(X, other.X))
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(Y, other.Y))
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(Z, other.Z))
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
		if (X != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(X);
		}
		if (Y != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(Y);
		}
		if (Z != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(Z);
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
		if (X != 0f)
		{
			output.WriteRawTag(13);
			output.WriteFloat(X);
		}
		if (Y != 0f)
		{
			output.WriteRawTag(21);
			output.WriteFloat(Y);
		}
		if (Z != 0f)
		{
			output.WriteRawTag(29);
			output.WriteFloat(Z);
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
		if (X != 0f)
		{
			num += 5;
		}
		if (Y != 0f)
		{
			num += 5;
		}
		if (Z != 0f)
		{
			num += 5;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(PBVector3 other)
	{
		if (other != null)
		{
			if (other.X != 0f)
			{
				X = other.X;
			}
			if (other.Y != 0f)
			{
				Y = other.Y;
			}
			if (other.Z != 0f)
			{
				Z = other.Z;
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
			case 13u:
				X = input.ReadFloat();
				break;
			case 21u:
				Y = input.ReadFloat();
				break;
			case 29u:
				Z = input.ReadFloat();
				break;
			}
		}
	}
}
