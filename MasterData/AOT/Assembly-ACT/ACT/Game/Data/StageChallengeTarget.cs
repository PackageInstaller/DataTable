using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class StageChallengeTarget : IMessage<StageChallengeTarget>, IMessage, IEquatable<StageChallengeTarget>, IDeepCloneable<StageChallengeTarget>, IBufferMessage
{
	private static readonly MessageParser<StageChallengeTarget> _parser = new MessageParser<StageChallengeTarget>(() => new StageChallengeTarget());

	private UnknownFieldSet _unknownFields;

	public const int TargetRewardFieldNumber = 1;

	private static readonly MapField<int, bool>.Codec _map_targetReward_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 10u);

	private readonly MapField<int, bool> targetReward_ = new MapField<int, bool>();

	public const int IsPerfectFieldNumber = 2;

	private bool isPerfect_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<StageChallengeTarget> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[205];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> TargetReward => targetReward_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool IsPerfect
	{
		get
		{
			return isPerfect_;
		}
		set
		{
			isPerfect_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public StageChallengeTarget()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public StageChallengeTarget(StageChallengeTarget other)
		: this()
	{
		targetReward_ = other.targetReward_.Clone();
		isPerfect_ = other.isPerfect_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public StageChallengeTarget Clone()
	{
		return new StageChallengeTarget(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as StageChallengeTarget);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(StageChallengeTarget other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!TargetReward.Equals(other.TargetReward))
		{
			return false;
		}
		if (IsPerfect != other.IsPerfect)
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
		num ^= TargetReward.GetHashCode();
		if (IsPerfect)
		{
			num ^= IsPerfect.GetHashCode();
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
		targetReward_.WriteTo(ref output, _map_targetReward_codec);
		if (IsPerfect)
		{
			output.WriteRawTag(16);
			output.WriteBool(IsPerfect);
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
		num += targetReward_.CalculateSize(_map_targetReward_codec);
		if (IsPerfect)
		{
			num += 2;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(StageChallengeTarget other)
	{
		if (other != null)
		{
			targetReward_.Add(other.targetReward_);
			if (other.IsPerfect)
			{
				IsPerfect = other.IsPerfect;
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
			case 10u:
				targetReward_.AddEntriesFrom(ref input, _map_targetReward_codec);
				break;
			case 16u:
				IsPerfect = input.ReadBool();
				break;
			}
		}
	}
}
