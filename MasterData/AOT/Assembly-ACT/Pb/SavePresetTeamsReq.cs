using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class SavePresetTeamsReq : IMessage<SavePresetTeamsReq>, IMessage, IEquatable<SavePresetTeamsReq>, IDeepCloneable<SavePresetTeamsReq>, IBufferMessage
{
	private static readonly MessageParser<SavePresetTeamsReq> _parser = new MessageParser<SavePresetTeamsReq>(() => new SavePresetTeamsReq());

	private UnknownFieldSet _unknownFields;

	public const int TeamsFieldNumber = 1;

	private static readonly FieldCodec<PresetTeam> _repeated_teams_codec = FieldCodec.ForMessage(10u, PresetTeam.Parser);

	private readonly RepeatedField<PresetTeam> teams_ = new RepeatedField<PresetTeam>();

	public const int MainTeamIdxFieldNumber = 2;

	private int mainTeamIdx_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<SavePresetTeamsReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => TeamReflection.Descriptor.MessageTypes[3];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<PresetTeam> Teams => teams_;

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
	public SavePresetTeamsReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SavePresetTeamsReq(SavePresetTeamsReq other)
		: this()
	{
		teams_ = other.teams_.Clone();
		mainTeamIdx_ = other.mainTeamIdx_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SavePresetTeamsReq Clone()
	{
		return new SavePresetTeamsReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as SavePresetTeamsReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(SavePresetTeamsReq other)
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
		if (MainTeamIdx != other.MainTeamIdx)
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
		if (MainTeamIdx != 0)
		{
			num ^= MainTeamIdx.GetHashCode();
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
		if (MainTeamIdx != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(MainTeamIdx);
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
		if (MainTeamIdx != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MainTeamIdx);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(SavePresetTeamsReq other)
	{
		if (other != null)
		{
			teams_.Add(other.teams_);
			if (other.MainTeamIdx != 0)
			{
				MainTeamIdx = other.MainTeamIdx;
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
				MainTeamIdx = input.ReadInt32();
				break;
			}
		}
	}
}
