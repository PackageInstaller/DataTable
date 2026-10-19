using System.Collections.Generic;
using ACT.Battle;
using Fundamental;

namespace ACT;

internal class InitGameOperation : WorldLoadStepOperation
{
	private Queue<WorldLoadStepOperation> _options;

	private WorldLoadStepOperation _currentOperation;

	internal override void OnStart()
	{
		_options = new Queue<WorldLoadStepOperation>();
		Singleton<GameState>.instance.SetGameRunningState(GameRunningState.Loading);
		_options.Enqueue(new ReportGameSettings());
		_options.Enqueue(new InitModelStepOperation());
		_options.Enqueue(new InitBattleStep());
		_options.Enqueue(new InitUIView());
		_options.Enqueue(new InitMusic());
		_options.Enqueue(new EnterWorldStep());
		_options.Enqueue(new InitSceneFinalize());
		_options.Enqueue(new AfterLoadStep());
	}

	internal override void OnUpdate()
	{
		if (State != OptionState.Processing)
		{
			return;
		}
		if (_currentOperation == null)
		{
			if (_options.Count > 0)
			{
				_currentOperation = _options.Dequeue();
				OperationManager.StartOperation(_currentOperation);
			}
			else
			{
				State = OptionState.Succeed;
			}
		}
		else
		{
			if (_currentOperation.State == OptionState.Processing)
			{
				return;
			}
			if (_currentOperation.State == OptionState.Failed)
			{
				ErrorInfo = _currentOperation.ErrorInfo;
				State = OptionState.Failed;
			}
			if (_currentOperation.State == OptionState.Succeed)
			{
				_currentOperation = null;
				if (_options.Count > 0)
				{
					_currentOperation = _options.Dequeue();
					OperationManager.StartOperation(_currentOperation);
				}
				else
				{
					State = OptionState.Succeed;
				}
			}
		}
	}
}
