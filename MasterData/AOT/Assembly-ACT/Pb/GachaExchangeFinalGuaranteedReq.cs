using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class GachaExchangeFinalGuaranteedReq : IMessage<GachaExchangeFinalGuaranteedReq>, IMessage, IEquatable<GachaExchangeFinalGuaranteedReq>, IDeepCloneable<GachaExchangeFinalGuaranteedReq>, IBufferMessage
{
	private static readonly MessageParser<GachaExchangeFinalGuaranteedReq> _parser = new MessageParser<GachaExchangeFinalGuaranteedReq>(() => new GachaExchangeFinalGuaranteedReq());

	private UnknownFieldSet _unknownFields;

	public const int PoolIdFieldNumber = 1;

	private int poolId_;

	public const int GachaItemIdFieldNumber = 2;

	private int gachaItemId_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<GachaExchangeFinalGuaranteedReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[25];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int PoolId
	{
		get
		{
			return poolId_;
		}
		set
		{
			poolId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int GachaItemId
	{
		get
		{
			return gachaItemId_;
		}
		set
		{
			gachaItemId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaExchangeFinalGuaranteedReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaExchangeFinalGuaranteedReq(GachaExchangeFinalGuaranteedReq other)
		: this()
	{
		poolId_ = other.poolId_;
		gachaItemId_ = other.gachaItemId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaExchangeFinalGuaranteedReq Clone()
	{
		return new GachaExchangeFinalGuaranteedReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as GachaExchangeFinalGuaranteedReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(GachaExchangeFinalGuaranteedReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (PoolId != other.PoolId)
		{
			return false;
		}
		if (GachaItemId != other.GachaItemId)
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
		if (PoolId != 0)
		{
			num ^= PoolId.GetHashCode();
		}
		if (GachaItemId != 0)
		{
			num ^= GachaItemId.GetHashCode();
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
		if (PoolId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(PoolId);
		}
		if (GachaItemId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(GachaItemId);
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
		if (PoolId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PoolId);
		}
		if (GachaItemId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GachaItemId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(GachaExchangeFinalGuaranteedReq other)
	{
		if (other != null)
		{
			if (other.PoolId != 0)
			{
				PoolId = other.PoolId;
			}
			if (other.GachaItemId != 0)
			{
				GachaItemId = other.GachaItemId;
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
				PoolId = input.ReadInt32();
				break;
			case 16u:
				GachaItemId = input.ReadInt32();
				break;
			}
		}
	}
}
