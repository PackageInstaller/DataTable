using System;
using System.Collections.Generic;
using Newtonsoft.Json;

namespace ACT.MissionSystem;

public static class ActionDefine
{
	public class ActionDefineInfo
	{
		public readonly int TypeId;

		public readonly Type ParamType;

		public readonly Type ProcessorType;

		public ActionDefineInfo(int typeId, Type paramType, Type processorType)
		{
			TypeId = typeId;
			ParamType = paramType;
			ProcessorType = processorType;
		}
	}

	private static Dictionary<int, ActionDefineInfo> s_ActionDefineInfos;

	public static IReadOnlyDictionary<int, ActionDefineInfo> DefineInfos => s_ActionDefineInfos;

	static ActionDefine()
	{
		s_ActionDefineInfos = new Dictionary<int, ActionDefineInfo>();
		RegisterActions();
	}

	private static void RegisterActions()
	{
		RegisterAction(9, typeof(PlayAsideActionParam), typeof(PlayAsideAction));
		RegisterAction(10, typeof(SpawnMonsterActionParam), typeof(SpawnMonsterAction));
		RegisterAction(11, typeof(TPActionParam), typeof(TPAction));
		RegisterAction(12, typeof(SetRebornPointActionParam), typeof(SetRebornPointAction));
		RegisterAction(13, typeof(SetInteractableStatesActionParam), typeof(SetInteractableStatesAction));
		RegisterAction(18, typeof(TPWithWorldActionParam), typeof(TPWithWorldAction));
		RegisterAction(20, typeof(OpenSNSActionParam), typeof(OpenSNSAction));
		RegisterAction(21, typeof(SendSNSActionParam), typeof(SendSNSAction));
		RegisterAction(22, typeof(SetUIModuleStateActionParam), typeof(SetUIModuleStateAction));
		RegisterAction(23, typeof(SetInputStateActionParam), typeof(SetInputStateAction));
		RegisterAction(24, typeof(TeamChargeActionParam), typeof(TeamChargeAction));
		RegisterAction(25, typeof(StartSoftGuideActionParam), typeof(StartSoftGuideAction));
		RegisterAction(26, typeof(StartHardGuideActionParam), typeof(StartHardGuideAction));
		RegisterAction(27, typeof(SetupBloodBottleActionParam), typeof(SetupBloodBottleAction));
		RegisterAction(28, typeof(UnlockSystemActionParam), typeof(UnlockSystemAction));
		RegisterAction(29, typeof(AddItemActionParam), typeof(AddItemAction));
		RegisterAction(31, typeof(PlayTimelineConversationActionParam), typeof(PlayTimelineConversationAction));
		RegisterAction(32, typeof(LoadBluePrintActionParam), typeof(LoadBluePrintAction));
		RegisterAction(33, typeof(UnloadBluePrintActionParam), typeof(UnloadBluePrintAction));
		RegisterAction(39, typeof(DeleteItemActionParam), typeof(DeleteItemAction));
		RegisterAction(40, typeof(SystemUnlockEventActionParam), typeof(SystemUnlockEventAction));
		RegisterAction(41, typeof(AddMissionMarkActionParam), typeof(AddMissionMarkAction));
		RegisterAction(42, typeof(OpenUIViewActionParam), typeof(OpenUIViewAction));
		RegisterAction(43, typeof(DeleteMissionMarkActionParam), typeof(DeleteMissionMarkAction));
		RegisterAction(51, typeof(SetNoMoveRespawnSettingActionParam), typeof(SetNoMoveRespawnSettingAction));
		RegisterAction(52, typeof(RemoveRespawnSettingActionParam), typeof(RemoveRespawnSettingAction));
		RegisterAction(53, typeof(DisableTPBtnActionParam), typeof(DisableTPBtnAction));
		RegisterAction(54, typeof(EnableTPBtnActionParam), typeof(EnableTPBtnAction));
		RegisterAction(55, typeof(BlackScreenActionParam), typeof(BlackScreenAction));
		RegisterAction(56, typeof(SetRespawnToRespawnPosSettingActionParam), typeof(SetRespawnToRespawnPosSettingAction));
		RegisterAction(64, typeof(SendKeyPointActionParam), typeof(SendKeyPointAction));
		RegisterAction(65, typeof(ChangeStandardElevatorFloorActionParam), typeof(ChangeStandardElevatorFloorAction));
		RegisterAction(66, typeof(PlaySpecialBGMActionParam), typeof(PlaySpecialBGMAction));
		RegisterAction(67, typeof(SetSpecialBGMStateActionParam), typeof(SetSpecialBGMStateAction));
		RegisterAction(68, typeof(OpenImageVideoTipsActionParam), typeof(OpenImageVideoTipsAction));
		RegisterAction(69, typeof(PlayAVGActionParam), typeof(PlayAVGAction));
		RegisterAction(70, typeof(PlayTimelineActionParam), typeof(PlayTimelineAction));
		RegisterAction(71, typeof(MissionChapterTipActionParam), typeof(MissionChapterTipAction));
		RegisterAction(74, typeof(EnterProtagonistModeActionParam), typeof(EnterProtagonistModeAction));
		RegisterAction(75, typeof(ExitProtagonistModeActionParam), typeof(ExitProtagonistModeAction));
		RegisterAction(83, typeof(StartRaidActionParam), typeof(StartRaidAction));
		RegisterAction(87, typeof(OpenReadableViewActionParam), typeof(OpenReadableViewAction));
		RegisterAction(88, typeof(SetRespawnToCustomPosSettingActionParam), typeof(SetRespawnToCustomPosSettingAction));
		RegisterAction(89, typeof(WorldLevelBreakTaskTipActionParam), typeof(WorldLevelBreakTaskTipAction));
		RegisterAction(93, typeof(ClearKeyPointActionParam), typeof(ClearKeyPointAction));
		RegisterAction(98, typeof(TriggerCountdownTutorialActionParam), typeof(TriggerCountdownTutorialAction));
		RegisterAction(99, typeof(EnterTrailCharacterModelActionParam), typeof(EnterTrailCharacterModelAction));
		RegisterAction(100, typeof(ExitTrialCharacterModeActionParam), typeof(ExitTrialCharacterModeAction));
		RegisterAction(101, typeof(OpenMissionPermissionLevelViewActionParam), typeof(OpenMissionPermissionLevelViewAction));
		RegisterAction(103, typeof(OpenAAAActionParam), typeof(OpenAAAAction));
	}

	public static void RegisterAction(int type, Type paramType, Type processorType)
	{
		s_ActionDefineInfos.Add(type, new ActionDefineInfo(type, paramType, processorType));
	}

	public static object DeserializeActionParam(int typeId, string jsonData)
	{
		if (!s_ActionDefineInfos.TryGetValue(typeId, out var value))
		{
			return null;
		}
		if (string.IsNullOrEmpty(jsonData))
		{
			return Activator.CreateInstance(value.ParamType);
		}
		return JsonConvert.DeserializeObject(jsonData, value.ParamType);
	}

	public static string SerializeActionParam(int typeId, object parameter)
	{
		return JsonConvert.SerializeObject(parameter);
	}

	public static MissionAction CreateActionProcessor(MissionActionData data)
	{
		if (!s_ActionDefineInfos.TryGetValue(data.Type, out var value))
		{
			return null;
		}
		MissionAction obj = Activator.CreateInstance(value.ProcessorType) as MissionAction;
		((IMissionActionInternal)obj).Init(data);
		return obj;
	}
}
