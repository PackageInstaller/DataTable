using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class AbyssChallengeStageReq : IMessage<AbyssChallengeStageReq>, IMessage, IEquatable<AbyssChallengeStageReq>, IDeepCloneable<AbyssChallengeStageReq>, IBufferMessage
{
	private static readonly MessageParser<AbyssChallengeStageReq> _parser = new MessageParser<AbyssChallengeStageReq>(() => new AbyssChallengeStageReq());

	private UnknownFieldSet _unknownFields;

	public const int SelectedStageIdxFieldNumber = 1;

	private int selectedStageIdx_;

	public const int AbyssIdFieldNumber = 2;

	private int abyssId_;

	public const int TeamsFieldNumber = 3;

	private static readonly FieldCodec<TeamUsage> _repeated_teams_codec = FieldCodec.ForMessage(26u, TeamUsage.Parser);

	private readonly RepeatedField<TeamUsage> teams_ = new RepeatedField<TeamUsage>();

	public const int ByGMFieldNumber = 4;

	private bool byGM_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<AbyssChallengeStageReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => AbyssReflection.Descriptor.MessageTypes[0];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int SelectedStageIdx
	{
		get
		{
			return selectedStageIdx_;
		}
		set
		{
			selectedStageIdx_ = value;
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
	public RepeatedField<TeamUsage> Teams => teams_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool ByGM
	{
		get
		{
			return byGM_;
		}
		set
		{
			byGM_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AbyssChallengeStageReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AbyssChallengeStageReq(AbyssChallengeStageReq other)
		: this()
	{
		selectedStageIdx_ = other.selectedStageIdx_;
		abyssId_ = other.abyssId_;
		teams_ = other.teams_.Clone();
		byGM_ = other.byGM_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AbyssChallengeStageReq Clone()
	{
		return new AbyssChallengeStageReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as AbyssChallengeStageReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(AbyssChallengeStageReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (SelectedStageIdx != other.SelectedStageIdx)
		{
			return false;
		}
		if (AbyssId != other.AbyssId)
		{
			return false;
		}
		if (!teams_.Equals(other.teams_))
		{
			return false;
		}
		if (ByGM != other.ByGM)
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
		if (SelectedStageIdx != 0)
		{
			num ^= SelectedStageIdx.GetHashCode();
		}
		if (AbyssId != 0)
		{
			num ^= AbyssId.GetHashCode();
		}
		num ^= teams_.GetHashCode();
		if (ByGM)
		{
			num ^= ByGM.GetHashCode();
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
		if (SelectedStageIdx != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(SelectedStageIdx);
		}
		if (AbyssId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(AbyssId);
		}
		teams_.WriteTo(ref output, _repeated_teams_codec);
		if (ByGM)
		{
			output.WriteRawTag(32);
			output.WriteBool(ByGM);
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
		if (SelectedStageIdx != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SelectedStageIdx);
		}
		if (AbyssId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AbyssId);
		}
		num += teams_.CalculateSize(_repeated_teams_codec);
		if (ByGM)
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
	public void MergeFrom(AbyssChallengeStageReq other)
	{
		if (other != null)
		{
			if (other.SelectedStageIdx != 0)
			{
				SelectedStageIdx = other.SelectedStageIdx;
			}
			if (other.AbyssId != 0)
			{
				AbyssId = other.AbyssId;
			}
			teams_.Add(other.teams_);
			if (other.ByGM)
			{
				ByGM = other.ByGM;
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
				SelectedStageIdx = input.ReadInt32();
				break;
			case 16u:
				AbyssId = input.ReadInt32();
				break;
			case 26u:
				teams_.AddEntriesFrom(ref input, _repeated_teams_codec);
				break;
			case 32u:
				ByGM = input.ReadBool();
				break;
			}
		}
	}
}
