using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class TeamList : IMessage<TeamList>, IMessage, IEquatable<TeamList>, IDeepCloneable<TeamList>, IBufferMessage
{
	private static readonly MessageParser<TeamList> _parser = new MessageParser<TeamList>(() => new TeamList());

	private UnknownFieldSet _unknownFields;

	public const int TeamsFieldNumber = 1;

	private static readonly FieldCodec<Team> _repeated_teams_codec = FieldCodec.ForMessage(10u, Team.Parser);

	private readonly RepeatedField<Team> teams_ = new RepeatedField<Team>();

	public const int CurrentBattleTeamIdxFieldNumber = 2;

	private int currentBattleTeamIdx_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<TeamList> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[72];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<Team> Teams => teams_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CurrentBattleTeamIdx
	{
		get
		{
			return currentBattleTeamIdx_;
		}
		set
		{
			currentBattleTeamIdx_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TeamList()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TeamList(TeamList other)
		: this()
	{
		teams_ = other.teams_.Clone();
		currentBattleTeamIdx_ = other.currentBattleTeamIdx_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TeamList Clone()
	{
		return new TeamList(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as TeamList);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(TeamList other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!teams_.Equals(other.teams_))
		{
			return false;
		}
		if (CurrentBattleTeamIdx != other.CurrentBattleTeamIdx)
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
		num ^= teams_.GetHashCode();
		if (CurrentBattleTeamIdx != 0)
		{
			num ^= CurrentBattleTeamIdx.GetHashCode();
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
		teams_.WriteTo(ref output, _repeated_teams_codec);
		if (CurrentBattleTeamIdx != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(CurrentBattleTeamIdx);
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
		num += teams_.CalculateSize(_repeated_teams_codec);
		if (CurrentBattleTeamIdx != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CurrentBattleTeamIdx);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(TeamList other)
	{
		if (other != null)
		{
			teams_.Add(other.teams_);
			if (other.CurrentBattleTeamIdx != 0)
			{
				CurrentBattleTeamIdx = other.CurrentBattleTeamIdx;
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
				teams_.AddEntriesFrom(ref input, _repeated_teams_codec);
				break;
			case 16u:
				CurrentBattleTeamIdx = input.ReadInt32();
				break;
			}
		}
	}
}
