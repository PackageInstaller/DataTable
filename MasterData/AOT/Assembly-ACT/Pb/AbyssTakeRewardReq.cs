using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class AbyssTakeRewardReq : IMessage<AbyssTakeRewardReq>, IMessage, IEquatable<AbyssTakeRewardReq>, IDeepCloneable<AbyssTakeRewardReq>, IBufferMessage
{
	private static readonly MessageParser<AbyssTakeRewardReq> _parser = new MessageParser<AbyssTakeRewardReq>(() => new AbyssTakeRewardReq());

	private UnknownFieldSet _unknownFields;

	public const int TargetStarFieldNumber = 1;

	private int targetStar_;

	public const int AbyssIdFieldNumber = 2;

	private int abyssId_;

	public const int StageIdxFieldNumber = 3;

	private int stageIdx_;

	public const int ClaimAllFieldNumber = 4;

	private bool claimAll_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<AbyssTakeRewardReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => AbyssReflection.Descriptor.MessageTypes[4];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int TargetStar
	{
		get
		{
			return targetStar_;
		}
		set
		{
			targetStar_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int AbyssId
	{
		get
		{
			return abyssId_;
		}
		set
		{
			abyssId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int StageIdx
	{
		get
		{
			return stageIdx_;
		}
		set
		{
			stageIdx_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool ClaimAll
	{
		get
		{
			return claimAll_;
		}
		set
		{
			claimAll_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AbyssTakeRewardReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AbyssTakeRewardReq(AbyssTakeRewardReq other)
		: this()
	{
		targetStar_ = other.targetStar_;
		abyssId_ = other.abyssId_;
		stageIdx_ = other.stageIdx_;
		claimAll_ = other.claimAll_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AbyssTakeRewardReq Clone()
	{
		return new AbyssTakeRewardReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as AbyssTakeRewardReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(AbyssTakeRewardReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (TargetStar != other.TargetStar)
		{
			return false;
		}
		if (AbyssId != other.AbyssId)
		{
			return false;
		}
		if (StageIdx != other.StageIdx)
		{
			return false;
		}
		if (ClaimAll != other.ClaimAll)
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
		if (TargetStar != 0)
		{
			num ^= TargetStar.GetHashCode();
		}
		if (AbyssId != 0)
		{
			num ^= AbyssId.GetHashCode();
		}
		if (StageIdx != 0)
		{
			num ^= StageIdx.GetHashCode();
		}
		if (ClaimAll)
		{
			num ^= ClaimAll.GetHashCode();
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
		if (TargetStar != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(TargetStar);
		}
		if (AbyssId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(AbyssId);
		}
		if (StageIdx != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(StageIdx);
		}
		if (ClaimAll)
		{
			output.WriteRawTag(32);
			output.WriteBool(ClaimAll);
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
		if (TargetStar != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TargetStar);
		}
		if (AbyssId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AbyssId);
		}
		if (StageIdx != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StageIdx);
		}
		if (ClaimAll)
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
	public void MergeFrom(AbyssTakeRewardReq other)
	{
		if (other != null)
		{
			if (other.TargetStar != 0)
			{
				TargetStar = other.TargetStar;
			}
			if (other.AbyssId != 0)
			{
				AbyssId = other.AbyssId;
			}
			if (other.StageIdx != 0)
			{
				StageIdx = other.StageIdx;
			}
			if (other.ClaimAll)
			{
				ClaimAll = other.ClaimAll;
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
				TargetStar = input.ReadInt32();
				break;
			case 16u:
				AbyssId = input.ReadInt32();
				break;
			case 24u:
				StageIdx = input.ReadInt32();
				break;
			case 32u:
				ClaimAll = input.ReadBool();
				break;
			}
		}
	}
}
