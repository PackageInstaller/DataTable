using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class RaidTeamCharacter : IMessage<RaidTeamCharacter>, IMessage, IEquatable<RaidTeamCharacter>, IDeepCloneable<RaidTeamCharacter>, IBufferMessage
{
	private static readonly MessageParser<RaidTeamCharacter> _parser = new MessageParser<RaidTeamCharacter>(() => new RaidTeamCharacter());

	private UnknownFieldSet _unknownFields;

	public const int CharacterFieldNumber = 1;

	private Character character_;

	public const int IsTrialFieldNumber = 2;

	private bool isTrial_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<RaidTeamCharacter> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[202];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Character Character
	{
		get
		{
			return character_;
		}
		set
		{
			character_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool IsTrial
	{
		get
		{
			return isTrial_;
		}
		set
		{
			isTrial_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RaidTeamCharacter()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RaidTeamCharacter(RaidTeamCharacter other)
		: this()
	{
		character_ = ((other.character_ != null) ? other.character_.Clone() : null);
		isTrial_ = other.isTrial_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RaidTeamCharacter Clone()
	{
		return new RaidTeamCharacter(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as RaidTeamCharacter);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(RaidTeamCharacter other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(Character, other.Character))
		{
			return false;
		}
		if (IsTrial != other.IsTrial)
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
		if (character_ != null)
		{
			num ^= Character.GetHashCode();
		}
		if (IsTrial)
		{
			num ^= IsTrial.GetHashCode();
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
		if (character_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(Character);
		}
		if (IsTrial)
		{
			output.WriteRawTag(16);
			output.WriteBool(IsTrial);
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
		if (character_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Character);
		}
		if (IsTrial)
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
	public void MergeFrom(RaidTeamCharacter other)
	{
		if (other == null)
		{
			return;
		}
		if (other.character_ != null)
		{
			if (character_ == null)
			{
				Character = new Character();
			}
			Character.MergeFrom(other.Character);
		}
		if (other.IsTrial)
		{
			IsTrial = other.IsTrial;
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
			case 10u:
				if (character_ == null)
				{
					Character = new Character();
				}
				input.ReadMessage(Character);
				break;
			case 16u:
				IsTrial = input.ReadBool();
				break;
			}
		}
	}
}
