using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class UpdateUsageTeamAck : IMessage<UpdateUsageTeamAck>, IMessage, IEquatable<UpdateUsageTeamAck>, IDeepCloneable<UpdateUsageTeamAck>, IBufferMessage
{
	private static readonly MessageParser<UpdateUsageTeamAck> _parser = new MessageParser<UpdateUsageTeamAck>(() => new UpdateUsageTeamAck());

	private UnknownFieldSet _unknownFields;

	public const int SceneEnumFieldNumber = 1;

	private int sceneEnum_;

	public const int TeamsFieldNumber = 2;

	private TeamList teams_;

	public const int CharacterRepositoryFieldNumber = 3;

	private CharacterRepository characterRepository_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<UpdateUsageTeamAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => TeamReflection.Descriptor.MessageTypes[12];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int SceneEnum
	{
		get
		{
			return sceneEnum_;
		}
		set
		{
			sceneEnum_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TeamList Teams
	{
		get
		{
			return teams_;
		}
		set
		{
			teams_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterRepository CharacterRepository
	{
		get
		{
			return characterRepository_;
		}
		set
		{
			characterRepository_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public UpdateUsageTeamAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public UpdateUsageTeamAck(UpdateUsageTeamAck other)
		: this()
	{
		sceneEnum_ = other.sceneEnum_;
		teams_ = ((other.teams_ != null) ? other.teams_.Clone() : null);
		characterRepository_ = ((other.characterRepository_ != null) ? other.characterRepository_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public UpdateUsageTeamAck Clone()
	{
		return new UpdateUsageTeamAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as UpdateUsageTeamAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(UpdateUsageTeamAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (SceneEnum != other.SceneEnum)
		{
			return false;
		}
		if (!object.Equals(Teams, other.Teams))
		{
			return false;
		}
		if (!object.Equals(CharacterRepository, other.CharacterRepository))
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
		if (SceneEnum != 0)
		{
			num ^= SceneEnum.GetHashCode();
		}
		if (teams_ != null)
		{
			num ^= Teams.GetHashCode();
		}
		if (characterRepository_ != null)
		{
			num ^= CharacterRepository.GetHashCode();
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
		if (SceneEnum != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(SceneEnum);
		}
		if (teams_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(Teams);
		}
		if (characterRepository_ != null)
		{
			output.WriteRawTag(26);
			output.WriteMessage(CharacterRepository);
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
		if (SceneEnum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SceneEnum);
		}
		if (teams_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Teams);
		}
		if (characterRepository_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(CharacterRepository);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(UpdateUsageTeamAck other)
	{
		if (other == null)
		{
			return;
		}
		if (other.SceneEnum != 0)
		{
			SceneEnum = other.SceneEnum;
		}
		if (other.teams_ != null)
		{
			if (teams_ == null)
			{
				Teams = new TeamList();
			}
			Teams.MergeFrom(other.Teams);
		}
		if (other.characterRepository_ != null)
		{
			if (characterRepository_ == null)
			{
				CharacterRepository = new CharacterRepository();
			}
			CharacterRepository.MergeFrom(other.CharacterRepository);
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
				SceneEnum = input.ReadInt32();
				break;
			case 18u:
				if (teams_ == null)
				{
					Teams = new TeamList();
				}
				input.ReadMessage(Teams);
				break;
			case 26u:
				if (characterRepository_ == null)
				{
					CharacterRepository = new CharacterRepository();
				}
				input.ReadMessage(CharacterRepository);
				break;
			}
		}
	}
}
