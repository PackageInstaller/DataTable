using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class EffectDressInfo : IMessage<EffectDressInfo>, IMessage, IEquatable<EffectDressInfo>, IDeepCloneable<EffectDressInfo>, IBufferMessage
{
	private static readonly MessageParser<EffectDressInfo> _parser = new MessageParser<EffectDressInfo>(() => new EffectDressInfo());

	private UnknownFieldSet _unknownFields;

	public const int UidFieldNumber = 1;

	private int uid_;

	public const int EffectDressIdFieldNumber = 2;

	private int effectDressId_;

	public const int ObtainTimeFieldNumber = 3;

	private long obtainTime_;

	public const int ExpireTimeFieldNumber = 4;

	private long expireTime_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<EffectDressInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[22];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Uid
	{
		get
		{
			return uid_;
		}
		set
		{
			uid_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int EffectDressId
	{
		get
		{
			return effectDressId_;
		}
		set
		{
			effectDressId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long ObtainTime
	{
		get
		{
			return obtainTime_;
		}
		set
		{
			obtainTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long ExpireTime
	{
		get
		{
			return expireTime_;
		}
		set
		{
			expireTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public EffectDressInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public EffectDressInfo(EffectDressInfo other)
		: this()
	{
		uid_ = other.uid_;
		effectDressId_ = other.effectDressId_;
		obtainTime_ = other.obtainTime_;
		expireTime_ = other.expireTime_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public EffectDressInfo Clone()
	{
		return new EffectDressInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as EffectDressInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(EffectDressInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Uid != other.Uid)
		{
			return false;
		}
		if (EffectDressId != other.EffectDressId)
		{
			return false;
		}
		if (ObtainTime != other.ObtainTime)
		{
			return false;
		}
		if (ExpireTime != other.ExpireTime)
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
		if (Uid != 0)
		{
			num ^= Uid.GetHashCode();
		}
		if (EffectDressId != 0)
		{
			num ^= EffectDressId.GetHashCode();
		}
		if (ObtainTime != 0L)
		{
			num ^= ObtainTime.GetHashCode();
		}
		if (ExpireTime != 0L)
		{
			num ^= ExpireTime.GetHashCode();
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
		if (Uid != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Uid);
		}
		if (EffectDressId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(EffectDressId);
		}
		if (ObtainTime != 0L)
		{
			output.WriteRawTag(24);
			output.WriteInt64(ObtainTime);
		}
		if (ExpireTime != 0L)
		{
			output.WriteRawTag(32);
			output.WriteInt64(ExpireTime);
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
		if (Uid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Uid);
		}
		if (EffectDressId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EffectDressId);
		}
		if (ObtainTime != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(ObtainTime);
		}
		if (ExpireTime != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(ExpireTime);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(EffectDressInfo other)
	{
		if (other != null)
		{
			if (other.Uid != 0)
			{
				Uid = other.Uid;
			}
			if (other.EffectDressId != 0)
			{
				EffectDressId = other.EffectDressId;
			}
			if (other.ObtainTime != 0L)
			{
				ObtainTime = other.ObtainTime;
			}
			if (other.ExpireTime != 0L)
			{
				ExpireTime = other.ExpireTime;
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
				Uid = input.ReadInt32();
				break;
			case 16u:
				EffectDressId = input.ReadInt32();
				break;
			case 24u:
				ObtainTime = input.ReadInt64();
				break;
			case 32u:
				ExpireTime = input.ReadInt64();
				break;
			}
		}
	}
}
