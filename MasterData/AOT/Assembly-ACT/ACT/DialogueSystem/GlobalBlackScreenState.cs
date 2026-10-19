using System;
using System.Threading;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.DialogueSystem;

public class GlobalBlackScreenState : DialogueState
{
	public bool active;

	protected override UniTask ApplyImmediate(DialogueContext context, CancellationToken token)
	{
		if (active)
		{
			Singleton<NewUIManager>.instance.BlackScreen.SetBlackScreenText(0, 0f);
			return Singleton<NewUIManager>.instance.BlackScreen.Enable(new FrameworkBlackScreenData
			{
				fadeInTime = TimeSpan.FromSeconds(0.0),
				fadeOutTime = TimeSpan.FromSeconds(0.0)
			});
		}
		Singleton<NewUIManager>.instance.BlackScreen.SetBlackScreenText(0, 0f);
		return Singleton<NewUIManager>.instance.BlackScreen.Disable(new FrameworkBlackScreenData
		{
			fadeInTime = TimeSpan.FromSeconds(0.0),
			fadeOutTime = TimeSpan.FromSeconds(0.0)
		});
	}

	public void Begin()
	{
		active = true;
	}

	public void End()
	{
		active = false;
	}

	public async UniTask Show(float speed, CancellationToken token)
	{
		Singleton<NewUIManager>.instance.BlackScreen.SetBlackScreenText(0, 0f);
		FrameworkBlackScreenData data = new FrameworkBlackScreenData
		{
			fadeInTime = TimeSpan.FromSeconds(speed),
			fadeOutTime = TimeSpan.FromSeconds(speed)
		};
		if (speed <= 0f)
		{
			await Singleton<NewUIManager>.instance.BlackScreen.Enable(data);
			return;
		}
		Singleton<NewUIManager>.instance.BlackScreen.Enable(data).Forget();
		await LuminDialogueUtility.DelayOrForceNext(TimeSpan.FromSeconds(speed), token, () =>
		{
			Singleton<NewUIManager>.instance.BlackScreen.SetBlackScreenText(0, 0f);
			Singleton<NewUIManager>.instance.BlackScreen.Enable(new FrameworkBlackScreenData
			{
				fadeInTime = TimeSpan.Zero,
				fadeOutTime = TimeSpan.Zero
			}).Forget();
		});
	}

	public async UniTask Hide(float speed, CancellationToken token)
	{
		Singleton<NewUIManager>.instance.BlackScreen.SetBlackScreenText(0, 0f);
		FrameworkBlackScreenData data = new FrameworkBlackScreenData
		{
			fadeInTime = TimeSpan.FromSeconds(speed),
			fadeOutTime = TimeSpan.FromSeconds(speed)
		};
		if (speed <= 0f)
		{
			await Singleton<NewUIManager>.instance.BlackScreen.Disable(data);
			return;
		}
		Singleton<NewUIManager>.instance.BlackScreen.Disable(data).Forget();
		await LuminDialogueUtility.DelayOrForceNext(TimeSpan.FromSeconds(speed), token, () =>
		{
			Singleton<NewUIManager>.instance.BlackScreen.SetBlackScreenText(0, 0f);
			Singleton<NewUIManager>.instance.BlackScreen.Disable(new FrameworkBlackScreenData
			{
				fadeInTime = TimeSpan.Zero,
				fadeOutTime = TimeSpan.Zero
			}).Forget();
		});
	}
}
