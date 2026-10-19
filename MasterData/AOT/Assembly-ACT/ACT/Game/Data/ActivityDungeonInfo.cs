using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class ActivityDungeonInfo : IMessage<ActivityDungeonInfo>, IMessage, IEquatable<ActivityDungeonInfo>, IDeepCloneable<ActivityDungeonInfo>, IBufferMessage
{
	private static readonly MessageParser<ActivityDungeonInfo> _parser = new MessageParser<ActivityDungeonInfo>(() => new ActivityDungeonInfo());

	private UnknownFieldSet _unknownFields;

	public const int ChallengeGroupFieldNumber = 1;

	private int challengeGroup_;

	public const int FinishCountFieldNumber = 2;

	private int finishCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ActivityDungeonInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[255];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ChallengeGroup
	{
		get
		{
			return challengeGroup_;
		}
		set
		{
			challengeGroup_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int FinishCount
	{
		get
		{
			return finishCount_;
		}
		set
		{
			finishCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityDungeonInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityDungeonInfo(ActivityDungeonInfo other)
		: this()
	{
		challengeGroup_ = other.challengeGroup_;
		finishCount_ = other.finishCount_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityDungeonInfo Clone()
	{
		return new ActivityDungeonInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityDungeonInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ActivityDungeonInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ChallengeGroup != other.ChallengeGroup)
		{
			return false;
		}
		if (FinishCount != other.FinishCount)
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
		if (ChallengeGroup != 0)
		{
			num ^= ChallengeGroup.GetHashCode();
		}
		if (FinishCount != 0)
		{
			num ^= FinishCount.GetHashCode();
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
		if (ChallengeGroup != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ChallengeGroup);
		}
		if (FinishCount != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(FinishCount);
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
		if (ChallengeGroup != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ChallengeGroup);
		}
		if (FinishCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FinishCount);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ActivityDungeonInfo other)
	{
		if (other != null)
		{
			if (other.ChallengeGroup != 0)
			{
				ChallengeGroup = other.ChallengeGroup;
			}
			if (other.FinishCount != 0)
			{
				FinishCount = other.FinishCount;
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
				ChallengeGroup = input.ReadInt32();
				break;
			case 16u:
				FinishCount = input.ReadInt32();
				break;
			}
		}
	}
}
