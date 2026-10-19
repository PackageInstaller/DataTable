using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class TeamInfo : IMessage<TeamInfo>, IMessage, IEquatable<TeamInfo>, IDeepCloneable<TeamInfo>, IBufferMessage
{
	private static readonly MessageParser<TeamInfo> _parser = new MessageParser<TeamInfo>(() => new TeamInfo());

	private UnknownFieldSet _unknownFields;

	public const int PresetTeamsFieldNumber = 1;

	private static readonly FieldCodec<PresetTeam> _repeated_presetTeams_codec = FieldCodec.ForMessage(10u, PresetTeam.Parser);

	private readonly RepeatedField<PresetTeam> presetTeams_ = new RepeatedField<PresetTeam>();

	public const int MainTeamIdxFieldNumber = 2;

	private int mainTeamIdx_;

	public const int TeamsFieldNumber = 3;

	private static readonly MapField<int, TeamList>.Codec _map_teams_codec = new MapField<int, TeamList>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, TeamList.Parser), 26u);

	private readonly MapField<int, TeamList> teams_ = new MapField<int, TeamList>();

	public const int CharacterRepositoryFieldNumber = 4;

	private static readonly MapField<int, CharacterRepository>.Codec _map_characterRepository_codec = new MapField<int, CharacterRepository>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, ACT.Game.Data.CharacterRepository.Parser), 34u);

	private readonly MapField<int, CharacterRepository> characterRepository_ = new MapField<int, CharacterRepository>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<TeamInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[73];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<PresetTeam> PresetTeams => presetTeams_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int MainTeamIdx
	{
		get
		{
			return mainTeamIdx_;
		}
		set
		{
			mainTeamIdx_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, TeamList> Teams => teams_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, CharacterRepository> CharacterRepository => characterRepository_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TeamInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TeamInfo(TeamInfo other)
		: this()
	{
		presetTeams_ = other.presetTeams_.Clone();
		mainTeamIdx_ = other.mainTeamIdx_;
		teams_ = other.teams_.Clone();
		characterRepository_ = other.characterRepository_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TeamInfo Clone()
	{
		return new TeamInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as TeamInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(TeamInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!presetTeams_.Equals(other.presetTeams_))
		{
			return false;
		}
		if (MainTeamIdx != other.MainTeamIdx)
		{
			return false;
		}
		if (!Teams.Equals(other.Teams))
		{
			return false;
		}
		if (!CharacterRepository.Equals(other.CharacterRepository))
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
		num ^= presetTeams_.GetHashCode();
		if (MainTeamIdx != 0)
		{
			num ^= MainTeamIdx.GetHashCode();
		}
		num ^= Teams.GetHashCode();
		num ^= CharacterRepository.GetHashCode();
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
		presetTeams_.WriteTo(ref output, _repeated_presetTeams_codec);
		if (MainTeamIdx != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(MainTeamIdx);
		}
		teams_.WriteTo(ref output, _map_teams_codec);
		characterRepository_.WriteTo(ref output, _map_characterRepository_codec);
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
		num += presetTeams_.CalculateSize(_repeated_presetTeams_codec);
		if (MainTeamIdx != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MainTeamIdx);
		}
		num += teams_.CalculateSize(_map_teams_codec);
		num += characterRepository_.CalculateSize(_map_characterRepository_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(TeamInfo other)
	{
		if (other != null)
		{
			presetTeams_.Add(other.presetTeams_);
			if (other.MainTeamIdx != 0)
			{
				MainTeamIdx = other.MainTeamIdx;
			}
			teams_.Add(other.teams_);
			characterRepository_.Add(other.characterRepository_);
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
				presetTeams_.AddEntriesFrom(ref input, _repeated_presetTeams_codec);
				break;
			case 16u:
				MainTeamIdx = input.ReadInt32();
				break;
			case 26u:
				teams_.AddEntriesFrom(ref input, _map_teams_codec);
				break;
			case 34u:
				characterRepository_.AddEntriesFrom(ref input, _map_characterRepository_codec);
				break;
			}
		}
	}
}
