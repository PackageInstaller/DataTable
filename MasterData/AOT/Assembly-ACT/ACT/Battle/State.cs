using System.Text;
using ACT.Battle.Configs;

namespace ACT.Battle;

public class State : StateObject
{
	public int index;

	public ConfigAnimState value { get; protected set; }

	public State(StateLayer stateLayer, StateMachine parentStateMachine, ConfigAnimState config, int index)
	{
		base.stateLayer = stateLayer;
		base.parentStateMachine = parentStateMachine;
		this.index = index;
		if (stateLayer.stateController is StateAttackController)
		{
			this.index |= 1073741824;
		}
		value = config;
		Register();
	}

	public override string ToString(int padLeft = 0)
	{
		StringBuilder stringBuilder = new StringBuilder(PadLeft(padLeft) + "[" + GetType().Name + "]" + value.name);
		foreach (StateTransition transition in transitions)
		{
			stringBuilder.Append("\n" + transition.ToString(padLeft + 3));
		}
		return stringBuilder.ToString();
	}

	public override string Name()
	{
		return value.name;
	}

	public override string ToString()
	{
		return "[s:" + Name() + "]";
	}
}
