using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class MissionApplyItemReq : IMessage<MissionApplyItemReq>, IMessage, IEquatable<MissionApplyItemReq>, IDeepCloneable<MissionApplyItemReq>, IBufferMessage
{
	private static readonly MessageParser<MissionApplyItemReq> _parser = new MessageParser<MissionApplyItemReq>(() => new MissionApplyItemReq());

	private UnknownFieldSet _unknownFields;

	public const int MissionIdFieldNumber = 1;

	private int missionId_;

	public const int CollectionIdFieldNumber = 2;

	private int collectionId_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MissionApplyItemReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => MissionReflection.Descriptor.MessageTypes[9];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int MissionId
	{
		get
		{
			return missionId_;
		}
		set
		{
			missionId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CollectionId
	{
		get
		{
			return collectionId_;
		}
		set
		{
			collectionId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MissionApplyItemReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MissionApplyItemReq(MissionApplyItemReq other)
		: this()
	{
		missionId_ = other.missionId_;
		collectionId_ = other.collectionId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MissionApplyItemReq Clone()
	{
		return new MissionApplyItemReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MissionApplyItemReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MissionApplyItemReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (MissionId != other.MissionId)
		{
			return false;
		}
		if (CollectionId != other.CollectionId)
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
		if (MissionId != 0)
		{
			num ^= MissionId.GetHashCode();
		}
		if (CollectionId != 0)
		{
			num ^= CollectionId.GetHashCode();
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
		if (MissionId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(MissionId);
		}
		if (CollectionId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(CollectionId);
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
		if (MissionId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MissionId);
		}
		if (CollectionId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CollectionId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(MissionApplyItemReq other)
	{
		if (other != null)
		{
			if (other.MissionId != 0)
			{
				MissionId = other.MissionId;
			}
			if (other.CollectionId != 0)
			{
				CollectionId = other.CollectionId;
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
				MissionId = input.ReadInt32();
				break;
			case 16u:
				CollectionId = input.ReadInt32();
				break;
			}
		}
	}
}
