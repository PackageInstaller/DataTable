using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class MissionRActionUpdateReq : IMessage<MissionRActionUpdateReq>, IMessage, IEquatable<MissionRActionUpdateReq>, IDeepCloneable<MissionRActionUpdateReq>, IBufferMessage
{
	private static readonly MessageParser<MissionRActionUpdateReq> _parser = new MessageParser<MissionRActionUpdateReq>(() => new MissionRActionUpdateReq());

	private UnknownFieldSet _unknownFields;

	public const int MissionIDFieldNumber = 1;

	private long missionID_;

	public const int FlowIndexFieldNumber = 2;

	private int flowIndex_;

	public const int PairIdxFieldNumber = 3;

	private int pairIdx_;

	public const int ActionFieldNumber = 4;

	private TriggerAction action_;

	public const int FlowTypeFieldNumber = 5;

	private MissionFlowType flowType_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MissionRActionUpdateReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => MissionReflection.Descriptor.MessageTypes[34];

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
	public int FlowIndex
	{
		get
		{
			return flowIndex_;
		}
		set
		{
			flowIndex_ = value;
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
	public TriggerAction Action
	{
		get
		{
			return action_;
		}
		set
		{
			action_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MissionFlowType FlowType
	{
		get
		{
			return flowType_;
		}
		set
		{
			flowType_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MissionRActionUpdateReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MissionRActionUpdateReq(MissionRActionUpdateReq other)
		: this()
	{
		missionID_ = other.missionID_;
		flowIndex_ = other.flowIndex_;
		pairIdx_ = other.pairIdx_;
		action_ = ((other.action_ != null) ? other.action_.Clone() : null);
		flowType_ = other.flowType_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MissionRActionUpdateReq Clone()
	{
		return new MissionRActionUpdateReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MissionRActionUpdateReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MissionRActionUpdateReq other)
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
		if (FlowIndex != other.FlowIndex)
		{
			return false;
		}
		if (PairIdx != other.PairIdx)
		{
			return false;
		}
		if (!object.Equals(Action, other.Action))
		{
			return false;
		}
		if (FlowType != other.FlowType)
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
		if (FlowIndex != 0)
		{
			num ^= FlowIndex.GetHashCode();
		}
		if (PairIdx != 0)
		{
			num ^= PairIdx.GetHashCode();
		}
		if (action_ != null)
		{
			num ^= Action.GetHashCode();
		}
		if (FlowType != MissionFlowType.Normal)
		{
			num ^= FlowType.GetHashCode();
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
		if (FlowIndex != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(FlowIndex);
		}
		if (PairIdx != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(PairIdx);
		}
		if (action_ != null)
		{
			output.WriteRawTag(34);
			output.WriteMessage(Action);
		}
		if (FlowType != MissionFlowType.Normal)
		{
			output.WriteRawTag(40);
			output.WriteEnum((int)FlowType);
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
		if (FlowIndex != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FlowIndex);
		}
		if (PairIdx != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PairIdx);
		}
		if (action_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Action);
		}
		if (FlowType != MissionFlowType.Normal)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)FlowType);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(MissionRActionUpdateReq other)
	{
		if (other == null)
		{
			return;
		}
		if (other.MissionID != 0L)
		{
			MissionID = other.MissionID;
		}
		if (other.FlowIndex != 0)
		{
			FlowIndex = other.FlowIndex;
		}
		if (other.PairIdx != 0)
		{
			PairIdx = other.PairIdx;
		}
		if (other.action_ != null)
		{
			if (action_ == null)
			{
				Action = new TriggerAction();
			}
			Action.MergeFrom(other.Action);
		}
		if (other.FlowType != MissionFlowType.Normal)
		{
			FlowType = other.FlowType;
		}
		_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
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
				FlowIndex = input.ReadInt32();
				break;
			case 24u:
				PairIdx = input.ReadInt32();
				break;
			case 34u:
				if (action_ == null)
				{
					Action = new TriggerAction();
				}
				input.ReadMessage(Action);
				break;
			case 40u:
				FlowType = (MissionFlowType)input.ReadEnum();
				break;
			}
		}
	}
}
