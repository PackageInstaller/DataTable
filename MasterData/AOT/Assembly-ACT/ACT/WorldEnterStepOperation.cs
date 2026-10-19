using System;
using ACT.Game.Data;
using Cysharp.Threading.Tasks;

namespace ACT;

internal class WorldEnterStepOperation : WorldLoadStepOperation
{
	private SceneStatus _targetSceneStatus;

	private WorldData _data;

	private bool _isEntering;

	public WorldEnterStepOperation(SceneStatus sceneStatus, WorldData data = null)
	{
		_targetSceneStatus = sceneStatus;
		_data = data ?? new WorldData();
	}

	internal override void OnStart()
	{
		_isEntering = true;
		EnterWorldAsync().Forget();
	}

	internal override void OnUpdate()
	{
	}

	private async UniTaskVoid EnterWorldAsync()
	{
		try
		{
			State = OptionState.Succeed;
		}
		catch (Exception ex)
		{
			ErrorInfo = ex.Message;
			State = OptionState.Failed;
		}
	}
}
