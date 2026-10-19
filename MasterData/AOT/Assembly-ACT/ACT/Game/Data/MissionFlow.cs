using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class MissionFlow : IMessage<MissionFlow>, IMessage, IEquatable<MissionFlow>, IDeepCloneable<MissionFlow>, IBufferMessage
{
	private static readonly MessageParser<MissionFlow> _parser = new MessageParser<MissionFlow>(() => new MissionFlow());

	private UnknownFieldSet _unknownFields;

	public const int CurConditionGroupIdxFieldNumber = 1;

	private int curConditionGroupIdx_;

	public const int ConditionActionPairsFieldNumber = 2;

	private static readonly FieldCodec<TriggerConditionActionPair> _repeated_conditionActionPairs_codec = FieldCodec.ForMessage(18u, TriggerConditionActionPair.Parser);

	private readonly RepeatedField<TriggerConditionActionPair> conditionActionPairs_ = new RepeatedField<TriggerConditionActionPair>();

	public const int FinalActionsFieldNumber = 3;

	private static readonly FieldCodec<TriggerAction> _repeated_finalActions_codec = FieldCodec.ForMessage(26u, TriggerAction.Parser);

	private readonly RepeatedField<TriggerAction> finalActions_ = new RepeatedField<TriggerAction>();

	public const int DoneCountFieldNumber = 4;

	private int doneCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MissionFlow> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[185];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CurConditionGroupIdx
	{
		get
		{
			return curConditionGroupIdx_;
		}
		set
		{
			curConditionGroupIdx_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<TriggerConditionActionPair> ConditionActionPairs => conditionActionPairs_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<TriggerAction> FinalActions => finalActions_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int DoneCount
	{
		get
		{
			return doneCount_;
		}
		set
		{
			doneCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MissionFlow()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MissionFlow(MissionFlow other)
		: this()
	{
		curConditionGroupIdx_ = other.curConditionGroupIdx_;
		conditionActionPairs_ = other.conditionActionPairs_.Clone();
		finalActions_ = other.finalActions_.Clone();
		doneCount_ = other.doneCount_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MissionFlow Clone()
	{
		return new MissionFlow(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MissionFlow);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MissionFlow other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (CurConditionGroupIdx != other.CurConditionGroupIdx)
		{
			return false;
		}
		if (!conditionActionPairs_.Equals(other.conditionActionPairs_))
		{
			return false;
		}
		if (!finalActions_.Equals(other.finalActions_))
		{
			return false;
		}
		if (DoneCount != other.DoneCount)
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
		if (CurConditionGroupIdx != 0)
		{
			num ^= CurConditionGroupIdx.GetHashCode();
		}
		num ^= conditionActionPairs_.GetHashCode();
		num ^= finalActions_.GetHashCode();
		if (DoneCount != 0)
		{
			num ^= DoneCount.GetHashCode();
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
		if (CurConditionGroupIdx != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(CurConditionGroupIdx);
		}
		conditionActionPairs_.WriteTo(ref output, _repeated_conditionActionPairs_codec);
		finalActions_.WriteTo(ref output, _repeated_finalActions_codec);
		if (DoneCount != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(DoneCount);
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
		if (CurConditionGroupIdx != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CurConditionGroupIdx);
		}
		num += conditionActionPairs_.CalculateSize(_repeated_conditionActionPairs_codec);
		num += finalActions_.CalculateSize(_repeated_finalActions_codec);
		if (DoneCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DoneCount);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(MissionFlow other)
	{
		if (other != null)
		{
			if (other.CurConditionGroupIdx != 0)
			{
				CurConditionGroupIdx = other.CurConditionGroupIdx;
			}
			conditionActionPairs_.Add(other.conditionActionPairs_);
			finalActions_.Add(other.finalActions_);
			if (other.DoneCount != 0)
			{
				DoneCount = other.DoneCount;
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
				CurConditionGroupIdx = input.ReadInt32();
				break;
			case 18u:
				conditionActionPairs_.AddEntriesFrom(ref input, _repeated_conditionActionPairs_codec);
				break;
			case 26u:
				finalActions_.AddEntriesFrom(ref input, _repeated_finalActions_codec);
				break;
			case 32u:
				DoneCount = input.ReadInt32();
				break;
			}
		}
	}
}
