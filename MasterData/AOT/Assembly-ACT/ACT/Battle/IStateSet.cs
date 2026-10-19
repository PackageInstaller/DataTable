using System.Collections.Generic;

namespace ACT.Battle;

public interface IStateSet
{
	List<State> states { get; }

	List<StateMachine> stateMachines { get; }
}
