using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class SkinInfo : IMessage<SkinInfo>, IMessage, IEquatable<SkinInfo>, IDeepCloneable<SkinInfo>, IBufferMessage
{
	private static readonly MessageParser<SkinInfo> _parser = new MessageParser<SkinInfo>(() => new SkinInfo());

	private UnknownFieldSet _unknownFields;

	public const int UidFieldNumber = 1;

	private int uid_;

	public const int SkinIdFieldNumber = 2;

	private int skinId_;

	public const int ObtainTimeFieldNumber = 3;

	private long obtainTime_;

	public const int ExpireTimeFieldNumber = 4;

	private long expireTime_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<SkinInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[21];

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
	public int SkinId
	{
		get
		{
			return skinId_;
		}
		set
		{
			skinId_ = value;
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
	public SkinInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SkinInfo(SkinInfo other)
		: this()
	{
		uid_ = other.uid_;
		skinId_ = other.skinId_;
		obtainTime_ = other.obtainTime_;
		expireTime_ = other.expireTime_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SkinInfo Clone()
	{
		return new SkinInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as SkinInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(SkinInfo other)
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
		if (SkinId != other.SkinId)
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
		if (SkinId != 0)
		{
			num ^= SkinId.GetHashCode();
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
		if (SkinId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(SkinId);
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
		if (SkinId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SkinId);
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
	public void MergeFrom(SkinInfo other)
	{
		if (other != null)
		{
			if (other.Uid != 0)
			{
				Uid = other.Uid;
			}
			if (other.SkinId != 0)
			{
				SkinId = other.SkinId;
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
				SkinId = input.ReadInt32();
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
