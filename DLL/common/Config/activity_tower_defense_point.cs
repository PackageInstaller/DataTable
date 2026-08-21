using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class activity_tower_defense_point : IMessage<activity_tower_defense_point>, IMessage, IEquatable<activity_tower_defense_point>, IDeepCloneable<activity_tower_defense_point>
{
	private static readonly MessageParser<activity_tower_defense_point> _parser = new MessageParser<activity_tower_defense_point>(() => new activity_tower_defense_point());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int PtFieldNumber = 2;

	private int pt_;

	public const int ReducedValueFieldNumber = 3;

	private int reducedValue_;

	[DebuggerNonUserCode]
	public static MessageParser<activity_tower_defense_point> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[74];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int ID
	{
		get
		{
			return iD_;
		}
		set
		{
			iD_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Pt
	{
		get
		{
			return pt_;
		}
		set
		{
			pt_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ReducedValue
	{
		get
		{
			return reducedValue_;
		}
		set
		{
			reducedValue_ = value;
		}
	}

	[DebuggerNonUserCode]
	public activity_tower_defense_point()
	{
	}

	[DebuggerNonUserCode]
	public activity_tower_defense_point(activity_tower_defense_point other)
		: this()
	{
		iD_ = other.iD_;
		pt_ = other.pt_;
		reducedValue_ = other.reducedValue_;
	}

	[DebuggerNonUserCode]
	public activity_tower_defense_point Clone()
	{
		return new activity_tower_defense_point(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as activity_tower_defense_point);
	}

	[DebuggerNonUserCode]
	public bool Equals(activity_tower_defense_point other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ID != other.ID)
		{
			return false;
		}
		if (Pt != other.Pt)
		{
			return false;
		}
		if (ReducedValue != other.ReducedValue)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (ID != 0)
		{
			num ^= ID.GetHashCode();
		}
		if (Pt != 0)
		{
			num ^= Pt.GetHashCode();
		}
		if (ReducedValue != 0)
		{
			num ^= ReducedValue.GetHashCode();
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
		if (ID != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ID);
		}
		if (Pt != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Pt);
		}
		if (ReducedValue != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(ReducedValue);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (ID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ID);
		}
		if (Pt != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Pt);
		}
		if (ReducedValue != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ReducedValue);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(activity_tower_defense_point other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.Pt != 0)
			{
				Pt = other.Pt;
			}
			if (other.ReducedValue != 0)
			{
				ReducedValue = other.ReducedValue;
			}
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
				input.SkipLastField();
				break;
			case 8u:
				ID = input.ReadInt32();
				break;
			case 16u:
				Pt = input.ReadInt32();
				break;
			case 24u:
				ReducedValue = input.ReadInt32();
				break;
			}
		}
	}
}
