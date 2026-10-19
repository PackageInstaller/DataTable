using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class AchievementRecordFightTypeCntReq : IMessage<AchievementRecordFightTypeCntReq>, IMessage, IEquatable<AchievementRecordFightTypeCntReq>, IDeepCloneable<AchievementRecordFightTypeCntReq>, IBufferMessage
{
	private static readonly MessageParser<AchievementRecordFightTypeCntReq> _parser = new MessageParser<AchievementRecordFightTypeCntReq>(() => new AchievementRecordFightTypeCntReq());

	private UnknownFieldSet _unknownFields;

	public const int TypFieldNumber = 1;

	private int typ_;

	public const int CntFieldNumber = 2;

	private int cnt_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<AchievementRecordFightTypeCntReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[43];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Typ
	{
		get
		{
			return typ_;
		}
		set
		{
			typ_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Cnt
	{
		get
		{
			return cnt_;
		}
		set
		{
			cnt_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AchievementRecordFightTypeCntReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AchievementRecordFightTypeCntReq(AchievementRecordFightTypeCntReq other)
		: this()
	{
		typ_ = other.typ_;
		cnt_ = other.cnt_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AchievementRecordFightTypeCntReq Clone()
	{
		return new AchievementRecordFightTypeCntReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as AchievementRecordFightTypeCntReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(AchievementRecordFightTypeCntReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Typ != other.Typ)
		{
			return false;
		}
		if (Cnt != other.Cnt)
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
		if (Typ != 0)
		{
			num ^= Typ.GetHashCode();
		}
		if (Cnt != 0)
		{
			num ^= Cnt.GetHashCode();
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
		if (Typ != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Typ);
		}
		if (Cnt != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Cnt);
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
		if (Typ != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Typ);
		}
		if (Cnt != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Cnt);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(AchievementRecordFightTypeCntReq other)
	{
		if (other != null)
		{
			if (other.Typ != 0)
			{
				Typ = other.Typ;
			}
			if (other.Cnt != 0)
			{
				Cnt = other.Cnt;
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
				Typ = input.ReadInt32();
				break;
			case 16u:
				Cnt = input.ReadInt32();
				break;
			}
		}
	}
}
