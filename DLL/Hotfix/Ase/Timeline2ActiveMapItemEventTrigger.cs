using System.Collections.Generic;
using UnityEngine;

namespace Ase;

[Trigger("Timeline2激活交互物事件触发器")]
public class Timeline2ActiveMapItemEventTrigger : TimelineEventTrigger
{
	public List<MapItemNode> mapItemList;

	public override string TriggerName => "Timeline-激活交互物事件触发器";

	protected override void DoExecute()
	{
		base.DoExecute();
		if (mapItemList == null)
		{
			return;
		}
		foreach (MapItemNode mapItem in mapItemList)
		{
			if (!((Object)(object)mapItem == null))
			{
				mapItem.ForceLoadNode();
			}
		}
	}
}
