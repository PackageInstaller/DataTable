using System.Collections.Generic;
using UnityEngine;

namespace Ase;

[Trigger("激活交互物触发器")]
public class MapItemActiveTrigger : BaseTrigger
{
	public List<MapItemNode> mapItemList;

	public override string TriggerName => "激活交互物触发器";

	protected override void DoExecute()
	{
		base.DoExecute();
		if (mapItemList != null)
		{
			ActiveMapItem();
		}
	}

	private void ActiveMapItem()
	{
		foreach (MapItemNode mapItem in mapItemList)
		{
			if (!((Object)(object)mapItem == null))
			{
				mapItem.ForceLoadNode();
			}
		}
	}
}
