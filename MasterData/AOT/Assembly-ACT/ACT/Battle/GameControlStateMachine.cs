using System.Collections.Generic;

namespace ACT.Battle;

public class GameControlStateMachine
{
	private GameControlState _state;

	private Dictionary<GameControlState, IState> _states;

	public GameControlState Current => _state;

	public GameControlStateMachine()
	{
		_states = new Dictionary<GameControlState, IState>
		{
			{
				GameControlState.None,
				new EmptyState()
			},
			{
				GameControlState.Free,
				new EmptyState()
			},
			{
				GameControlState.Loading,
				new EmptyState()
			},
			{
				GameControlState.Respawn,
				new EmptyState()
			},
			{
				GameControlState.Tp,
				new TpState()
			},
			{
				GameControlState.Avg,
				new EmptyState()
			},
			{
				GameControlState.Guide,
				new EmptyState()
			},
			{
				GameControlState.SystemUnlock,
				new EmptyState()
			},
			{
				GameControlState.Skill,
				new EmptyState()
			}
		};
		EnterState(GameControlState.Free);
	}

	public void EnterState(GameControlState state)
	{
		if (_state != state)
		{
			if (_states.TryGetValue(_state, out var value))
			{
				value.Exit();
			}
			_state = state;
			if (_states.TryGetValue(_state, out var value2))
			{
				value2.Enter();
			}
		}
	}

	public void ExitState(GameControlState state)
	{
		if (_states.TryGetValue(state, out var _) && _state == state)
		{
			EnterState(GameControlState.Free);
		}
	}

	public void Reset()
	{
		if (_state != GameControlState.None)
		{
			EnterState(GameControlState.None);
		}
	}
}
