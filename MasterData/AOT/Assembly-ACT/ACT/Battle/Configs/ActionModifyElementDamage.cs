using System.Collections.Generic;
using ACT.Core;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("修改元素伤害", "Action", new string[] { "modify", "element", "damage", "hit", "attack" })]
public class ActionModifyElementDamage : ConfigAction
{
	public Dictionary<Element, float> elementDamage = new Dictionary<Element, float>();

	public override void Do(ActionMemory memory)
	{
		if (memory.evt is EvtAttackeeModifyDamage evtAttackeeModifyDamage && elementDamage.TryGetValue(evtAttackeeModifyDamage.attackData.element, out var value))
		{
			evtAttackeeModifyDamage.attackData.damage = value;
		}
	}
}
