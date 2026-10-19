namespace ACT.Battle.Configs;

public class ConfigPredicateList : LuminSerializedScriptableObject
{
	public ConfigPredicate[] configPredicates;

	public bool Check(ActionMemory memory)
	{
		ConfigPredicate[] array = configPredicates;
		for (int i = 0; i < array.Length; i++)
		{
			if (!array[i].Check(memory))
			{
				return false;
			}
		}
		return true;
	}
}
