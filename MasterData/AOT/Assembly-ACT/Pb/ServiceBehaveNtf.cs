using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class ServiceBehaveNtf : IMessage<ServiceBehaveNtf>, IMessage, IEquatable<ServiceBehaveNtf>, IDeepCloneable<ServiceBehaveNtf>, IBufferMessage
{
	private static readonly MessageParser<ServiceBehaveNtf> _parser = new MessageParser<ServiceBehaveNtf>(() => new ServiceBehaveNtf());

	private UnknownFieldSet _unknownFields;

	public const int WidFieldNumber = 1;

	private int wid_;

	public const int ChangesFieldNumber = 2;

	private static readonly FieldCodec<ServiceBehave> _repeated_changes_codec = FieldCodec.ForMessage(18u, ServiceBehave.Parser);

	private readonly RepeatedField<ServiceBehave> changes_ = new RepeatedField<ServiceBehave>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ServiceBehaveNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => InteracteventReflection.Descriptor.MessageTypes[4];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Wid
	{
		get
		{
			return wid_;
		}
		set
		{
			wid_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<ServiceBehave> Changes => changes_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ServiceBehaveNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ServiceBehaveNtf(ServiceBehaveNtf other)
		: this()
	{
		wid_ = other.wid_;
		changes_ = other.changes_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ServiceBehaveNtf Clone()
	{
		return new ServiceBehaveNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ServiceBehaveNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ServiceBehaveNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Wid != other.Wid)
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
		if (Wid != 0)
		{
			num ^= Wid.GetHashCode();
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
		if (Wid != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Wid);
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
		if (Wid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Wid);
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
	public void MergeFrom(ServiceBehaveNtf other)
	{
		if (other != null)
		{
			if (other.Wid != 0)
			{
				Wid = other.Wid;
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
				Wid = input.ReadInt32();
				break;
			case 18u:
				changes_.AddEntriesFrom(ref input, _repeated_changes_codec);
				break;
			}
		}
	}
}
