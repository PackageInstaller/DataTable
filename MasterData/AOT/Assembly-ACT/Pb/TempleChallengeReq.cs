using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class TempleChallengeReq : IMessage<TempleChallengeReq>, IMessage, IEquatable<TempleChallengeReq>, IDeepCloneable<TempleChallengeReq>, IBufferMessage
{
	private static readonly MessageParser<TempleChallengeReq> _parser = new MessageParser<TempleChallengeReq>(() => new TempleChallengeReq());

	private UnknownFieldSet _unknownFields;

	public const int TempleIdFieldNumber = 1;

	private int templeId_;

	public const int TeamFieldNumber = 2;

	private TeamUsage team_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<TempleChallengeReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => TempleReflection.Descriptor.MessageTypes[2];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int TempleId
	{
		get
		{
			return templeId_;
		}
		set
		{
			templeId_ = value;
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
	public TempleChallengeReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TempleChallengeReq(TempleChallengeReq other)
		: this()
	{
		templeId_ = other.templeId_;
		team_ = ((other.team_ != null) ? other.team_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TempleChallengeReq Clone()
	{
		return new TempleChallengeReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as TempleChallengeReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(TempleChallengeReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (TempleId != other.TempleId)
		{
			return false;
		}
		if (!object.Equals(Team, other.Team))
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
		if (TempleId != 0)
		{
			num ^= TempleId.GetHashCode();
		}
		if (team_ != null)
		{
			num ^= Team.GetHashCode();
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
		if (TempleId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(TempleId);
		}
		if (team_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(Team);
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
		if (TempleId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TempleId);
		}
		if (team_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Team);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(TempleChallengeReq other)
	{
		if (other == null)
		{
			return;
		}
		if (other.TempleId != 0)
		{
			TempleId = other.TempleId;
		}
		if (other.team_ != null)
		{
			if (team_ == null)
			{
				Team = new TeamUsage();
			}
			Team.MergeFrom(other.Team);
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
				TempleId = input.ReadInt32();
				break;
			case 18u:
				if (team_ == null)
				{
					Team = new TeamUsage();
				}
				input.ReadMessage(Team);
				break;
			}
		}
	}
}
