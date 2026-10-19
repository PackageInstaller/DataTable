using ACT.Core;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("创建动态变量", "Action", new string[] { "create", "dynamic", "var" })]
public class ActionCreateDynamicVar : ConfigAction
{
	public string name;

	public int id;

	public float value;

	public float min;

	public float max;

	protected override AbilityAuth defaultAuth => AbilityAuth.Both;

	public override void Do(ActionMemory memory)
	{
		CompAbility compAbility = memory.target.entity.GetCompAbility();
		if (compAbility.vars.ContainsKey(name))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("创建相同名称的daynamic:" + name);
			}
			return;
		}
		DynamicValue orCreateDynamicVar = compAbility.GetOrCreateDynamicVar(name);
		orCreateDynamicVar.id = id;
		orCreateDynamicVar.min = min;
		orCreateDynamicVar.max = max;
		orCreateDynamicVar.value = value;
		compAbility.dynamicNames.Add(id, name);
	}
}
