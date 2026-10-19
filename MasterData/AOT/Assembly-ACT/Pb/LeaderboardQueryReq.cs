using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class LeaderboardQueryReq : IMessage<LeaderboardQueryReq>, IMessage, IEquatable<LeaderboardQueryReq>, IDeepCloneable<LeaderboardQueryReq>, IBufferMessage
{
	private static readonly MessageParser<LeaderboardQueryReq> _parser = new MessageParser<LeaderboardQueryReq>(() => new LeaderboardQueryReq());

	private UnknownFieldSet _unknownFields;

	public const int TypFieldNumber = 1;

	private int typ_;

	public const int IdFieldNumber = 2;

	private int id_;

	public const int StartPosFieldNumber = 3;

	private int startPos_;

	public const int NumFieldNumber = 4;

	private int num_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<LeaderboardQueryReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[130];

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
	public int Id
	{
		get
		{
			return id_;
		}
		set
		{
			id_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int StartPos
	{
		get
		{
			return startPos_;
		}
		set
		{
			startPos_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Num
	{
		get
		{
			return num_;
		}
		set
		{
			num_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LeaderboardQueryReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LeaderboardQueryReq(LeaderboardQueryReq other)
		: this()
	{
		typ_ = other.typ_;
		id_ = other.id_;
		startPos_ = other.startPos_;
		num_ = other.num_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LeaderboardQueryReq Clone()
	{
		return new LeaderboardQueryReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as LeaderboardQueryReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(LeaderboardQueryReq other)
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
		if (Id != other.Id)
		{
			return false;
		}
		if (StartPos != other.StartPos)
		{
			return false;
		}
		if (Num != other.Num)
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
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (StartPos != 0)
		{
			num ^= StartPos.GetHashCode();
		}
		if (Num != 0)
		{
			num ^= Num.GetHashCode();
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
		if (Id != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Id);
		}
		if (StartPos != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(StartPos);
		}
		if (Num != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Num);
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
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		if (StartPos != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StartPos);
		}
		if (Num != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Num);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(LeaderboardQueryReq other)
	{
		if (other != null)
		{
			if (other.Typ != 0)
			{
				Typ = other.Typ;
			}
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.StartPos != 0)
			{
				StartPos = other.StartPos;
			}
			if (other.Num != 0)
			{
				Num = other.Num;
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
				Id = input.ReadInt32();
				break;
			case 24u:
				StartPos = input.ReadInt32();
				break;
			case 32u:
				Num = input.ReadInt32();
				break;
			}
		}
	}
}
