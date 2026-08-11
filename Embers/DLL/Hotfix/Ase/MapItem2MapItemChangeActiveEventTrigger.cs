using System.Collections.Generic;
using UnityEngine;

namespace Ase;

[Trigger("交互物2交互物改变激活状态触发器")]
public class MapItem2MapItemChangeActiveEventTrigger : MapItemEventTrigger
{
	public List<MapItemNode> MapItemNodes;

	public bool active;

	public override string TriggerName => "交互物-交互物改变激活状态触发器";

	protected override void DoExecute()
	{
		base.DoExecute();
		for (int i = 0; i < MapItemNodes.Count; i++)
		{
			MapItemNode mapItemNode = MapItemNodes[i];
			if (!((Object)(object)mapItemNode == null))
			{
				int levelId = sceneSystem.GetSystem<SceneSystem>().GetLevelId();
				Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().UpdateMapItemActiveState(levelId, mapItemNode.Uid, (!active) ? 1 : 0);
				Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().ExcuteMapItemUpdateAction(levelId, mapItemNode.Uid);
			}
		}
	}

	public override void OnDisposed()
	{
	}
}
