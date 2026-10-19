using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class TriggerConditionActionPair : IMessage<TriggerConditionActionPair>, IMessage, IEquatable<TriggerConditionActionPair>, IDeepCloneable<TriggerConditionActionPair>, IBufferMessage
{
	private static readonly MessageParser<TriggerConditionActionPair> _parser = new MessageParser<TriggerConditionActionPair>(() => new TriggerConditionActionPair());

	private UnknownFieldSet _unknownFields;

	public const int ConditionFieldNumber = 1;

	private TriggerCondition condition_;

	public const int ActionsFieldNumber = 2;

	private static readonly FieldCodec<TriggerAction> _repeated_actions_codec = FieldCodec.ForMessage(18u, TriggerAction.Parser);

	private readonly RepeatedField<TriggerAction> actions_ = new RepeatedField<TriggerAction>();

	public const int ConditionsFieldNumber = 3;

	private static readonly FieldCodec<TriggerCondition> _repeated_conditions_codec = FieldCodec.ForMessage(26u, TriggerCondition.Parser);

	private readonly RepeatedField<TriggerCondition> conditions_ = new RepeatedField<TriggerCondition>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<TriggerConditionActionPair> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[184];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

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
	public RepeatedField<TriggerAction> Actions => actions_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<TriggerCondition> Conditions => conditions_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TriggerConditionActionPair()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TriggerConditionActionPair(TriggerConditionActionPair other)
		: this()
	{
		condition_ = ((other.condition_ != null) ? other.condition_.Clone() : null);
		actions_ = other.actions_.Clone();
		conditions_ = other.conditions_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TriggerConditionActionPair Clone()
	{
		return new TriggerConditionActionPair(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as TriggerConditionActionPair);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(TriggerConditionActionPair other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(Condition, other.Condition))
		{
			return false;
		}
		if (!actions_.Equals(other.actions_))
		{
			return false;
		}
		if (!conditions_.Equals(other.conditions_))
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
		if (condition_ != null)
		{
			num ^= Condition.GetHashCode();
		}
		num ^= actions_.GetHashCode();
		num ^= conditions_.GetHashCode();
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
		if (condition_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(Condition);
		}
		actions_.WriteTo(ref output, _repeated_actions_codec);
		conditions_.WriteTo(ref output, _repeated_conditions_codec);
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
		if (condition_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Condition);
		}
		num += actions_.CalculateSize(_repeated_actions_codec);
		num += conditions_.CalculateSize(_repeated_conditions_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(TriggerConditionActionPair other)
	{
		if (other == null)
		{
			return;
		}
		if (other.condition_ != null)
		{
			if (condition_ == null)
			{
				Condition = new TriggerCondition();
			}
			Condition.MergeFrom(other.Condition);
		}
		actions_.Add(other.actions_);
		conditions_.Add(other.conditions_);
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
			case 10u:
				if (condition_ == null)
				{
					Condition = new TriggerCondition();
				}
				input.ReadMessage(Condition);
				break;
			case 18u:
				actions_.AddEntriesFrom(ref input, _repeated_actions_codec);
				break;
			case 26u:
				conditions_.AddEntriesFrom(ref input, _repeated_conditions_codec);
				break;
			}
		}
	}
}
