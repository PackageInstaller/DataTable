using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class SignInChallenge : IMessage<SignInChallenge>, IMessage, IEquatable<SignInChallenge>, IDeepCloneable<SignInChallenge>, IBufferMessage
{
	private static readonly MessageParser<SignInChallenge> _parser = new MessageParser<SignInChallenge>(() => new SignInChallenge());

	private UnknownFieldSet _unknownFields;

	public const int ChallengeIdFieldNumber = 1;

	private int challengeId_;

	public const int IsGainedFieldNumber = 2;

	private bool isGained_;

	public const int RewardsFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_rewards_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> rewards_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<SignInChallenge> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[258];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ChallengeId
	{
		get
		{
			return challengeId_;
		}
		set
		{
			challengeId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool IsGained
	{
		get
		{
			return isGained_;
		}
		set
		{
			isGained_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> Rewards => rewards_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SignInChallenge()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SignInChallenge(SignInChallenge other)
		: this()
	{
		challengeId_ = other.challengeId_;
		isGained_ = other.isGained_;
		rewards_ = other.rewards_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SignInChallenge Clone()
	{
		return new SignInChallenge(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as SignInChallenge);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(SignInChallenge other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ChallengeId != other.ChallengeId)
		{
			return false;
		}
		if (IsGained != other.IsGained)
		{
			return false;
		}
		if (!rewards_.Equals(other.rewards_))
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
		if (ChallengeId != 0)
		{
			num ^= ChallengeId.GetHashCode();
		}
		if (IsGained)
		{
			num ^= IsGained.GetHashCode();
		}
		num ^= rewards_.GetHashCode();
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
		if (ChallengeId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ChallengeId);
		}
		if (IsGained)
		{
			output.WriteRawTag(16);
			output.WriteBool(IsGained);
		}
		rewards_.WriteTo(ref output, _repeated_rewards_codec);
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
		if (ChallengeId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ChallengeId);
		}
		if (IsGained)
		{
			num += 2;
		}
		num += rewards_.CalculateSize(_repeated_rewards_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(SignInChallenge other)
	{
		if (other != null)
		{
			if (other.ChallengeId != 0)
			{
				ChallengeId = other.ChallengeId;
			}
			if (other.IsGained)
			{
				IsGained = other.IsGained;
			}
			rewards_.Add(other.rewards_);
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
				ChallengeId = input.ReadInt32();
				break;
			case 16u:
				IsGained = input.ReadBool();
				break;
			case 24u:
			case 26u:
				rewards_.AddEntriesFrom(ref input, _repeated_rewards_codec);
				break;
			}
		}
	}
}
