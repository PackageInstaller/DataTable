using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class ActivityInfo : IMessage<ActivityInfo>, IMessage, IEquatable<ActivityInfo>, IDeepCloneable<ActivityInfo>, IBufferMessage
{
	private static readonly MessageParser<ActivityInfo> _parser = new MessageParser<ActivityInfo>(() => new ActivityInfo());

	private UnknownFieldSet _unknownFields;

	public const int ActivitLevelRewardInfosFieldNumber = 1;

	private static readonly MapField<int, ActivitLevelRewardInfo>.Codec _map_activitLevelRewardInfos_codec = new MapField<int, ActivitLevelRewardInfo>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, ActivitLevelRewardInfo.Parser), 10u);

	private readonly MapField<int, ActivitLevelRewardInfo> activitLevelRewardInfos_ = new MapField<int, ActivitLevelRewardInfo>();

	public const int ActivitDoubleDungeonInfosFieldNumber = 2;

	private static readonly MapField<int, ActivitDoubleDungeonInfo>.Codec _map_activitDoubleDungeonInfos_codec = new MapField<int, ActivitDoubleDungeonInfo>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, ActivitDoubleDungeonInfo.Parser), 18u);

	private readonly MapField<int, ActivitDoubleDungeonInfo> activitDoubleDungeonInfos_ = new MapField<int, ActivitDoubleDungeonInfo>();

	public const int ActivitSignInInfosFieldNumber = 3;

	private static readonly MapField<int, ActivitSignInInfo>.Codec _map_activitSignInInfos_codec = new MapField<int, ActivitSignInInfo>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, ActivitSignInInfo.Parser), 26u);

	private readonly MapField<int, ActivitSignInInfo> activitSignInInfos_ = new MapField<int, ActivitSignInInfo>();

	public const int ActivitAbyssInfosFieldNumber = 4;

	private static readonly MapField<int, ActivitAbyssInfo>.Codec _map_activitAbyssInfos_codec = new MapField<int, ActivitAbyssInfo>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, ActivitAbyssInfo.Parser), 34u);

	private readonly MapField<int, ActivitAbyssInfo> activitAbyssInfos_ = new MapField<int, ActivitAbyssInfo>();

	public const int ActivitCombinationInfosFieldNumber = 5;

	private static readonly MapField<int, ActivitCombinationInfo>.Codec _map_activitCombinationInfos_codec = new MapField<int, ActivitCombinationInfo>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, ActivitCombinationInfo.Parser), 42u);

	private readonly MapField<int, ActivitCombinationInfo> activitCombinationInfos_ = new MapField<int, ActivitCombinationInfo>();

	public const int ActivitTempleChallengeInfosFieldNumber = 6;

	private static readonly MapField<int, ActivitTempleChallengeInfo>.Codec _map_activitTempleChallengeInfos_codec = new MapField<int, ActivitTempleChallengeInfo>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, ActivitTempleChallengeInfo.Parser), 50u);

	private readonly MapField<int, ActivitTempleChallengeInfo> activitTempleChallengeInfos_ = new MapField<int, ActivitTempleChallengeInfo>();

	public const int ActivitRoleTrialInfosFieldNumber = 7;

	private static readonly MapField<int, ActivitRoleTrialInfo>.Codec _map_activitRoleTrialInfos_codec = new MapField<int, ActivitRoleTrialInfo>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, ActivitRoleTrialInfo.Parser), 58u);

	private readonly MapField<int, ActivitRoleTrialInfo> activitRoleTrialInfos_ = new MapField<int, ActivitRoleTrialInfo>();

	public const int ActivityDailyLotteryInfosFieldNumber = 8;

	private static readonly MapField<int, ActivityDailyLotteryInfo>.Codec _map_activityDailyLotteryInfos_codec = new MapField<int, ActivityDailyLotteryInfo>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, ActivityDailyLotteryInfo.Parser), 66u);

	private readonly MapField<int, ActivityDailyLotteryInfo> activityDailyLotteryInfos_ = new MapField<int, ActivityDailyLotteryInfo>();

	public const int ActivitSkinTrialInfosFieldNumber = 9;

	private static readonly MapField<int, ActivitSkinTrialInfo>.Codec _map_activitSkinTrialInfos_codec = new MapField<int, ActivitSkinTrialInfo>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, ActivitSkinTrialInfo.Parser), 74u);

	private readonly MapField<int, ActivitSkinTrialInfo> activitSkinTrialInfos_ = new MapField<int, ActivitSkinTrialInfo>();

	public const int ActivityTotalRechargeInfosFieldNumber = 10;

	private static readonly MapField<int, ActivityTotalRechargeInfo>.Codec _map_activityTotalRechargeInfos_codec = new MapField<int, ActivityTotalRechargeInfo>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, ActivityTotalRechargeInfo.Parser), 82u);

	private readonly MapField<int, ActivityTotalRechargeInfo> activityTotalRechargeInfos_ = new MapField<int, ActivityTotalRechargeInfo>();

	public const int ActivityKujiInfosFieldNumber = 11;

	private static readonly MapField<int, ActivityKujiInfo>.Codec _map_activityKujiInfos_codec = new MapField<int, ActivityKujiInfo>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, ActivityKujiInfo.Parser), 90u);

	private readonly MapField<int, ActivityKujiInfo> activityKujiInfos_ = new MapField<int, ActivityKujiInfo>();

	public const int ActivityMainStoryInfosFieldNumber = 12;

	private static readonly MapField<int, ActivityMainStoryInfo>.Codec _map_activityMainStoryInfos_codec = new MapField<int, ActivityMainStoryInfo>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, ActivityMainStoryInfo.Parser), 98u);

	private readonly MapField<int, ActivityMainStoryInfo> activityMainStoryInfos_ = new MapField<int, ActivityMainStoryInfo>();

	public const int ActivityMapExploreInfosFieldNumber = 13;

	private static readonly MapField<int, ActivityMapExploreInfo>.Codec _map_activityMapExploreInfos_codec = new MapField<int, ActivityMapExploreInfo>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, ActivityMapExploreInfo.Parser), 106u);

	private readonly MapField<int, ActivityMapExploreInfo> activityMapExploreInfos_ = new MapField<int, ActivityMapExploreInfo>();

	public const int ActivityMultiDeviceInfosFieldNumber = 14;

	private static readonly MapField<int, ActivityMultiDeviceInfo>.Codec _map_activityMultiDeviceInfos_codec = new MapField<int, ActivityMultiDeviceInfo>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, ActivityMultiDeviceInfo.Parser), 114u);

	private readonly MapField<int, ActivityMultiDeviceInfo> activityMultiDeviceInfos_ = new MapField<int, ActivityMultiDeviceInfo>();

	public const int ActivityCompanionInfosFieldNumber = 15;

	private static readonly MapField<int, ActivityCompanionInfo>.Codec _map_activityCompanionInfos_codec = new MapField<int, ActivityCompanionInfo>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, ActivityCompanionInfo.Parser), 122u);

	private readonly MapField<int, ActivityCompanionInfo> activityCompanionInfos_ = new MapField<int, ActivityCompanionInfo>();

	public const int FinishedActivityIdsFieldNumber = 100;

	private static readonly MapField<int, bool>.Codec _map_finishedActivityIds_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 802u);

	private readonly MapField<int, bool> finishedActivityIds_ = new MapField<int, bool>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ActivityInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[250];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, ActivitLevelRewardInfo> ActivitLevelRewardInfos => activitLevelRewardInfos_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, ActivitDoubleDungeonInfo> ActivitDoubleDungeonInfos => activitDoubleDungeonInfos_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, ActivitSignInInfo> ActivitSignInInfos => activitSignInInfos_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, ActivitAbyssInfo> ActivitAbyssInfos => activitAbyssInfos_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, ActivitCombinationInfo> ActivitCombinationInfos => activitCombinationInfos_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, ActivitTempleChallengeInfo> ActivitTempleChallengeInfos => activitTempleChallengeInfos_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, ActivitRoleTrialInfo> ActivitRoleTrialInfos => activitRoleTrialInfos_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, ActivityDailyLotteryInfo> ActivityDailyLotteryInfos => activityDailyLotteryInfos_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, ActivitSkinTrialInfo> ActivitSkinTrialInfos => activitSkinTrialInfos_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, ActivityTotalRechargeInfo> ActivityTotalRechargeInfos => activityTotalRechargeInfos_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, ActivityKujiInfo> ActivityKujiInfos => activityKujiInfos_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, ActivityMainStoryInfo> ActivityMainStoryInfos => activityMainStoryInfos_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, ActivityMapExploreInfo> ActivityMapExploreInfos => activityMapExploreInfos_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, ActivityMultiDeviceInfo> ActivityMultiDeviceInfos => activityMultiDeviceInfos_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, ActivityCompanionInfo> ActivityCompanionInfos => activityCompanionInfos_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> FinishedActivityIds => finishedActivityIds_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityInfo(ActivityInfo other)
		: this()
	{
		activitLevelRewardInfos_ = other.activitLevelRewardInfos_.Clone();
		activitDoubleDungeonInfos_ = other.activitDoubleDungeonInfos_.Clone();
		activitSignInInfos_ = other.activitSignInInfos_.Clone();
		activitAbyssInfos_ = other.activitAbyssInfos_.Clone();
		activitCombinationInfos_ = other.activitCombinationInfos_.Clone();
		activitTempleChallengeInfos_ = other.activitTempleChallengeInfos_.Clone();
		activitRoleTrialInfos_ = other.activitRoleTrialInfos_.Clone();
		activityDailyLotteryInfos_ = other.activityDailyLotteryInfos_.Clone();
		activitSkinTrialInfos_ = other.activitSkinTrialInfos_.Clone();
		activityTotalRechargeInfos_ = other.activityTotalRechargeInfos_.Clone();
		activityKujiInfos_ = other.activityKujiInfos_.Clone();
		activityMainStoryInfos_ = other.activityMainStoryInfos_.Clone();
		activityMapExploreInfos_ = other.activityMapExploreInfos_.Clone();
		activityMultiDeviceInfos_ = other.activityMultiDeviceInfos_.Clone();
		activityCompanionInfos_ = other.activityCompanionInfos_.Clone();
		finishedActivityIds_ = other.finishedActivityIds_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityInfo Clone()
	{
		return new ActivityInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ActivityInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!ActivitLevelRewardInfos.Equals(other.ActivitLevelRewardInfos))
		{
			return false;
		}
		if (!ActivitDoubleDungeonInfos.Equals(other.ActivitDoubleDungeonInfos))
		{
			return false;
		}
		if (!ActivitSignInInfos.Equals(other.ActivitSignInInfos))
		{
			return false;
		}
		if (!ActivitAbyssInfos.Equals(other.ActivitAbyssInfos))
		{
			return false;
		}
		if (!ActivitCombinationInfos.Equals(other.ActivitCombinationInfos))
		{
			return false;
		}
		if (!ActivitTempleChallengeInfos.Equals(other.ActivitTempleChallengeInfos))
		{
			return false;
		}
		if (!ActivitRoleTrialInfos.Equals(other.ActivitRoleTrialInfos))
		{
			return false;
		}
		if (!ActivityDailyLotteryInfos.Equals(other.ActivityDailyLotteryInfos))
		{
			return false;
		}
		if (!ActivitSkinTrialInfos.Equals(other.ActivitSkinTrialInfos))
		{
			return false;
		}
		if (!ActivityTotalRechargeInfos.Equals(other.ActivityTotalRechargeInfos))
		{
			return false;
		}
		if (!ActivityKujiInfos.Equals(other.ActivityKujiInfos))
		{
			return false;
		}
		if (!ActivityMainStoryInfos.Equals(other.ActivityMainStoryInfos))
		{
			return false;
		}
		if (!ActivityMapExploreInfos.Equals(other.ActivityMapExploreInfos))
		{
			return false;
		}
		if (!ActivityMultiDeviceInfos.Equals(other.ActivityMultiDeviceInfos))
		{
			return false;
		}
		if (!ActivityCompanionInfos.Equals(other.ActivityCompanionInfos))
		{
			return false;
		}
		if (!FinishedActivityIds.Equals(other.FinishedActivityIds))
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override int GetHashCode()
	{
		int num = 1;
		num ^= ActivitLevelRewardInfos.GetHashCode();
		num ^= ActivitDoubleDungeonInfos.GetHashCode();
		num ^= ActivitSignInInfos.GetHashCode();
		num ^= ActivitAbyssInfos.GetHashCode();
		num ^= ActivitCombinationInfos.GetHashCode();
		num ^= ActivitTempleChallengeInfos.GetHashCode();
		num ^= ActivitRoleTrialInfos.GetHashCode();
		num ^= ActivityDailyLotteryInfos.GetHashCode();
		num ^= ActivitSkinTrialInfos.GetHashCode();
		num ^= ActivityTotalRechargeInfos.GetHashCode();
		num ^= ActivityKujiInfos.GetHashCode();
		num ^= ActivityMainStoryInfos.GetHashCode();
		num ^= ActivityMapExploreInfos.GetHashCode();
		num ^= ActivityMultiDeviceInfos.GetHashCode();
		num ^= ActivityCompanionInfos.GetHashCode();
		num ^= FinishedActivityIds.GetHashCode();
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void WriteTo(CodedOutputStream output)
	{
		output.WriteRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalWriteTo(ref WriteContext output)
	{
		activitLevelRewardInfos_.WriteTo(ref output, _map_activitLevelRewardInfos_codec);
		activitDoubleDungeonInfos_.WriteTo(ref output, _map_activitDoubleDungeonInfos_codec);
		activitSignInInfos_.WriteTo(ref output, _map_activitSignInInfos_codec);
		activitAbyssInfos_.WriteTo(ref output, _map_activitAbyssInfos_codec);
		activitCombinationInfos_.WriteTo(ref output, _map_activitCombinationInfos_codec);
		activitTempleChallengeInfos_.WriteTo(ref output, _map_activitTempleChallengeInfos_codec);
		activitRoleTrialInfos_.WriteTo(ref output, _map_activitRoleTrialInfos_codec);
		activityDailyLotteryInfos_.WriteTo(ref output, _map_activityDailyLotteryInfos_codec);
		activitSkinTrialInfos_.WriteTo(ref output, _map_activitSkinTrialInfos_codec);
		activityTotalRechargeInfos_.WriteTo(ref output, _map_activityTotalRechargeInfos_codec);
		activityKujiInfos_.WriteTo(ref output, _map_activityKujiInfos_codec);
		activityMainStoryInfos_.WriteTo(ref output, _map_activityMainStoryInfos_codec);
		activityMapExploreInfos_.WriteTo(ref output, _map_activityMapExploreInfos_codec);
		activityMultiDeviceInfos_.WriteTo(ref output, _map_activityMultiDeviceInfos_codec);
		activityCompanionInfos_.WriteTo(ref output, _map_activityCompanionInfos_codec);
		finishedActivityIds_.WriteTo(ref output, _map_finishedActivityIds_codec);
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(ref output);
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CalculateSize()
	{
		int num = 0;
		num += activitLevelRewardInfos_.CalculateSize(_map_activitLevelRewardInfos_codec);
		num += activitDoubleDungeonInfos_.CalculateSize(_map_activitDoubleDungeonInfos_codec);
		num += activitSignInInfos_.CalculateSize(_map_activitSignInInfos_codec);
		num += activitAbyssInfos_.CalculateSize(_map_activitAbyssInfos_codec);
		num += activitCombinationInfos_.CalculateSize(_map_activitCombinationInfos_codec);
		num += activitTempleChallengeInfos_.CalculateSize(_map_activitTempleChallengeInfos_codec);
		num += activitRoleTrialInfos_.CalculateSize(_map_activitRoleTrialInfos_codec);
		num += activityDailyLotteryInfos_.CalculateSize(_map_activityDailyLotteryInfos_codec);
		num += activitSkinTrialInfos_.CalculateSize(_map_activitSkinTrialInfos_codec);
		num += activityTotalRechargeInfos_.CalculateSize(_map_activityTotalRechargeInfos_codec);
		num += activityKujiInfos_.CalculateSize(_map_activityKujiInfos_codec);
		num += activityMainStoryInfos_.CalculateSize(_map_activityMainStoryInfos_codec);
		num += activityMapExploreInfos_.CalculateSize(_map_activityMapExploreInfos_codec);
		num += activityMultiDeviceInfos_.CalculateSize(_map_activityMultiDeviceInfos_codec);
		num += activityCompanionInfos_.CalculateSize(_map_activityCompanionInfos_codec);
		num += finishedActivityIds_.CalculateSize(_map_finishedActivityIds_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ActivityInfo other)
	{
		if (other != null)
		{
			activitLevelRewardInfos_.Add(other.activitLevelRewardInfos_);
			activitDoubleDungeonInfos_.Add(other.activitDoubleDungeonInfos_);
			activitSignInInfos_.Add(other.activitSignInInfos_);
			activitAbyssInfos_.Add(other.activitAbyssInfos_);
			activitCombinationInfos_.Add(other.activitCombinationInfos_);
			activitTempleChallengeInfos_.Add(other.activitTempleChallengeInfos_);
			activitRoleTrialInfos_.Add(other.activitRoleTrialInfos_);
			activityDailyLotteryInfos_.Add(other.activityDailyLotteryInfos_);
			activitSkinTrialInfos_.Add(other.activitSkinTrialInfos_);
			activityTotalRechargeInfos_.Add(other.activityTotalRechargeInfos_);
			activityKujiInfos_.Add(other.activityKujiInfos_);
			activityMainStoryInfos_.Add(other.activityMainStoryInfos_);
			activityMapExploreInfos_.Add(other.activityMapExploreInfos_);
			activityMultiDeviceInfos_.Add(other.activityMultiDeviceInfos_);
			activityCompanionInfos_.Add(other.activityCompanionInfos_);
			finishedActivityIds_.Add(other.finishedActivityIds_);
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CodedInputStream input)
	{
		input.ReadRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalMergeFrom(ref ParseContext input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			switch (num)
			{
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				break;
			case 10u:
				activitLevelRewardInfos_.AddEntriesFrom(ref input, _map_activitLevelRewardInfos_codec);
				break;
			case 18u:
				activitDoubleDungeonInfos_.AddEntriesFrom(ref input, _map_activitDoubleDungeonInfos_codec);
				break;
			case 26u:
				activitSignInInfos_.AddEntriesFrom(ref input, _map_activitSignInInfos_codec);
				break;
			case 34u:
				activitAbyssInfos_.AddEntriesFrom(ref input, _map_activitAbyssInfos_codec);
				break;
			case 42u:
				activitCombinationInfos_.AddEntriesFrom(ref input, _map_activitCombinationInfos_codec);
				break;
			case 50u:
				activitTempleChallengeInfos_.AddEntriesFrom(ref input, _map_activitTempleChallengeInfos_codec);
				break;
			case 58u:
				activitRoleTrialInfos_.AddEntriesFrom(ref input, _map_activitRoleTrialInfos_codec);
				break;
			case 66u:
				activityDailyLotteryInfos_.AddEntriesFrom(ref input, _map_activityDailyLotteryInfos_codec);
				break;
			case 74u:
				activitSkinTrialInfos_.AddEntriesFrom(ref input, _map_activitSkinTrialInfos_codec);
				break;
			case 82u:
				activityTotalRechargeInfos_.AddEntriesFrom(ref input, _map_activityTotalRechargeInfos_codec);
				break;
			case 90u:
				activityKujiInfos_.AddEntriesFrom(ref input, _map_activityKujiInfos_codec);
				break;
			case 98u:
				activityMainStoryInfos_.AddEntriesFrom(ref input, _map_activityMainStoryInfos_codec);
				break;
			case 106u:
				activityMapExploreInfos_.AddEntriesFrom(ref input, _map_activityMapExploreInfos_codec);
				break;
			case 114u:
				activityMultiDeviceInfos_.AddEntriesFrom(ref input, _map_activityMultiDeviceInfos_codec);
				break;
			case 122u:
				activityCompanionInfos_.AddEntriesFrom(ref input, _map_activityCompanionInfos_codec);
				break;
			case 802u:
				finishedActivityIds_.AddEntriesFrom(ref input, _map_finishedActivityIds_codec);
				break;
			}
		}
	}
}
