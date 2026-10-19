using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class CharacterUpdateConstellationAck : IMessage<CharacterUpdateConstellationAck>, IMessage, IEquatable<CharacterUpdateConstellationAck>, IDeepCloneable<CharacterUpdateConstellationAck>, IBufferMessage
{
	private static readonly MessageParser<CharacterUpdateConstellationAck> _parser = new MessageParser<CharacterUpdateConstellationAck>(() => new CharacterUpdateConstellationAck());

	private UnknownFieldSet _unknownFields;

	public const int ConstellationNumFieldNumber = 1;

	private int constellationNum_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<CharacterUpdateConstellationAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CharacterReflection.Descriptor.MessageTypes[18];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ConstellationNum
	{
		get
		{
			return constellationNum_;
		}
		set
		{
			constellationNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterUpdateConstellationAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterUpdateConstellationAck(CharacterUpdateConstellationAck other)
		: this()
	{
		constellationNum_ = other.constellationNum_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterUpdateConstellationAck Clone()
	{
		return new CharacterUpdateConstellationAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as CharacterUpdateConstellationAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(CharacterUpdateConstellationAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ConstellationNum != other.ConstellationNum)
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
		if (ConstellationNum != 0)
		{
			num ^= ConstellationNum.GetHashCode();
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
		if (ConstellationNum != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ConstellationNum);
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
		if (ConstellationNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ConstellationNum);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CharacterUpdateConstellationAck other)
	{
		if (other != null)
		{
			if (other.ConstellationNum != 0)
			{
				ConstellationNum = other.ConstellationNum;
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
			if (num != 8)
			{
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
			}
			else
			{
				ConstellationNum = input.ReadInt32();
			}
		}
	}
}
