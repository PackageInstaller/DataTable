using BilliardGame.Spell;

namespace AINodes;

public class BTSetEnvParam<T> : BActionNode where T : class
{
	public string field;

	public T value;

	public override BTNodeStatus Run(BTEnv env)
	{
		env.AddObject(field, value);
		return BTNodeStatus.Success;
	}
}
