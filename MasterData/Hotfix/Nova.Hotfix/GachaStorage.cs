using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class GachaStorage : IMessage<GachaStorage>, IMessage, IEquatable<GachaStorage>, IDeepCloneable<GachaStorage>
{
	private static readonly MessageParser<GachaStorage> _parser = new MessageParser<GachaStorage>(() => new GachaStorage());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int DefaultIdFieldNumber = 3;

	private int defaultId_;

	public const int DefaultQtyFieldNumber = 4;

	private int defaultQty_;

	public const int CostIdFieldNumber = 5;

	private int costId_;

	public const int CostQtyFieldNumber = 6;

	private int costQty_;

	public const int OncePreferredFieldNumber = 7;

	private string oncePreferred_ = "";

	public const int TenTimesPreferredFieldNumber = 8;

	private string tenTimesPreferred_ = "";

	public const int GiveItemsFieldNumber = 9;

	private string giveItems_ = "";

	public const int ATypeGroupFieldNumber = 10;

	private int aTypeGroup_;

	public const int ATypeUpProbFieldNumber = 11;

	private int aTypeUpProb_;

	public const int ATypeUpShowProbFieldNumber = 12;

	private int aTypeUpShowProb_;

	public const int AUpGuaranteeTimesFieldNumber = 13;

	private int aUpGuaranteeTimes_;

	public const int BTypeProbFieldNumber = 14;

	private int bTypeProb_;

	public const int BTypeUpProbFieldNumber = 15;

	private int bTypeUpProb_;

	public const int BTypeUpShowProbFieldNumber = 16;

	private int bTypeUpShowProb_;

	public const int BTypeGuaranteeProbFieldNumber = 17;

	private int bTypeGuaranteeProb_;

	[DebuggerNonUserCode]
	public static MessageParser<GachaStorage> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(372);

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
	public int DefaultId
	{
		get
		{
			return defaultId_;
		}
		set
		{
			defaultId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DefaultQty
	{
		get
		{
			return defaultQty_;
		}
		set
		{
			defaultQty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CostId
	{
		get
		{
			return costId_;
		}
		set
		{
			costId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CostQty
	{
		get
		{
			return costQty_;
		}
		set
		{
			costQty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string OncePreferred
	{
		get
		{
			return oncePreferred_;
		}
		set
		{
			oncePreferred_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string TenTimesPreferred
	{
		get
		{
			return tenTimesPreferred_;
		}
		set
		{
			tenTimesPreferred_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string GiveItems
	{
		get
		{
			return giveItems_;
		}
		set
		{
			giveItems_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int ATypeGroup
	{
		get
		{
			return aTypeGroup_;
		}
		set
		{
			aTypeGroup_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ATypeUpProb
	{
		get
		{
			return aTypeUpProb_;
		}
		set
		{
			aTypeUpProb_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ATypeUpShowProb
	{
		get
		{
			return aTypeUpShowProb_;
		}
		set
		{
			aTypeUpShowProb_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AUpGuaranteeTimes
	{
		get
		{
			return aUpGuaranteeTimes_;
		}
		set
		{
			aUpGuaranteeTimes_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BTypeProb
	{
		get
		{
			return bTypeProb_;
		}
		set
		{
			bTypeProb_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BTypeUpProb
	{
		get
		{
			return bTypeUpProb_;
		}
		set
		{
			bTypeUpProb_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BTypeUpShowProb
	{
		get
		{
			return bTypeUpShowProb_;
		}
		set
		{
			bTypeUpShowProb_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BTypeGuaranteeProb
	{
		get
		{
			return bTypeGuaranteeProb_;
		}
		set
		{
			bTypeGuaranteeProb_ = value;
		}
	}

	[DebuggerNonUserCode]
	public GachaStorage()
	{
	}

	[DebuggerNonUserCode]
	public GachaStorage(GachaStorage other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		defaultId_ = other.defaultId_;
		defaultQty_ = other.defaultQty_;
		costId_ = other.costId_;
		costQty_ = other.costQty_;
		oncePreferred_ = other.oncePreferred_;
		tenTimesPreferred_ = other.tenTimesPreferred_;
		giveItems_ = other.giveItems_;
		aTypeGroup_ = other.aTypeGroup_;
		aTypeUpProb_ = other.aTypeUpProb_;
		aTypeUpShowProb_ = other.aTypeUpShowProb_;
		aUpGuaranteeTimes_ = other.aUpGuaranteeTimes_;
		bTypeProb_ = other.bTypeProb_;
		bTypeUpProb_ = other.bTypeUpProb_;
		bTypeUpShowProb_ = other.bTypeUpShowProb_;
		bTypeGuaranteeProb_ = other.bTypeGuaranteeProb_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public GachaStorage Clone()
	{
		return new GachaStorage(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as GachaStorage);
	}

	[DebuggerNonUserCode]
	public bool Equals(GachaStorage other)
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
		if (DefaultId != other.DefaultId)
		{
			return false;
		}
		if (DefaultQty != other.DefaultQty)
		{
			return false;
		}
		if (CostId != other.CostId)
		{
			return false;
		}
		if (CostQty != other.CostQty)
		{
			return false;
		}
		if (OncePreferred != other.OncePreferred)
		{
			return false;
		}
		if (TenTimesPreferred != other.TenTimesPreferred)
		{
			return false;
		}
		if (GiveItems != other.GiveItems)
		{
			return false;
		}
		if (ATypeGroup != other.ATypeGroup)
		{
			return false;
		}
		if (ATypeUpProb != other.ATypeUpProb)
		{
			return false;
		}
		if (ATypeUpShowProb != other.ATypeUpShowProb)
		{
			return false;
		}
		if (AUpGuaranteeTimes != other.AUpGuaranteeTimes)
		{
			return false;
		}
		if (BTypeProb != other.BTypeProb)
		{
			return false;
		}
		if (BTypeUpProb != other.BTypeUpProb)
		{
			return false;
		}
		if (BTypeUpShowProb != other.BTypeUpShowProb)
		{
			return false;
		}
		if (BTypeGuaranteeProb != other.BTypeGuaranteeProb)
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
		if (DefaultId != 0)
		{
			num ^= DefaultId.GetHashCode();
		}
		if (DefaultQty != 0)
		{
			num ^= DefaultQty.GetHashCode();
		}
		if (CostId != 0)
		{
			num ^= CostId.GetHashCode();
		}
		if (CostQty != 0)
		{
			num ^= CostQty.GetHashCode();
		}
		if (OncePreferred.Length != 0)
		{
			num ^= OncePreferred.GetHashCode();
		}
		if (TenTimesPreferred.Length != 0)
		{
			num ^= TenTimesPreferred.GetHashCode();
		}
		if (GiveItems.Length != 0)
		{
			num ^= GiveItems.GetHashCode();
		}
		if (ATypeGroup != 0)
		{
			num ^= ATypeGroup.GetHashCode();
		}
		if (ATypeUpProb != 0)
		{
			num ^= ATypeUpProb.GetHashCode();
		}
		if (ATypeUpShowProb != 0)
		{
			num ^= ATypeUpShowProb.GetHashCode();
		}
		if (AUpGuaranteeTimes != 0)
		{
			num ^= AUpGuaranteeTimes.GetHashCode();
		}
		if (BTypeProb != 0)
		{
			num ^= BTypeProb.GetHashCode();
		}
		if (BTypeUpProb != 0)
		{
			num ^= BTypeUpProb.GetHashCode();
		}
		if (BTypeUpShowProb != 0)
		{
			num ^= BTypeUpShowProb.GetHashCode();
		}
		if (BTypeGuaranteeProb != 0)
		{
			num ^= BTypeGuaranteeProb.GetHashCode();
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
		if (DefaultId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(DefaultId);
		}
		if (DefaultQty != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(DefaultQty);
		}
		if (CostId != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(CostId);
		}
		if (CostQty != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(CostQty);
		}
		if (OncePreferred.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(OncePreferred);
		}
		if (TenTimesPreferred.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(TenTimesPreferred);
		}
		if (GiveItems.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(GiveItems);
		}
		if (ATypeGroup != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(ATypeGroup);
		}
		if (ATypeUpProb != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(ATypeUpProb);
		}
		if (ATypeUpShowProb != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(ATypeUpShowProb);
		}
		if (AUpGuaranteeTimes != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(AUpGuaranteeTimes);
		}
		if (BTypeProb != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(BTypeProb);
		}
		if (BTypeUpProb != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(BTypeUpProb);
		}
		if (BTypeUpShowProb != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(BTypeUpShowProb);
		}
		if (BTypeGuaranteeProb != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(BTypeGuaranteeProb);
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
		if (DefaultId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DefaultId);
		}
		if (DefaultQty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DefaultQty);
		}
		if (CostId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CostId);
		}
		if (CostQty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CostQty);
		}
		if (OncePreferred.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(OncePreferred);
		}
		if (TenTimesPreferred.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(TenTimesPreferred);
		}
		if (GiveItems.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(GiveItems);
		}
		if (ATypeGroup != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ATypeGroup);
		}
		if (ATypeUpProb != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ATypeUpProb);
		}
		if (ATypeUpShowProb != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ATypeUpShowProb);
		}
		if (AUpGuaranteeTimes != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AUpGuaranteeTimes);
		}
		if (BTypeProb != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BTypeProb);
		}
		if (BTypeUpProb != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BTypeUpProb);
		}
		if (BTypeUpShowProb != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(BTypeUpShowProb);
		}
		if (BTypeGuaranteeProb != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(BTypeGuaranteeProb);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(GachaStorage other)
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
			if (other.DefaultId != 0)
			{
				DefaultId = other.DefaultId;
			}
			if (other.DefaultQty != 0)
			{
				DefaultQty = other.DefaultQty;
			}
			if (other.CostId != 0)
			{
				CostId = other.CostId;
			}
			if (other.CostQty != 0)
			{
				CostQty = other.CostQty;
			}
			if (other.OncePreferred.Length != 0)
			{
				OncePreferred = other.OncePreferred;
			}
			if (other.TenTimesPreferred.Length != 0)
			{
				TenTimesPreferred = other.TenTimesPreferred;
			}
			if (other.GiveItems.Length != 0)
			{
				GiveItems = other.GiveItems;
			}
			if (other.ATypeGroup != 0)
			{
				ATypeGroup = other.ATypeGroup;
			}
			if (other.ATypeUpProb != 0)
			{
				ATypeUpProb = other.ATypeUpProb;
			}
			if (other.ATypeUpShowProb != 0)
			{
				ATypeUpShowProb = other.ATypeUpShowProb;
			}
			if (other.AUpGuaranteeTimes != 0)
			{
				AUpGuaranteeTimes = other.AUpGuaranteeTimes;
			}
			if (other.BTypeProb != 0)
			{
				BTypeProb = other.BTypeProb;
			}
			if (other.BTypeUpProb != 0)
			{
				BTypeUpProb = other.BTypeUpProb;
			}
			if (other.BTypeUpShowProb != 0)
			{
				BTypeUpShowProb = other.BTypeUpShowProb;
			}
			if (other.BTypeGuaranteeProb != 0)
			{
				BTypeGuaranteeProb = other.BTypeGuaranteeProb;
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
				DefaultId = input.ReadInt32();
				break;
			case 32u:
				DefaultQty = input.ReadInt32();
				break;
			case 40u:
				CostId = input.ReadInt32();
				break;
			case 48u:
				CostQty = input.ReadInt32();
				break;
			case 58u:
				OncePreferred = input.ReadString();
				break;
			case 66u:
				TenTimesPreferred = input.ReadString();
				break;
			case 74u:
				GiveItems = input.ReadString();
				break;
			case 80u:
				ATypeGroup = input.ReadInt32();
				break;
			case 88u:
				ATypeUpProb = input.ReadInt32();
				break;
			case 96u:
				ATypeUpShowProb = input.ReadInt32();
				break;
			case 104u:
				AUpGuaranteeTimes = input.ReadInt32();
				break;
			case 112u:
				BTypeProb = input.ReadInt32();
				break;
			case 120u:
				BTypeUpProb = input.ReadInt32();
				break;
			case 128u:
				BTypeUpShowProb = input.ReadInt32();
				break;
			case 136u:
				BTypeGuaranteeProb = input.ReadInt32();
				break;
			}
		}
	}
}
