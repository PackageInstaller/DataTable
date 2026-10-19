using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class MissionRConditionUpdateReq : IMessage<MissionRConditionUpdateReq>, IMessage, IEquatable<MissionRConditionUpdateReq>, IDeepCloneable<MissionRConditionUpdateReq>, IBufferMessage
{
	private static readonly MessageParser<MissionRConditionUpdateReq> _parser = new MessageParser<MissionRConditionUpdateReq>(() => new MissionRConditionUpdateReq());

	private UnknownFieldSet _unknownFields;

	public const int MissionIDFieldNumber = 1;

	private long missionID_;

	public const int FlowIndexFieldNumber = 2;

	private int flowIndex_;

	public const int ConditionFieldNumber = 3;

	private TriggerCondition condition_;

	public const int FlowTypeFieldNumber = 4;

	private MissionFlowType flowType_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MissionRConditionUpdateReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => MissionReflection.Descriptor.MessageTypes[32];

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
	public TriggerCondition Condition
	{
		get
		{
			return condition_;
		}
		set
		{
			condition_ = value;
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
	public MissionRConditionUpdateReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MissionRConditionUpdateReq(MissionRConditionUpdateReq other)
		: this()
	{
		missionID_ = other.missionID_;
		flowIndex_ = other.flowIndex_;
		condition_ = ((other.condition_ != null) ? other.condition_.Clone() : null);
		flowType_ = other.flowType_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MissionRConditionUpdateReq Clone()
	{
		return new MissionRConditionUpdateReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MissionRConditionUpdateReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MissionRConditionUpdateReq other)
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
		if (!object.Equals(Condition, other.Condition))
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
		if (condition_ != null)
		{
			num ^= Condition.GetHashCode();
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
		if (condition_ != null)
		{
			output.WriteRawTag(26);
			output.WriteMessage(Condition);
		}
		if (FlowType != MissionFlowType.Normal)
		{
			output.WriteRawTag(32);
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
		if (condition_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Condition);
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
	public void MergeFrom(MissionRConditionUpdateReq other)
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
		if (other.condition_ != null)
		{
			if (condition_ == null)
			{
				Condition = new TriggerCondition();
			}
			Condition.MergeFrom(other.Condition);
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
			case 26u:
				if (condition_ == null)
				{
					Condition = new TriggerCondition();
				}
				input.ReadMessage(Condition);
				break;
			case 32u:
				FlowType = (MissionFlowType)input.ReadEnum();
				break;
			}
		}
	}
}
