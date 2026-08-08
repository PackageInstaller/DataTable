using BilliardGame.Spell;

namespace AINodes;

public class BTSetEnvParamValueType<T> : BActionNode where T : struct
{
	public string field;

	public T value;

	public override BTNodeStatus Run(BTEnv env)
	{
		env.AddStruct(field, value);
		return BTNodeStatus.Success;
	}
}
