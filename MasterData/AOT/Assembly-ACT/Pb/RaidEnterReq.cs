using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class RaidEnterReq : IMessage<RaidEnterReq>, IMessage, IEquatable<RaidEnterReq>, IDeepCloneable<RaidEnterReq>, IBufferMessage
{
	private static readonly MessageParser<RaidEnterReq> _parser = new MessageParser<RaidEnterReq>(() => new RaidEnterReq());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TeamFieldNumber = 2;

	private TeamUsage team_;

	public const int RateFieldNumber = 3;

	private int rate_;

	public const int ByGMFieldNumber = 4;

	private bool byGM_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<RaidEnterReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => RaidReflection.Descriptor.MessageTypes[0];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Id
	{
		get
		{
			return id_;
		}
		set
		{
			id_ = value;
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
	public int Rate
	{
		get
		{
			return rate_;
		}
		set
		{
			rate_ = value;
		}
	}

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
	public RaidEnterReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RaidEnterReq(RaidEnterReq other)
		: this()
	{
		id_ = other.id_;
		team_ = ((other.team_ != null) ? other.team_.Clone() : null);
		rate_ = other.rate_;
		byGM_ = other.byGM_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RaidEnterReq Clone()
	{
		return new RaidEnterReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as RaidEnterReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(RaidEnterReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Id != other.Id)
		{
			return false;
		}
		if (!object.Equals(Team, other.Team))
		{
			return false;
		}
		if (Rate != other.Rate)
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
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (team_ != null)
		{
			num ^= Team.GetHashCode();
		}
		if (Rate != 0)
		{
			num ^= Rate.GetHashCode();
		}
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
		if (Id != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Id);
		}
		if (team_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(Team);
		}
		if (Rate != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Rate);
		}
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
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		if (team_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Team);
		}
		if (Rate != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Rate);
		}
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
	public void MergeFrom(RaidEnterReq other)
	{
		if (other == null)
		{
			return;
		}
		if (other.Id != 0)
		{
			Id = other.Id;
		}
		if (other.team_ != null)
		{
			if (team_ == null)
			{
				Team = new TeamUsage();
			}
			Team.MergeFrom(other.Team);
		}
		if (other.Rate != 0)
		{
			Rate = other.Rate;
		}
		if (other.ByGM)
		{
			ByGM = other.ByGM;
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
				Id = input.ReadInt32();
				break;
			case 18u:
				if (team_ == null)
				{
					Team = new TeamUsage();
				}
				input.ReadMessage(Team);
				break;
			case 24u:
				Rate = input.ReadInt32();
				break;
			case 32u:
				ByGM = input.ReadBool();
				break;
			}
		}
	}
}
