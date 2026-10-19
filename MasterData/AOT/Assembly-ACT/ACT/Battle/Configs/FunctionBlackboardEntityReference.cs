namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取黑板实体引用", "Function", new string[] { "blackboard", "entity", "reference" })]
public class FunctionBlackboardEntityReference : ConfigFunction<EntityReference>
{
	public BlackboardScope scope;

	public string key;

	public int index;

	public ConfigFunction<EntityReference> fallback;

	protected override EntityReference Evaluate(ActionMemory memory)
	{
		BattleBlackboard blackboard = memory.GetBlackboard(scope);
		if (blackboard != null && blackboard.TryGet<EntityReference[]>(key, out var value) && value != null && index >= 0 && index < value.Length)
		{
			return value[index];
		}
		if (fallback == null)
		{
			return default;
		}
		return fallback.Return(memory);
	}
}
