using TrueSync;
using UnityEngine;

public class TrapSpawnPointGizmo : BaseSpawnPointGizmo
{
	public int trapID;

	public long spawnTrapUniqueID { get; protected set; }

	public int GroupId { get; set; }

	public bool IsActive { get; set; }

	public override void EnableSpawnLogic()
	{
		isSpawnEnabled = true;
	}

	public override void UpdateSpawnLogic()
	{
	}

	public override void ExecuteSpawnLogic(AdventureActor summoner = null)
	{
		if (!isSpawnEnabled)
		{
			return;
		}
		if (trapID == 0)
		{
			Debug.Log("陷阱ID为0");
			return;
		}
		bool isRoguelike = false;
		int num = 0;
		if (ModuleController<AdventureModuleController>.Instance.levelType == HotfixEnum.worldLevelType.StarTower)
		{
			isRoguelike = true;
		}
		num = ModuleController<AdventureModuleController>.Instance.levelLoadParams.monsterLevel;
		TrapSpawnInfo trapSpawnInfo = new TrapSpawnInfo(trapID);
		trapSpawnInfo.position = new TSVector2(transform.position.x, transform.position.z);
		trapSpawnInfo.positionY = transform.position.y;
		trapSpawnInfo.rotation = 0f - transform.rotation.eulerAngles.y;
		trapSpawnInfo.groupId = GroupId;
		trapSpawnInfo.isRoguelike = isRoguelike;
		trapSpawnInfo.Level = num;
		TrapSpawnInfo spawnInfo = trapSpawnInfo;
		ModuleController<AdventureModuleController>.Instance.SpawnTrap(spawnInfo, (AdventureLevelObjPoolMgr.PoolObj obj) =>
		{
			TrapAdventureActor component = obj.gameObject.GetComponent<TrapAdventureActor>();
			if (component != null)
			{
				spawnTrapUniqueID = component.Id;
				component.IsActive = IsActive;
			}
		});
	}
}
