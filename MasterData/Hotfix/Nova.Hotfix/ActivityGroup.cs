using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ActivityGroup : IMessage<ActivityGroup>, IMessage, IEquatable<ActivityGroup>, IDeepCloneable<ActivityGroup>
{
	private static readonly MessageParser<ActivityGroup> _parser = new MessageParser<ActivityGroup>(() => new ActivityGroup());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ActivityGroupTypeFieldNumber = 2;

	private int activityGroupType_;

	public const int ActivityThemeTypeFieldNumber = 3;

	private int activityThemeType_;

	public const int StartTimeFieldNumber = 4;

	private string startTime_ = "";

	public const int EndTimeFieldNumber = 5;

	private string endTime_ = "";

	public const int EnterEndTimeFieldNumber = 6;

	private string enterEndTime_ = "";

	public const int StoryShowTimeFieldNumber = 7;

	private string storyShowTime_ = "";

	public const int EnterResFieldNumber = 8;

	private string enterRes_ = "";

	public const int PanelIdFieldNumber = 9;

	private int panelId_;

	public const int PrologueFieldNumber = 10;

	private static readonly FieldCodec<int> _repeated_prologue_codec = FieldCodec.ForInt32(82u);

	private readonly RepeatedField<int> prologue_ = new RepeatedField<int>();

	public const int PreLimitFieldNumber = 11;

	private int preLimit_;

	public const int LimitParamFieldNumber = 12;

	private string limitParam_ = "";

	public const int StartCondTypeFieldNumber = 13;

	private int startCondType_;

	public const int StartCondParamsFieldNumber = 14;

	private static readonly FieldCodec<int> _repeated_startCondParams_codec = FieldCodec.ForInt32(114u);

	private readonly RepeatedField<int> startCondParams_ = new RepeatedField<int>();

	public const int CGFieldNumber = 15;

	private string cG_ = "";

	public const int EnterFieldNumber = 16;

	private string enter_ = "";

	public const int MultipleEnterFieldNumber = 17;

	private string multipleEnter_ = "";

	public const int UIAssetsPrefabFieldNumber = 18;

	private string uIAssetsPrefab_ = "";

	public const int CtrlNameFieldNumber = 19;

	private string ctrlName_ = "";

	public const int RewardsShowFieldNumber = 20;

	private static readonly FieldCodec<int> _repeated_rewardsShow_codec = FieldCodec.ForInt32(162u);

	private readonly RepeatedField<int> rewardsShow_ = new RepeatedField<int>();

	public const int DesTextFieldNumber = 21;

	private string desText_ = "";

	public const int BannerResFieldNumber = 22;

	private string bannerRes_ = "";

	public const int TabBgResFieldNumber = 23;

	private string tabBgRes_ = "";

	public const int TransitionIdFieldNumber = 24;

	private int transitionId_;

	public const int EntranceIdFieldNumber = 25;

	private int entranceId_;

	[DebuggerNonUserCode]
	public static MessageParser<ActivityGroup> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(16);

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
	public int ActivityGroupType
	{
		get
		{
			return activityGroupType_;
		}
		set
		{
			activityGroupType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ActivityThemeType
	{
		get
		{
			return activityThemeType_;
		}
		set
		{
			activityThemeType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string StartTime
	{
		get
		{
			return startTime_;
		}
		set
		{
			startTime_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string EndTime
	{
		get
		{
			return endTime_;
		}
		set
		{
			endTime_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string EnterEndTime
	{
		get
		{
			return enterEndTime_;
		}
		set
		{
			enterEndTime_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string StoryShowTime
	{
		get
		{
			return storyShowTime_;
		}
		set
		{
			storyShowTime_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string EnterRes
	{
		get
		{
			return enterRes_;
		}
		set
		{
			enterRes_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int PanelId
	{
		get
		{
			return panelId_;
		}
		set
		{
			panelId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Prologue => prologue_;

	[DebuggerNonUserCode]
	public int PreLimit
	{
		get
		{
			return preLimit_;
		}
		set
		{
			preLimit_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string LimitParam
	{
		get
		{
			return limitParam_;
		}
		set
		{
			limitParam_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int StartCondType
	{
		get
		{
			return startCondType_;
		}
		set
		{
			startCondType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> StartCondParams => startCondParams_;

	[DebuggerNonUserCode]
	public string CG
	{
		get
		{
			return cG_;
		}
		set
		{
			cG_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Enter
	{
		get
		{
			return enter_;
		}
		set
		{
			enter_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string MultipleEnter
	{
		get
		{
			return multipleEnter_;
		}
		set
		{
			multipleEnter_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string UIAssetsPrefab
	{
		get
		{
			return uIAssetsPrefab_;
		}
		set
		{
			uIAssetsPrefab_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string CtrlName
	{
		get
		{
			return ctrlName_;
		}
		set
		{
			ctrlName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> RewardsShow => rewardsShow_;

	[DebuggerNonUserCode]
	public string DesText
	{
		get
		{
			return desText_;
		}
		set
		{
			desText_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string BannerRes
	{
		get
		{
			return bannerRes_;
		}
		set
		{
			bannerRes_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string TabBgRes
	{
		get
		{
			return tabBgRes_;
		}
		set
		{
			tabBgRes_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int TransitionId
	{
		get
		{
			return transitionId_;
		}
		set
		{
			transitionId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EntranceId
	{
		get
		{
			return entranceId_;
		}
		set
		{
			entranceId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public ActivityGroup()
	{
	}

	[DebuggerNonUserCode]
	public ActivityGroup(ActivityGroup other)
		: this()
	{
		id_ = other.id_;
		activityGroupType_ = other.activityGroupType_;
		activityThemeType_ = other.activityThemeType_;
		startTime_ = other.startTime_;
		endTime_ = other.endTime_;
		enterEndTime_ = other.enterEndTime_;
		storyShowTime_ = other.storyShowTime_;
		enterRes_ = other.enterRes_;
		panelId_ = other.panelId_;
		prologue_ = other.prologue_.Clone();
		preLimit_ = other.preLimit_;
		limitParam_ = other.limitParam_;
		startCondType_ = other.startCondType_;
		startCondParams_ = other.startCondParams_.Clone();
		cG_ = other.cG_;
		enter_ = other.enter_;
		multipleEnter_ = other.multipleEnter_;
		uIAssetsPrefab_ = other.uIAssetsPrefab_;
		ctrlName_ = other.ctrlName_;
		rewardsShow_ = other.rewardsShow_.Clone();
		desText_ = other.desText_;
		bannerRes_ = other.bannerRes_;
		tabBgRes_ = other.tabBgRes_;
		transitionId_ = other.transitionId_;
		entranceId_ = other.entranceId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ActivityGroup Clone()
	{
		return new ActivityGroup(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityGroup);
	}

	[DebuggerNonUserCode]
	public bool Equals(ActivityGroup other)
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
		if (ActivityGroupType != other.ActivityGroupType)
		{
			return false;
		}
		if (ActivityThemeType != other.ActivityThemeType)
		{
			return false;
		}
		if (StartTime != other.StartTime)
		{
			return false;
		}
		if (EndTime != other.EndTime)
		{
			return false;
		}
		if (EnterEndTime != other.EnterEndTime)
		{
			return false;
		}
		if (StoryShowTime != other.StoryShowTime)
		{
			return false;
		}
		if (EnterRes != other.EnterRes)
		{
			return false;
		}
		if (PanelId != other.PanelId)
		{
			return false;
		}
		if (!prologue_.Equals(other.prologue_))
		{
			return false;
		}
		if (PreLimit != other.PreLimit)
		{
			return false;
		}
		if (LimitParam != other.LimitParam)
		{
			return false;
		}
		if (StartCondType != other.StartCondType)
		{
			return false;
		}
		if (!startCondParams_.Equals(other.startCondParams_))
		{
			return false;
		}
		if (CG != other.CG)
		{
			return false;
		}
		if (Enter != other.Enter)
		{
			return false;
		}
		if (MultipleEnter != other.MultipleEnter)
		{
			return false;
		}
		if (UIAssetsPrefab != other.UIAssetsPrefab)
		{
			return false;
		}
		if (CtrlName != other.CtrlName)
		{
			return false;
		}
		if (!rewardsShow_.Equals(other.rewardsShow_))
		{
			return false;
		}
		if (DesText != other.DesText)
		{
			return false;
		}
		if (BannerRes != other.BannerRes)
		{
			return false;
		}
		if (TabBgRes != other.TabBgRes)
		{
			return false;
		}
		if (TransitionId != other.TransitionId)
		{
			return false;
		}
		if (EntranceId != other.EntranceId)
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
		if (ActivityGroupType != 0)
		{
			num ^= ActivityGroupType.GetHashCode();
		}
		if (ActivityThemeType != 0)
		{
			num ^= ActivityThemeType.GetHashCode();
		}
		if (StartTime.Length != 0)
		{
			num ^= StartTime.GetHashCode();
		}
		if (EndTime.Length != 0)
		{
			num ^= EndTime.GetHashCode();
		}
		if (EnterEndTime.Length != 0)
		{
			num ^= EnterEndTime.GetHashCode();
		}
		if (StoryShowTime.Length != 0)
		{
			num ^= StoryShowTime.GetHashCode();
		}
		if (EnterRes.Length != 0)
		{
			num ^= EnterRes.GetHashCode();
		}
		if (PanelId != 0)
		{
			num ^= PanelId.GetHashCode();
		}
		num ^= prologue_.GetHashCode();
		if (PreLimit != 0)
		{
			num ^= PreLimit.GetHashCode();
		}
		if (LimitParam.Length != 0)
		{
			num ^= LimitParam.GetHashCode();
		}
		if (StartCondType != 0)
		{
			num ^= StartCondType.GetHashCode();
		}
		num ^= startCondParams_.GetHashCode();
		if (CG.Length != 0)
		{
			num ^= CG.GetHashCode();
		}
		if (Enter.Length != 0)
		{
			num ^= Enter.GetHashCode();
		}
		if (MultipleEnter.Length != 0)
		{
			num ^= MultipleEnter.GetHashCode();
		}
		if (UIAssetsPrefab.Length != 0)
		{
			num ^= UIAssetsPrefab.GetHashCode();
		}
		if (CtrlName.Length != 0)
		{
			num ^= CtrlName.GetHashCode();
		}
		num ^= rewardsShow_.GetHashCode();
		if (DesText.Length != 0)
		{
			num ^= DesText.GetHashCode();
		}
		if (BannerRes.Length != 0)
		{
			num ^= BannerRes.GetHashCode();
		}
		if (TabBgRes.Length != 0)
		{
			num ^= TabBgRes.GetHashCode();
		}
		if (TransitionId != 0)
		{
			num ^= TransitionId.GetHashCode();
		}
		if (EntranceId != 0)
		{
			num ^= EntranceId.GetHashCode();
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
		if (ActivityGroupType != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ActivityGroupType);
		}
		if (ActivityThemeType != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(ActivityThemeType);
		}
		if (StartTime.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(StartTime);
		}
		if (EndTime.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(EndTime);
		}
		if (EnterEndTime.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(EnterEndTime);
		}
		if (StoryShowTime.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(StoryShowTime);
		}
		if (EnterRes.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(EnterRes);
		}
		if (PanelId != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(PanelId);
		}
		prologue_.WriteTo(output, _repeated_prologue_codec);
		if (PreLimit != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(PreLimit);
		}
		if (LimitParam.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(LimitParam);
		}
		if (StartCondType != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(StartCondType);
		}
		startCondParams_.WriteTo(output, _repeated_startCondParams_codec);
		if (CG.Length != 0)
		{
			output.WriteRawTag(122);
			output.WriteString(CG);
		}
		if (Enter.Length != 0)
		{
			output.WriteRawTag(130, 1);
			output.WriteString(Enter);
		}
		if (MultipleEnter.Length != 0)
		{
			output.WriteRawTag(138, 1);
			output.WriteString(MultipleEnter);
		}
		if (UIAssetsPrefab.Length != 0)
		{
			output.WriteRawTag(146, 1);
			output.WriteString(UIAssetsPrefab);
		}
		if (CtrlName.Length != 0)
		{
			output.WriteRawTag(154, 1);
			output.WriteString(CtrlName);
		}
		rewardsShow_.WriteTo(output, _repeated_rewardsShow_codec);
		if (DesText.Length != 0)
		{
			output.WriteRawTag(170, 1);
			output.WriteString(DesText);
		}
		if (BannerRes.Length != 0)
		{
			output.WriteRawTag(178, 1);
			output.WriteString(BannerRes);
		}
		if (TabBgRes.Length != 0)
		{
			output.WriteRawTag(186, 1);
			output.WriteString(TabBgRes);
		}
		if (TransitionId != 0)
		{
			output.WriteRawTag(192, 1);
			output.WriteInt32(TransitionId);
		}
		if (EntranceId != 0)
		{
			output.WriteRawTag(200, 1);
			output.WriteInt32(EntranceId);
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
		if (ActivityGroupType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ActivityGroupType);
		}
		if (ActivityThemeType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ActivityThemeType);
		}
		if (StartTime.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(StartTime);
		}
		if (EndTime.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(EndTime);
		}
		if (EnterEndTime.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(EnterEndTime);
		}
		if (StoryShowTime.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(StoryShowTime);
		}
		if (EnterRes.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(EnterRes);
		}
		if (PanelId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PanelId);
		}
		num += prologue_.CalculateSize(_repeated_prologue_codec);
		if (PreLimit != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PreLimit);
		}
		if (LimitParam.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(LimitParam);
		}
		if (StartCondType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StartCondType);
		}
		num += startCondParams_.CalculateSize(_repeated_startCondParams_codec);
		if (CG.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CG);
		}
		if (Enter.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Enter);
		}
		if (MultipleEnter.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(MultipleEnter);
		}
		if (UIAssetsPrefab.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(UIAssetsPrefab);
		}
		if (CtrlName.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(CtrlName);
		}
		num += rewardsShow_.CalculateSize(_repeated_rewardsShow_codec);
		if (DesText.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(DesText);
		}
		if (BannerRes.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(BannerRes);
		}
		if (TabBgRes.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(TabBgRes);
		}
		if (TransitionId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(TransitionId);
		}
		if (EntranceId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(EntranceId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ActivityGroup other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.ActivityGroupType != 0)
			{
				ActivityGroupType = other.ActivityGroupType;
			}
			if (other.ActivityThemeType != 0)
			{
				ActivityThemeType = other.ActivityThemeType;
			}
			if (other.StartTime.Length != 0)
			{
				StartTime = other.StartTime;
			}
			if (other.EndTime.Length != 0)
			{
				EndTime = other.EndTime;
			}
			if (other.EnterEndTime.Length != 0)
			{
				EnterEndTime = other.EnterEndTime;
			}
			if (other.StoryShowTime.Length != 0)
			{
				StoryShowTime = other.StoryShowTime;
			}
			if (other.EnterRes.Length != 0)
			{
				EnterRes = other.EnterRes;
			}
			if (other.PanelId != 0)
			{
				PanelId = other.PanelId;
			}
			prologue_.Add(other.prologue_);
			if (other.PreLimit != 0)
			{
				PreLimit = other.PreLimit;
			}
			if (other.LimitParam.Length != 0)
			{
				LimitParam = other.LimitParam;
			}
			if (other.StartCondType != 0)
			{
				StartCondType = other.StartCondType;
			}
			startCondParams_.Add(other.startCondParams_);
			if (other.CG.Length != 0)
			{
				CG = other.CG;
			}
			if (other.Enter.Length != 0)
			{
				Enter = other.Enter;
			}
			if (other.MultipleEnter.Length != 0)
			{
				MultipleEnter = other.MultipleEnter;
			}
			if (other.UIAssetsPrefab.Length != 0)
			{
				UIAssetsPrefab = other.UIAssetsPrefab;
			}
			if (other.CtrlName.Length != 0)
			{
				CtrlName = other.CtrlName;
			}
			rewardsShow_.Add(other.rewardsShow_);
			if (other.DesText.Length != 0)
			{
				DesText = other.DesText;
			}
			if (other.BannerRes.Length != 0)
			{
				BannerRes = other.BannerRes;
			}
			if (other.TabBgRes.Length != 0)
			{
				TabBgRes = other.TabBgRes;
			}
			if (other.TransitionId != 0)
			{
				TransitionId = other.TransitionId;
			}
			if (other.EntranceId != 0)
			{
				EntranceId = other.EntranceId;
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
				ActivityGroupType = input.ReadInt32();
				break;
			case 24u:
				ActivityThemeType = input.ReadInt32();
				break;
			case 34u:
				StartTime = input.ReadString();
				break;
			case 42u:
				EndTime = input.ReadString();
				break;
			case 50u:
				EnterEndTime = input.ReadString();
				break;
			case 58u:
				StoryShowTime = input.ReadString();
				break;
			case 66u:
				EnterRes = input.ReadString();
				break;
			case 72u:
				PanelId = input.ReadInt32();
				break;
			case 80u:
			case 82u:
				prologue_.AddEntriesFrom(input, _repeated_prologue_codec);
				break;
			case 88u:
				PreLimit = input.ReadInt32();
				break;
			case 98u:
				LimitParam = input.ReadString();
				break;
			case 104u:
				StartCondType = input.ReadInt32();
				break;
			case 112u:
			case 114u:
				startCondParams_.AddEntriesFrom(input, _repeated_startCondParams_codec);
				break;
			case 122u:
				CG = input.ReadString();
				break;
			case 130u:
				Enter = input.ReadString();
				break;
			case 138u:
				MultipleEnter = input.ReadString();
				break;
			case 146u:
				UIAssetsPrefab = input.ReadString();
				break;
			case 154u:
				CtrlName = input.ReadString();
				break;
			case 160u:
			case 162u:
				rewardsShow_.AddEntriesFrom(input, _repeated_rewardsShow_codec);
				break;
			case 170u:
				DesText = input.ReadString();
				break;
			case 178u:
				BannerRes = input.ReadString();
				break;
			case 186u:
				TabBgRes = input.ReadString();
				break;
			case 192u:
				TransitionId = input.ReadInt32();
				break;
			case 200u:
				EntranceId = input.ReadInt32();
				break;
			}
		}
	}
}
