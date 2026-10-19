using System.Collections.Generic;
using ACT.Battle;
using Fundamental;

namespace ACT;

internal class DestroyGameOption : WorldLoadStepOperation
{
	private Queue<WorldLoadStepOperation> _options;

	private WorldLoadStepOperation _currentOption;

	internal override void OnStart()
	{
		Singleton<LoadManager>.instance.StartLoading(null, isBlack: false, null, new SimpleLoadProgressHandle());
		_options = new Queue<WorldLoadStepOperation>();
		Singleton<GameState>.instance.SetGameRunningState(GameRunningState.UnLoading);
		if (!MonoECS.instance.isStartWorld)
		{
			_options.Enqueue(new ReleaseModel());
			_options.Enqueue(new FinalCleanup());
			return;
		}
		_options.Enqueue(new WaitAndPrepareDestroy());
		_options.Enqueue(new DestroyUIAndManagers());
		_options.Enqueue(new SyncAndSaveData());
		_options.Enqueue(new DisconnectNetwork());
		_options.Enqueue(new CleanupSystems());
		_options.Enqueue(new DestroyWorld());
		_options.Enqueue(new CleanupEntities());
		_options.Enqueue(new ReleaseModel());
		_options.Enqueue(new FinalCleanup());
	}

	internal override void OnUpdate()
	{
		if (State != OptionState.Processing)
		{
			return;
		}
		if (_currentOption == null)
		{
			if (_options.Count > 0)
			{
				_currentOption = _options.Dequeue();
				OperationManager.StartOperation(_currentOption);
			}
			else
			{
				State = OptionState.Succeed;
			}
		}
		else
		{
			if (_currentOption.State == OptionState.Processing)
			{
				return;
			}
			if (_currentOption.State == OptionState.Failed)
			{
				ErrorInfo = _currentOption.ErrorInfo;
				State = OptionState.Failed;
			}
			if (_currentOption.State == OptionState.Succeed)
			{
				_currentOption = null;
				if (_options.Count > 0)
				{
					_currentOption = _options.Dequeue();
					OperationManager.StartOperation(_currentOption);
				}
				else
				{
					State = OptionState.Succeed;
				}
			}
		}
	}
}
