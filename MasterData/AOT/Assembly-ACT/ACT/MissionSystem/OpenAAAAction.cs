using System.Threading;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.MissionSystem;

public class OpenAAAAction : MissionAction
{
	protected override async UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions options, CancellationToken token)
	{
		OpenAAAActionParam param = Param as OpenAAAActionParam;
		if (param == null)
		{
			Debug.LogError($"打开专注模式确认弹窗行为参数为空：missionId={Flow.Id}, actionId={Id}");
			return;
		}
		while (!InBattleMain() && !token.IsCancellationRequested)
		{
			await UniTask.Yield();
		}
		TextPanel.Param uiData = new TextPanel.Param
		{
			commonId = 41000201,
			onlyClickOnce = true,
			needPause = true,
			OnConfirm = () =>
			{
				if (!token.IsCancellationRequested && !string.IsNullOrEmpty(param.confirmSignal))
				{
					Flow.SendSignal(param.confirmSignal);
				}
			},
			OnCancel = () =>
			{
				if (!token.IsCancellationRequested && !string.IsNullOrEmpty(param.cancelSignal))
				{
					Flow.SendSignal(param.cancelSignal);
				}
			}
		};
		Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_TEXTPANEL, uiData).Forget();
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
