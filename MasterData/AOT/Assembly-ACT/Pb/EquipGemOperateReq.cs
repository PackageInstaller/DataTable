using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class EquipGemOperateReq : IMessage<EquipGemOperateReq>, IMessage, IEquatable<EquipGemOperateReq>, IDeepCloneable<EquipGemOperateReq>, IBufferMessage
{
	private static readonly MessageParser<EquipGemOperateReq> _parser = new MessageParser<EquipGemOperateReq>(() => new EquipGemOperateReq());

	private UnknownFieldSet _unknownFields;

	public const int EquipUidFieldNumber = 1;

	private int equipUid_;

	public const int GemSlotIdFieldNumber = 2;

	private int gemSlotId_;

	public const int OperateFieldNumber = 3;

	private bool operate_;

	public const int GemUidFieldNumber = 4;

	private int gemUid_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<EquipGemOperateReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => EquipReflection.Descriptor.MessageTypes[10];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int EquipUid
	{
		get
		{
			return equipUid_;
		}
		set
		{
			equipUid_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int GemSlotId
	{
		get
		{
			return gemSlotId_;
		}
		set
		{
			gemSlotId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Operate
	{
		get
		{
			return operate_;
		}
		set
		{
			operate_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int GemUid
	{
		get
		{
			return gemUid_;
		}
		set
		{
			gemUid_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public EquipGemOperateReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public EquipGemOperateReq(EquipGemOperateReq other)
		: this()
	{
		equipUid_ = other.equipUid_;
		gemSlotId_ = other.gemSlotId_;
		operate_ = other.operate_;
		gemUid_ = other.gemUid_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public EquipGemOperateReq Clone()
	{
		return new EquipGemOperateReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as EquipGemOperateReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(EquipGemOperateReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (EquipUid != other.EquipUid)
		{
			return false;
		}
		if (GemSlotId != other.GemSlotId)
		{
			return false;
		}
		if (Operate != other.Operate)
		{
			return false;
		}
		if (GemUid != other.GemUid)
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
		if (EquipUid != 0)
		{
			num ^= EquipUid.GetHashCode();
		}
		if (GemSlotId != 0)
		{
			num ^= GemSlotId.GetHashCode();
		}
		if (Operate)
		{
			num ^= Operate.GetHashCode();
		}
		if (GemUid != 0)
		{
			num ^= GemUid.GetHashCode();
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
		if (EquipUid != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(EquipUid);
		}
		if (GemSlotId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(GemSlotId);
		}
		if (Operate)
		{
			output.WriteRawTag(24);
			output.WriteBool(Operate);
		}
		if (GemUid != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(GemUid);
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
		if (EquipUid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EquipUid);
		}
		if (GemSlotId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GemSlotId);
		}
		if (Operate)
		{
			num += 2;
		}
		if (GemUid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GemUid);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(EquipGemOperateReq other)
	{
		if (other != null)
		{
			if (other.EquipUid != 0)
			{
				EquipUid = other.EquipUid;
			}
			if (other.GemSlotId != 0)
			{
				GemSlotId = other.GemSlotId;
			}
			if (other.Operate)
			{
				Operate = other.Operate;
			}
			if (other.GemUid != 0)
			{
				GemUid = other.GemUid;
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
				EquipUid = input.ReadInt32();
				break;
			case 16u:
				GemSlotId = input.ReadInt32();
				break;
			case 24u:
				Operate = input.ReadBool();
				break;
			case 32u:
				GemUid = input.ReadInt32();
				break;
			}
		}
	}
}
