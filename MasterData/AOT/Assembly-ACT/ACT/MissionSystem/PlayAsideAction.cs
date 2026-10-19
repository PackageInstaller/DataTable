using System;
using System.Threading;
using ACT.Drama;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.MissionSystem;

public class PlayAsideAction : MissionAction
{
	protected override async UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		await UniTask.Delay(100, ignoreTimeScale: false, PlayerLoopTiming.Update, token);
		if (token.IsCancellationRequested)
		{
			return;
		}
		try
		{
			PlayAsideActionParam playAsideActionParam = Param as PlayAsideActionParam;
			AsideManager.instance.BeginAsideBatch(playAsideActionParam.asideIds);
		}
		catch (Exception message)
		{
			Debug.LogError(message);
		}
	}
}
