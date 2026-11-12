using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class GachaATypeProb : IMessage<GachaATypeProb>, IMessage, IEquatable<GachaATypeProb>, IDeepCloneable<GachaATypeProb>
{
	private static readonly MessageParser<GachaATypeProb> _parser = new MessageParser<GachaATypeProb>(() => new GachaATypeProb());

	private UnknownFieldSet _unknownFields;

	public const int GroupFieldNumber = 1;

	private int group_;

	public const int TimesFieldNumber = 2;

	private int times_;

	public const int ProbFieldNumber = 3;

	private int prob_;

	[DebuggerNonUserCode]
	public static MessageParser<GachaATypeProb> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(364);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int Group
	{
		get
		{
			return group_;
		}
		set
		{
			group_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Times
	{
		get
		{
			return times_;
		}
		set
		{
			times_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Prob
	{
		get
		{
			return prob_;
		}
		set
		{
			prob_ = value;
		}
	}

	[DebuggerNonUserCode]
	public GachaATypeProb()
	{
	}

	[DebuggerNonUserCode]
	public GachaATypeProb(GachaATypeProb other)
		: this()
	{
		group_ = other.group_;
		times_ = other.times_;
		prob_ = other.prob_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public GachaATypeProb Clone()
	{
		return new GachaATypeProb(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as GachaATypeProb);
	}

	[DebuggerNonUserCode]
	public bool Equals(GachaATypeProb other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Group != other.Group)
		{
			return false;
		}
		if (Times != other.Times)
		{
			return false;
		}
		if (Prob != other.Prob)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Group != 0)
		{
			num ^= Group.GetHashCode();
		}
		if (Times != 0)
		{
			num ^= Times.GetHashCode();
		}
		if (Prob != 0)
		{
			num ^= Prob.GetHashCode();
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
		if (Group != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Group);
		}
		if (Times != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Times);
		}
		if (Prob != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Prob);
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
		if (Group != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Group);
		}
		if (Times != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Times);
		}
		if (Prob != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Prob);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(GachaATypeProb other)
	{
		if (other != null)
		{
			if (other.Group != 0)
			{
				Group = other.Group;
			}
			if (other.Times != 0)
			{
				Times = other.Times;
			}
			if (other.Prob != 0)
			{
				Prob = other.Prob;
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
				Group = input.ReadInt32();
				break;
			case 16u:
				Times = input.ReadInt32();
				break;
			case 24u:
				Prob = input.ReadInt32();
				break;
			}
		}
	}
}
