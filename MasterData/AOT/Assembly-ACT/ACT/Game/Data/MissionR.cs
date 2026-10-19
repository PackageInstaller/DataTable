using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class MissionR : IMessage<MissionR>, IMessage, IEquatable<MissionR>, IDeepCloneable<MissionR>, IBufferMessage
{
	private static readonly MessageParser<MissionR> _parser = new MessageParser<MissionR>(() => new MissionR());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private long id_;

	public const int FlowsFieldNumber = 2;

	private static readonly FieldCodec<MissionFlow> _repeated_flows_codec = FieldCodec.ForMessage(18u, MissionFlow.Parser);

	private readonly RepeatedField<MissionFlow> flows_ = new RepeatedField<MissionFlow>();

	public const int StateFieldNumber = 3;

	private MissionStateEnum state_;

	public const int CompletedNumFieldNumber = 4;

	private int completedNum_;

	public const int ExtraFlowsFieldNumber = 5;

	private static readonly FieldCodec<MissionFlow> _repeated_extraFlows_codec = FieldCodec.ForMessage(42u, MissionFlow.Parser);

	private readonly RepeatedField<MissionFlow> extraFlows_ = new RepeatedField<MissionFlow>();

	public const int FailFlowFieldNumber = 6;

	private MissionFlow failFlow_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MissionR> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[186];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long Id
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
	public RepeatedField<MissionFlow> Flows => flows_;

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
	public int CompletedNum
	{
		get
		{
			return completedNum_;
		}
		set
		{
			completedNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<MissionFlow> ExtraFlows => extraFlows_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MissionFlow FailFlow
	{
		get
		{
			return failFlow_;
		}
		set
		{
			failFlow_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MissionR()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MissionR(MissionR other)
		: this()
	{
		id_ = other.id_;
		flows_ = other.flows_.Clone();
		state_ = other.state_;
		completedNum_ = other.completedNum_;
		extraFlows_ = other.extraFlows_.Clone();
		failFlow_ = ((other.failFlow_ != null) ? other.failFlow_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MissionR Clone()
	{
		return new MissionR(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MissionR);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MissionR other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Id != other.Id)
		{
			return false;
		}
		if (!flows_.Equals(other.flows_))
		{
			return false;
		}
		if (State != other.State)
		{
			return false;
		}
		if (CompletedNum != other.CompletedNum)
		{
			return false;
		}
		if (!extraFlows_.Equals(other.extraFlows_))
		{
			return false;
		}
		if (!object.Equals(FailFlow, other.FailFlow))
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
		if (Id != 0L)
		{
			num ^= Id.GetHashCode();
		}
		num ^= flows_.GetHashCode();
		if (State != MissionStateEnum.MissionStateWaitAccept)
		{
			num ^= State.GetHashCode();
		}
		if (CompletedNum != 0)
		{
			num ^= CompletedNum.GetHashCode();
		}
		num ^= extraFlows_.GetHashCode();
		if (failFlow_ != null)
		{
			num ^= FailFlow.GetHashCode();
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
		if (Id != 0L)
		{
			output.WriteRawTag(8);
			output.WriteInt64(Id);
		}
		flows_.WriteTo(ref output, _repeated_flows_codec);
		if (State != MissionStateEnum.MissionStateWaitAccept)
		{
			output.WriteRawTag(24);
			output.WriteEnum((int)State);
		}
		if (CompletedNum != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(CompletedNum);
		}
		extraFlows_.WriteTo(ref output, _repeated_extraFlows_codec);
		if (failFlow_ != null)
		{
			output.WriteRawTag(50);
			output.WriteMessage(FailFlow);
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
		if (Id != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(Id);
		}
		num += flows_.CalculateSize(_repeated_flows_codec);
		if (State != MissionStateEnum.MissionStateWaitAccept)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)State);
		}
		if (CompletedNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CompletedNum);
		}
		num += extraFlows_.CalculateSize(_repeated_extraFlows_codec);
		if (failFlow_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(FailFlow);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(MissionR other)
	{
		if (other == null)
		{
			return;
		}
		if (other.Id != 0L)
		{
			Id = other.Id;
		}
		flows_.Add(other.flows_);
		if (other.State != MissionStateEnum.MissionStateWaitAccept)
		{
			State = other.State;
		}
		if (other.CompletedNum != 0)
		{
			CompletedNum = other.CompletedNum;
		}
		extraFlows_.Add(other.extraFlows_);
		if (other.failFlow_ != null)
		{
			if (failFlow_ == null)
			{
				FailFlow = new MissionFlow();
			}
			FailFlow.MergeFrom(other.FailFlow);
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
				Id = input.ReadInt64();
				break;
			case 18u:
				flows_.AddEntriesFrom(ref input, _repeated_flows_codec);
				break;
			case 24u:
				State = (MissionStateEnum)input.ReadEnum();
				break;
			case 32u:
				CompletedNum = input.ReadInt32();
				break;
			case 42u:
				extraFlows_.AddEntriesFrom(ref input, _repeated_extraFlows_codec);
				break;
			case 50u:
				if (failFlow_ == null)
				{
					FailFlow = new MissionFlow();
				}
				input.ReadMessage(FailFlow);
				break;
			}
		}
	}
}
