using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class RogueTeamChangeAck : IMessage<RogueTeamChangeAck>, IMessage, IEquatable<RogueTeamChangeAck>, IDeepCloneable<RogueTeamChangeAck>, IBufferMessage
{
	private static readonly MessageParser<RogueTeamChangeAck> _parser = new MessageParser<RogueTeamChangeAck>(() => new RogueTeamChangeAck());

	private UnknownFieldSet _unknownFields;

	public const int RogueTeamFieldNumber = 1;

	private CharacterRepository rogueTeam_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<RogueTeamChangeAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => RogueReflection.Descriptor.MessageTypes[23];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterRepository RogueTeam
	{
		get
		{
			return rogueTeam_;
		}
		set
		{
			rogueTeam_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueTeamChangeAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueTeamChangeAck(RogueTeamChangeAck other)
		: this()
	{
		rogueTeam_ = ((other.rogueTeam_ != null) ? other.rogueTeam_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueTeamChangeAck Clone()
	{
		return new RogueTeamChangeAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as RogueTeamChangeAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(RogueTeamChangeAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(RogueTeam, other.RogueTeam))
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
		if (rogueTeam_ != null)
		{
			num ^= RogueTeam.GetHashCode();
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
		if (rogueTeam_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(RogueTeam);
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
		if (rogueTeam_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(RogueTeam);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(RogueTeamChangeAck other)
	{
		if (other == null)
		{
			return;
		}
		if (other.rogueTeam_ != null)
		{
			if (rogueTeam_ == null)
			{
				RogueTeam = new CharacterRepository();
			}
			RogueTeam.MergeFrom(other.RogueTeam);
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
			if (num != 10)
			{
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				continue;
			}
			if (rogueTeam_ == null)
			{
				RogueTeam = new CharacterRepository();
			}
			input.ReadMessage(RogueTeam);
		}
	}
}
