using System;
using TrueSync;
using UnityEngine;

public class StarTowerPort : LogicMonoComponent
{
	public enum PortType
	{
		SpawnPoint,
		Teleporter
	}

	public enum PortState
	{
		Default,
		Destroyed,
		Opened
	}

	[Serializable]
	public struct FixedRoguelikePortInfo(HotfixEnum.fixedRoguelikePortDir portDir, PortType portType, PortState portState)
	{
		[SerializeField]
		public HotfixEnum.fixedRoguelikePortDir direction = portDir;

		[SerializeField]
		[ReadOnly]
		public PortType portType = portType;

		[SerializeField]
		[ReadOnly]
		public PortState state = portState;
	}

	[SerializeField]
	protected FixedRoguelikePortInfo portInfo;

	public GameObject target;

	protected const string RUINED_MODEL_PATH = "Assets/AssetBundles/Environment/Roguelike_2/Perfab/Roguelike_2_Lift_DoorStop.prefab";

	public bool isSelected { get; protected set; }

	public void Select()
	{
		isSelected = true;
	}

	public void OutPort_InitInfo(int nextRoomType, bool isFinalLevel = false, bool sceneDoMir = false)
	{
		isSelected = true;
		UpdatePortDropShow(nextRoomType, isFinalLevel, sceneDoMir);
	}

	public void OutPort_Close()
	{
		base.gameObject.SetActive(value: true);
		if (null != target)
		{
			target.SetActive(value: false);
		}
		GameObject gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Env, "Assets/AssetBundles/Environment/Roguelike_2/Perfab/Roguelike_2_Lift_DoorStop.prefab", typeof(GameObject)) as GameObject;
		if (null == gameObject)
		{
			Debug.LogError("固定rog:没有找到目标prefab:Assets/AssetBundles/Environment/Roguelike_2/Perfab/Roguelike_2_Lift_DoorStop.prefab");
			return;
		}
		GameObject gameObject2 = UnityEngine.Object.Instantiate(gameObject);
		gameObject2.transform.SetParent(transform);
		gameObject2.transform.localScale = Vector3.one;
		gameObject2.transform.localPosition = Vector3.zero;
		gameObject2.transform.localRotation = Quaternion.identity;
		LogicEntity[] componentsInChildren = gameObject2.GetComponentsInChildren<LogicEntity>();
		if (componentsInChildren != null)
		{
			foreach (LogicEntity logicEntity in componentsInChildren)
			{
				logicEntity.tsTransform.Position = new TSVector2(logicEntity.transform.position.x, logicEntity.transform.position.z);
				logicEntity.tsTransform.PositionY = logicEntity.transform.position.y;
				logicEntity.tsTransform.Forward = new TSVector2(logicEntity.transform.forward.x, logicEntity.transform.forward.z);
			}
		}
	}

	private void UpdatePortDropShow(int nextRoomType, bool isFinalLevel = false, bool sceneDoMir = false)
	{
		if (null == target)
		{
			Debug.LogError("固定rog关卡:出入口节点目标游戏对象为空!");
			return;
		}
		AdventureLevelTeleporter component = target.GetComponent<AdventureLevelTeleporter>();
		if (null == component)
		{
			Debug.LogError("固定rog关卡:传送门为空");
		}
		else
		{
			component.UpdatePortDropShow(nextRoomType, isFinalLevel, sceneDoMir);
		}
	}

	public void SetActive_Teleporter(bool active)
	{
		if (null == target)
		{
			Debug.LogError("固定rog关卡:出入口节点目标游戏对象为空!");
			return;
		}
		AdventureLevelTeleporter component = target.GetComponent<AdventureLevelTeleporter>();
		if (null == component)
		{
			Debug.LogError("固定rog关卡:传送门为空");
			return;
		}
		component.Active(active);
		if (active)
		{
			component.RegisterTeleporterCallback(OnTriggeTeleporter);
		}
		else
		{
			component.UnRegisterTeleporterCallbak();
		}
	}

	public AdventureLevelTeleporter GetTeleporter()
	{
		if (null == target)
		{
			Debug.LogError("固定rog关卡:出入口节点目标游戏对象为空!");
			return null;
		}
		return target.GetComponent<AdventureLevelTeleporter>();
	}

	protected void OnTriggeTeleporter(AdventureLevelTeleporter.NextLevelData nextLevelData)
	{
		Debug.Log("触发了出口:" + name);
		nextLevelData.enterExitPortDirection = portInfo.direction;
		nextLevelData.enterSettlementState = false;
		ModuleController<AdventureModuleController>.Instance.DispatchEventWithData("ADVENTURE_LEVEL_ON_TELEPORTER_TRIGGERED", this, nextLevelData);
	}

	public PlayerSpawnPointGizmo SetActive_SpawnPoint()
	{
		if (null == target)
		{
			Debug.LogError("固定rog关卡:出入口节点目标游戏对象为空!");
			return null;
		}
		PlayerSpawnPointGizmo component = target.GetComponent<PlayerSpawnPointGizmo>();
		if (null == component)
		{
			Debug.LogError("固定rog关卡:角色出生点为空");
			return null;
		}
		component.Initialize(0, 0);
		component.EnableSpawnLogic();
		component.ExecuteSpawnLogic();
		isSelected = true;
		return component;
	}

	public bool UpdateStatus(HotfixEnum.fixedRoguelikePortDir direction)
	{
		if (direction != portInfo.direction)
		{
			return true;
		}
		return false;
	}

	public override void OnActive()
	{
	}

	public override void OnDeactive()
	{
	}
}
