using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class Mainline : IMessage<Mainline>, IMessage, IEquatable<Mainline>, IDeepCloneable<Mainline>
{
	private static readonly MessageParser<Mainline> _parser = new MessageParser<Mainline>(() => new Mainline());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NumFieldNumber = 2;

	private string num_ = "";

	public const int NameFieldNumber = 3;

	private string name_ = "";

	public const int DescFieldNumber = 4;

	private string desc_ = "";

	public const int TypeFieldNumber = 5;

	private int type_;

	public const int EnergyFieldNumber = 6;

	private int energy_;

	public const int ChapterIdFieldNumber = 7;

	private int chapterId_;

	public const int PrevFieldNumber = 8;

	private static readonly FieldCodec<int> _repeated_prev_codec = FieldCodec.ForInt32(66u);

	private readonly RepeatedField<int> prev_ = new RepeatedField<int>();

	public const int FormFieldNumber = 9;

	private static readonly FieldCodec<int> _repeated_form_codec = FieldCodec.ForInt32(74u);

	private readonly RepeatedField<int> form_ = new RepeatedField<int>();

	public const int AvgIdFieldNumber = 10;

	private string avgId_ = "";

	public const int TrialCharacterFieldNumber = 11;

	private static readonly FieldCodec<int> _repeated_trialCharacter_codec = FieldCodec.ForInt32(90u);

	private readonly RepeatedField<int> trialCharacter_ = new RepeatedField<int>();

	public const int BeforeAvgIdFieldNumber = 12;

	private string beforeAvgId_ = "";

	public const int AfterAvgIdFieldNumber = 13;

	private string afterAvgId_ = "";

	public const int EnergyConsumeFieldNumber = 14;

	private int energyConsume_;

	public const int UnlockItemFieldNumber = 15;

	private int unlockItem_;

	public const int UnlockQtyFieldNumber = 16;

	private int unlockQty_;

	public const int GlobRewardFieldNumber = 17;

	private int globReward_;

	public const int RewardPreviewFieldNumber = 18;

	private string rewardPreview_ = "";

	public const int ItemRewardFieldNumber = 19;

	private int itemReward_;

	public const int FirstItemRewardFieldNumber = 20;

	private int firstItemReward_;

	public const int DiamondRewardFieldNumber = 21;

	private int diamondReward_;

	public const int MinChestRewardFieldNumber = 22;

	private string minChestReward_ = "";

	public const int MaxChestRewardFieldNumber = 23;

	private string maxChestReward_ = "";

	public const int CharBannedFieldNumber = 24;

	private static readonly FieldCodec<int> _repeated_charBanned_codec = FieldCodec.ForInt32(194u);

	private readonly RepeatedField<int> charBanned_ = new RepeatedField<int>();

	public const int FloorIdFieldNumber = 25;

	private static readonly FieldCodec<int> _repeated_floorId_codec = FieldCodec.ForInt32(202u);

	private readonly RepeatedField<int> floorId_ = new RepeatedField<int>();

	public const int IconFieldNumber = 26;

	private string icon_ = "";

	public const int PosIdFieldNumber = 27;

	private int posId_;

	public const int PreviewMonsterGroupIdFieldNumber = 28;

	private int previewMonsterGroupId_;

	public const int RecommendFieldNumber = 29;

	private int recommend_;

	public const int RepeatFieldNumber = 30;

	private bool repeat_;

	public const int SubMapNameFieldNumber = 31;

	private int subMapName_;

	public const int MainlineImgFieldNumber = 32;

	private string mainlineImg_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<Mainline> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(504);

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
	public string Num
	{
		get
		{
			return num_;
		}
		set
		{
			num_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public int Energy
	{
		get
		{
			return energy_;
		}
		set
		{
			energy_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ChapterId
	{
		get
		{
			return chapterId_;
		}
		set
		{
			chapterId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Prev => prev_;

	[DebuggerNonUserCode]
	public RepeatedField<int> Form => form_;

	[DebuggerNonUserCode]
	public string AvgId
	{
		get
		{
			return avgId_;
		}
		set
		{
			avgId_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> TrialCharacter => trialCharacter_;

	[DebuggerNonUserCode]
	public string BeforeAvgId
	{
		get
		{
			return beforeAvgId_;
		}
		set
		{
			beforeAvgId_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string AfterAvgId
	{
		get
		{
			return afterAvgId_;
		}
		set
		{
			afterAvgId_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public int UnlockItem
	{
		get
		{
			return unlockItem_;
		}
		set
		{
			unlockItem_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int UnlockQty
	{
		get
		{
			return unlockQty_;
		}
		set
		{
			unlockQty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int GlobReward
	{
		get
		{
			return globReward_;
		}
		set
		{
			globReward_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string RewardPreview
	{
		get
		{
			return rewardPreview_;
		}
		set
		{
			rewardPreview_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int ItemReward
	{
		get
		{
			return itemReward_;
		}
		set
		{
			itemReward_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FirstItemReward
	{
		get
		{
			return firstItemReward_;
		}
		set
		{
			firstItemReward_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DiamondReward
	{
		get
		{
			return diamondReward_;
		}
		set
		{
			diamondReward_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string MinChestReward
	{
		get
		{
			return minChestReward_;
		}
		set
		{
			minChestReward_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string MaxChestReward
	{
		get
		{
			return maxChestReward_;
		}
		set
		{
			maxChestReward_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> CharBanned => charBanned_;

	[DebuggerNonUserCode]
	public RepeatedField<int> FloorId => floorId_;

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
	public int PosId
	{
		get
		{
			return posId_;
		}
		set
		{
			posId_ = value;
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
	public int Recommend
	{
		get
		{
			return recommend_;
		}
		set
		{
			recommend_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool Repeat
	{
		get
		{
			return repeat_;
		}
		set
		{
			repeat_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SubMapName
	{
		get
		{
			return subMapName_;
		}
		set
		{
			subMapName_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string MainlineImg
	{
		get
		{
			return mainlineImg_;
		}
		set
		{
			mainlineImg_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public Mainline()
	{
	}

	[DebuggerNonUserCode]
	public Mainline(Mainline other)
		: this()
	{
		id_ = other.id_;
		num_ = other.num_;
		name_ = other.name_;
		desc_ = other.desc_;
		type_ = other.type_;
		energy_ = other.energy_;
		chapterId_ = other.chapterId_;
		prev_ = other.prev_.Clone();
		form_ = other.form_.Clone();
		avgId_ = other.avgId_;
		trialCharacter_ = other.trialCharacter_.Clone();
		beforeAvgId_ = other.beforeAvgId_;
		afterAvgId_ = other.afterAvgId_;
		energyConsume_ = other.energyConsume_;
		unlockItem_ = other.unlockItem_;
		unlockQty_ = other.unlockQty_;
		globReward_ = other.globReward_;
		rewardPreview_ = other.rewardPreview_;
		itemReward_ = other.itemReward_;
		firstItemReward_ = other.firstItemReward_;
		diamondReward_ = other.diamondReward_;
		minChestReward_ = other.minChestReward_;
		maxChestReward_ = other.maxChestReward_;
		charBanned_ = other.charBanned_.Clone();
		floorId_ = other.floorId_.Clone();
		icon_ = other.icon_;
		posId_ = other.posId_;
		previewMonsterGroupId_ = other.previewMonsterGroupId_;
		recommend_ = other.recommend_;
		repeat_ = other.repeat_;
		subMapName_ = other.subMapName_;
		mainlineImg_ = other.mainlineImg_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public Mainline Clone()
	{
		return new Mainline(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Mainline);
	}

	[DebuggerNonUserCode]
	public bool Equals(Mainline other)
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
		if (Num != other.Num)
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
		if (Type != other.Type)
		{
			return false;
		}
		if (Energy != other.Energy)
		{
			return false;
		}
		if (ChapterId != other.ChapterId)
		{
			return false;
		}
		if (!prev_.Equals(other.prev_))
		{
			return false;
		}
		if (!form_.Equals(other.form_))
		{
			return false;
		}
		if (AvgId != other.AvgId)
		{
			return false;
		}
		if (!trialCharacter_.Equals(other.trialCharacter_))
		{
			return false;
		}
		if (BeforeAvgId != other.BeforeAvgId)
		{
			return false;
		}
		if (AfterAvgId != other.AfterAvgId)
		{
			return false;
		}
		if (EnergyConsume != other.EnergyConsume)
		{
			return false;
		}
		if (UnlockItem != other.UnlockItem)
		{
			return false;
		}
		if (UnlockQty != other.UnlockQty)
		{
			return false;
		}
		if (GlobReward != other.GlobReward)
		{
			return false;
		}
		if (RewardPreview != other.RewardPreview)
		{
			return false;
		}
		if (ItemReward != other.ItemReward)
		{
			return false;
		}
		if (FirstItemReward != other.FirstItemReward)
		{
			return false;
		}
		if (DiamondReward != other.DiamondReward)
		{
			return false;
		}
		if (MinChestReward != other.MinChestReward)
		{
			return false;
		}
		if (MaxChestReward != other.MaxChestReward)
		{
			return false;
		}
		if (!charBanned_.Equals(other.charBanned_))
		{
			return false;
		}
		if (!floorId_.Equals(other.floorId_))
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (PosId != other.PosId)
		{
			return false;
		}
		if (PreviewMonsterGroupId != other.PreviewMonsterGroupId)
		{
			return false;
		}
		if (Recommend != other.Recommend)
		{
			return false;
		}
		if (Repeat != other.Repeat)
		{
			return false;
		}
		if (SubMapName != other.SubMapName)
		{
			return false;
		}
		if (MainlineImg != other.MainlineImg)
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
		if (Num.Length != 0)
		{
			num ^= Num.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (Energy != 0)
		{
			num ^= Energy.GetHashCode();
		}
		if (ChapterId != 0)
		{
			num ^= ChapterId.GetHashCode();
		}
		num ^= prev_.GetHashCode();
		num ^= form_.GetHashCode();
		if (AvgId.Length != 0)
		{
			num ^= AvgId.GetHashCode();
		}
		num ^= trialCharacter_.GetHashCode();
		if (BeforeAvgId.Length != 0)
		{
			num ^= BeforeAvgId.GetHashCode();
		}
		if (AfterAvgId.Length != 0)
		{
			num ^= AfterAvgId.GetHashCode();
		}
		if (EnergyConsume != 0)
		{
			num ^= EnergyConsume.GetHashCode();
		}
		if (UnlockItem != 0)
		{
			num ^= UnlockItem.GetHashCode();
		}
		if (UnlockQty != 0)
		{
			num ^= UnlockQty.GetHashCode();
		}
		if (GlobReward != 0)
		{
			num ^= GlobReward.GetHashCode();
		}
		if (RewardPreview.Length != 0)
		{
			num ^= RewardPreview.GetHashCode();
		}
		if (ItemReward != 0)
		{
			num ^= ItemReward.GetHashCode();
		}
		if (FirstItemReward != 0)
		{
			num ^= FirstItemReward.GetHashCode();
		}
		if (DiamondReward != 0)
		{
			num ^= DiamondReward.GetHashCode();
		}
		if (MinChestReward.Length != 0)
		{
			num ^= MinChestReward.GetHashCode();
		}
		if (MaxChestReward.Length != 0)
		{
			num ^= MaxChestReward.GetHashCode();
		}
		num ^= charBanned_.GetHashCode();
		num ^= floorId_.GetHashCode();
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (PosId != 0)
		{
			num ^= PosId.GetHashCode();
		}
		if (PreviewMonsterGroupId != 0)
		{
			num ^= PreviewMonsterGroupId.GetHashCode();
		}
		if (Recommend != 0)
		{
			num ^= Recommend.GetHashCode();
		}
		if (Repeat)
		{
			num ^= Repeat.GetHashCode();
		}
		if (SubMapName != 0)
		{
			num ^= SubMapName.GetHashCode();
		}
		if (MainlineImg.Length != 0)
		{
			num ^= MainlineImg.GetHashCode();
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
		if (Num.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Num);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Name);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Desc);
		}
		if (Type != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Type);
		}
		if (Energy != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Energy);
		}
		if (ChapterId != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(ChapterId);
		}
		prev_.WriteTo(output, _repeated_prev_codec);
		form_.WriteTo(output, _repeated_form_codec);
		if (AvgId.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(AvgId);
		}
		trialCharacter_.WriteTo(output, _repeated_trialCharacter_codec);
		if (BeforeAvgId.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(BeforeAvgId);
		}
		if (AfterAvgId.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(AfterAvgId);
		}
		if (EnergyConsume != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(EnergyConsume);
		}
		if (UnlockItem != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(UnlockItem);
		}
		if (UnlockQty != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(UnlockQty);
		}
		if (GlobReward != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(GlobReward);
		}
		if (RewardPreview.Length != 0)
		{
			output.WriteRawTag(146, 1);
			output.WriteString(RewardPreview);
		}
		if (ItemReward != 0)
		{
			output.WriteRawTag(152, 1);
			output.WriteInt32(ItemReward);
		}
		if (FirstItemReward != 0)
		{
			output.WriteRawTag(160, 1);
			output.WriteInt32(FirstItemReward);
		}
		if (DiamondReward != 0)
		{
			output.WriteRawTag(168, 1);
			output.WriteInt32(DiamondReward);
		}
		if (MinChestReward.Length != 0)
		{
			output.WriteRawTag(178, 1);
			output.WriteString(MinChestReward);
		}
		if (MaxChestReward.Length != 0)
		{
			output.WriteRawTag(186, 1);
			output.WriteString(MaxChestReward);
		}
		charBanned_.WriteTo(output, _repeated_charBanned_codec);
		floorId_.WriteTo(output, _repeated_floorId_codec);
		if (Icon.Length != 0)
		{
			output.WriteRawTag(210, 1);
			output.WriteString(Icon);
		}
		if (PosId != 0)
		{
			output.WriteRawTag(216, 1);
			output.WriteInt32(PosId);
		}
		if (PreviewMonsterGroupId != 0)
		{
			output.WriteRawTag(224, 1);
			output.WriteInt32(PreviewMonsterGroupId);
		}
		if (Recommend != 0)
		{
			output.WriteRawTag(232, 1);
			output.WriteInt32(Recommend);
		}
		if (Repeat)
		{
			output.WriteRawTag(240, 1);
			output.WriteBool(Repeat);
		}
		if (SubMapName != 0)
		{
			output.WriteRawTag(248, 1);
			output.WriteInt32(SubMapName);
		}
		if (MainlineImg.Length != 0)
		{
			output.WriteRawTag(130, 2);
			output.WriteString(MainlineImg);
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
		if (Num.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Num);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (Energy != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Energy);
		}
		if (ChapterId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ChapterId);
		}
		num += prev_.CalculateSize(_repeated_prev_codec);
		num += form_.CalculateSize(_repeated_form_codec);
		if (AvgId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AvgId);
		}
		num += trialCharacter_.CalculateSize(_repeated_trialCharacter_codec);
		if (BeforeAvgId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BeforeAvgId);
		}
		if (AfterAvgId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AfterAvgId);
		}
		if (EnergyConsume != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EnergyConsume);
		}
		if (UnlockItem != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UnlockItem);
		}
		if (UnlockQty != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(UnlockQty);
		}
		if (GlobReward != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(GlobReward);
		}
		if (RewardPreview.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(RewardPreview);
		}
		if (ItemReward != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(ItemReward);
		}
		if (FirstItemReward != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(FirstItemReward);
		}
		if (DiamondReward != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(DiamondReward);
		}
		if (MinChestReward.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(MinChestReward);
		}
		if (MaxChestReward.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(MaxChestReward);
		}
		num += charBanned_.CalculateSize(_repeated_charBanned_codec);
		num += floorId_.CalculateSize(_repeated_floorId_codec);
		if (Icon.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (PosId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(PosId);
		}
		if (PreviewMonsterGroupId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(PreviewMonsterGroupId);
		}
		if (Recommend != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Recommend);
		}
		if (Repeat)
		{
			num += 3;
		}
		if (SubMapName != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SubMapName);
		}
		if (MainlineImg.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(MainlineImg);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Mainline other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Num.Length != 0)
			{
				Num = other.Num;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.Energy != 0)
			{
				Energy = other.Energy;
			}
			if (other.ChapterId != 0)
			{
				ChapterId = other.ChapterId;
			}
			prev_.Add(other.prev_);
			form_.Add(other.form_);
			if (other.AvgId.Length != 0)
			{
				AvgId = other.AvgId;
			}
			trialCharacter_.Add(other.trialCharacter_);
			if (other.BeforeAvgId.Length != 0)
			{
				BeforeAvgId = other.BeforeAvgId;
			}
			if (other.AfterAvgId.Length != 0)
			{
				AfterAvgId = other.AfterAvgId;
			}
			if (other.EnergyConsume != 0)
			{
				EnergyConsume = other.EnergyConsume;
			}
			if (other.UnlockItem != 0)
			{
				UnlockItem = other.UnlockItem;
			}
			if (other.UnlockQty != 0)
			{
				UnlockQty = other.UnlockQty;
			}
			if (other.GlobReward != 0)
			{
				GlobReward = other.GlobReward;
			}
			if (other.RewardPreview.Length != 0)
			{
				RewardPreview = other.RewardPreview;
			}
			if (other.ItemReward != 0)
			{
				ItemReward = other.ItemReward;
			}
			if (other.FirstItemReward != 0)
			{
				FirstItemReward = other.FirstItemReward;
			}
			if (other.DiamondReward != 0)
			{
				DiamondReward = other.DiamondReward;
			}
			if (other.MinChestReward.Length != 0)
			{
				MinChestReward = other.MinChestReward;
			}
			if (other.MaxChestReward.Length != 0)
			{
				MaxChestReward = other.MaxChestReward;
			}
			charBanned_.Add(other.charBanned_);
			floorId_.Add(other.floorId_);
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.PosId != 0)
			{
				PosId = other.PosId;
			}
			if (other.PreviewMonsterGroupId != 0)
			{
				PreviewMonsterGroupId = other.PreviewMonsterGroupId;
			}
			if (other.Recommend != 0)
			{
				Recommend = other.Recommend;
			}
			if (other.Repeat)
			{
				Repeat = other.Repeat;
			}
			if (other.SubMapName != 0)
			{
				SubMapName = other.SubMapName;
			}
			if (other.MainlineImg.Length != 0)
			{
				MainlineImg = other.MainlineImg;
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
				Num = input.ReadString();
				break;
			case 26u:
				Name = input.ReadString();
				break;
			case 34u:
				Desc = input.ReadString();
				break;
			case 40u:
				Type = input.ReadInt32();
				break;
			case 48u:
				Energy = input.ReadInt32();
				break;
			case 56u:
				ChapterId = input.ReadInt32();
				break;
			case 64u:
			case 66u:
				prev_.AddEntriesFrom(input, _repeated_prev_codec);
				break;
			case 72u:
			case 74u:
				form_.AddEntriesFrom(input, _repeated_form_codec);
				break;
			case 82u:
				AvgId = input.ReadString();
				break;
			case 88u:
			case 90u:
				trialCharacter_.AddEntriesFrom(input, _repeated_trialCharacter_codec);
				break;
			case 98u:
				BeforeAvgId = input.ReadString();
				break;
			case 106u:
				AfterAvgId = input.ReadString();
				break;
			case 112u:
				EnergyConsume = input.ReadInt32();
				break;
			case 120u:
				UnlockItem = input.ReadInt32();
				break;
			case 128u:
				UnlockQty = input.ReadInt32();
				break;
			case 136u:
				GlobReward = input.ReadInt32();
				break;
			case 146u:
				RewardPreview = input.ReadString();
				break;
			case 152u:
				ItemReward = input.ReadInt32();
				break;
			case 160u:
				FirstItemReward = input.ReadInt32();
				break;
			case 168u:
				DiamondReward = input.ReadInt32();
				break;
			case 178u:
				MinChestReward = input.ReadString();
				break;
			case 186u:
				MaxChestReward = input.ReadString();
				break;
			case 192u:
			case 194u:
				charBanned_.AddEntriesFrom(input, _repeated_charBanned_codec);
				break;
			case 200u:
			case 202u:
				floorId_.AddEntriesFrom(input, _repeated_floorId_codec);
				break;
			case 210u:
				Icon = input.ReadString();
				break;
			case 216u:
				PosId = input.ReadInt32();
				break;
			case 224u:
				PreviewMonsterGroupId = input.ReadInt32();
				break;
			case 232u:
				Recommend = input.ReadInt32();
				break;
			case 240u:
				Repeat = input.ReadBool();
				break;
			case 248u:
				SubMapName = input.ReadInt32();
				break;
			case 258u:
				MainlineImg = input.ReadString();
				break;
			}
		}
	}
}
