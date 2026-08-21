using System.Collections.Generic;
using UnityEngine;

namespace Ase;

[Trigger("怪物组2激活交互物事件触发器")]
public class MonsterGroup2ChangeMapItemActiveEventTrigger : MonsterGroupEventTrigger
{
	public List<MapItemNode> nodes;

	public override string TriggerName => "怪物组-激活交互物触发器";

	protected override async void DoExecute()
	{
		base.DoExecute();
		if (nodes == null || nodes.Count <= 0)
		{
			return;
		}
		foreach (MapItemNode node in nodes)
		{
			if ((Object)(object)node != null)
			{
				node.ChangeActiveState();
			}
		}
	}
}
