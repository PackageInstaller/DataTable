using Nova.Hotfix;
using TrueSync;
using UnityEngine;

[AddComponentMenu("触发器结果/暂时废弃/玩家周边刷新NPC(特殊宝箱)", 0)]
public class Task_SpawnTreasureBox : TaskCellBase
{
	public bool isRandomPosition = true;

	public int boxID;

	[HideInInspector]
	public TSVector2 randomCenterPos = TSVector2.zero;

	[HideInInspector]
	public FP RandomRotation = 0;

	[HideInInspector]
	public FP RandomAngle = 45;

	private PrologueInteractiveBox spawnBox;

	protected override void OnExecute()
	{
		base.OnExecute();
		Chest boxData = null;
		PrologueBattleLevelController prologueBattleLevelController = ModuleController<AdventureModuleController>.Instance.levelInstance as PrologueBattleLevelController;
		if (prologueBattleLevelController.boxID != 0)
		{
			boxID = prologueBattleLevelController.boxID;
		}
		ActorSpawnInfo spawnInfo = GetSpawnInfo();
		ModuleController<AdventureModuleController>.Instance.SpawnTreasureBox(spawnInfo, out boxData, (AdventureLevelObjPoolMgr.PoolObj obj) =>
		{
			spawnBox = obj.gameObject.GetComponent<PrologueInteractiveBox>();
			Transform transform = obj.gameObject.transform.FindInChildren("icon");
			if (transform != null)
			{
				GameObject objIcon = transform.gameObject;
				objIcon.SetActive(value: false);
				string dropIconPath = string.Empty;
				BundleHandler.LoadAssetAsyncCallback callback = (Object asset) =>
				{
					if (null == asset)
					{
						Debug.LogError("宝箱主题:错误的主题Icon路径" + dropIconPath);
					}
					else
					{
						objIcon.GetComponent<Renderer>().material.mainTexture = asset as Texture;
						objIcon.SetActive(value: true);
					}
				};
				GameResourceLoader.LoadAssetAsync(GameResourceLoader.ResourceType.Env, dropIconPath, typeof(Texture), callback);
			}
			MonoSingleton<LuaManager>.Instance.FireEvent("TreasureBoxTrans", obj.gameObject.transform);
			AdventureTreasureBoxSpawnPosEvent adventureTreasureBoxSpawnPosEvent = AdventureTreasureBoxSpawnPosEvent.Generate();
			adventureTreasureBoxSpawnPosEvent.boxPos = new TSVector2(obj.gameObject.transform.position.x, obj.gameObject.transform.position.z);
			adventureTreasureBoxSpawnPosEvent.boxId = boxID;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureTreasureBoxSpawnPosEvent);
			InteractiveManager.interactiveState interactiveState = InteractiveManager.interactiveState.active0;
			if (boxData.TnteractionType == 0)
			{
				interactiveState = InteractiveManager.interactiveState.deactive0;
			}
			long uuid = ModuleController<AdventureModuleController>.Instance.GenerateUniqueID();
			spawnBox.initInteractiveBox(boxData, interactiveState, uuid);
		});
	}

	protected ActorSpawnInfo GetSpawnInfo(bool callbackImmediately = false)
	{
		ActorSpawnInfo result = new ActorSpawnInfo(boxID);
		Vector3 position = transform.position;
		result.position = (isRandomPosition ? GetRandomPosition() : new TSVector2(position.x, position.z));
		result.positionY = position.y;
		result.rotation = 0f - transform.rotation.eulerAngles.y;
		return result;
	}

	protected TSVector2 GetRandomPosition()
	{
		if (randomCenterPos == TSVector2.zero)
		{
			AdventureActor component = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.GetComponent<AdventureActor>();
			if (component != null)
			{
				for (int i = 0; i < 5; i++)
				{
					TSVector2 tSVector = TrueSyncExtensions.RandomPointInsideFan(component.tsTransform.Position, component.dtCollider.Radius * 2.5f, component.dtCollider.Radius * 6, RandomRotation, RandomAngle);
					if (component.QueryPositionReachable(tSVector))
					{
						return tSVector;
					}
				}
			}
		}
		else
		{
			AdventureActor component2 = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.GetComponent<AdventureActor>();
			for (int j = 0; j < 5; j++)
			{
				TSVector2 tSVector2 = TrueSyncExtensions.RandomPointInsideFan(randomCenterPos, component2.dtCollider.Radius * 3, component2.dtCollider.Radius * 6, RandomRotation, RandomAngle);
				if (component2.QueryPositionReachable(tSVector2))
				{
					return tSVector2;
				}
			}
		}
		return new TSVector2(transform.position.x, transform.position.z);
	}

	private void Test()
	{
		OnExecute();
	}
}
