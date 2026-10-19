using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class ReplacePresetTeamReq : IMessage<ReplacePresetTeamReq>, IMessage, IEquatable<ReplacePresetTeamReq>, IDeepCloneable<ReplacePresetTeamReq>, IBufferMessage
{
	private static readonly MessageParser<ReplacePresetTeamReq> _parser = new MessageParser<ReplacePresetTeamReq>(() => new ReplacePresetTeamReq());

	private UnknownFieldSet _unknownFields;

	public const int IdxFieldNumber = 1;

	private int idx_;

	public const int TeamFieldNumber = 2;

	private TeamUsage team_;

	public const int PresetTeamFieldNumber = 3;

	private PresetTeam presetTeam_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ReplacePresetTeamReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => TeamReflection.Descriptor.MessageTypes[1];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Idx
	{
		get
		{
			return idx_;
		}
		set
		{
			idx_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TeamUsage Team
	{
		get
		{
			return team_;
		}
		set
		{
			team_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PresetTeam PresetTeam
	{
		get
		{
			return presetTeam_;
		}
		set
		{
			presetTeam_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ReplacePresetTeamReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ReplacePresetTeamReq(ReplacePresetTeamReq other)
		: this()
	{
		idx_ = other.idx_;
		team_ = ((other.team_ != null) ? other.team_.Clone() : null);
		presetTeam_ = ((other.presetTeam_ != null) ? other.presetTeam_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ReplacePresetTeamReq Clone()
	{
		return new ReplacePresetTeamReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ReplacePresetTeamReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ReplacePresetTeamReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Idx != other.Idx)
		{
			return false;
		}
		if (!object.Equals(Team, other.Team))
		{
			return false;
		}
		if (!object.Equals(PresetTeam, other.PresetTeam))
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
		if (Idx != 0)
		{
			num ^= Idx.GetHashCode();
		}
		if (team_ != null)
		{
			num ^= Team.GetHashCode();
		}
		if (presetTeam_ != null)
		{
			num ^= PresetTeam.GetHashCode();
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
		if (Idx != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Idx);
		}
		if (team_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(Team);
		}
		if (presetTeam_ != null)
		{
			output.WriteRawTag(26);
			output.WriteMessage(PresetTeam);
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
		if (Idx != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Idx);
		}
		if (team_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Team);
		}
		if (presetTeam_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(PresetTeam);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ReplacePresetTeamReq other)
	{
		if (other == null)
		{
			return;
		}
		if (other.Idx != 0)
		{
			Idx = other.Idx;
		}
		if (other.team_ != null)
		{
			if (team_ == null)
			{
				Team = new TeamUsage();
			}
			Team.MergeFrom(other.Team);
		}
		if (other.presetTeam_ != null)
		{
			if (presetTeam_ == null)
			{
				PresetTeam = new PresetTeam();
			}
			PresetTeam.MergeFrom(other.PresetTeam);
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
			case 8u:
				Idx = input.ReadInt32();
				break;
			case 18u:
				if (team_ == null)
				{
					Team = new TeamUsage();
				}
				input.ReadMessage(Team);
				break;
			case 26u:
				if (presetTeam_ == null)
				{
					PresetTeam = new PresetTeam();
				}
				input.ReadMessage(PresetTeam);
				break;
			}
		}
	}
}
