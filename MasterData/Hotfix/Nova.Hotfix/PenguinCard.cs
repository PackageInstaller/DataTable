using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class PenguinCard : IMessage<PenguinCard>, IMessage, IEquatable<PenguinCard>, IDeepCloneable<PenguinCard>
{
	private static readonly MessageParser<PenguinCard> _parser = new MessageParser<PenguinCard>(() => new PenguinCard());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupIdFieldNumber = 2;

	private int groupId_;

	public const int TitleFieldNumber = 3;

	private string title_ = "";

	public const int DescFieldNumber = 4;

	private string desc_ = "";

	public const int RarityFieldNumber = 5;

	private int rarity_;

	public const int LevelFieldNumber = 6;

	private int level_;

	public const int MaxLevelFieldNumber = 7;

	private int maxLevel_;

	public const int TendencyGroupFieldNumber = 8;

	private int tendencyGroup_;

	public const int TendencyScoreFieldNumber = 9;

	private int tendencyScore_;

	public const int SoldPriceFieldNumber = 10;

	private int soldPrice_;

	public const int TriggerPhaseFieldNumber = 11;

	private int triggerPhase_;

	public const int TriggerTypeFieldNumber = 12;

	private int triggerType_;

	public const int TriggerParamFieldNumber = 13;

	private string triggerParam_ = "";

	public const int TriggerProbabilityFieldNumber = 14;

	private int triggerProbability_;

	public const int TriggerLimitFieldNumber = 15;

	private int triggerLimit_;

	public const int TriggerLimitParamFieldNumber = 16;

	private static readonly FieldCodec<int> _repeated_triggerLimitParam_codec = FieldCodec.ForInt32(130u);

	private readonly RepeatedField<int> triggerLimitParam_ = new RepeatedField<int>();

	public const int GrowthTypeFieldNumber = 17;

	private int growthType_;

	public const int UpgradeResetGrowthFieldNumber = 18;

	private bool upgradeResetGrowth_;

	public const int GrowthTriggerPhaseFieldNumber = 19;

	private int growthTriggerPhase_;

	public const int GrowthTriggerTypeFieldNumber = 20;

	private int growthTriggerType_;

	public const int GrowthTriggerParamFieldNumber = 21;

	private string growthTriggerParam_ = "";

	public const int GrowthEffectParamFieldNumber = 22;

	private string growthEffectParam_ = "";

	public const int GrowthLimitFieldNumber = 23;

	private int growthLimit_;

	public const int EffectTypeFieldNumber = 24;

	private int effectType_;

	public const int EffectParamFieldNumber = 25;

	private string effectParam_ = "";

	public const int IconFieldNumber = 26;

	private string icon_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<PenguinCard> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(614);

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
	public int GroupId
	{
		get
		{
			return groupId_;
		}
		set
		{
			groupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Title
	{
		get
		{
			return title_;
		}
		set
		{
			title_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Desc
	{
		get
		{
			return desc_;
		}
		set
		{
			desc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Rarity
	{
		get
		{
			return rarity_;
		}
		set
		{
			rarity_ = value;
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
	public int MaxLevel
	{
		get
		{
			return maxLevel_;
		}
		set
		{
			maxLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TendencyGroup
	{
		get
		{
			return tendencyGroup_;
		}
		set
		{
			tendencyGroup_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TendencyScore
	{
		get
		{
			return tendencyScore_;
		}
		set
		{
			tendencyScore_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SoldPrice
	{
		get
		{
			return soldPrice_;
		}
		set
		{
			soldPrice_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TriggerPhase
	{
		get
		{
			return triggerPhase_;
		}
		set
		{
			triggerPhase_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TriggerType
	{
		get
		{
			return triggerType_;
		}
		set
		{
			triggerType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string TriggerParam
	{
		get
		{
			return triggerParam_;
		}
		set
		{
			triggerParam_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int TriggerProbability
	{
		get
		{
			return triggerProbability_;
		}
		set
		{
			triggerProbability_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TriggerLimit
	{
		get
		{
			return triggerLimit_;
		}
		set
		{
			triggerLimit_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> TriggerLimitParam => triggerLimitParam_;

	[DebuggerNonUserCode]
	public int GrowthType
	{
		get
		{
			return growthType_;
		}
		set
		{
			growthType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool UpgradeResetGrowth
	{
		get
		{
			return upgradeResetGrowth_;
		}
		set
		{
			upgradeResetGrowth_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int GrowthTriggerPhase
	{
		get
		{
			return growthTriggerPhase_;
		}
		set
		{
			growthTriggerPhase_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int GrowthTriggerType
	{
		get
		{
			return growthTriggerType_;
		}
		set
		{
			growthTriggerType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string GrowthTriggerParam
	{
		get
		{
			return growthTriggerParam_;
		}
		set
		{
			growthTriggerParam_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string GrowthEffectParam
	{
		get
		{
			return growthEffectParam_;
		}
		set
		{
			growthEffectParam_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int GrowthLimit
	{
		get
		{
			return growthLimit_;
		}
		set
		{
			growthLimit_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EffectType
	{
		get
		{
			return effectType_;
		}
		set
		{
			effectType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string EffectParam
	{
		get
		{
			return effectParam_;
		}
		set
		{
			effectParam_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public PenguinCard()
	{
	}

	[DebuggerNonUserCode]
	public PenguinCard(PenguinCard other)
		: this()
	{
		id_ = other.id_;
		groupId_ = other.groupId_;
		title_ = other.title_;
		desc_ = other.desc_;
		rarity_ = other.rarity_;
		level_ = other.level_;
		maxLevel_ = other.maxLevel_;
		tendencyGroup_ = other.tendencyGroup_;
		tendencyScore_ = other.tendencyScore_;
		soldPrice_ = other.soldPrice_;
		triggerPhase_ = other.triggerPhase_;
		triggerType_ = other.triggerType_;
		triggerParam_ = other.triggerParam_;
		triggerProbability_ = other.triggerProbability_;
		triggerLimit_ = other.triggerLimit_;
		triggerLimitParam_ = other.triggerLimitParam_.Clone();
		growthType_ = other.growthType_;
		upgradeResetGrowth_ = other.upgradeResetGrowth_;
		growthTriggerPhase_ = other.growthTriggerPhase_;
		growthTriggerType_ = other.growthTriggerType_;
		growthTriggerParam_ = other.growthTriggerParam_;
		growthEffectParam_ = other.growthEffectParam_;
		growthLimit_ = other.growthLimit_;
		effectType_ = other.effectType_;
		effectParam_ = other.effectParam_;
		icon_ = other.icon_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public PenguinCard Clone()
	{
		return new PenguinCard(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as PenguinCard);
	}

	[DebuggerNonUserCode]
	public bool Equals(PenguinCard other)
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
		if (GroupId != other.GroupId)
		{
			return false;
		}
		if (Title != other.Title)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (Rarity != other.Rarity)
		{
			return false;
		}
		if (Level != other.Level)
		{
			return false;
		}
		if (MaxLevel != other.MaxLevel)
		{
			return false;
		}
		if (TendencyGroup != other.TendencyGroup)
		{
			return false;
		}
		if (TendencyScore != other.TendencyScore)
		{
			return false;
		}
		if (SoldPrice != other.SoldPrice)
		{
			return false;
		}
		if (TriggerPhase != other.TriggerPhase)
		{
			return false;
		}
		if (TriggerType != other.TriggerType)
		{
			return false;
		}
		if (TriggerParam != other.TriggerParam)
		{
			return false;
		}
		if (TriggerProbability != other.TriggerProbability)
		{
			return false;
		}
		if (TriggerLimit != other.TriggerLimit)
		{
			return false;
		}
		if (!triggerLimitParam_.Equals(other.triggerLimitParam_))
		{
			return false;
		}
		if (GrowthType != other.GrowthType)
		{
			return false;
		}
		if (UpgradeResetGrowth != other.UpgradeResetGrowth)
		{
			return false;
		}
		if (GrowthTriggerPhase != other.GrowthTriggerPhase)
		{
			return false;
		}
		if (GrowthTriggerType != other.GrowthTriggerType)
		{
			return false;
		}
		if (GrowthTriggerParam != other.GrowthTriggerParam)
		{
			return false;
		}
		if (GrowthEffectParam != other.GrowthEffectParam)
		{
			return false;
		}
		if (GrowthLimit != other.GrowthLimit)
		{
			return false;
		}
		if (EffectType != other.EffectType)
		{
			return false;
		}
		if (EffectParam != other.EffectParam)
		{
			return false;
		}
		if (Icon != other.Icon)
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
		if (GroupId != 0)
		{
			num ^= GroupId.GetHashCode();
		}
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (Rarity != 0)
		{
			num ^= Rarity.GetHashCode();
		}
		if (Level != 0)
		{
			num ^= Level.GetHashCode();
		}
		if (MaxLevel != 0)
		{
			num ^= MaxLevel.GetHashCode();
		}
		if (TendencyGroup != 0)
		{
			num ^= TendencyGroup.GetHashCode();
		}
		if (TendencyScore != 0)
		{
			num ^= TendencyScore.GetHashCode();
		}
		if (SoldPrice != 0)
		{
			num ^= SoldPrice.GetHashCode();
		}
		if (TriggerPhase != 0)
		{
			num ^= TriggerPhase.GetHashCode();
		}
		if (TriggerType != 0)
		{
			num ^= TriggerType.GetHashCode();
		}
		if (TriggerParam.Length != 0)
		{
			num ^= TriggerParam.GetHashCode();
		}
		if (TriggerProbability != 0)
		{
			num ^= TriggerProbability.GetHashCode();
		}
		if (TriggerLimit != 0)
		{
			num ^= TriggerLimit.GetHashCode();
		}
		num ^= triggerLimitParam_.GetHashCode();
		if (GrowthType != 0)
		{
			num ^= GrowthType.GetHashCode();
		}
		if (UpgradeResetGrowth)
		{
			num ^= UpgradeResetGrowth.GetHashCode();
		}
		if (GrowthTriggerPhase != 0)
		{
			num ^= GrowthTriggerPhase.GetHashCode();
		}
		if (GrowthTriggerType != 0)
		{
			num ^= GrowthTriggerType.GetHashCode();
		}
		if (GrowthTriggerParam.Length != 0)
		{
			num ^= GrowthTriggerParam.GetHashCode();
		}
		if (GrowthEffectParam.Length != 0)
		{
			num ^= GrowthEffectParam.GetHashCode();
		}
		if (GrowthLimit != 0)
		{
			num ^= GrowthLimit.GetHashCode();
		}
		if (EffectType != 0)
		{
			num ^= EffectType.GetHashCode();
		}
		if (EffectParam.Length != 0)
		{
			num ^= EffectParam.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
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
		if (GroupId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(GroupId);
		}
		if (Title.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Title);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Desc);
		}
		if (Rarity != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Rarity);
		}
		if (Level != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Level);
		}
		if (MaxLevel != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(MaxLevel);
		}
		if (TendencyGroup != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(TendencyGroup);
		}
		if (TendencyScore != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(TendencyScore);
		}
		if (SoldPrice != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(SoldPrice);
		}
		if (TriggerPhase != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(TriggerPhase);
		}
		if (TriggerType != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(TriggerType);
		}
		if (TriggerParam.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(TriggerParam);
		}
		if (TriggerProbability != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(TriggerProbability);
		}
		if (TriggerLimit != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(TriggerLimit);
		}
		triggerLimitParam_.WriteTo(output, _repeated_triggerLimitParam_codec);
		if (GrowthType != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(GrowthType);
		}
		if (UpgradeResetGrowth)
		{
			output.WriteRawTag(144, 1);
			output.WriteBool(UpgradeResetGrowth);
		}
		if (GrowthTriggerPhase != 0)
		{
			output.WriteRawTag(152, 1);
			output.WriteInt32(GrowthTriggerPhase);
		}
		if (GrowthTriggerType != 0)
		{
			output.WriteRawTag(160, 1);
			output.WriteInt32(GrowthTriggerType);
		}
		if (GrowthTriggerParam.Length != 0)
		{
			output.WriteRawTag(170, 1);
			output.WriteString(GrowthTriggerParam);
		}
		if (GrowthEffectParam.Length != 0)
		{
			output.WriteRawTag(178, 1);
			output.WriteString(GrowthEffectParam);
		}
		if (GrowthLimit != 0)
		{
			output.WriteRawTag(184, 1);
			output.WriteInt32(GrowthLimit);
		}
		if (EffectType != 0)
		{
			output.WriteRawTag(192, 1);
			output.WriteInt32(EffectType);
		}
		if (EffectParam.Length != 0)
		{
			output.WriteRawTag(202, 1);
			output.WriteString(EffectParam);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(210, 1);
			output.WriteString(Icon);
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
		if (GroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GroupId);
		}
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (Rarity != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Rarity);
		}
		if (Level != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Level);
		}
		if (MaxLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MaxLevel);
		}
		if (TendencyGroup != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TendencyGroup);
		}
		if (TendencyScore != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TendencyScore);
		}
		if (SoldPrice != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SoldPrice);
		}
		if (TriggerPhase != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TriggerPhase);
		}
		if (TriggerType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TriggerType);
		}
		if (TriggerParam.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(TriggerParam);
		}
		if (TriggerProbability != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TriggerProbability);
		}
		if (TriggerLimit != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TriggerLimit);
		}
		num += triggerLimitParam_.CalculateSize(_repeated_triggerLimitParam_codec);
		if (GrowthType != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(GrowthType);
		}
		if (UpgradeResetGrowth)
		{
			num += 3;
		}
		if (GrowthTriggerPhase != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(GrowthTriggerPhase);
		}
		if (GrowthTriggerType != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(GrowthTriggerType);
		}
		if (GrowthTriggerParam.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(GrowthTriggerParam);
		}
		if (GrowthEffectParam.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(GrowthEffectParam);
		}
		if (GrowthLimit != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(GrowthLimit);
		}
		if (EffectType != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(EffectType);
		}
		if (EffectParam.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(EffectParam);
		}
		if (Icon.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(PenguinCard other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.GroupId != 0)
			{
				GroupId = other.GroupId;
			}
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.Rarity != 0)
			{
				Rarity = other.Rarity;
			}
			if (other.Level != 0)
			{
				Level = other.Level;
			}
			if (other.MaxLevel != 0)
			{
				MaxLevel = other.MaxLevel;
			}
			if (other.TendencyGroup != 0)
			{
				TendencyGroup = other.TendencyGroup;
			}
			if (other.TendencyScore != 0)
			{
				TendencyScore = other.TendencyScore;
			}
			if (other.SoldPrice != 0)
			{
				SoldPrice = other.SoldPrice;
			}
			if (other.TriggerPhase != 0)
			{
				TriggerPhase = other.TriggerPhase;
			}
			if (other.TriggerType != 0)
			{
				TriggerType = other.TriggerType;
			}
			if (other.TriggerParam.Length != 0)
			{
				TriggerParam = other.TriggerParam;
			}
			if (other.TriggerProbability != 0)
			{
				TriggerProbability = other.TriggerProbability;
			}
			if (other.TriggerLimit != 0)
			{
				TriggerLimit = other.TriggerLimit;
			}
			triggerLimitParam_.Add(other.triggerLimitParam_);
			if (other.GrowthType != 0)
			{
				GrowthType = other.GrowthType;
			}
			if (other.UpgradeResetGrowth)
			{
				UpgradeResetGrowth = other.UpgradeResetGrowth;
			}
			if (other.GrowthTriggerPhase != 0)
			{
				GrowthTriggerPhase = other.GrowthTriggerPhase;
			}
			if (other.GrowthTriggerType != 0)
			{
				GrowthTriggerType = other.GrowthTriggerType;
			}
			if (other.GrowthTriggerParam.Length != 0)
			{
				GrowthTriggerParam = other.GrowthTriggerParam;
			}
			if (other.GrowthEffectParam.Length != 0)
			{
				GrowthEffectParam = other.GrowthEffectParam;
			}
			if (other.GrowthLimit != 0)
			{
				GrowthLimit = other.GrowthLimit;
			}
			if (other.EffectType != 0)
			{
				EffectType = other.EffectType;
			}
			if (other.EffectParam.Length != 0)
			{
				EffectParam = other.EffectParam;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
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
				GroupId = input.ReadInt32();
				break;
			case 26u:
				Title = input.ReadString();
				break;
			case 34u:
				Desc = input.ReadString();
				break;
			case 40u:
				Rarity = input.ReadInt32();
				break;
			case 48u:
				Level = input.ReadInt32();
				break;
			case 56u:
				MaxLevel = input.ReadInt32();
				break;
			case 64u:
				TendencyGroup = input.ReadInt32();
				break;
			case 72u:
				TendencyScore = input.ReadInt32();
				break;
			case 80u:
				SoldPrice = input.ReadInt32();
				break;
			case 88u:
				TriggerPhase = input.ReadInt32();
				break;
			case 96u:
				TriggerType = input.ReadInt32();
				break;
			case 106u:
				TriggerParam = input.ReadString();
				break;
			case 112u:
				TriggerProbability = input.ReadInt32();
				break;
			case 120u:
				TriggerLimit = input.ReadInt32();
				break;
			case 128u:
			case 130u:
				triggerLimitParam_.AddEntriesFrom(input, _repeated_triggerLimitParam_codec);
				break;
			case 136u:
				GrowthType = input.ReadInt32();
				break;
			case 144u:
				UpgradeResetGrowth = input.ReadBool();
				break;
			case 152u:
				GrowthTriggerPhase = input.ReadInt32();
				break;
			case 160u:
				GrowthTriggerType = input.ReadInt32();
				break;
			case 170u:
				GrowthTriggerParam = input.ReadString();
				break;
			case 178u:
				GrowthEffectParam = input.ReadString();
				break;
			case 184u:
				GrowthLimit = input.ReadInt32();
				break;
			case 192u:
				EffectType = input.ReadInt32();
				break;
			case 202u:
				EffectParam = input.ReadString();
				break;
			case 210u:
				Icon = input.ReadString();
				break;
			}
		}
	}
}
