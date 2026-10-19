using System;
using System.Collections.Generic;
using Newtonsoft.Json;

namespace ACT.MissionSystem;

public static class ConditionDefine
{
	public class ConditionDefineInfo
	{
		public readonly int TypeId;

		public readonly Type ParamType;

		public readonly Type ProcessorType;

		public ConditionDefineInfo(int typeId, Type paramType, Type processorType)
		{
			TypeId = typeId;
			ParamType = paramType;
			ProcessorType = processorType;
		}
	}

	private static Dictionary<int, ConditionDefineInfo> s_ConditionDefineInfos;

	public static IReadOnlyDictionary<int, ConditionDefineInfo> DefineInfos => s_ConditionDefineInfos;

	static ConditionDefine()
	{
		s_ConditionDefineInfos = new Dictionary<int, ConditionDefineInfo>();
		RegisterConditions();
	}

	private static void RegisterConditions()
	{
		RegisterCondition(2, typeof(PlayDialogueUntilCompletedConditionParam), typeof(PlayDialogueUntilCompletedCondition));
		RegisterCondition(3, typeof(PlayTimelineUntilCompletedConditionParam), typeof(PlayTimelineUntilCompletedCondition));
		RegisterCondition(4, typeof(MissionCompletedConditionParam), typeof(MissionCompletedCondition));
		RegisterCondition(5, typeof(TeamAllDeadConditionParam), typeof(TeamAllDeadCondition));
		RegisterCondition(6, typeof(PlayerLevelRangeConditionParam), typeof(PlayerLevelRangeCondition));
		RegisterCondition(7, typeof(EnterAreaConditionParam), typeof(EnterAreaCondition));
		RegisterCondition(8, typeof(OfflineConditionParam), typeof(OfflineCondition));
		RegisterCondition(14, typeof(KillDynamicMonsterConditionParam), typeof(KillDynamicMonsterCondition));
		RegisterCondition(15, typeof(KillStaticMonsterConditionParam), typeof(KillStaticMonsterCondition));
		RegisterCondition(16, typeof(InteractObjectStateConditionParam), typeof(InteractObjectStateCondition));
		RegisterCondition(17, typeof(BlueprintConditionParam), typeof(BlueprintCondition));
		RegisterCondition(19, typeof(ItemConditionParam), typeof(ItemCondition));
		RegisterCondition(30, typeof(ItemSubmitNPCConditionParam), typeof(ItemSubmitNPCCondition));
		RegisterCondition(34, typeof(ExitFixedAreaConditionParam), typeof(ExitFixedAreaCondition));
		RegisterCondition(35, typeof(EnterFixedAreaConditionParam), typeof(EnterFixedAreaCondition));
		RegisterCondition(36, typeof(DaysConditionParam), typeof(DaysCondition));
		RegisterCondition(37, typeof(InUIViewConditionParam), typeof(InUIViewCondition));
		RegisterCondition(38, typeof(InMapAreaConditionParam), typeof(InMapAreaCondition));
		RegisterCondition(44, typeof(UntilDialogueCompletedConditionParam), typeof(UntilDialogueCompletedCondition));
		RegisterCondition(45, typeof(GlobalEventConditionParam), typeof(GlobalEventCondition));
		RegisterCondition(46, typeof(GlobalStringEventConditionParam), typeof(GlobalStringEventCondition));
		RegisterCondition(47, typeof(PlayDialogueWithNpcUntilCompletedConditionParam), typeof(PlayDialogueWithNpcUntilCompletedCondition));
		RegisterCondition(48, typeof(PlayTimelineWithNpcUntilCompletedConditionParam), typeof(PlayTimelineWithNpcUntilCompletedCondition));
		RegisterCondition(49, typeof(StartGuideUntilCompletedConditionParam), typeof(StartGuideUntilCompletedCondition));
		RegisterCondition(50, typeof(SystemUnlockAnimConditionParam), typeof(SystemUnlockAnimCondition));
		RegisterCondition(57, typeof(ChaseFailConditionParam), typeof(ChaseFailCondition));
		RegisterCondition(58, typeof(OnReceiveClientEventConditionParam), typeof(OnReceiveClientEventCondition));
		RegisterCondition(59, typeof(UntilTimelineCompletedConditionParam), typeof(UntilTimelineCompletedCondition));
		RegisterCondition(60, typeof(SecondsConditionParam), typeof(SecondsCondition));
		RegisterCondition(61, typeof(WorldLevelRangeConditionParam), typeof(WorldLevelRangeCondition));
		RegisterCondition(62, typeof(TemplesCompletedConditionParam), typeof(TemplesCompletedCondition));
		RegisterCondition(63, typeof(AwaitKeyPointConditionParam), typeof(AwaitKeyPointCondition));
		RegisterCondition(72, typeof(SystemUnlockConditionParam), typeof(SystemUnlockCondition));
		RegisterCondition(73, typeof(ExitMissionWorldConditionParam), typeof(ExitMissionWorldCondition));
		RegisterCondition(77, typeof(CheckAsideCompletedConditionParam), typeof(CheckAsideCompletedCondition));
		RegisterCondition(78, typeof(CheckBattleRoomWavesConditionParam), typeof(CheckBattleRoomWavesCondition));
		RegisterCondition(79, typeof(CheckBattleRoomMonsterHPConditionParam), typeof(CheckBattleRoomMonsterHPCondition));
		RegisterCondition(80, typeof(CheckDialogueOptionConditionParam), typeof(CheckDialogueOptionCondition));
		RegisterCondition(81, typeof(CheckSNSCompletedConditionParam), typeof(CheckSNSCompletedCondition));
		RegisterCondition(82, typeof(KCMissionsConditionParam), typeof(KCMissionCondition));
		RegisterCondition(84, typeof(ItemSubmitInteractConditionParam), typeof(ItemSubmitInteractCondition));
		RegisterCondition(85, typeof(UntilPreconditionGroupCompleteParam), typeof(UntilPreconditionGroupComplete));
		RegisterCondition(86, typeof(OpenReadableViewConditionParam), typeof(OpenReadableViewCondition));
		RegisterCondition(90, typeof(TextLibraryReadConditionParam), typeof(TextLibraryReadCondition));
		RegisterCondition(91, typeof(PlayMiniGameUntilCompletedConditionParam), typeof(PlayMiniGameUntilCompletedCondition));
		RegisterCondition(92, typeof(ReceiveMissionSignalConditionParam), typeof(ReceiveMissionSignalCondition));
		RegisterCondition(94, typeof(RoguelikeCompletionConditionParam), typeof(RoguelikeCompletionCondition));
		RegisterCondition(95, typeof(AbyssCompletionConditionParam), typeof(AbyssCompletionCondition));
		RegisterCondition(96, typeof(TrainingCompletionConditionParam), typeof(TrainingCompletionCondition));
		RegisterCondition(97, typeof(PermissionLevelConditionParam), typeof(PermissionLevelCondition));
		RegisterCondition(102, typeof(EnterAAAConditionParam), typeof(EnterAAACondition));
		RegisterCondition(104, typeof(CountdownSignalConditionParam), typeof(CountdownSignalCondition));
		RegisterCondition(105, typeof(ExitAreaConditionParam), typeof(ExitAreaCondition));
		RegisterCondition(106, typeof(BindEnvNodeConditionParam), typeof(BindEnvNodeCondition));
		RegisterCondition(107, typeof(ChunkChangeConditionParam), typeof(ChunkChangeCondition));
		RegisterCondition(108, typeof(ExitProtagonistModeConditionParam), typeof(ExitProtagonistModeCondition));
	}

	public static void RegisterCondition(int type, Type paramType, Type processorType)
	{
		s_ConditionDefineInfos.Add(type, new ConditionDefineInfo(type, paramType, processorType));
	}

	public static object DeserializeConditionParam(int typeId, string jsonData)
	{
		if (!s_ConditionDefineInfos.TryGetValue(typeId, out var value))
		{
			return null;
		}
		if (string.IsNullOrEmpty(jsonData))
		{
			return Activator.CreateInstance(value.ParamType);
		}
		return JsonConvert.DeserializeObject(jsonData, value.ParamType);
	}

	public static string SerializeConditionParam(int typeId, object parameter)
	{
		return JsonConvert.SerializeObject(parameter);
	}

	public static MissionCondition CreateConditionProcessor(MissionConditionData data)
	{
		if (!s_ConditionDefineInfos.TryGetValue(data.Type, out var value))
		{
			return null;
		}
		MissionCondition obj = Activator.CreateInstance(value.ProcessorType) as MissionCondition;
		((IMissionConditionInternal)obj).Init(value, data);
		return obj;
	}
}
