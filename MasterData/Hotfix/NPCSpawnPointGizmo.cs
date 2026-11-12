using TrueSync;
using UnityEngine;

public class NPCSpawnPointGizmo : BaseSpawnPointGizmo
{
	public enum SpawnNPCType
	{
		IDNpc,
		RandomNpc,
		TalkNpc
	}

	public SpawnNPCType npcType;

	public int index = 1;

	public int npcID;

	public int npcSkinID;

	public override void EnableSpawnLogic()
	{
		isSpawnEnabled = true;
	}

	public override void ExecuteSpawnLogic(AdventureActor summoner = null)
	{
		if (npcID > 0 && isSpawnEnabled && !isSpawnActived)
		{
			isSpawnActived = true;
			Vector3 position = transform.position;
			ModuleController<AdventureModuleController>.Instance.SpawnNPC(npcID, npcSkinID, new TSVector2(position.x, position.z), position.y, 0f - transform.rotation.eulerAngles.y, (NPCAdventureActor npcAdventureActor) =>
			{
			});
		}
	}
}
