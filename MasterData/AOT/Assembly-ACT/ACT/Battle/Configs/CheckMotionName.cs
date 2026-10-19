using System;
using System.Linq;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断动作名称", "Predicate", new string[] { "check", "motion", "name", "predicate", "condition", "skill", "ability", "cd" })]
public class CheckMotionName : ConfigPredicate
{
	public enum CheckMotionNameType
	{
		CheckOne,
		CheckMulti
	}

	public string name;

	public CheckMotionNameType checkMotionNameType;

	public string[] nameArray;

	public override bool Check(ActionMemory memory)
	{
		bool result = false;
		if (memory.target.entity.TryGetCompMotion(out CompMotion component))
		{
			if (checkMotionNameType == CheckMotionNameType.CheckOne)
			{
				result = string.Equals(component.layer0Peak.state.value.name, name, StringComparison.CurrentCultureIgnoreCase);
			}
			else
			{
				for (int i = 0; i < nameArray.Count(); i++)
				{
					if (string.Equals(component.layer0Peak.state.value.name, nameArray[i], StringComparison.CurrentCultureIgnoreCase))
					{
						result = true;
						break;
					}
				}
			}
		}
		return result;
	}
}
