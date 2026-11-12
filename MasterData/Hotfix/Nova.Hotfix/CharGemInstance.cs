using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class CharGemInstance : IMessage<CharGemInstance>, IMessage, IEquatable<CharGemInstance>, IDeepCloneable<CharGemInstance>
{
	private static readonly MessageParser<CharGemInstance> _parser = new MessageParser<CharGemInstance>(() => new CharGemInstance());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TypeFieldNumber = 2;

	private int type_;

	public const int DifficultyFieldNumber = 3;

	private int difficulty_;

	public const int NameFieldNumber = 4;

	private string name_ = "";

	public const int DescFieldNumber = 5;

	private string desc_ = "";

	public const int SuggestedPowerFieldNumber = 6;

	private int suggestedPower_;

	public const int SuggestedBuildFieldNumber = 7;

	private int suggestedBuild_;

	public const int PreLevelIdFieldNumber = 8;

	private int preLevelId_;

	public const int PreLevelStarFieldNumber = 9;

	private int preLevelStar_;

	public const int NeedWorldClassFieldNumber = 10;

	private int needWorldClass_;

	public const int NeedRoguelikeFieldNumber = 11;

	private int needRoguelike_;

	public const int FloorIdFieldNumber = 12;

	private int floorId_;

	public const int PreviewMonsterGroupIdFieldNumber = 13;

	private int previewMonsterGroupId_;

	public const int OneStarConditionFieldNumber = 14;

	private string oneStarCondition_ = "";

	public const int TwoStarConditionFieldNumber = 15;

	private string twoStarCondition_ = "";

	public const int ThreeStarConditionFieldNumber = 16;

	private string threeStarCondition_ = "";

	public const int RoundTableDropIdFieldNumber = 17;

	private int roundTableDropId_;

	public const int RoundTableGuaranteeFieldNumber = 18;

	private string roundTableGuarantee_ = "";

	public const int SequentialDropIdFieldNumber = 19;

	private int sequentialDropId_;

	public const int SequentialGuaranteeFieldNumber = 20;

	private string sequentialGuarantee_ = "";

	public const int DropIdFieldNumber = 21;

	private int dropId_;

	public const int DropGuaranteeTypeFieldNumber = 22;

	private int dropGuaranteeType_;

	public const int EnergyConsumeFieldNumber = 23;

	private int energyConsume_;

	public const int BaseAwardPreviewFieldNumber = 24;

	private string baseAwardPreview_ = "";

	public const int FirstRewardPreviewFieldNumber = 25;

	private static readonly FieldCodec<int> _repeated_firstRewardPreview_codec = FieldCodec.ForInt32(202u);

	private readonly RepeatedField<int> firstRewardPreview_ = new RepeatedField<int>();

	public const int ExtraDropPreviewFieldNumber = 26;

	private static readonly FieldCodec<int> _repeated_extraDropPreview_codec = FieldCodec.ForInt32(210u);

	private readonly RepeatedField<int> extraDropPreview_ = new RepeatedField<int>();

	public const int IconFieldNumber = 27;

	private string icon_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<CharGemInstance> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(190);

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
	public int Type
	{
		get
		{
			return type_;
		}
		set
		{
			type_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Difficulty
	{
		get
		{
			return difficulty_;
		}
		set
		{
			difficulty_ = value;
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
	public int SuggestedPower
	{
		get
		{
			return suggestedPower_;
		}
		set
		{
			suggestedPower_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SuggestedBuild
	{
		get
		{
			return suggestedBuild_;
		}
		set
		{
			suggestedBuild_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int PreLevelId
	{
		get
		{
			return preLevelId_;
		}
		set
		{
			preLevelId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int PreLevelStar
	{
		get
		{
			return preLevelStar_;
		}
		set
		{
			preLevelStar_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int NeedWorldClass
	{
		get
		{
			return needWorldClass_;
		}
		set
		{
			needWorldClass_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int NeedRoguelike
	{
		get
		{
			return needRoguelike_;
		}
		set
		{
			needRoguelike_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FloorId
	{
		get
		{
			return floorId_;
		}
		set
		{
			floorId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int PreviewMonsterGroupId
	{
		get
		{
			return previewMonsterGroupId_;
		}
		set
		{
			previewMonsterGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string OneStarCondition
	{
		get
		{
			return oneStarCondition_;
		}
		set
		{
			oneStarCondition_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string TwoStarCondition
	{
		get
		{
			return twoStarCondition_;
		}
		set
		{
			twoStarCondition_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string ThreeStarCondition
	{
		get
		{
			return threeStarCondition_;
		}
		set
		{
			threeStarCondition_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int RoundTableDropId
	{
		get
		{
			return roundTableDropId_;
		}
		set
		{
			roundTableDropId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string RoundTableGuarantee
	{
		get
		{
			return roundTableGuarantee_;
		}
		set
		{
			roundTableGuarantee_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int SequentialDropId
	{
		get
		{
			return sequentialDropId_;
		}
		set
		{
			sequentialDropId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string SequentialGuarantee
	{
		get
		{
			return sequentialGuarantee_;
		}
		set
		{
			sequentialGuarantee_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int DropId
	{
		get
		{
			return dropId_;
		}
		set
		{
			dropId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DropGuaranteeType
	{
		get
		{
			return dropGuaranteeType_;
		}
		set
		{
			dropGuaranteeType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EnergyConsume
	{
		get
		{
			return energyConsume_;
		}
		set
		{
			energyConsume_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string BaseAwardPreview
	{
		get
		{
			return baseAwardPreview_;
		}
		set
		{
			baseAwardPreview_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> FirstRewardPreview => firstRewardPreview_;

	[DebuggerNonUserCode]
	public RepeatedField<int> ExtraDropPreview => extraDropPreview_;

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
	public CharGemInstance()
	{
	}

	[DebuggerNonUserCode]
	public CharGemInstance(CharGemInstance other)
		: this()
	{
		id_ = other.id_;
		type_ = other.type_;
		difficulty_ = other.difficulty_;
		name_ = other.name_;
		desc_ = other.desc_;
		suggestedPower_ = other.suggestedPower_;
		suggestedBuild_ = other.suggestedBuild_;
		preLevelId_ = other.preLevelId_;
		preLevelStar_ = other.preLevelStar_;
		needWorldClass_ = other.needWorldClass_;
		needRoguelike_ = other.needRoguelike_;
		floorId_ = other.floorId_;
		previewMonsterGroupId_ = other.previewMonsterGroupId_;
		oneStarCondition_ = other.oneStarCondition_;
		twoStarCondition_ = other.twoStarCondition_;
		threeStarCondition_ = other.threeStarCondition_;
		roundTableDropId_ = other.roundTableDropId_;
		roundTableGuarantee_ = other.roundTableGuarantee_;
		sequentialDropId_ = other.sequentialDropId_;
		sequentialGuarantee_ = other.sequentialGuarantee_;
		dropId_ = other.dropId_;
		dropGuaranteeType_ = other.dropGuaranteeType_;
		energyConsume_ = other.energyConsume_;
		baseAwardPreview_ = other.baseAwardPreview_;
		firstRewardPreview_ = other.firstRewardPreview_.Clone();
		extraDropPreview_ = other.extraDropPreview_.Clone();
		icon_ = other.icon_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public CharGemInstance Clone()
	{
		return new CharGemInstance(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as CharGemInstance);
	}

	[DebuggerNonUserCode]
	public bool Equals(CharGemInstance other)
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
		if (Type != other.Type)
		{
			return false;
		}
		if (Difficulty != other.Difficulty)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (SuggestedPower != other.SuggestedPower)
		{
			return false;
		}
		if (SuggestedBuild != other.SuggestedBuild)
		{
			return false;
		}
		if (PreLevelId != other.PreLevelId)
		{
			return false;
		}
		if (PreLevelStar != other.PreLevelStar)
		{
			return false;
		}
		if (NeedWorldClass != other.NeedWorldClass)
		{
			return false;
		}
		if (NeedRoguelike != other.NeedRoguelike)
		{
			return false;
		}
		if (FloorId != other.FloorId)
		{
			return false;
		}
		if (PreviewMonsterGroupId != other.PreviewMonsterGroupId)
		{
			return false;
		}
		if (OneStarCondition != other.OneStarCondition)
		{
			return false;
		}
		if (TwoStarCondition != other.TwoStarCondition)
		{
			return false;
		}
		if (ThreeStarCondition != other.ThreeStarCondition)
		{
			return false;
		}
		if (RoundTableDropId != other.RoundTableDropId)
		{
			return false;
		}
		if (RoundTableGuarantee != other.RoundTableGuarantee)
		{
			return false;
		}
		if (SequentialDropId != other.SequentialDropId)
		{
			return false;
		}
		if (SequentialGuarantee != other.SequentialGuarantee)
		{
			return false;
		}
		if (DropId != other.DropId)
		{
			return false;
		}
		if (DropGuaranteeType != other.DropGuaranteeType)
		{
			return false;
		}
		if (EnergyConsume != other.EnergyConsume)
		{
			return false;
		}
		if (BaseAwardPreview != other.BaseAwardPreview)
		{
			return false;
		}
		if (!firstRewardPreview_.Equals(other.firstRewardPreview_))
		{
			return false;
		}
		if (!extraDropPreview_.Equals(other.extraDropPreview_))
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
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (Difficulty != 0)
		{
			num ^= Difficulty.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (SuggestedPower != 0)
		{
			num ^= SuggestedPower.GetHashCode();
		}
		if (SuggestedBuild != 0)
		{
			num ^= SuggestedBuild.GetHashCode();
		}
		if (PreLevelId != 0)
		{
			num ^= PreLevelId.GetHashCode();
		}
		if (PreLevelStar != 0)
		{
			num ^= PreLevelStar.GetHashCode();
		}
		if (NeedWorldClass != 0)
		{
			num ^= NeedWorldClass.GetHashCode();
		}
		if (NeedRoguelike != 0)
		{
			num ^= NeedRoguelike.GetHashCode();
		}
		if (FloorId != 0)
		{
			num ^= FloorId.GetHashCode();
		}
		if (PreviewMonsterGroupId != 0)
		{
			num ^= PreviewMonsterGroupId.GetHashCode();
		}
		if (OneStarCondition.Length != 0)
		{
			num ^= OneStarCondition.GetHashCode();
		}
		if (TwoStarCondition.Length != 0)
		{
			num ^= TwoStarCondition.GetHashCode();
		}
		if (ThreeStarCondition.Length != 0)
		{
			num ^= ThreeStarCondition.GetHashCode();
		}
		if (RoundTableDropId != 0)
		{
			num ^= RoundTableDropId.GetHashCode();
		}
		if (RoundTableGuarantee.Length != 0)
		{
			num ^= RoundTableGuarantee.GetHashCode();
		}
		if (SequentialDropId != 0)
		{
			num ^= SequentialDropId.GetHashCode();
		}
		if (SequentialGuarantee.Length != 0)
		{
			num ^= SequentialGuarantee.GetHashCode();
		}
		if (DropId != 0)
		{
			num ^= DropId.GetHashCode();
		}
		if (DropGuaranteeType != 0)
		{
			num ^= DropGuaranteeType.GetHashCode();
		}
		if (EnergyConsume != 0)
		{
			num ^= EnergyConsume.GetHashCode();
		}
		if (BaseAwardPreview.Length != 0)
		{
			num ^= BaseAwardPreview.GetHashCode();
		}
		num ^= firstRewardPreview_.GetHashCode();
		num ^= extraDropPreview_.GetHashCode();
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
		if (Type != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Type);
		}
		if (Difficulty != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Difficulty);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Name);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Desc);
		}
		if (SuggestedPower != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(SuggestedPower);
		}
		if (SuggestedBuild != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(SuggestedBuild);
		}
		if (PreLevelId != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(PreLevelId);
		}
		if (PreLevelStar != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(PreLevelStar);
		}
		if (NeedWorldClass != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(NeedWorldClass);
		}
		if (NeedRoguelike != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(NeedRoguelike);
		}
		if (FloorId != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(FloorId);
		}
		if (PreviewMonsterGroupId != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(PreviewMonsterGroupId);
		}
		if (OneStarCondition.Length != 0)
		{
			output.WriteRawTag(114);
			output.WriteString(OneStarCondition);
		}
		if (TwoStarCondition.Length != 0)
		{
			output.WriteRawTag(122);
			output.WriteString(TwoStarCondition);
		}
		if (ThreeStarCondition.Length != 0)
		{
			output.WriteRawTag(130, 1);
			output.WriteString(ThreeStarCondition);
		}
		if (RoundTableDropId != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(RoundTableDropId);
		}
		if (RoundTableGuarantee.Length != 0)
		{
			output.WriteRawTag(146, 1);
			output.WriteString(RoundTableGuarantee);
		}
		if (SequentialDropId != 0)
		{
			output.WriteRawTag(152, 1);
			output.WriteInt32(SequentialDropId);
		}
		if (SequentialGuarantee.Length != 0)
		{
			output.WriteRawTag(162, 1);
			output.WriteString(SequentialGuarantee);
		}
		if (DropId != 0)
		{
			output.WriteRawTag(168, 1);
			output.WriteInt32(DropId);
		}
		if (DropGuaranteeType != 0)
		{
			output.WriteRawTag(176, 1);
			output.WriteInt32(DropGuaranteeType);
		}
		if (EnergyConsume != 0)
		{
			output.WriteRawTag(184, 1);
			output.WriteInt32(EnergyConsume);
		}
		if (BaseAwardPreview.Length != 0)
		{
			output.WriteRawTag(194, 1);
			output.WriteString(BaseAwardPreview);
		}
		firstRewardPreview_.WriteTo(output, _repeated_firstRewardPreview_codec);
		extraDropPreview_.WriteTo(output, _repeated_extraDropPreview_codec);
		if (Icon.Length != 0)
		{
			output.WriteRawTag(218, 1);
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
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (Difficulty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Difficulty);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (SuggestedPower != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SuggestedPower);
		}
		if (SuggestedBuild != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SuggestedBuild);
		}
		if (PreLevelId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PreLevelId);
		}
		if (PreLevelStar != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PreLevelStar);
		}
		if (NeedWorldClass != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(NeedWorldClass);
		}
		if (NeedRoguelike != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(NeedRoguelike);
		}
		if (FloorId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FloorId);
		}
		if (PreviewMonsterGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PreviewMonsterGroupId);
		}
		if (OneStarCondition.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(OneStarCondition);
		}
		if (TwoStarCondition.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(TwoStarCondition);
		}
		if (ThreeStarCondition.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(ThreeStarCondition);
		}
		if (RoundTableDropId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RoundTableDropId);
		}
		if (RoundTableGuarantee.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(RoundTableGuarantee);
		}
		if (SequentialDropId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SequentialDropId);
		}
		if (SequentialGuarantee.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(SequentialGuarantee);
		}
		if (DropId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(DropId);
		}
		if (DropGuaranteeType != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(DropGuaranteeType);
		}
		if (EnergyConsume != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(EnergyConsume);
		}
		if (BaseAwardPreview.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(BaseAwardPreview);
		}
		num += firstRewardPreview_.CalculateSize(_repeated_firstRewardPreview_codec);
		num += extraDropPreview_.CalculateSize(_repeated_extraDropPreview_codec);
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
	public void MergeFrom(CharGemInstance other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.Difficulty != 0)
			{
				Difficulty = other.Difficulty;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.SuggestedPower != 0)
			{
				SuggestedPower = other.SuggestedPower;
			}
			if (other.SuggestedBuild != 0)
			{
				SuggestedBuild = other.SuggestedBuild;
			}
			if (other.PreLevelId != 0)
			{
				PreLevelId = other.PreLevelId;
			}
			if (other.PreLevelStar != 0)
			{
				PreLevelStar = other.PreLevelStar;
			}
			if (other.NeedWorldClass != 0)
			{
				NeedWorldClass = other.NeedWorldClass;
			}
			if (other.NeedRoguelike != 0)
			{
				NeedRoguelike = other.NeedRoguelike;
			}
			if (other.FloorId != 0)
			{
				FloorId = other.FloorId;
			}
			if (other.PreviewMonsterGroupId != 0)
			{
				PreviewMonsterGroupId = other.PreviewMonsterGroupId;
			}
			if (other.OneStarCondition.Length != 0)
			{
				OneStarCondition = other.OneStarCondition;
			}
			if (other.TwoStarCondition.Length != 0)
			{
				TwoStarCondition = other.TwoStarCondition;
			}
			if (other.ThreeStarCondition.Length != 0)
			{
				ThreeStarCondition = other.ThreeStarCondition;
			}
			if (other.RoundTableDropId != 0)
			{
				RoundTableDropId = other.RoundTableDropId;
			}
			if (other.RoundTableGuarantee.Length != 0)
			{
				RoundTableGuarantee = other.RoundTableGuarantee;
			}
			if (other.SequentialDropId != 0)
			{
				SequentialDropId = other.SequentialDropId;
			}
			if (other.SequentialGuarantee.Length != 0)
			{
				SequentialGuarantee = other.SequentialGuarantee;
			}
			if (other.DropId != 0)
			{
				DropId = other.DropId;
			}
			if (other.DropGuaranteeType != 0)
			{
				DropGuaranteeType = other.DropGuaranteeType;
			}
			if (other.EnergyConsume != 0)
			{
				EnergyConsume = other.EnergyConsume;
			}
			if (other.BaseAwardPreview.Length != 0)
			{
				BaseAwardPreview = other.BaseAwardPreview;
			}
			firstRewardPreview_.Add(other.firstRewardPreview_);
			extraDropPreview_.Add(other.extraDropPreview_);
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
				Type = input.ReadInt32();
				break;
			case 24u:
				Difficulty = input.ReadInt32();
				break;
			case 34u:
				Name = input.ReadString();
				break;
			case 42u:
				Desc = input.ReadString();
				break;
			case 48u:
				SuggestedPower = input.ReadInt32();
				break;
			case 56u:
				SuggestedBuild = input.ReadInt32();
				break;
			case 64u:
				PreLevelId = input.ReadInt32();
				break;
			case 72u:
				PreLevelStar = input.ReadInt32();
				break;
			case 80u:
				NeedWorldClass = input.ReadInt32();
				break;
			case 88u:
				NeedRoguelike = input.ReadInt32();
				break;
			case 96u:
				FloorId = input.ReadInt32();
				break;
			case 104u:
				PreviewMonsterGroupId = input.ReadInt32();
				break;
			case 114u:
				OneStarCondition = input.ReadString();
				break;
			case 122u:
				TwoStarCondition = input.ReadString();
				break;
			case 130u:
				ThreeStarCondition = input.ReadString();
				break;
			case 136u:
				RoundTableDropId = input.ReadInt32();
				break;
			case 146u:
				RoundTableGuarantee = input.ReadString();
				break;
			case 152u:
				SequentialDropId = input.ReadInt32();
				break;
			case 162u:
				SequentialGuarantee = input.ReadString();
				break;
			case 168u:
				DropId = input.ReadInt32();
				break;
			case 176u:
				DropGuaranteeType = input.ReadInt32();
				break;
			case 184u:
				EnergyConsume = input.ReadInt32();
				break;
			case 194u:
				BaseAwardPreview = input.ReadString();
				break;
			case 200u:
			case 202u:
				firstRewardPreview_.AddEntriesFrom(input, _repeated_firstRewardPreview_codec);
				break;
			case 208u:
			case 210u:
				extraDropPreview_.AddEntriesFrom(input, _repeated_extraDropPreview_codec);
				break;
			case 218u:
				Icon = input.ReadString();
				break;
			}
		}
	}
}
