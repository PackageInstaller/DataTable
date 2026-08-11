using System.Collections.Generic;
using UnityEngine;

namespace Ase;

[Trigger("Timeline2NPC传参触发器")]
public class Timeline2SendNpcMessageTrigger : TimelineEventTrigger
{
	public NPCNode npcNode;

	[SerializeField]
	private bool IsSaveData;

	[SerializeField]
	public Dictionary<string, MapDataNodeParadoxParameter> eventNodeParadoxMsg = new Dictionary<string, MapDataNodeParadoxParameter>();

	public override string TriggerName => "Timeline-NPC传参触发器";

	protected override void DoExecute()
	{
		base.DoExecute();
		int levelId = sceneSystem.GetSystem<SceneSystem>().GetLevelId();
		if ((Object)(object)npcNode != null)
		{
			npcNode.SendParadoxMessage(eventNodeParadoxMsg);
			if (IsSaveData)
			{
				Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().UpdateNpcParadoxDatas(levelId, npcNode.Uid, eventNodeParadoxMsg);
			}
		}
	}
}
