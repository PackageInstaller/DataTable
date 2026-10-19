using System;
using System.Threading;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.MissionSystem;

public class BlackScreenScope : IScope
{
	public bool fromMustDo;

	public string ScopeId => "BlackScreenScope";

	public async UniTask Enter(object options, CancellationToken token)
	{
		BlackScreenActionParam blackScreenActionParam = (BlackScreenActionParam)options;
		Singleton<NewUIManager>.instance.BlackScreen.SetBlackScreenText(0, 1f);
		if (fromMustDo)
		{
			await Show(0f, blackScreenActionParam.duration);
		}
		else
		{
			await Show(blackScreenActionParam.time, blackScreenActionParam.duration);
		}
	}

	public UniTask Exit(object options, CancellationToken token)
	{
		if (options != null)
		{
			BlackScreenActionParam blackScreenActionParam = (BlackScreenActionParam)options;
			Singleton<NewUIManager>.instance.BlackScreen.SetBlackScreenText(0, 1f);
			Hide(blackScreenActionParam.time, blackScreenActionParam.duration);
		}
		else
		{
			Singleton<NewUIManager>.instance.BlackScreen.SetBlackScreenText(0, 1f);
			Hide(0f, 0f);
		}
		return UniTask.CompletedTask;
	}

	private async UniTask Show(float time, float duration)
	{
		Singleton<NewUIManager>.instance.BlackScreen.Enable(new FrameworkBlackScreenData
		{
			fadeInTime = TimeSpan.FromSeconds(time)
		}).Forget();
		await UniTask.Delay(TimeSpan.FromSeconds(time));
		await UniTask.Delay(TimeSpan.FromSeconds(duration));
	}

	private async void Hide(float time, float duration)
	{
		await UniTask.Delay(TimeSpan.FromSeconds(duration));
		Singleton<NewUIManager>.instance.BlackScreen.Disable(new FrameworkBlackScreenData
		{
			fadeOutTime = TimeSpan.FromSeconds(time)
		}).Forget();
		await UniTask.Delay(TimeSpan.FromSeconds(time));
	}
}
