using System;
using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.Battle;

public class TriggerActionWait : TriggerActionBase
{
	public float waitSeconds;

	public override async UniTask Invoke(TriggerActionContext context, CancellationToken token)
	{
		await UniTask.Delay(TimeSpan.FromSeconds(waitSeconds), ignoreTimeScale: false, PlayerLoopTiming.Update, token);
	}
}
