using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class Activity : IMessage<Activity>, IMessage, IEquatable<Activity>, IDeepCloneable<Activity>
{
	private static readonly MessageParser<Activity> _parser = new MessageParser<Activity>(() => new Activity());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int MidGroupIdFieldNumber = 2;

	private int midGroupId_;

	public const int SortIdFieldNumber = 3;

	private int sortId_;

	public const int ActivityTypeFieldNumber = 4;

	private int activityType_;

	public const int NameFieldNumber = 5;

	private string name_ = "";

	public const int ActivityThemeTypeFieldNumber = 6;

	private int activityThemeType_;

	public const int SpecialParamFieldNumber = 7;

	private string specialParam_ = "";

	public const int PreLimitFieldNumber = 8;

	private int preLimit_;

	public const int LimitParamFieldNumber = 9;

	private string limitParam_ = "";

	public const int PlayCondFieldNumber = 10;

	private int playCond_;

	public const int PlayCondParamsFieldNumber = 11;

	private string playCondParams_ = "";

	public const int StartTypeFieldNumber = 12;

	private int startType_;

	public const int StartTimeFieldNumber = 13;

	private string startTime_ = "";

	public const int StartCondTypeFieldNumber = 14;

	private int startCondType_;

	public const int StartCondParamsFieldNumber = 15;

	private static readonly FieldCodec<int> _repeated_startCondParams_codec = FieldCodec.ForInt32(122u);

	private readonly RepeatedField<int> startCondParams_ = new RepeatedField<int>();

	public const int EndTypeFieldNumber = 16;

	private int endType_;

	public const int EndTimeFieldNumber = 17;

	private string endTime_ = "";

	public const int EndDurationFieldNumber = 18;

	private int endDuration_;

	public const int BannerResFieldNumber = 19;

	private string bannerRes_ = "";

	public const int EnterResFieldNumber = 20;

	private string enterRes_ = "";

	public const int TabBgResFieldNumber = 21;

	private string tabBgRes_ = "";

	public const int EntranceIdFieldNumber = 22;

	private int entranceId_;

	public const int HideFromActivityListFieldNumber = 23;

	private bool hideFromActivityList_;

	public const int MiniGameRedDotFieldNumber = 24;

	private int miniGameRedDot_;

	[DebuggerNonUserCode]
	public static MessageParser<Activity> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(4);

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
	public int MidGroupId
	{
		get
		{
			return midGroupId_;
		}
		set
		{
			midGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SortId
	{
		get
		{
			return sortId_;
		}
		set
		{
			sortId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ActivityType
	{
		get
		{
			return activityType_;
		}
		set
		{
			activityType_ = value;
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
	public string SpecialParam
	{
		get
		{
			return specialParam_;
		}
		set
		{
			specialParam_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

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
	public int PlayCond
	{
		get
		{
			return playCond_;
		}
		set
		{
			playCond_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string PlayCondParams
	{
		get
		{
			return playCondParams_;
		}
		set
		{
			playCondParams_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int StartType
	{
		get
		{
			return startType_;
		}
		set
		{
			startType_ = value;
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
	public int EndType
	{
		get
		{
			return endType_;
		}
		set
		{
			endType_ = value;
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
	public int EndDuration
	{
		get
		{
			return endDuration_;
		}
		set
		{
			endDuration_ = value;
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
	public bool HideFromActivityList
	{
		get
		{
			return hideFromActivityList_;
		}
		set
		{
			hideFromActivityList_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MiniGameRedDot
	{
		get
		{
			return miniGameRedDot_;
		}
		set
		{
			miniGameRedDot_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Activity()
	{
	}

	[DebuggerNonUserCode]
	public Activity(Activity other)
		: this()
	{
		id_ = other.id_;
		midGroupId_ = other.midGroupId_;
		sortId_ = other.sortId_;
		activityType_ = other.activityType_;
		name_ = other.name_;
		activityThemeType_ = other.activityThemeType_;
		specialParam_ = other.specialParam_;
		preLimit_ = other.preLimit_;
		limitParam_ = other.limitParam_;
		playCond_ = other.playCond_;
		playCondParams_ = other.playCondParams_;
		startType_ = other.startType_;
		startTime_ = other.startTime_;
		startCondType_ = other.startCondType_;
		startCondParams_ = other.startCondParams_.Clone();
		endType_ = other.endType_;
		endTime_ = other.endTime_;
		endDuration_ = other.endDuration_;
		bannerRes_ = other.bannerRes_;
		enterRes_ = other.enterRes_;
		tabBgRes_ = other.tabBgRes_;
		entranceId_ = other.entranceId_;
		hideFromActivityList_ = other.hideFromActivityList_;
		miniGameRedDot_ = other.miniGameRedDot_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public Activity Clone()
	{
		return new Activity(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Activity);
	}

	[DebuggerNonUserCode]
	public bool Equals(Activity other)
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
		if (MidGroupId != other.MidGroupId)
		{
			return false;
		}
		if (SortId != other.SortId)
		{
			return false;
		}
		if (ActivityType != other.ActivityType)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (ActivityThemeType != other.ActivityThemeType)
		{
			return false;
		}
		if (SpecialParam != other.SpecialParam)
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
		if (PlayCond != other.PlayCond)
		{
			return false;
		}
		if (PlayCondParams != other.PlayCondParams)
		{
			return false;
		}
		if (StartType != other.StartType)
		{
			return false;
		}
		if (StartTime != other.StartTime)
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
		if (EndType != other.EndType)
		{
			return false;
		}
		if (EndTime != other.EndTime)
		{
			return false;
		}
		if (EndDuration != other.EndDuration)
		{
			return false;
		}
		if (BannerRes != other.BannerRes)
		{
			return false;
		}
		if (EnterRes != other.EnterRes)
		{
			return false;
		}
		if (TabBgRes != other.TabBgRes)
		{
			return false;
		}
		if (EntranceId != other.EntranceId)
		{
			return false;
		}
		if (HideFromActivityList != other.HideFromActivityList)
		{
			return false;
		}
		if (MiniGameRedDot != other.MiniGameRedDot)
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
		if (MidGroupId != 0)
		{
			num ^= MidGroupId.GetHashCode();
		}
		if (SortId != 0)
		{
			num ^= SortId.GetHashCode();
		}
		if (ActivityType != 0)
		{
			num ^= ActivityType.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (ActivityThemeType != 0)
		{
			num ^= ActivityThemeType.GetHashCode();
		}
		if (SpecialParam.Length != 0)
		{
			num ^= SpecialParam.GetHashCode();
		}
		if (PreLimit != 0)
		{
			num ^= PreLimit.GetHashCode();
		}
		if (LimitParam.Length != 0)
		{
			num ^= LimitParam.GetHashCode();
		}
		if (PlayCond != 0)
		{
			num ^= PlayCond.GetHashCode();
		}
		if (PlayCondParams.Length != 0)
		{
			num ^= PlayCondParams.GetHashCode();
		}
		if (StartType != 0)
		{
			num ^= StartType.GetHashCode();
		}
		if (StartTime.Length != 0)
		{
			num ^= StartTime.GetHashCode();
		}
		if (StartCondType != 0)
		{
			num ^= StartCondType.GetHashCode();
		}
		num ^= startCondParams_.GetHashCode();
		if (EndType != 0)
		{
			num ^= EndType.GetHashCode();
		}
		if (EndTime.Length != 0)
		{
			num ^= EndTime.GetHashCode();
		}
		if (EndDuration != 0)
		{
			num ^= EndDuration.GetHashCode();
		}
		if (BannerRes.Length != 0)
		{
			num ^= BannerRes.GetHashCode();
		}
		if (EnterRes.Length != 0)
		{
			num ^= EnterRes.GetHashCode();
		}
		if (TabBgRes.Length != 0)
		{
			num ^= TabBgRes.GetHashCode();
		}
		if (EntranceId != 0)
		{
			num ^= EntranceId.GetHashCode();
		}
		if (HideFromActivityList)
		{
			num ^= HideFromActivityList.GetHashCode();
		}
		if (MiniGameRedDot != 0)
		{
			num ^= MiniGameRedDot.GetHashCode();
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
		if (MidGroupId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(MidGroupId);
		}
		if (SortId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(SortId);
		}
		if (ActivityType != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(ActivityType);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Name);
		}
		if (ActivityThemeType != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(ActivityThemeType);
		}
		if (SpecialParam.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(SpecialParam);
		}
		if (PreLimit != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(PreLimit);
		}
		if (LimitParam.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(LimitParam);
		}
		if (PlayCond != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(PlayCond);
		}
		if (PlayCondParams.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(PlayCondParams);
		}
		if (StartType != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(StartType);
		}
		if (StartTime.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(StartTime);
		}
		if (StartCondType != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(StartCondType);
		}
		startCondParams_.WriteTo(output, _repeated_startCondParams_codec);
		if (EndType != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(EndType);
		}
		if (EndTime.Length != 0)
		{
			output.WriteRawTag(138, 1);
			output.WriteString(EndTime);
		}
		if (EndDuration != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(EndDuration);
		}
		if (BannerRes.Length != 0)
		{
			output.WriteRawTag(154, 1);
			output.WriteString(BannerRes);
		}
		if (EnterRes.Length != 0)
		{
			output.WriteRawTag(162, 1);
			output.WriteString(EnterRes);
		}
		if (TabBgRes.Length != 0)
		{
			output.WriteRawTag(170, 1);
			output.WriteString(TabBgRes);
		}
		if (EntranceId != 0)
		{
			output.WriteRawTag(176, 1);
			output.WriteInt32(EntranceId);
		}
		if (HideFromActivityList)
		{
			output.WriteRawTag(184, 1);
			output.WriteBool(HideFromActivityList);
		}
		if (MiniGameRedDot != 0)
		{
			output.WriteRawTag(192, 1);
			output.WriteInt32(MiniGameRedDot);
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
		if (MidGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MidGroupId);
		}
		if (SortId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SortId);
		}
		if (ActivityType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ActivityType);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (ActivityThemeType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ActivityThemeType);
		}
		if (SpecialParam.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SpecialParam);
		}
		if (PreLimit != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PreLimit);
		}
		if (LimitParam.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(LimitParam);
		}
		if (PlayCond != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PlayCond);
		}
		if (PlayCondParams.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(PlayCondParams);
		}
		if (StartType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StartType);
		}
		if (StartTime.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(StartTime);
		}
		if (StartCondType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StartCondType);
		}
		num += startCondParams_.CalculateSize(_repeated_startCondParams_codec);
		if (EndType != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(EndType);
		}
		if (EndTime.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(EndTime);
		}
		if (EndDuration != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(EndDuration);
		}
		if (BannerRes.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(BannerRes);
		}
		if (EnterRes.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(EnterRes);
		}
		if (TabBgRes.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(TabBgRes);
		}
		if (EntranceId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(EntranceId);
		}
		if (HideFromActivityList)
		{
			num += 3;
		}
		if (MiniGameRedDot != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(MiniGameRedDot);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Activity other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.MidGroupId != 0)
			{
				MidGroupId = other.MidGroupId;
			}
			if (other.SortId != 0)
			{
				SortId = other.SortId;
			}
			if (other.ActivityType != 0)
			{
				ActivityType = other.ActivityType;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.ActivityThemeType != 0)
			{
				ActivityThemeType = other.ActivityThemeType;
			}
			if (other.SpecialParam.Length != 0)
			{
				SpecialParam = other.SpecialParam;
			}
			if (other.PreLimit != 0)
			{
				PreLimit = other.PreLimit;
			}
			if (other.LimitParam.Length != 0)
			{
				LimitParam = other.LimitParam;
			}
			if (other.PlayCond != 0)
			{
				PlayCond = other.PlayCond;
			}
			if (other.PlayCondParams.Length != 0)
			{
				PlayCondParams = other.PlayCondParams;
			}
			if (other.StartType != 0)
			{
				StartType = other.StartType;
			}
			if (other.StartTime.Length != 0)
			{
				StartTime = other.StartTime;
			}
			if (other.StartCondType != 0)
			{
				StartCondType = other.StartCondType;
			}
			startCondParams_.Add(other.startCondParams_);
			if (other.EndType != 0)
			{
				EndType = other.EndType;
			}
			if (other.EndTime.Length != 0)
			{
				EndTime = other.EndTime;
			}
			if (other.EndDuration != 0)
			{
				EndDuration = other.EndDuration;
			}
			if (other.BannerRes.Length != 0)
			{
				BannerRes = other.BannerRes;
			}
			if (other.EnterRes.Length != 0)
			{
				EnterRes = other.EnterRes;
			}
			if (other.TabBgRes.Length != 0)
			{
				TabBgRes = other.TabBgRes;
			}
			if (other.EntranceId != 0)
			{
				EntranceId = other.EntranceId;
			}
			if (other.HideFromActivityList)
			{
				HideFromActivityList = other.HideFromActivityList;
			}
			if (other.MiniGameRedDot != 0)
			{
				MiniGameRedDot = other.MiniGameRedDot;
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
				MidGroupId = input.ReadInt32();
				break;
			case 24u:
				SortId = input.ReadInt32();
				break;
			case 32u:
				ActivityType = input.ReadInt32();
				break;
			case 42u:
				Name = input.ReadString();
				break;
			case 48u:
				ActivityThemeType = input.ReadInt32();
				break;
			case 58u:
				SpecialParam = input.ReadString();
				break;
			case 64u:
				PreLimit = input.ReadInt32();
				break;
			case 74u:
				LimitParam = input.ReadString();
				break;
			case 80u:
				PlayCond = input.ReadInt32();
				break;
			case 90u:
				PlayCondParams = input.ReadString();
				break;
			case 96u:
				StartType = input.ReadInt32();
				break;
			case 106u:
				StartTime = input.ReadString();
				break;
			case 112u:
				StartCondType = input.ReadInt32();
				break;
			case 120u:
			case 122u:
				startCondParams_.AddEntriesFrom(input, _repeated_startCondParams_codec);
				break;
			case 128u:
				EndType = input.ReadInt32();
				break;
			case 138u:
				EndTime = input.ReadString();
				break;
			case 144u:
				EndDuration = input.ReadInt32();
				break;
			case 154u:
				BannerRes = input.ReadString();
				break;
			case 162u:
				EnterRes = input.ReadString();
				break;
			case 170u:
				TabBgRes = input.ReadString();
				break;
			case 176u:
				EntranceId = input.ReadInt32();
				break;
			case 184u:
				HideFromActivityList = input.ReadBool();
				break;
			case 192u:
				MiniGameRedDot = input.ReadInt32();
				break;
			}
		}
	}
}
