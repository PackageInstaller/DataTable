using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TowerDefenseCharacter : IMessage<TowerDefenseCharacter>, IMessage, IEquatable<TowerDefenseCharacter>, IDeepCloneable<TowerDefenseCharacter>
{
	private static readonly MessageParser<TowerDefenseCharacter> _parser = new MessageParser<TowerDefenseCharacter>(() => new TowerDefenseCharacter());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int SkinIdFieldNumber = 3;

	private int skinId_;

	public const int SearchTargetTypeFieldNumber = 4;

	private int searchTargetType_;

	public const int SearchRadiusFieldNumber = 5;

	private int searchRadius_;

	public const int SkillRadiusFieldNumber = 6;

	private int skillRadius_;

	public const int AIIdFieldNumber = 7;

	private int aIId_;

	public const int NewPotential2FieldNumber = 8;

	private static readonly FieldCodec<int> _repeated_newPotential2_codec = FieldCodec.ForInt32(66u);

	private readonly RepeatedField<int> newPotential2_ = new RepeatedField<int>();

	public const int NewPotential3FieldNumber = 9;

	private static readonly FieldCodec<int> _repeated_newPotential3_codec = FieldCodec.ForInt32(74u);

	private readonly RepeatedField<int> newPotential3_ = new RepeatedField<int>();

	public const int NewPotential4FieldNumber = 10;

	private static readonly FieldCodec<int> _repeated_newPotential4_codec = FieldCodec.ForInt32(82u);

	private readonly RepeatedField<int> newPotential4_ = new RepeatedField<int>();

	public const int NewPotential5FieldNumber = 11;

	private static readonly FieldCodec<int> _repeated_newPotential5_codec = FieldCodec.ForInt32(90u);

	private readonly RepeatedField<int> newPotential5_ = new RepeatedField<int>();

	public const int NewPotential6FieldNumber = 12;

	private static readonly FieldCodec<int> _repeated_newPotential6_codec = FieldCodec.ForInt32(98u);

	private readonly RepeatedField<int> newPotential6_ = new RepeatedField<int>();

	public const int PointNeededFieldNumber = 13;

	private static readonly FieldCodec<int> _repeated_pointNeeded_codec = FieldCodec.ForInt32(106u);

	private readonly RepeatedField<int> pointNeeded_ = new RepeatedField<int>();

	public const int FactionFieldNumber = 14;

	private int faction_;

	public const int NormalAtkIdFieldNumber = 15;

	private int normalAtkId_;

	public const int SkillIdFieldNumber = 16;

	private int skillId_;

	public const int SkillCdFieldNumber = 17;

	private int skillCd_;

	public const int SkillStartChargeFieldNumber = 18;

	private int skillStartCharge_;

	public const int CdStartTimeFieldNumber = 19;

	private bool cdStartTime_;

	public const int TempleteFieldNumber = 20;

	private int templete_;

	public const int IconFieldNumber = 21;

	private string icon_ = "";

	public const int IsShapeshifterFieldNumber = 22;

	private bool isShapeshifter_;

	[DebuggerNonUserCode]
	public static MessageParser<TowerDefenseCharacter> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(950);

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
	public int SkinId
	{
		get
		{
			return skinId_;
		}
		set
		{
			skinId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SearchTargetType
	{
		get
		{
			return searchTargetType_;
		}
		set
		{
			searchTargetType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SearchRadius
	{
		get
		{
			return searchRadius_;
		}
		set
		{
			searchRadius_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SkillRadius
	{
		get
		{
			return skillRadius_;
		}
		set
		{
			skillRadius_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AIId
	{
		get
		{
			return aIId_;
		}
		set
		{
			aIId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> NewPotential2 => newPotential2_;

	[DebuggerNonUserCode]
	public RepeatedField<int> NewPotential3 => newPotential3_;

	[DebuggerNonUserCode]
	public RepeatedField<int> NewPotential4 => newPotential4_;

	[DebuggerNonUserCode]
	public RepeatedField<int> NewPotential5 => newPotential5_;

	[DebuggerNonUserCode]
	public RepeatedField<int> NewPotential6 => newPotential6_;

	[DebuggerNonUserCode]
	public RepeatedField<int> PointNeeded => pointNeeded_;

	[DebuggerNonUserCode]
	public int Faction
	{
		get
		{
			return faction_;
		}
		set
		{
			faction_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int NormalAtkId
	{
		get
		{
			return normalAtkId_;
		}
		set
		{
			normalAtkId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SkillId
	{
		get
		{
			return skillId_;
		}
		set
		{
			skillId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SkillCd
	{
		get
		{
			return skillCd_;
		}
		set
		{
			skillCd_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SkillStartCharge
	{
		get
		{
			return skillStartCharge_;
		}
		set
		{
			skillStartCharge_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool CdStartTime
	{
		get
		{
			return cdStartTime_;
		}
		set
		{
			cdStartTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Templete
	{
		get
		{
			return templete_;
		}
		set
		{
			templete_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Icon
	{
		get
		{
			return icon_;
		}
		set
		{
			icon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public bool IsShapeshifter
	{
		get
		{
			return isShapeshifter_;
		}
		set
		{
			isShapeshifter_ = value;
		}
	}

	[DebuggerNonUserCode]
	public TowerDefenseCharacter()
	{
	}

	[DebuggerNonUserCode]
	public TowerDefenseCharacter(TowerDefenseCharacter other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		skinId_ = other.skinId_;
		searchTargetType_ = other.searchTargetType_;
		searchRadius_ = other.searchRadius_;
		skillRadius_ = other.skillRadius_;
		aIId_ = other.aIId_;
		newPotential2_ = other.newPotential2_.Clone();
		newPotential3_ = other.newPotential3_.Clone();
		newPotential4_ = other.newPotential4_.Clone();
		newPotential5_ = other.newPotential5_.Clone();
		newPotential6_ = other.newPotential6_.Clone();
		pointNeeded_ = other.pointNeeded_.Clone();
		faction_ = other.faction_;
		normalAtkId_ = other.normalAtkId_;
		skillId_ = other.skillId_;
		skillCd_ = other.skillCd_;
		skillStartCharge_ = other.skillStartCharge_;
		cdStartTime_ = other.cdStartTime_;
		templete_ = other.templete_;
		icon_ = other.icon_;
		isShapeshifter_ = other.isShapeshifter_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TowerDefenseCharacter Clone()
	{
		return new TowerDefenseCharacter(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TowerDefenseCharacter);
	}

	[DebuggerNonUserCode]
	public bool Equals(TowerDefenseCharacter other)
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
		if (SkinId != other.SkinId)
		{
			return false;
		}
		if (SearchTargetType != other.SearchTargetType)
		{
			return false;
		}
		if (SearchRadius != other.SearchRadius)
		{
			return false;
		}
		if (SkillRadius != other.SkillRadius)
		{
			return false;
		}
		if (AIId != other.AIId)
		{
			return false;
		}
		if (!newPotential2_.Equals(other.newPotential2_))
		{
			return false;
		}
		if (!newPotential3_.Equals(other.newPotential3_))
		{
			return false;
		}
		if (!newPotential4_.Equals(other.newPotential4_))
		{
			return false;
		}
		if (!newPotential5_.Equals(other.newPotential5_))
		{
			return false;
		}
		if (!newPotential6_.Equals(other.newPotential6_))
		{
			return false;
		}
		if (!pointNeeded_.Equals(other.pointNeeded_))
		{
			return false;
		}
		if (Faction != other.Faction)
		{
			return false;
		}
		if (NormalAtkId != other.NormalAtkId)
		{
			return false;
		}
		if (SkillId != other.SkillId)
		{
			return false;
		}
		if (SkillCd != other.SkillCd)
		{
			return false;
		}
		if (SkillStartCharge != other.SkillStartCharge)
		{
			return false;
		}
		if (CdStartTime != other.CdStartTime)
		{
			return false;
		}
		if (Templete != other.Templete)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (IsShapeshifter != other.IsShapeshifter)
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
		if (SkinId != 0)
		{
			num ^= SkinId.GetHashCode();
		}
		if (SearchTargetType != 0)
		{
			num ^= SearchTargetType.GetHashCode();
		}
		if (SearchRadius != 0)
		{
			num ^= SearchRadius.GetHashCode();
		}
		if (SkillRadius != 0)
		{
			num ^= SkillRadius.GetHashCode();
		}
		if (AIId != 0)
		{
			num ^= AIId.GetHashCode();
		}
		num ^= newPotential2_.GetHashCode();
		num ^= newPotential3_.GetHashCode();
		num ^= newPotential4_.GetHashCode();
		num ^= newPotential5_.GetHashCode();
		num ^= newPotential6_.GetHashCode();
		num ^= pointNeeded_.GetHashCode();
		if (Faction != 0)
		{
			num ^= Faction.GetHashCode();
		}
		if (NormalAtkId != 0)
		{
			num ^= NormalAtkId.GetHashCode();
		}
		if (SkillId != 0)
		{
			num ^= SkillId.GetHashCode();
		}
		if (SkillCd != 0)
		{
			num ^= SkillCd.GetHashCode();
		}
		if (SkillStartCharge != 0)
		{
			num ^= SkillStartCharge.GetHashCode();
		}
		if (CdStartTime)
		{
			num ^= CdStartTime.GetHashCode();
		}
		if (Templete != 0)
		{
			num ^= Templete.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (IsShapeshifter)
		{
			num ^= IsShapeshifter.GetHashCode();
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
		if (SkinId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(SkinId);
		}
		if (SearchTargetType != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(SearchTargetType);
		}
		if (SearchRadius != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(SearchRadius);
		}
		if (SkillRadius != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(SkillRadius);
		}
		if (AIId != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(AIId);
		}
		newPotential2_.WriteTo(output, _repeated_newPotential2_codec);
		newPotential3_.WriteTo(output, _repeated_newPotential3_codec);
		newPotential4_.WriteTo(output, _repeated_newPotential4_codec);
		newPotential5_.WriteTo(output, _repeated_newPotential5_codec);
		newPotential6_.WriteTo(output, _repeated_newPotential6_codec);
		pointNeeded_.WriteTo(output, _repeated_pointNeeded_codec);
		if (Faction != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(Faction);
		}
		if (NormalAtkId != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(NormalAtkId);
		}
		if (SkillId != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(SkillId);
		}
		if (SkillCd != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(SkillCd);
		}
		if (SkillStartCharge != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(SkillStartCharge);
		}
		if (CdStartTime)
		{
			output.WriteRawTag(152, 1);
			output.WriteBool(CdStartTime);
		}
		if (Templete != 0)
		{
			output.WriteRawTag(160, 1);
			output.WriteInt32(Templete);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(170, 1);
			output.WriteString(Icon);
		}
		if (IsShapeshifter)
		{
			output.WriteRawTag(176, 1);
			output.WriteBool(IsShapeshifter);
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
		if (SkinId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SkinId);
		}
		if (SearchTargetType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SearchTargetType);
		}
		if (SearchRadius != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SearchRadius);
		}
		if (SkillRadius != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SkillRadius);
		}
		if (AIId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AIId);
		}
		num += newPotential2_.CalculateSize(_repeated_newPotential2_codec);
		num += newPotential3_.CalculateSize(_repeated_newPotential3_codec);
		num += newPotential4_.CalculateSize(_repeated_newPotential4_codec);
		num += newPotential5_.CalculateSize(_repeated_newPotential5_codec);
		num += newPotential6_.CalculateSize(_repeated_newPotential6_codec);
		num += pointNeeded_.CalculateSize(_repeated_pointNeeded_codec);
		if (Faction != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Faction);
		}
		if (NormalAtkId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(NormalAtkId);
		}
		if (SkillId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SkillId);
		}
		if (SkillCd != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SkillCd);
		}
		if (SkillStartCharge != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SkillStartCharge);
		}
		if (CdStartTime)
		{
			num += 3;
		}
		if (Templete != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Templete);
		}
		if (Icon.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (IsShapeshifter)
		{
			num += 3;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TowerDefenseCharacter other)
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
			if (other.SkinId != 0)
			{
				SkinId = other.SkinId;
			}
			if (other.SearchTargetType != 0)
			{
				SearchTargetType = other.SearchTargetType;
			}
			if (other.SearchRadius != 0)
			{
				SearchRadius = other.SearchRadius;
			}
			if (other.SkillRadius != 0)
			{
				SkillRadius = other.SkillRadius;
			}
			if (other.AIId != 0)
			{
				AIId = other.AIId;
			}
			newPotential2_.Add(other.newPotential2_);
			newPotential3_.Add(other.newPotential3_);
			newPotential4_.Add(other.newPotential4_);
			newPotential5_.Add(other.newPotential5_);
			newPotential6_.Add(other.newPotential6_);
			pointNeeded_.Add(other.pointNeeded_);
			if (other.Faction != 0)
			{
				Faction = other.Faction;
			}
			if (other.NormalAtkId != 0)
			{
				NormalAtkId = other.NormalAtkId;
			}
			if (other.SkillId != 0)
			{
				SkillId = other.SkillId;
			}
			if (other.SkillCd != 0)
			{
				SkillCd = other.SkillCd;
			}
			if (other.SkillStartCharge != 0)
			{
				SkillStartCharge = other.SkillStartCharge;
			}
			if (other.CdStartTime)
			{
				CdStartTime = other.CdStartTime;
			}
			if (other.Templete != 0)
			{
				Templete = other.Templete;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.IsShapeshifter)
			{
				IsShapeshifter = other.IsShapeshifter;
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
				SkinId = input.ReadInt32();
				break;
			case 32u:
				SearchTargetType = input.ReadInt32();
				break;
			case 40u:
				SearchRadius = input.ReadInt32();
				break;
			case 48u:
				SkillRadius = input.ReadInt32();
				break;
			case 56u:
				AIId = input.ReadInt32();
				break;
			case 64u:
			case 66u:
				newPotential2_.AddEntriesFrom(input, _repeated_newPotential2_codec);
				break;
			case 72u:
			case 74u:
				newPotential3_.AddEntriesFrom(input, _repeated_newPotential3_codec);
				break;
			case 80u:
			case 82u:
				newPotential4_.AddEntriesFrom(input, _repeated_newPotential4_codec);
				break;
			case 88u:
			case 90u:
				newPotential5_.AddEntriesFrom(input, _repeated_newPotential5_codec);
				break;
			case 96u:
			case 98u:
				newPotential6_.AddEntriesFrom(input, _repeated_newPotential6_codec);
				break;
			case 104u:
			case 106u:
				pointNeeded_.AddEntriesFrom(input, _repeated_pointNeeded_codec);
				break;
			case 112u:
				Faction = input.ReadInt32();
				break;
			case 120u:
				NormalAtkId = input.ReadInt32();
				break;
			case 128u:
				SkillId = input.ReadInt32();
				break;
			case 136u:
				SkillCd = input.ReadInt32();
				break;
			case 144u:
				SkillStartCharge = input.ReadInt32();
				break;
			case 152u:
				CdStartTime = input.ReadBool();
				break;
			case 160u:
				Templete = input.ReadInt32();
				break;
			case 170u:
				Icon = input.ReadString();
				break;
			case 176u:
				IsShapeshifter = input.ReadBool();
				break;
			}
		}
	}
}
