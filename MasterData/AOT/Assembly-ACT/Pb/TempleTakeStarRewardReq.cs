using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class TempleTakeStarRewardReq : IMessage<TempleTakeStarRewardReq>, IMessage, IEquatable<TempleTakeStarRewardReq>, IDeepCloneable<TempleTakeStarRewardReq>, IBufferMessage
{
	private static readonly MessageParser<TempleTakeStarRewardReq> _parser = new MessageParser<TempleTakeStarRewardReq>(() => new TempleTakeStarRewardReq());

	private UnknownFieldSet _unknownFields;

	public const int AreaIdFieldNumber = 1;

	private int areaId_;

	public const int StarNumFieldNumber = 2;

	private int starNum_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<TempleTakeStarRewardReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => TempleReflection.Descriptor.MessageTypes[14];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int AreaId
	{
		get
		{
			return areaId_;
		}
		set
		{
			areaId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int StarNum
	{
		get
		{
			return starNum_;
		}
		set
		{
			starNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TempleTakeStarRewardReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TempleTakeStarRewardReq(TempleTakeStarRewardReq other)
		: this()
	{
		areaId_ = other.areaId_;
		starNum_ = other.starNum_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TempleTakeStarRewardReq Clone()
	{
		return new TempleTakeStarRewardReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as TempleTakeStarRewardReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(TempleTakeStarRewardReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (AreaId != other.AreaId)
		{
			return false;
		}
		if (StarNum != other.StarNum)
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
		if (AreaId != 0)
		{
			num ^= AreaId.GetHashCode();
		}
		if (StarNum != 0)
		{
			num ^= StarNum.GetHashCode();
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
		if (AreaId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(AreaId);
		}
		if (StarNum != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(StarNum);
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
		if (AreaId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AreaId);
		}
		if (StarNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StarNum);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(TempleTakeStarRewardReq other)
	{
		if (other != null)
		{
			if (other.AreaId != 0)
			{
				AreaId = other.AreaId;
			}
			if (other.StarNum != 0)
			{
				StarNum = other.StarNum;
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
				AreaId = input.ReadInt32();
				break;
			case 16u:
				StarNum = input.ReadInt32();
				break;
			}
		}
	}
}
