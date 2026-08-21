using System.Collections.Generic;
using UnityEngine;

namespace Ase;

[Trigger("交互物2创建交互物触发器")]
public class MapItem2CreateMapItemEventTrigger : MapItemEventTrigger
{
	public List<MapItemNode> mapItemNodeList;

	public override string TriggerName => "交互物-交互物创建交互物触发器";

	protected override void DoExecute()
	{
		base.DoExecute();
		if (mapItemNodeList != null)
		{
			ActiveMapItem();
		}
	}

	private void ActiveMapItem()
	{
		foreach (MapItemNode mapItemNode in mapItemNodeList)
		{
			if (!((Object)(object)mapItemNode == null))
			{
				mapItemNode.ForceLoadNode();
			}
		}
	}

	public override void OnDisposed()
	{
	}
}
