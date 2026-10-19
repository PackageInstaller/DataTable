using System.Threading;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.MissionSystem;

public class MissionChapterTipAction : MissionAction
{
	protected override async UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		MissionChapterTipActionParam param = Param as MissionChapterTipActionParam;
		MissionData missionData = Flow.Data;
		await UniTask.WaitUntil(InBattleMain, PlayerLoopTiming.Update, token);
		if (token.IsCancellationRequested)
		{
			return;
		}
		MissionType missionTypeEnum = missionData.Config.MissionTypeEnum;
		if ((uint)(missionTypeEnum - 1) <= 1u || missionTypeEnum == MissionType.Legend)
		{
			UIOpenResult openUIResult = await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_TASKPOP, new MonoTaskPopView.TaskPopPara
			{
				mainMissionId = Flow.Id,
				isOpen = (param.tipType == MissionChapterTipActionParam.MissionChapterTipType.Begin)
			});
			if (!token.IsCancellationRequested)
			{
				await Singleton<NewUIManager>.instance.WaitUICloseAsync(openUIResult);
			}
		}
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
