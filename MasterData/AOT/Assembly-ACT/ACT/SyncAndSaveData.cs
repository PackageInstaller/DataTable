using System;
using ACT.Battle;
using ACT.Game;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT;

internal class SyncAndSaveData : WorldLoadStepOperation
{
	private bool _isWaiting = true;

	internal override void OnStart()
	{
		SyncAndSave().Forget();
	}

	internal override void OnUpdate()
	{
		if (!_isWaiting)
		{
			State = OptionState.Succeed;
		}
	}

	private async UniTaskVoid SyncAndSave()
	{
		if (G.localPlayer != null && G.service != null)
		{
			try
			{
				if (MonoECS.instance.mainEntity != null && !MonoECS.instance.IsNotInMain)
				{
					MonoECS.instance.SyncGameInfos();
				}
			}
			catch (Exception exception)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogException(exception);
				}
			}
			if (UnityEngine.Object.FindObjectOfType<GameLoader>().mode == GameLoader.GameMode.Local)
			{
				(G.service as LocalGameService).SaveGame();
			}
		}
		_isWaiting = false;
	}
}
