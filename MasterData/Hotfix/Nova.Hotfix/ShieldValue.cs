using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ShieldValue : IMessage<ShieldValue>, IMessage, IEquatable<ShieldValue>, IDeepCloneable<ShieldValue>
{
	private static readonly MessageParser<ShieldValue> _parser = new MessageParser<ShieldValue>(() => new ShieldValue());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int AbsorptionBaseFieldNumber = 3;

	private long absorptionBase_;

	public const int ReferenceTargetFieldNumber = 4;

	private int referenceTarget_;

	public const int ReferenceAttribFieldNumber = 5;

	private int referenceAttrib_;

	public const int ReferenceScaleFieldNumber = 6;

	private int referenceScale_;

	public const int TimeFieldNumber = 7;

	private int time_;

	public const int ShieldLaminatedNumFieldNumber = 8;

	private int shieldLaminatedNum_;

	public const int TimeSuperpositionFieldNumber = 9;

	private int timeSuperposition_;

	public const int NotRemoveFieldNumber = 10;

	private bool notRemove_;

	public const int ReferenceLimitFieldNumber = 11;

	private long referenceLimit_;

	[DebuggerNonUserCode]
	public static MessageParser<ShieldValue> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(716);

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
	public string Name
	{
		get
		{
			return name_;
		}
		set
		{
			name_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public long AbsorptionBase
	{
		get
		{
			return absorptionBase_;
		}
		set
		{
			absorptionBase_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ReferenceTarget
	{
		get
		{
			return referenceTarget_;
		}
		set
		{
			referenceTarget_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ReferenceAttrib
	{
		get
		{
			return referenceAttrib_;
		}
		set
		{
			referenceAttrib_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ReferenceScale
	{
		get
		{
			return referenceScale_;
		}
		set
		{
			referenceScale_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Time
	{
		get
		{
			return time_;
		}
		set
		{
			time_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ShieldLaminatedNum
	{
		get
		{
			return shieldLaminatedNum_;
		}
		set
		{
			shieldLaminatedNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TimeSuperposition
	{
		get
		{
			return timeSuperposition_;
		}
		set
		{
			timeSuperposition_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool NotRemove
	{
		get
		{
			return notRemove_;
		}
		set
		{
			notRemove_ = value;
		}
	}

	[DebuggerNonUserCode]
	public long ReferenceLimit
	{
		get
		{
			return referenceLimit_;
		}
		set
		{
			referenceLimit_ = value;
		}
	}

	[DebuggerNonUserCode]
	public ShieldValue()
	{
	}

	[DebuggerNonUserCode]
	public ShieldValue(ShieldValue other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		absorptionBase_ = other.absorptionBase_;
		referenceTarget_ = other.referenceTarget_;
		referenceAttrib_ = other.referenceAttrib_;
		referenceScale_ = other.referenceScale_;
		time_ = other.time_;
		shieldLaminatedNum_ = other.shieldLaminatedNum_;
		timeSuperposition_ = other.timeSuperposition_;
		notRemove_ = other.notRemove_;
		referenceLimit_ = other.referenceLimit_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ShieldValue Clone()
	{
		return new ShieldValue(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ShieldValue);
	}

	[DebuggerNonUserCode]
	public bool Equals(ShieldValue other)
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
		if (Name != other.Name)
		{
			return false;
		}
		if (AbsorptionBase != other.AbsorptionBase)
		{
			return false;
		}
		if (ReferenceTarget != other.ReferenceTarget)
		{
			return false;
		}
		if (ReferenceAttrib != other.ReferenceAttrib)
		{
			return false;
		}
		if (ReferenceScale != other.ReferenceScale)
		{
			return false;
		}
		if (Time != other.Time)
		{
			return false;
		}
		if (ShieldLaminatedNum != other.ShieldLaminatedNum)
		{
			return false;
		}
		if (TimeSuperposition != other.TimeSuperposition)
		{
			return false;
		}
		if (NotRemove != other.NotRemove)
		{
			return false;
		}
		if (ReferenceLimit != other.ReferenceLimit)
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
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (AbsorptionBase != 0L)
		{
			num ^= AbsorptionBase.GetHashCode();
		}
		if (ReferenceTarget != 0)
		{
			num ^= ReferenceTarget.GetHashCode();
		}
		if (ReferenceAttrib != 0)
		{
			num ^= ReferenceAttrib.GetHashCode();
		}
		if (ReferenceScale != 0)
		{
			num ^= ReferenceScale.GetHashCode();
		}
		if (Time != 0)
		{
			num ^= Time.GetHashCode();
		}
		if (ShieldLaminatedNum != 0)
		{
			num ^= ShieldLaminatedNum.GetHashCode();
		}
		if (TimeSuperposition != 0)
		{
			num ^= TimeSuperposition.GetHashCode();
		}
		if (NotRemove)
		{
			num ^= NotRemove.GetHashCode();
		}
		if (ReferenceLimit != 0L)
		{
			num ^= ReferenceLimit.GetHashCode();
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
		if (Name.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Name);
		}
		if (AbsorptionBase != 0L)
		{
			output.WriteRawTag(24);
			output.WriteInt64(AbsorptionBase);
		}
		if (ReferenceTarget != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(ReferenceTarget);
		}
		if (ReferenceAttrib != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(ReferenceAttrib);
		}
		if (ReferenceScale != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(ReferenceScale);
		}
		if (Time != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Time);
		}
		if (ShieldLaminatedNum != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(ShieldLaminatedNum);
		}
		if (TimeSuperposition != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(TimeSuperposition);
		}
		if (NotRemove)
		{
			output.WriteRawTag(80);
			output.WriteBool(NotRemove);
		}
		if (ReferenceLimit != 0L)
		{
			output.WriteRawTag(88);
			output.WriteInt64(ReferenceLimit);
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
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (AbsorptionBase != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(AbsorptionBase);
		}
		if (ReferenceTarget != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ReferenceTarget);
		}
		if (ReferenceAttrib != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ReferenceAttrib);
		}
		if (ReferenceScale != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ReferenceScale);
		}
		if (Time != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Time);
		}
		if (ShieldLaminatedNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ShieldLaminatedNum);
		}
		if (TimeSuperposition != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TimeSuperposition);
		}
		if (NotRemove)
		{
			num += 2;
		}
		if (ReferenceLimit != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(ReferenceLimit);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ShieldValue other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.AbsorptionBase != 0L)
			{
				AbsorptionBase = other.AbsorptionBase;
			}
			if (other.ReferenceTarget != 0)
			{
				ReferenceTarget = other.ReferenceTarget;
			}
			if (other.ReferenceAttrib != 0)
			{
				ReferenceAttrib = other.ReferenceAttrib;
			}
			if (other.ReferenceScale != 0)
			{
				ReferenceScale = other.ReferenceScale;
			}
			if (other.Time != 0)
			{
				Time = other.Time;
			}
			if (other.ShieldLaminatedNum != 0)
			{
				ShieldLaminatedNum = other.ShieldLaminatedNum;
			}
			if (other.TimeSuperposition != 0)
			{
				TimeSuperposition = other.TimeSuperposition;
			}
			if (other.NotRemove)
			{
				NotRemove = other.NotRemove;
			}
			if (other.ReferenceLimit != 0L)
			{
				ReferenceLimit = other.ReferenceLimit;
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
			case 18u:
				Name = input.ReadString();
				break;
			case 24u:
				AbsorptionBase = input.ReadInt64();
				break;
			case 32u:
				ReferenceTarget = input.ReadInt32();
				break;
			case 40u:
				ReferenceAttrib = input.ReadInt32();
				break;
			case 48u:
				ReferenceScale = input.ReadInt32();
				break;
			case 56u:
				Time = input.ReadInt32();
				break;
			case 64u:
				ShieldLaminatedNum = input.ReadInt32();
				break;
			case 72u:
				TimeSuperposition = input.ReadInt32();
				break;
			case 80u:
				NotRemove = input.ReadBool();
				break;
			case 88u:
				ReferenceLimit = input.ReadInt64();
				break;
			}
		}
	}
}
