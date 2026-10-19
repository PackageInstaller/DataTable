using System.Collections.Generic;

namespace ACT.Battle.Configs;

public class ConfigDynamicVarMap : LuminSerializedScriptableObject
{
	public Dictionary<string, int> dynamicVars = new Dictionary<string, int>();

	private bool UniqueElement(Dictionary<string, int> dic)
	{
		HashSet<int> hashSet = new HashSet<int>();
		foreach (int value in dic.Values)
		{
			if (!hashSet.Add(value))
			{
				return false;
			}
		}
		return true;
	}
}
