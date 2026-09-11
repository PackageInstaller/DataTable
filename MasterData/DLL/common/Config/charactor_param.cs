using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class charactor_param : IMessage<charactor_param>, IMessage, IEquatable<charactor_param>, IDeepCloneable<charactor_param>
{
	private static readonly MessageParser<charactor_param> _parser = new MessageParser<charactor_param>(() => new charactor_param());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int AttackRateFieldNumber = 2;

	private int attackRate_;

	public const int TargetDebuffArrayFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_targetDebuffArray_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> targetDebuffArray_ = new RepeatedField<int>();

	public const int BestDistanceFieldNumber = 4;

	private int bestDistance_;

	public const int ApproachDistanceFieldNumber = 5;

	private int approachDistance_;

	public const int NameFieldNumber = 6;

	private string name_ = "";

	public const int HeadIconFieldNumber = 7;

	private string headIcon_ = "";

	public const int EnergyTypeFieldNumber = 8;

	private int energyType_;

	public const int EnergyMaxValueFieldNumber = 9;

	private int energyMaxValue_;

	public const int MaxEnduranceValueFieldNumber = 10;

	private int maxEnduranceValue_;

	public const int ConsumeEnduranceValueFieldNumber = 11;

	private int consumeEnduranceValue_;

	public const int ResumeEnduranceSpeedFieldNumber = 12;

	private int resumeEnduranceSpeed_;

	public const int RaceIDFieldNumber = 13;

	private int raceID_;

	public const int UltimateAvoidCDFieldNumber = 14;

	private int ultimateAvoidCD_;

	public const int ItemPickUpRadiusFieldNumber = 15;

	private int itemPickUpRadius_;

	public const int UltimateAvoidSpaceTimeFieldNumber = 16;

	private int ultimateAvoidSpaceTime_;

	public const int RangeTypeFieldNumber = 17;

	private int rangeType_;

	public const int BeGatherValueFieldNumber = 18;

	private int beGatherValue_;

	public const int BreakValueRateFieldNumber = 19;

	private int breakValueRate_;

	[DebuggerNonUserCode]
	public static MessageParser<charactor_param> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[81];

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
	public int AttackRate
	{
		get
		{
			return attackRate_;
		}
		set
		{
			attackRate_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> TargetDebuffArray => targetDebuffArray_;

	[DebuggerNonUserCode]
	public int BestDistance
	{
		get
		{
			return bestDistance_;
		}
		set
		{
			bestDistance_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ApproachDistance
	{
		get
		{
			return approachDistance_;
		}
		set
		{
			approachDistance_ = value;
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
	public string HeadIcon
	{
		get
		{
			return headIcon_;
		}
		set
		{
			headIcon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int EnergyType
	{
		get
		{
			return energyType_;
		}
		set
		{
			energyType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EnergyMaxValue
	{
		get
		{
			return energyMaxValue_;
		}
		set
		{
			energyMaxValue_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MaxEnduranceValue
	{
		get
		{
			return maxEnduranceValue_;
		}
		set
		{
			maxEnduranceValue_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ConsumeEnduranceValue
	{
		get
		{
			return consumeEnduranceValue_;
		}
		set
		{
			consumeEnduranceValue_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ResumeEnduranceSpeed
	{
		get
		{
			return resumeEnduranceSpeed_;
		}
		set
		{
			resumeEnduranceSpeed_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RaceID
	{
		get
		{
			return raceID_;
		}
		set
		{
			raceID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int UltimateAvoidCD
	{
		get
		{
			return ultimateAvoidCD_;
		}
		set
		{
			ultimateAvoidCD_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ItemPickUpRadius
	{
		get
		{
			return itemPickUpRadius_;
		}
		set
		{
			itemPickUpRadius_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int UltimateAvoidSpaceTime
	{
		get
		{
			return ultimateAvoidSpaceTime_;
		}
		set
		{
			ultimateAvoidSpaceTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RangeType
	{
		get
		{
			return rangeType_;
		}
		set
		{
			rangeType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BeGatherValue
	{
		get
		{
			return beGatherValue_;
		}
		set
		{
			beGatherValue_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BreakValueRate
	{
		get
		{
			return breakValueRate_;
		}
		set
		{
			breakValueRate_ = value;
		}
	}

	[DebuggerNonUserCode]
	public charactor_param()
	{
	}

	[DebuggerNonUserCode]
	public charactor_param(charactor_param other)
		: this()
	{
		iD_ = other.iD_;
		attackRate_ = other.attackRate_;
		targetDebuffArray_ = other.targetDebuffArray_.Clone();
		bestDistance_ = other.bestDistance_;
		approachDistance_ = other.approachDistance_;
		name_ = other.name_;
		headIcon_ = other.headIcon_;
		energyType_ = other.energyType_;
		energyMaxValue_ = other.energyMaxValue_;
		maxEnduranceValue_ = other.maxEnduranceValue_;
		consumeEnduranceValue_ = other.consumeEnduranceValue_;
		resumeEnduranceSpeed_ = other.resumeEnduranceSpeed_;
		raceID_ = other.raceID_;
		ultimateAvoidCD_ = other.ultimateAvoidCD_;
		itemPickUpRadius_ = other.itemPickUpRadius_;
		ultimateAvoidSpaceTime_ = other.ultimateAvoidSpaceTime_;
		rangeType_ = other.rangeType_;
		beGatherValue_ = other.beGatherValue_;
		breakValueRate_ = other.breakValueRate_;
	}

	[DebuggerNonUserCode]
	public charactor_param Clone()
	{
		return new charactor_param(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as charactor_param);
	}

	[DebuggerNonUserCode]
	public bool Equals(charactor_param other)
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
		if (AttackRate != other.AttackRate)
		{
			return false;
		}
		if (!targetDebuffArray_.Equals(other.targetDebuffArray_))
		{
			return false;
		}
		if (BestDistance != other.BestDistance)
		{
			return false;
		}
		if (ApproachDistance != other.ApproachDistance)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (HeadIcon != other.HeadIcon)
		{
			return false;
		}
		if (EnergyType != other.EnergyType)
		{
			return false;
		}
		if (EnergyMaxValue != other.EnergyMaxValue)
		{
			return false;
		}
		if (MaxEnduranceValue != other.MaxEnduranceValue)
		{
			return false;
		}
		if (ConsumeEnduranceValue != other.ConsumeEnduranceValue)
		{
			return false;
		}
		if (ResumeEnduranceSpeed != other.ResumeEnduranceSpeed)
		{
			return false;
		}
		if (RaceID != other.RaceID)
		{
			return false;
		}
		if (UltimateAvoidCD != other.UltimateAvoidCD)
		{
			return false;
		}
		if (ItemPickUpRadius != other.ItemPickUpRadius)
		{
			return false;
		}
		if (UltimateAvoidSpaceTime != other.UltimateAvoidSpaceTime)
		{
			return false;
		}
		if (RangeType != other.RangeType)
		{
			return false;
		}
		if (BeGatherValue != other.BeGatherValue)
		{
			return false;
		}
		if (BreakValueRate != other.BreakValueRate)
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
		if (AttackRate != 0)
		{
			num ^= AttackRate.GetHashCode();
		}
		num ^= targetDebuffArray_.GetHashCode();
		if (BestDistance != 0)
		{
			num ^= BestDistance.GetHashCode();
		}
		if (ApproachDistance != 0)
		{
			num ^= ApproachDistance.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (HeadIcon.Length != 0)
		{
			num ^= HeadIcon.GetHashCode();
		}
		if (EnergyType != 0)
		{
			num ^= EnergyType.GetHashCode();
		}
		if (EnergyMaxValue != 0)
		{
			num ^= EnergyMaxValue.GetHashCode();
		}
		if (MaxEnduranceValue != 0)
		{
			num ^= MaxEnduranceValue.GetHashCode();
		}
		if (ConsumeEnduranceValue != 0)
		{
			num ^= ConsumeEnduranceValue.GetHashCode();
		}
		if (ResumeEnduranceSpeed != 0)
		{
			num ^= ResumeEnduranceSpeed.GetHashCode();
		}
		if (RaceID != 0)
		{
			num ^= RaceID.GetHashCode();
		}
		if (UltimateAvoidCD != 0)
		{
			num ^= UltimateAvoidCD.GetHashCode();
		}
		if (ItemPickUpRadius != 0)
		{
			num ^= ItemPickUpRadius.GetHashCode();
		}
		if (UltimateAvoidSpaceTime != 0)
		{
			num ^= UltimateAvoidSpaceTime.GetHashCode();
		}
		if (RangeType != 0)
		{
			num ^= RangeType.GetHashCode();
		}
		if (BeGatherValue != 0)
		{
			num ^= BeGatherValue.GetHashCode();
		}
		if (BreakValueRate != 0)
		{
			num ^= BreakValueRate.GetHashCode();
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
		if (AttackRate != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(AttackRate);
		}
		targetDebuffArray_.WriteTo(output, _repeated_targetDebuffArray_codec);
		if (BestDistance != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(BestDistance);
		}
		if (ApproachDistance != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(ApproachDistance);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Name);
		}
		if (HeadIcon.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(HeadIcon);
		}
		if (EnergyType != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(EnergyType);
		}
		if (EnergyMaxValue != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(EnergyMaxValue);
		}
		if (MaxEnduranceValue != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(MaxEnduranceValue);
		}
		if (ConsumeEnduranceValue != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(ConsumeEnduranceValue);
		}
		if (ResumeEnduranceSpeed != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(ResumeEnduranceSpeed);
		}
		if (RaceID != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(RaceID);
		}
		if (UltimateAvoidCD != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(UltimateAvoidCD);
		}
		if (ItemPickUpRadius != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(ItemPickUpRadius);
		}
		if (UltimateAvoidSpaceTime != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(UltimateAvoidSpaceTime);
		}
		if (RangeType != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(RangeType);
		}
		if (BeGatherValue != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(BeGatherValue);
		}
		if (BreakValueRate != 0)
		{
			output.WriteRawTag(152, 1);
			output.WriteInt32(BreakValueRate);
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
		if (AttackRate != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AttackRate);
		}
		num += targetDebuffArray_.CalculateSize(_repeated_targetDebuffArray_codec);
		if (BestDistance != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BestDistance);
		}
		if (ApproachDistance != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ApproachDistance);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (HeadIcon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(HeadIcon);
		}
		if (EnergyType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EnergyType);
		}
		if (EnergyMaxValue != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EnergyMaxValue);
		}
		if (MaxEnduranceValue != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MaxEnduranceValue);
		}
		if (ConsumeEnduranceValue != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ConsumeEnduranceValue);
		}
		if (ResumeEnduranceSpeed != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ResumeEnduranceSpeed);
		}
		if (RaceID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RaceID);
		}
		if (UltimateAvoidCD != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UltimateAvoidCD);
		}
		if (ItemPickUpRadius != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemPickUpRadius);
		}
		if (UltimateAvoidSpaceTime != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(UltimateAvoidSpaceTime);
		}
		if (RangeType != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RangeType);
		}
		if (BeGatherValue != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(BeGatherValue);
		}
		if (BreakValueRate != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(BreakValueRate);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(charactor_param other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.AttackRate != 0)
			{
				AttackRate = other.AttackRate;
			}
			targetDebuffArray_.Add(other.targetDebuffArray_);
			if (other.BestDistance != 0)
			{
				BestDistance = other.BestDistance;
			}
			if (other.ApproachDistance != 0)
			{
				ApproachDistance = other.ApproachDistance;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.HeadIcon.Length != 0)
			{
				HeadIcon = other.HeadIcon;
			}
			if (other.EnergyType != 0)
			{
				EnergyType = other.EnergyType;
			}
			if (other.EnergyMaxValue != 0)
			{
				EnergyMaxValue = other.EnergyMaxValue;
			}
			if (other.MaxEnduranceValue != 0)
			{
				MaxEnduranceValue = other.MaxEnduranceValue;
			}
			if (other.ConsumeEnduranceValue != 0)
			{
				ConsumeEnduranceValue = other.ConsumeEnduranceValue;
			}
			if (other.ResumeEnduranceSpeed != 0)
			{
				ResumeEnduranceSpeed = other.ResumeEnduranceSpeed;
			}
			if (other.RaceID != 0)
			{
				RaceID = other.RaceID;
			}
			if (other.UltimateAvoidCD != 0)
			{
				UltimateAvoidCD = other.UltimateAvoidCD;
			}
			if (other.ItemPickUpRadius != 0)
			{
				ItemPickUpRadius = other.ItemPickUpRadius;
			}
			if (other.UltimateAvoidSpaceTime != 0)
			{
				UltimateAvoidSpaceTime = other.UltimateAvoidSpaceTime;
			}
			if (other.RangeType != 0)
			{
				RangeType = other.RangeType;
			}
			if (other.BeGatherValue != 0)
			{
				BeGatherValue = other.BeGatherValue;
			}
			if (other.BreakValueRate != 0)
			{
				BreakValueRate = other.BreakValueRate;
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
				AttackRate = input.ReadInt32();
				break;
			case 24u:
			case 26u:
				targetDebuffArray_.AddEntriesFrom(input, _repeated_targetDebuffArray_codec);
				break;
			case 32u:
				BestDistance = input.ReadInt32();
				break;
			case 40u:
				ApproachDistance = input.ReadInt32();
				break;
			case 50u:
				Name = input.ReadString();
				break;
			case 58u:
				HeadIcon = input.ReadString();
				break;
			case 64u:
				EnergyType = input.ReadInt32();
				break;
			case 72u:
				EnergyMaxValue = input.ReadInt32();
				break;
			case 80u:
				MaxEnduranceValue = input.ReadInt32();
				break;
			case 88u:
				ConsumeEnduranceValue = input.ReadInt32();
				break;
			case 96u:
				ResumeEnduranceSpeed = input.ReadInt32();
				break;
			case 104u:
				RaceID = input.ReadInt32();
				break;
			case 112u:
				UltimateAvoidCD = input.ReadInt32();
				break;
			case 120u:
				ItemPickUpRadius = input.ReadInt32();
				break;
			case 128u:
				UltimateAvoidSpaceTime = input.ReadInt32();
				break;
			case 136u:
				RangeType = input.ReadInt32();
				break;
			case 144u:
				BeGatherValue = input.ReadInt32();
				break;
			case 152u:
				BreakValueRate = input.ReadInt32();
				break;
			}
		}
	}
}
