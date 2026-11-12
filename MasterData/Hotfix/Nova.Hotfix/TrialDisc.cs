using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TrialDisc : IMessage<TrialDisc>, IMessage, IEquatable<TrialDisc>, IDeepCloneable<TrialDisc>
{
	private static readonly MessageParser<TrialDisc> _parser = new MessageParser<TrialDisc>(() => new TrialDisc());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int DiscIdFieldNumber = 2;

	private int discId_;

	public const int PhaseFieldNumber = 3;

	private int phase_;

	public const int LevelFieldNumber = 4;

	private int level_;

	public const int StarFieldNumber = 5;

	private int star_;

	[DebuggerNonUserCode]
	public static MessageParser<TrialDisc> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(1032);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
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
	public int DiscId
	{
		get
		{
			return discId_;
		}
		set
		{
			discId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Phase
	{
		get
		{
			return phase_;
		}
		set
		{
			phase_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Level
	{
		get
		{
			return level_;
		}
		set
		{
			level_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Star
	{
		get
		{
			return star_;
		}
		set
		{
			star_ = value;
		}
	}

	[DebuggerNonUserCode]
	public TrialDisc()
	{
	}

	[DebuggerNonUserCode]
	public TrialDisc(TrialDisc other)
		: this()
	{
		id_ = other.id_;
		discId_ = other.discId_;
		phase_ = other.phase_;
		level_ = other.level_;
		star_ = other.star_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TrialDisc Clone()
	{
		return new TrialDisc(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TrialDisc);
	}

	[DebuggerNonUserCode]
	public bool Equals(TrialDisc other)
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
		if (DiscId != other.DiscId)
		{
			return false;
		}
		if (Phase != other.Phase)
		{
			return false;
		}
		if (Level != other.Level)
		{
			return false;
		}
		if (Star != other.Star)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (DiscId != 0)
		{
			num ^= DiscId.GetHashCode();
		}
		if (Phase != 0)
		{
			num ^= Phase.GetHashCode();
		}
		if (Level != 0)
		{
			num ^= Level.GetHashCode();
		}
		if (Star != 0)
		{
			num ^= Star.GetHashCode();
		}
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	public void WriteTo(CodedOutputStream output)
	{
		if (Id != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Id);
		}
		if (DiscId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(DiscId);
		}
		if (Phase != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Phase);
		}
		if (Level != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Level);
		}
		if (Star != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Star);
		}
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(output);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		if (DiscId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DiscId);
		}
		if (Phase != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Phase);
		}
		if (Level != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Level);
		}
		if (Star != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Star);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TrialDisc other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.DiscId != 0)
			{
				DiscId = other.DiscId;
			}
			if (other.Phase != 0)
			{
				Phase = other.Phase;
			}
			if (other.Level != 0)
			{
				Level = other.Level;
			}
			if (other.Star != 0)
			{
				Star = other.Star;
			}
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
		}
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CodedInputStream input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			switch (num)
			{
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, input);
				break;
			case 8u:
				Id = input.ReadInt32();
				break;
			case 16u:
				DiscId = input.ReadInt32();
				break;
			case 24u:
				Phase = input.ReadInt32();
				break;
			case 32u:
				Level = input.ReadInt32();
				break;
			case 40u:
				Star = input.ReadInt32();
				break;
			}
		}
	}
}
