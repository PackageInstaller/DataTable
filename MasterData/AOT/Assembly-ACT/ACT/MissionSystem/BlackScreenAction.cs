using System;
using System.Threading;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.MissionSystem;

public class BlackScreenAction : MissionAction
{
	public override bool MustDo => true;

	protected override bool IgnoreInMissionWorld => true;

	protected override async UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		BlackScreenActionParam param = Param as BlackScreenActionParam;
		switch (param.type)
		{
		case BlackScreenActionParam.BlackScreenType.Show:
			await context.BeginScope(new BlackScreenScope
			{
				fromMustDo = option.FromMustDo
			}, param, token);
			break;
		case BlackScreenActionParam.BlackScreenType.Hide:
			if (context.ContainsScope("BlackScreenScope"))
			{
				await context.EndScope("BlackScreenScope", param, token);
				break;
			}
			Singleton<NewUIManager>.instance.BlackScreen.SetBlackScreenText(0, 1f);
			await UniTask.Delay(TimeSpan.FromSeconds(param.duration));
			Singleton<NewUIManager>.instance.BlackScreen.Disable(new FrameworkBlackScreenData
			{
				fadeOutTime = TimeSpan.FromSeconds(param.time)
			}).Forget();
			await UniTask.Delay(TimeSpan.FromSeconds(param.time));
			break;
		}
	}
}
