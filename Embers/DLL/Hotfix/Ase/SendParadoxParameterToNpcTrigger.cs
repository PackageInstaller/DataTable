using System.Collections.Generic;
using UnityEngine;

namespace Ase;

[Trigger("NPC传参触发器")]
public class SendParadoxParameterToNpcTrigger : BaseTrigger
{
	public List<NPCNode> npcList;

	[SerializeField]
	private bool IsSaveData;

	[SerializeField]
	private bool IsSaveLevelData;

	public Dictionary<string, MapDataNodeParadoxParameter> mapDataNodeParadoxParameters = new Dictionary<string, MapDataNodeParadoxParameter>();

	public override string TriggerName => "NPC传参触发器";

	protected override void DoExecute()
	{
		base.DoExecute();
		if (npcList == null)
		{
			return;
		}
		int levelId = sceneSystem.GetSystem<SceneSystem>().GetLevelId();
		foreach (NPCNode npc in npcList)
		{
			if (!((Object)(object)npc == null))
			{
				npc.SendParadoxMessage(mapDataNodeParadoxParameters);
				if (IsSaveData)
				{
					Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().UpdateNpcParadoxDatas(levelId, npc.Uid, mapDataNodeParadoxParameters);
				}
			}
		}
		if (IsSaveData && IsSaveLevelData)
		{
			Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().SaveLevelData(levelId);
		}
	}
}
