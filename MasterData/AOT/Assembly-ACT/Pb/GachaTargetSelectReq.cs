using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class GachaTargetSelectReq : IMessage<GachaTargetSelectReq>, IMessage, IEquatable<GachaTargetSelectReq>, IDeepCloneable<GachaTargetSelectReq>, IBufferMessage
{
	private static readonly MessageParser<GachaTargetSelectReq> _parser = new MessageParser<GachaTargetSelectReq>(() => new GachaTargetSelectReq());

	private UnknownFieldSet _unknownFields;

	public const int GachaIdFieldNumber = 1;

	private int gachaId_;

	public const int TargetGachaItemIdFieldNumber = 2;

	private int targetGachaItemId_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<GachaTargetSelectReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[21];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int GachaId
	{
		get
		{
			return gachaId_;
		}
		set
		{
			gachaId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int TargetGachaItemId
	{
		get
		{
			return targetGachaItemId_;
		}
		set
		{
			targetGachaItemId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaTargetSelectReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaTargetSelectReq(GachaTargetSelectReq other)
		: this()
	{
		gachaId_ = other.gachaId_;
		targetGachaItemId_ = other.targetGachaItemId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaTargetSelectReq Clone()
	{
		return new GachaTargetSelectReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as GachaTargetSelectReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(GachaTargetSelectReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (GachaId != other.GachaId)
		{
			return false;
		}
		if (TargetGachaItemId != other.TargetGachaItemId)
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
		if (GachaId != 0)
		{
			num ^= GachaId.GetHashCode();
		}
		if (TargetGachaItemId != 0)
		{
			num ^= TargetGachaItemId.GetHashCode();
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
		if (GachaId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(GachaId);
		}
		if (TargetGachaItemId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(TargetGachaItemId);
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
		if (GachaId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GachaId);
		}
		if (TargetGachaItemId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TargetGachaItemId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(GachaTargetSelectReq other)
	{
		if (other != null)
		{
			if (other.GachaId != 0)
			{
				GachaId = other.GachaId;
			}
			if (other.TargetGachaItemId != 0)
			{
				TargetGachaItemId = other.TargetGachaItemId;
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
				GachaId = input.ReadInt32();
				break;
			case 16u:
				TargetGachaItemId = input.ReadInt32();
				break;
			}
		}
	}
}
