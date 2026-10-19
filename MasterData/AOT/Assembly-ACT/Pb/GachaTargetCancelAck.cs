using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class GachaTargetCancelAck : IMessage<GachaTargetCancelAck>, IMessage, IEquatable<GachaTargetCancelAck>, IDeepCloneable<GachaTargetCancelAck>, IBufferMessage
{
	private static readonly MessageParser<GachaTargetCancelAck> _parser = new MessageParser<GachaTargetCancelAck>(() => new GachaTargetCancelAck());

	private UnknownFieldSet _unknownFields;

	public const int PoolUniqueFieldNumber = 1;

	private GachaPoolUniqueData poolUnique_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<GachaTargetCancelAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[24];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaPoolUniqueData PoolUnique
	{
		get
		{
			return poolUnique_;
		}
		set
		{
			poolUnique_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaTargetCancelAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaTargetCancelAck(GachaTargetCancelAck other)
		: this()
	{
		poolUnique_ = ((other.poolUnique_ != null) ? other.poolUnique_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaTargetCancelAck Clone()
	{
		return new GachaTargetCancelAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as GachaTargetCancelAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(GachaTargetCancelAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(PoolUnique, other.PoolUnique))
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
		if (poolUnique_ != null)
		{
			num ^= PoolUnique.GetHashCode();
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
		if (poolUnique_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(PoolUnique);
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
		if (poolUnique_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(PoolUnique);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(GachaTargetCancelAck other)
	{
		if (other == null)
		{
			return;
		}
		if (other.poolUnique_ != null)
		{
			if (poolUnique_ == null)
			{
				PoolUnique = new GachaPoolUniqueData();
			}
			PoolUnique.MergeFrom(other.PoolUnique);
		}
		_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
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
			if (num != 10)
			{
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				continue;
			}
			if (poolUnique_ == null)
			{
				PoolUnique = new GachaPoolUniqueData();
			}
			input.ReadMessage(PoolUnique);
		}
	}
}
