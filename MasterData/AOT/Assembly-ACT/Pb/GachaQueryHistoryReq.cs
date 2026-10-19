using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class GachaQueryHistoryReq : IMessage<GachaQueryHistoryReq>, IMessage, IEquatable<GachaQueryHistoryReq>, IDeepCloneable<GachaQueryHistoryReq>, IBufferMessage
{
	private static readonly MessageParser<GachaQueryHistoryReq> _parser = new MessageParser<GachaQueryHistoryReq>(() => new GachaQueryHistoryReq());

	private UnknownFieldSet _unknownFields;

	public const int PoolTypeFieldNumber = 1;

	private GachaPoolType poolType_;

	public const int PageFieldNumber = 2;

	private int page_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<GachaQueryHistoryReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[13];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaPoolType PoolType
	{
		get
		{
			return poolType_;
		}
		set
		{
			poolType_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Page
	{
		get
		{
			return page_;
		}
		set
		{
			page_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaQueryHistoryReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaQueryHistoryReq(GachaQueryHistoryReq other)
		: this()
	{
		poolType_ = other.poolType_;
		page_ = other.page_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaQueryHistoryReq Clone()
	{
		return new GachaQueryHistoryReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as GachaQueryHistoryReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(GachaQueryHistoryReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (PoolType != other.PoolType)
		{
			return false;
		}
		if (Page != other.Page)
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
		if (PoolType != GachaPoolType.PoolTypeNull)
		{
			num ^= PoolType.GetHashCode();
		}
		if (Page != 0)
		{
			num ^= Page.GetHashCode();
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
		if (PoolType != GachaPoolType.PoolTypeNull)
		{
			output.WriteRawTag(8);
			output.WriteEnum((int)PoolType);
		}
		if (Page != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Page);
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
		if (PoolType != GachaPoolType.PoolTypeNull)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)PoolType);
		}
		if (Page != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Page);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(GachaQueryHistoryReq other)
	{
		if (other != null)
		{
			if (other.PoolType != GachaPoolType.PoolTypeNull)
			{
				PoolType = other.PoolType;
			}
			if (other.Page != 0)
			{
				Page = other.Page;
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
				PoolType = (GachaPoolType)input.ReadEnum();
				break;
			case 16u:
				Page = input.ReadInt32();
				break;
			}
		}
	}
}
