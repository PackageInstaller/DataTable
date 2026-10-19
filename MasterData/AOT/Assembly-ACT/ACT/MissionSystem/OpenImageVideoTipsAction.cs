using System.Threading;
using ACT.Model;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.MissionSystem;

public class OpenImageVideoTipsAction : MissionAction
{
	protected override async UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		while (!InBattleMain() && !token.IsCancellationRequested)
		{
			await UniTask.Yield();
		}
		if (token.IsCancellationRequested)
		{
			return;
		}
		OpenImageVideoTipsActionParam openImageVideoTipsActionParam = Param as OpenImageVideoTipsActionParam;
		if (await Model<GuideModel>.Interface.OpenImageVideoTips(openImageVideoTipsActionParam.tutorialId))
		{
			IBaseUIView view = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_GUIDEIMAGEVIDEO);
			await UniTask.WaitUntil(() => view == null || view.UIController.State == UIState.Closed, PlayerLoopTiming.Update, token);
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
