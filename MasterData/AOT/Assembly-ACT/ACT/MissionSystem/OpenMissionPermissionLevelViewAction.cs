using System;
using System.Threading;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.MissionSystem;

public class OpenMissionPermissionLevelViewAction : MissionAction
{
	protected override async UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		if (!(Param is OpenMissionPermissionLevelViewActionParam openMissionPermissionLevelViewActionParam))
		{
			Debug.LogError("打开权限等级任务指引界面行为参数为空");
			return;
		}
		int missionName = 0;
		if (openMissionPermissionLevelViewActionParam.missionId != 0)
		{
			MissionData missionData = Singleton<MissionManager>.instance.GetMissionData(openMissionPermissionLevelViewActionParam.missionId);
			if (missionData != null)
			{
				missionName = missionData.Config.MissionNameId;
			}
		}
		MissionPermissionLevelViewData viewData = new MissionPermissionLevelViewData
		{
			missionName = missionName,
			permissionLevel = Mathf.Max(1, openMissionPermissionLevelViewActionParam.permissionLevel)
		};
		await UniTask.WaitUntil(InBattleMain, PlayerLoopTiming.Update, token);
		Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_MISSIONPERMISSIONLEVEL, viewData).Forget();
		await UniTask.Delay(TimeSpan.FromSeconds(3.0), ignoreTimeScale: false, PlayerLoopTiming.Update, token);
	}

	private bool InBattleMain()
	{
		if (!Singleton<NewUIManager>.HasInstance())
		{
			return false;
		}
		if (!Singleton<NewUIManager>.instance.TryGetFirstUIController(UI_TYPE.UI_BATTLEMAIN, out var ui))
		{
			return false;
		}
		if (ui.State != UIState.Opened)
		{
			return false;
		}
		return true;
	}
}
