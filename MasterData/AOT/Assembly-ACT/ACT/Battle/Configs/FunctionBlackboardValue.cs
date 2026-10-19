namespace ACT.Battle.Configs;

public abstract class FunctionBlackboardValue<T> : ConfigFunction<T>
{
	public BlackboardScope scope;

	public string key;

	public ConfigFunction<T> fallback;

	protected override T Evaluate(ActionMemory memory)
	{
		BattleBlackboard blackboard = memory.GetBlackboard(scope);
		if (blackboard != null && blackboard.TryGet<T>(key, out var value))
		{
			return value;
		}
		if (fallback == null)
		{
			return default;
		}
		return fallback.Return(memory);
	}
}
