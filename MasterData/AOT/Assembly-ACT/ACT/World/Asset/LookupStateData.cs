using System;
using System.Collections.Generic;
using ACT.Event;
using UnityEngine;
using UnityEngine.Serialization;

namespace ACT.World.Asset;

[Serializable]
public class LookupStateData : InteractRuleActionData
{
	public List<StateWorldUid> targets = new List<StateWorldUid>();

	public List<int> map = new List<int>();

	[FormerlySerializedAs("offest")]
	public int offset;

	public bool loop;

	public override IEnumerable<StateWorldUid> checkedSwid => targets;

	public override void Do(IRuleManager ruleManager, LocalStateWorldEvent eventContent)
	{
		for (int i = 0; i < targets.Count; i++)
		{
			int item = ruleManager.SharedGetState(targets[i]);
			int num = map.IndexOf(item);
			if (num != -1)
			{
				num += offset;
				num = ((!loop) ? Mathf.Clamp(num, 0, map.Count - 1) : (num % map.Count));
				ruleManager.SharedChangeState(targets[i], map[num]);
			}
		}
	}

	public override void Bake(InteractRuleActionComp interactRuleActionComp)
	{
		targets.Bake(interactRuleActionComp);
	}
}
