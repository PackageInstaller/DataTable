using System;
using UnityEngine;

namespace ACT.Battle.Configs;

[Serializable]
public abstract class ConfigFunction<T>
{
	public string comment;

	public FunctionResultMode resultMode;

	public string blackboardKey;

	public BlackboardScope blackboardScope;

	public T Return(ActionMemory memory)
	{
		T val = Evaluate(memory);
		if (resultMode == FunctionResultMode.GetAndSetBlackboard)
		{
			BattleBlackboard orCreateBlackboard = memory.GetOrCreateBlackboard(blackboardScope);
			if (orCreateBlackboard == null)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogWarning($"ConfigFunction {GetType().Name} tried to write {blackboardScope} blackboard, but it is unavailable.");
				}
			}
			else
			{
				orCreateBlackboard.Set(blackboardKey, val);
			}
		}
		return val;
	}

	protected abstract T Evaluate(ActionMemory memory);
}
