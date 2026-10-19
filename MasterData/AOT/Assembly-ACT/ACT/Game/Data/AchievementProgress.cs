using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class AchievementProgress : IMessage<AchievementProgress>, IMessage, IEquatable<AchievementProgress>, IDeepCloneable<AchievementProgress>, IBufferMessage
{
	private static readonly MessageParser<AchievementProgress> _parser = new MessageParser<AchievementProgress>(() => new AchievementProgress());

	private UnknownFieldSet _unknownFields;

	public const int CompleteTSFieldNumber = 1;

	private int completeTS_;

	public const int HasTakenRewardFieldNumber = 2;

	private bool hasTakenReward_;

	public const int TagFieldNumber = 3;

	private AchievementTag tag_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<AchievementProgress> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[215];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CompleteTS
	{
		get
		{
			return completeTS_;
		}
		set
		{
			completeTS_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool HasTakenReward
	{
		get
		{
			return hasTakenReward_;
		}
		set
		{
			hasTakenReward_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AchievementTag Tag
	{
		get
		{
			return tag_;
		}
		set
		{
			tag_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AchievementProgress()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AchievementProgress(AchievementProgress other)
		: this()
	{
		completeTS_ = other.completeTS_;
		hasTakenReward_ = other.hasTakenReward_;
		tag_ = other.tag_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AchievementProgress Clone()
	{
		return new AchievementProgress(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as AchievementProgress);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(AchievementProgress other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (CompleteTS != other.CompleteTS)
		{
			return false;
		}
		if (HasTakenReward != other.HasTakenReward)
		{
			return false;
		}
		if (Tag != other.Tag)
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
		if (CompleteTS != 0)
		{
			num ^= CompleteTS.GetHashCode();
		}
		if (HasTakenReward)
		{
			num ^= HasTakenReward.GetHashCode();
		}
		if (Tag != AchievementTag.AcNotag)
		{
			num ^= Tag.GetHashCode();
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
		if (CompleteTS != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(CompleteTS);
		}
		if (HasTakenReward)
		{
			output.WriteRawTag(16);
			output.WriteBool(HasTakenReward);
		}
		if (Tag != AchievementTag.AcNotag)
		{
			output.WriteRawTag(24);
			output.WriteEnum((int)Tag);
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
		if (CompleteTS != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CompleteTS);
		}
		if (HasTakenReward)
		{
			num += 2;
		}
		if (Tag != AchievementTag.AcNotag)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)Tag);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(AchievementProgress other)
	{
		if (other != null)
		{
			if (other.CompleteTS != 0)
			{
				CompleteTS = other.CompleteTS;
			}
			if (other.HasTakenReward)
			{
				HasTakenReward = other.HasTakenReward;
			}
			if (other.Tag != AchievementTag.AcNotag)
			{
				Tag = other.Tag;
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
				CompleteTS = input.ReadInt32();
				break;
			case 16u:
				HasTakenReward = input.ReadBool();
				break;
			case 24u:
				Tag = (AchievementTag)input.ReadEnum();
				break;
			}
		}
	}
}
