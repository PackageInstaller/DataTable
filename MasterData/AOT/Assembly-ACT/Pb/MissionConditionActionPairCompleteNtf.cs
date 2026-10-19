using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class MissionConditionActionPairCompleteNtf : IMessage<MissionConditionActionPairCompleteNtf>, IMessage, IEquatable<MissionConditionActionPairCompleteNtf>, IDeepCloneable<MissionConditionActionPairCompleteNtf>, IBufferMessage
{
	private static readonly MessageParser<MissionConditionActionPairCompleteNtf> _parser = new MessageParser<MissionConditionActionPairCompleteNtf>(() => new MissionConditionActionPairCompleteNtf());

	private UnknownFieldSet _unknownFields;

	public const int MissionIDFieldNumber = 1;

	private long missionID_;

	public const int PairIdxFieldNumber = 2;

	private int pairIdx_;

	public const int StateFieldNumber = 3;

	private MissionStateEnum state_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MissionConditionActionPairCompleteNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => MissionReflection.Descriptor.MessageTypes[17];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long MissionID
	{
		get
		{
			return missionID_;
		}
		set
		{
			missionID_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int PairIdx
	{
		get
		{
			return pairIdx_;
		}
		set
		{
			pairIdx_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MissionStateEnum State
	{
		get
		{
			return state_;
		}
		set
		{
			state_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MissionConditionActionPairCompleteNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MissionConditionActionPairCompleteNtf(MissionConditionActionPairCompleteNtf other)
		: this()
	{
		missionID_ = other.missionID_;
		pairIdx_ = other.pairIdx_;
		state_ = other.state_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MissionConditionActionPairCompleteNtf Clone()
	{
		return new MissionConditionActionPairCompleteNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MissionConditionActionPairCompleteNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MissionConditionActionPairCompleteNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (MissionID != other.MissionID)
		{
			return false;
		}
		if (PairIdx != other.PairIdx)
		{
			return false;
		}
		if (State != other.State)
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
		if (MissionID != 0L)
		{
			num ^= MissionID.GetHashCode();
		}
		if (PairIdx != 0)
		{
			num ^= PairIdx.GetHashCode();
		}
		if (State != MissionStateEnum.MissionStateWaitAccept)
		{
			num ^= State.GetHashCode();
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
		if (MissionID != 0L)
		{
			output.WriteRawTag(8);
			output.WriteInt64(MissionID);
		}
		if (PairIdx != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(PairIdx);
		}
		if (State != MissionStateEnum.MissionStateWaitAccept)
		{
			output.WriteRawTag(24);
			output.WriteEnum((int)State);
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
		if (MissionID != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(MissionID);
		}
		if (PairIdx != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PairIdx);
		}
		if (State != MissionStateEnum.MissionStateWaitAccept)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)State);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(MissionConditionActionPairCompleteNtf other)
	{
		if (other != null)
		{
			if (other.MissionID != 0L)
			{
				MissionID = other.MissionID;
			}
			if (other.PairIdx != 0)
			{
				PairIdx = other.PairIdx;
			}
			if (other.State != MissionStateEnum.MissionStateWaitAccept)
			{
				State = other.State;
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
				MissionID = input.ReadInt64();
				break;
			case 16u:
				PairIdx = input.ReadInt32();
				break;
			case 24u:
				State = (MissionStateEnum)input.ReadEnum();
				break;
			}
		}
	}
}
