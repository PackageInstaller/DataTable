using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StarTowerSpMode : IMessage<StarTowerSpMode>, IMessage, IEquatable<StarTowerSpMode>, IDeepCloneable<StarTowerSpMode>
{
	private static readonly MessageParser<StarTowerSpMode> _parser = new MessageParser<StarTowerSpMode>(() => new StarTowerSpMode());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int LimitTimeWeightFieldNumber = 2;

	private bool limitTimeWeight_;

	public const int LimitKilledWeightFieldNumber = 3;

	private bool limitKilledWeight_;

	public const int GoblinWeightFieldNumber = 4;

	private bool goblinWeight_;

	public const int ContinuousKillingWeightFieldNumber = 5;

	private bool continuousKillingWeight_;

	[DebuggerNonUserCode]
	public static MessageParser<StarTowerSpMode> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(878);

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
	public bool LimitTimeWeight
	{
		get
		{
			return limitTimeWeight_;
		}
		set
		{
			limitTimeWeight_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool LimitKilledWeight
	{
		get
		{
			return limitKilledWeight_;
		}
		set
		{
			limitKilledWeight_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool GoblinWeight
	{
		get
		{
			return goblinWeight_;
		}
		set
		{
			goblinWeight_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool ContinuousKillingWeight
	{
		get
		{
			return continuousKillingWeight_;
		}
		set
		{
			continuousKillingWeight_ = value;
		}
	}

	[DebuggerNonUserCode]
	public StarTowerSpMode()
	{
	}

	[DebuggerNonUserCode]
	public StarTowerSpMode(StarTowerSpMode other)
		: this()
	{
		id_ = other.id_;
		limitTimeWeight_ = other.limitTimeWeight_;
		limitKilledWeight_ = other.limitKilledWeight_;
		goblinWeight_ = other.goblinWeight_;
		continuousKillingWeight_ = other.continuousKillingWeight_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StarTowerSpMode Clone()
	{
		return new StarTowerSpMode(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StarTowerSpMode);
	}

	[DebuggerNonUserCode]
	public bool Equals(StarTowerSpMode other)
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
		if (LimitTimeWeight != other.LimitTimeWeight)
		{
			return false;
		}
		if (LimitKilledWeight != other.LimitKilledWeight)
		{
			return false;
		}
		if (GoblinWeight != other.GoblinWeight)
		{
			return false;
		}
		if (ContinuousKillingWeight != other.ContinuousKillingWeight)
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
		if (LimitTimeWeight)
		{
			num ^= LimitTimeWeight.GetHashCode();
		}
		if (LimitKilledWeight)
		{
			num ^= LimitKilledWeight.GetHashCode();
		}
		if (GoblinWeight)
		{
			num ^= GoblinWeight.GetHashCode();
		}
		if (ContinuousKillingWeight)
		{
			num ^= ContinuousKillingWeight.GetHashCode();
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
		if (LimitTimeWeight)
		{
			output.WriteRawTag(16);
			output.WriteBool(LimitTimeWeight);
		}
		if (LimitKilledWeight)
		{
			output.WriteRawTag(24);
			output.WriteBool(LimitKilledWeight);
		}
		if (GoblinWeight)
		{
			output.WriteRawTag(32);
			output.WriteBool(GoblinWeight);
		}
		if (ContinuousKillingWeight)
		{
			output.WriteRawTag(40);
			output.WriteBool(ContinuousKillingWeight);
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
		if (LimitTimeWeight)
		{
			num += 2;
		}
		if (LimitKilledWeight)
		{
			num += 2;
		}
		if (GoblinWeight)
		{
			num += 2;
		}
		if (ContinuousKillingWeight)
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
	public void MergeFrom(StarTowerSpMode other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.LimitTimeWeight)
			{
				LimitTimeWeight = other.LimitTimeWeight;
			}
			if (other.LimitKilledWeight)
			{
				LimitKilledWeight = other.LimitKilledWeight;
			}
			if (other.GoblinWeight)
			{
				GoblinWeight = other.GoblinWeight;
			}
			if (other.ContinuousKillingWeight)
			{
				ContinuousKillingWeight = other.ContinuousKillingWeight;
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
				LimitTimeWeight = input.ReadBool();
				break;
			case 24u:
				LimitKilledWeight = input.ReadBool();
				break;
			case 32u:
				GoblinWeight = input.ReadBool();
				break;
			case 40u:
				ContinuousKillingWeight = input.ReadBool();
				break;
			}
		}
	}
}
