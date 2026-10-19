using System;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT;

internal class DestroyWorld : WorldLoadStepOperation
{
	internal override void OnStart()
	{
		DestroyWorldAsync().Forget();
	}

	internal override void OnUpdate()
	{
	}

	private async UniTaskVoid DestroyWorldAsync()
	{
		try
		{
			await Singleton<GameManager>.instance.worldManager.LeaveWorld();
			UnityEngine.Object.Destroy(GameUtility.uiRobot);
			GameManager.behaveSystem?.ReleaseStateController();
			State = OptionState.Succeed;
		}
		catch (Exception ex)
		{
			ErrorInfo = ex.Message;
			State = OptionState.Failed;
		}
	}
}
