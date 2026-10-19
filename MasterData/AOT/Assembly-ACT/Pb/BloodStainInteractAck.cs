using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class BloodStainInteractAck : IMessage<BloodStainInteractAck>, IMessage, IEquatable<BloodStainInteractAck>, IDeepCloneable<BloodStainInteractAck>, IBufferMessage
{
	private static readonly MessageParser<BloodStainInteractAck> _parser = new MessageParser<BloodStainInteractAck>(() => new BloodStainInteractAck());

	private UnknownFieldSet _unknownFields;

	public const int RewardsFieldNumber = 1;

	private static readonly FieldCodec<UniversalItem> _repeated_rewards_codec = FieldCodec.ForMessage(10u, UniversalItem.Parser);

	private readonly RepeatedField<UniversalItem> rewards_ = new RepeatedField<UniversalItem>();

	public const int BloodstainInfoFieldNumber = 2;

	private BloodstainInfo bloodstainInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<BloodStainInteractAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[156];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<UniversalItem> Rewards => rewards_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BloodstainInfo BloodstainInfo
	{
		get
		{
			return bloodstainInfo_;
		}
		set
		{
			bloodstainInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BloodStainInteractAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BloodStainInteractAck(BloodStainInteractAck other)
		: this()
	{
		rewards_ = other.rewards_.Clone();
		bloodstainInfo_ = ((other.bloodstainInfo_ != null) ? other.bloodstainInfo_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BloodStainInteractAck Clone()
	{
		return new BloodStainInteractAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as BloodStainInteractAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(BloodStainInteractAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!rewards_.Equals(other.rewards_))
		{
			return false;
		}
		if (!object.Equals(BloodstainInfo, other.BloodstainInfo))
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
		num ^= rewards_.GetHashCode();
		if (bloodstainInfo_ != null)
		{
			num ^= BloodstainInfo.GetHashCode();
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
		rewards_.WriteTo(ref output, _repeated_rewards_codec);
		if (bloodstainInfo_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(BloodstainInfo);
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
		num += rewards_.CalculateSize(_repeated_rewards_codec);
		if (bloodstainInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(BloodstainInfo);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(BloodStainInteractAck other)
	{
		if (other == null)
		{
			return;
		}
		rewards_.Add(other.rewards_);
		if (other.bloodstainInfo_ != null)
		{
			if (bloodstainInfo_ == null)
			{
				BloodstainInfo = new BloodstainInfo();
			}
			BloodstainInfo.MergeFrom(other.BloodstainInfo);
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
			case 10u:
				rewards_.AddEntriesFrom(ref input, _repeated_rewards_codec);
				break;
			case 18u:
				if (bloodstainInfo_ == null)
				{
					BloodstainInfo = new BloodstainInfo();
				}
				input.ReadMessage(BloodstainInfo);
				break;
			}
		}
	}
}
