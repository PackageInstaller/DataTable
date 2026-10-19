using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using ACT.World.Asset;
using ACT.World.StateObject;
using Bamboo.ECS;
using Fundamental;
using Runtime.Model;
using UnityEngine;

namespace ACT.UI;

public class BattleMainRogueComponent : SubUIView<RogueBattleMainSubController>, IBattleMainComponent
{
	private sealed class RogueBubbleFollowInfo
	{
		public GameObject Instance;

		public RectTransform RectTransform;

		public Transform Target;

		public Vector3 WorldOffset;
	}

	private const int AutomaticMonsterArrowIndex = int.MinValue;

	public RogueCoin RogueCoin;

	public RogueCollectInfo RogueCollectInfo;

	public HudRogueEquipTip RogueEquipTipComponent;

	public RogueHudCharacterTip RogueHudCharacterTipComponent;

	public RogueHudCharacterReplaceTip RogueHudCharacterReplaceTipComponent;

	public RogueHudBloodbottleTip RogueHudBloodbottleTipComponent;

	[Header("Rogue箭头区域")]
	public RectTransform arrowArea;

	[Tooltip("目标进入该区域后隐藏箭头；未配置时使用整个屏幕。")]
	public RectTransform arrowInvisibleArea;

	[Header("Rogue箭头")]
	public RogueArrow RogueMonsterArrowPrefab;

	public RogueArrow RogueInteractArrowPrefab;

	public RectTransform RogueArrowRoot;

	[Header("Rogue气泡")]
	public RectTransform BubbleUIRoot;

	public GameObject BubbleUIPrefab;

	private readonly List<RogueBubbleFollowInfo> rogueBubbleInstances = new List<RogueBubbleFollowInfo>();

	private readonly Dictionary<int, GameObject> rogueGateBubbles = new Dictionary<int, GameObject>();

	private readonly List<RogueArrow> rogueArrowInstances = new List<RogueArrow>();

	private readonly Dictionary<int, RogueArrow> rogueMonsterArrows = new Dictionary<int, RogueArrow>();

	private readonly Dictionary<int, RogueArrow> rogueInteractArrows = new Dictionary<int, RogueArrow>();

	private readonly Vector3[] rogueArrowAreaCorners = new Vector3[4];

	private readonly List<Entity> rogueAliveMonsters = new List<Entity>(256);

	private readonly HashSet<int> currentAutomaticRogueChestArrowIndices = new HashSet<int>();

	private readonly HashSet<int> automaticRogueChestArrowIndices = new HashSet<int>();

	private readonly List<int> staleAutomaticRogueChestArrowIndices = new List<int>(16);

	private Entity automaticMonsterArrowTarget;

	private RogueElement rogueelement;

	private int stateWorldAssetUid;

	private int dieMonsterCount;

	public IRogueSubComponent CurrentComponent { get; private set; }

	public IReadOnlyList<RogueArrow> RogueArrowInstances => rogueArrowInstances;

	protected override void OnEnable()
	{
		base.OnEnable();
		WorldManager worldManager = Singleton<GameManager>.instance.worldManager;
		if (worldManager != null)
		{
			_ = worldManager.GetCurrentWorld()?.SceneStatus == SceneStatus.Rogue;
		}
		else
			_ = 0;
	}

	protected override void OnDisable()
	{
		RecycleAllRogueBubbles();
		DestroyAllRogueArrows();
		base.OnDisable();
	}

	private void LateUpdate()
	{
		RefreshRogueBubbles();
		if (!ShouldCheckRogueArrows())
		{
			if (rogueArrowInstances.Count > 0)
			{
				DestroyAllRogueArrows();
			}
			return;
		}
		RefreshAutomaticRogueMonsterArrow();
		RefreshAutomaticRogueInteractArrows();
		if (rogueArrowInstances.Count == 0)
		{
			return;
		}
		bool hasPlayerPosition = TryGetRogueArrowPlayerPosition(out var playerPosition);
		for (int num = rogueArrowInstances.Count - 1; num >= 0; num--)
		{
			RogueArrow rogueArrow = rogueArrowInstances[num];
			if (rogueArrow == null)
			{
				rogueArrowInstances.RemoveAt(num);
			}
			else
			{
				RefreshRogueArrow(rogueArrow, playerPosition, hasPlayerPosition);
			}
		}
	}

	private static bool ShouldCheckRogueArrows()
	{
		WorldManager worldManager = Singleton<GameManager>.instance.worldManager;
		if (worldManager == null || worldManager.GetCurrentWorld()?.SceneStatus != SceneStatus.Rogue || !Model<RogueNewModel>.HasInstance())
		{
			return false;
		}
		RogueRoomType valueOrDefault = (Model<RogueNewModel>.Interface.Info?.GameInfo?.RoomInfo?.RoomType).GetValueOrDefault();
		if (valueOrDefault != RogueRoomType.Shop)
		{
			return valueOrDefault != RogueRoomType.Null;
		}
		return false;
	}

	private void RefreshAutomaticRogueMonsterArrow()
	{
		WorldManager worldManager = Singleton<GameManager>.instance.worldManager;
		if (worldManager == null || worldManager.GetCurrentWorld()?.SceneStatus != SceneStatus.Rogue || GameUtility.mainCamera == null || MonoECS.instance == null || !MonoECS.instance.mainEntity.IsValid || GameManager.monsterSystem == null || RogueMonsterArrowPrefab == null)
		{
			HideAutomaticRogueMonsterArrow();
			return;
		}
		CompTransform compTransform = MonoECS.instance.mainEntity.GetCompTransform();
		if (compTransform == null)
		{
			HideAutomaticRogueMonsterArrow();
			return;
		}
		GameManager.monsterSystem.CollectAliveMonsters(rogueAliveMonsters);
		Entity entity = Entity.Invalid;
		float num = float.MaxValue;
		for (int i = 0; i < rogueAliveMonsters.Count; i++)
		{
			Entity entity2 = rogueAliveMonsters[i];
			CompTransform compTransform2 = entity2.GetCompTransform();
			if (compTransform2 != null)
			{
				Vector3 screenPosition = GameUtility.mainCamera.WorldToScreenPoint(compTransform2.colliderPosition);
				if (IsRogueTargetInScreen(screenPosition))
				{
					HideAutomaticRogueMonsterArrow();
					return;
				}
				float sqrMagnitude = (compTransform2.physicsPosition - compTransform.physicsPosition).sqrMagnitude;
				if (sqrMagnitude < num)
				{
					entity = entity2;
					num = sqrMagnitude;
				}
			}
		}
		if (entity.IsValid)
		{
			MonoEntity mono = entity.GetMono();
			if ((object)mono != null)
			{
				if (automaticMonsterArrowTarget != entity || !rogueMonsterArrows.TryGetValue(int.MinValue, out var value) || value == null)
				{
					automaticMonsterArrowTarget = entity;
					SetRogueMonsterArrow(int.MinValue, mono.transform, visible: true, showDistance: false);
				}
				return;
			}
		}
		HideAutomaticRogueMonsterArrow();
	}

	private bool IsRogueTargetInScreen(Vector3 screenPosition)
	{
		if (screenPosition.z < 0f)
		{
			return false;
		}
		if (arrowInvisibleArea != null)
		{
			return RectTransformUtility.RectangleContainsScreenPoint(arrowInvisibleArea, screenPosition, GameUtility.uiCamera);
		}
		if (screenPosition.x >= 0f && screenPosition.x <= (float)Screen.width && screenPosition.y >= 0f)
		{
			return screenPosition.y <= (float)Screen.height;
		}
		return false;
	}

	private void HideAutomaticRogueMonsterArrow()
	{
		if (automaticMonsterArrowTarget.IsValid || rogueMonsterArrows.ContainsKey(int.MinValue))
		{
			automaticMonsterArrowTarget = Entity.Invalid;
			SetRogueMonsterArrow(int.MinValue, null, visible: false, showDistance: false);
		}
	}

	private void RefreshAutomaticRogueInteractArrows()
	{
		currentAutomaticRogueChestArrowIndices.Clear();
		WorldManager worldManager = Singleton<GameManager>.instance.worldManager;
		if (worldManager == null || worldManager.GetCurrentWorld()?.SceneStatus != SceneStatus.Rogue || GameUtility.mainCamera == null || RogueInteractArrowPrefab == null)
		{
			ClearAutomaticRogueInteractArrows();
			return;
		}
		IReadOnlyList<InteractRogueChest> activeRogueChests = Model<RogueNewModel>.Interface.ActiveRogueChests;
		for (int i = 0; i < activeRogueChests.Count; i++)
		{
			InteractRogueChest interactRogueChest = activeRogueChests[i];
			if (!(interactRogueChest == null) && interactRogueChest.isActiveAndEnabled && interactRogueChest.gameObject.activeInHierarchy && interactRogueChest.Inited && interactRogueChest.currentState.id == 1)
			{
				Transform interactTipTransform = interactRogueChest.GetInteractTipTransform();
				if (!(interactTipTransform == null) && !IsRogueTargetInScreen(GameUtility.mainCamera.WorldToScreenPoint(interactTipTransform.position)))
				{
					int num = interactRogueChest.swid ^ int.MinValue;
					currentAutomaticRogueChestArrowIndices.Add(num);
					SetRogueInteractArrow(num, interactTipTransform, visible: true, showDistance: true);
				}
			}
		}
		staleAutomaticRogueChestArrowIndices.Clear();
		foreach (int automaticRogueChestArrowIndex in automaticRogueChestArrowIndices)
		{
			if (!currentAutomaticRogueChestArrowIndices.Contains(automaticRogueChestArrowIndex))
			{
				staleAutomaticRogueChestArrowIndices.Add(automaticRogueChestArrowIndex);
			}
		}
		for (int j = 0; j < staleAutomaticRogueChestArrowIndices.Count; j++)
		{
			int num2 = staleAutomaticRogueChestArrowIndices[j];
			SetRogueInteractArrow(num2, null, visible: false, showDistance: true);
			automaticRogueChestArrowIndices.Remove(num2);
		}
		foreach (int currentAutomaticRogueChestArrowIndex in currentAutomaticRogueChestArrowIndices)
		{
			automaticRogueChestArrowIndices.Add(currentAutomaticRogueChestArrowIndex);
		}
	}

	private void ClearAutomaticRogueInteractArrows()
	{
		foreach (int automaticRogueChestArrowIndex in automaticRogueChestArrowIndices)
		{
			SetRogueInteractArrow(automaticRogueChestArrowIndex, null, visible: false, showDistance: true);
		}
		automaticRogueChestArrowIndices.Clear();
		currentAutomaticRogueChestArrowIndices.Clear();
		staleAutomaticRogueChestArrowIndices.Clear();
	}

	public void Initialize(MonoBattleMainBaseView view)
	{
		WorldManager worldManager = Singleton<GameManager>.instance.worldManager;
		if (worldManager != null && worldManager.GetCurrentWorld()?.SceneStatus == SceneStatus.Rogue)
		{
			stateWorldAssetUid = 0;
			Reset();
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.RogueCoinUpdate, OnUpdateRogueCoin);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.RogueOpenInteractTips, OnRogueOpenInteractTips);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.RogueCloseInteractTips, OnRogueCloseInteractTips);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.RogueOpenGateBubble, OnRogueOpenGateBubble);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.RogueCloseGateBubble, OnRogueCloseGateBubble);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.Rogue_Exit, OnRogueExit);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.RogueReplace, OnRogueReplace);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.MonsterDieCount, UpdateMonsterCount);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.RogueRecycleItem, OnRogueRecycle);
			bool flag = Model<RogueNewModel>.Interface.Info.GameInfo.RoomInfo.RoomType == RogueRoomType.Ally || Model<RogueNewModel>.Interface.Info.GameInfo.RoomInfo.RoomType == RogueRoomType.Item || Model<RogueNewModel>.Interface.Info.GameInfo.RoomInfo.RoomType == RogueRoomType.Cion || Model<RogueNewModel>.Interface.Info.GameInfo.RoomInfo.RoomType == RogueRoomType.Boss;
			RogueCollectInfo.Condition.gameObject.SetActive(flag);
			if (flag)
			{
				int totalMonsterCount = GetTotalMonsterCount();
				dieMonsterCount = ((Model<RogueNewModel>.Interface.Info.GameInfo.RoomInfo.RoomStatus == RogueRoomStatus.Finished) ? totalMonsterCount : 0);
				RogueCollectInfo.Refresh(dieMonsterCount, totalMonsterCount);
			}
			RogueCollectInfo.UpdateTitle();
		}
	}

	private void UpdateMonsterCount(BaseEventContent obj)
	{
		if (obj is EntityDieEvt entityDieEvt)
		{
			CompProduct compProduct = entityDieEvt.entity.GetCompProduct();
			if (compProduct != null && compProduct.caster.IsValid)
			{
				return;
			}
			dieMonsterCount++;
		}
		RogueCollectInfo.Refresh(dieMonsterCount);
	}

	private void OnRogueReplace(BaseEventContent obj)
	{
		if (obj is RoguePropReplace { isCompleted: not false } roguePropReplace)
		{
			rogueelement = CoreUtils.GetData(roguePropReplace.newItemId, RuntimeConfigs.data.rogueElements);
			RefreshTips();
		}
	}

	private void OnRogueRecycle(BaseEventContent obj)
	{
		if (stateWorldAssetUid != 0)
		{
			Reset();
			RefreshTips();
		}
	}

	private void OnRogueExit(BaseEventContent obj)
	{
		stateWorldAssetUid = 0;
		RecycleAllRogueBubbles();
		DestroyAllRogueArrows();
		Reset();
	}

	public GameObject CreateRogueBubble(Transform target, RogueRoomType roomType, Vector3 worldOffset = default(Vector3))
	{
		if (target == null)
		{
			Debug.LogError("Rogue bubble target is null");
			return null;
		}
		if (BubbleUIPrefab == null || BubbleUIRoot == null)
		{
			Debug.LogError("Rogue bubble prefab or root is not configured");
			return null;
		}
		GameObject gameObject = Object.Instantiate(BubbleUIPrefab, BubbleUIRoot, worldPositionStays: false);
		if (!(gameObject.transform is RectTransform rectTransform))
		{
			Debug.LogError("Rogue bubble prefab must use RectTransform");
			Object.Destroy(gameObject);
			return null;
		}
		if (!gameObject.TryGetComponent<RogueBubbleItem>(out var component))
		{
			Debug.LogError("Rogue bubble prefab does not contain RogueBubbleItem");
			Object.Destroy(gameObject);
			return null;
		}
		component.Init(roomType);
		RogueBubbleFollowInfo rogueBubbleFollowInfo = new RogueBubbleFollowInfo
		{
			Instance = gameObject,
			RectTransform = rectTransform,
			Target = target,
			WorldOffset = worldOffset
		};
		rogueBubbleInstances.Add(rogueBubbleFollowInfo);
		RefreshRogueBubble(rogueBubbleFollowInfo);
		return gameObject;
	}

	private void OnRogueOpenGateBubble(BaseEventContent content)
	{
		if (!(content is RogueGateBubbleEvent rogueGateBubbleEvent) || rogueGateBubbleEvent.Target == null)
		{
			return;
		}
		if (rogueGateBubbles.TryGetValue(rogueGateBubbleEvent.GateId, out var value) && value != null)
		{
			UpdateRogueBubbleFollow(value, rogueGateBubbleEvent.Target, rogueGateBubbleEvent.WorldOffset);
			value.GetComponent<RogueBubbleItem>()?.Init(rogueGateBubbleEvent.RoomType);
			return;
		}
		value = CreateRogueBubble(rogueGateBubbleEvent.Target, rogueGateBubbleEvent.RoomType, rogueGateBubbleEvent.WorldOffset);
		if (value != null)
		{
			rogueGateBubbles[rogueGateBubbleEvent.GateId] = value;
		}
	}

	private void OnRogueCloseGateBubble(BaseEventContent content)
	{
		if (content is RogueGateBubbleEvent rogueGateBubbleEvent && rogueGateBubbles.Remove(rogueGateBubbleEvent.GateId, out var value))
		{
			RecycleRogueBubble(value);
		}
	}

	public bool UpdateRogueBubbleFollow(GameObject bubble, Transform target, Vector3 worldOffset)
	{
		if (bubble == null || target == null)
		{
			return false;
		}
		for (int i = 0; i < rogueBubbleInstances.Count; i++)
		{
			RogueBubbleFollowInfo rogueBubbleFollowInfo = rogueBubbleInstances[i];
			if (!(rogueBubbleFollowInfo.Instance != bubble))
			{
				rogueBubbleFollowInfo.Target = target;
				rogueBubbleFollowInfo.WorldOffset = worldOffset;
				RefreshRogueBubble(rogueBubbleFollowInfo);
				return true;
			}
		}
		return false;
	}

	public bool SetRogueBubbleOffset(GameObject bubble, Vector3 worldOffset)
	{
		if (bubble == null)
		{
			return false;
		}
		for (int i = 0; i < rogueBubbleInstances.Count; i++)
		{
			RogueBubbleFollowInfo rogueBubbleFollowInfo = rogueBubbleInstances[i];
			if (!(rogueBubbleFollowInfo.Instance != bubble))
			{
				rogueBubbleFollowInfo.WorldOffset = worldOffset;
				RefreshRogueBubble(rogueBubbleFollowInfo);
				return true;
			}
		}
		return false;
	}

	public void RecycleRogueBubble(GameObject bubble)
	{
		if (bubble == null)
		{
			return;
		}
		for (int num = rogueBubbleInstances.Count - 1; num >= 0; num--)
		{
			RogueBubbleFollowInfo rogueBubbleFollowInfo = rogueBubbleInstances[num];
			if (!(rogueBubbleFollowInfo.Instance != bubble))
			{
				rogueBubbleInstances.RemoveAt(num);
				Object.Destroy(rogueBubbleFollowInfo.Instance);
				break;
			}
		}
	}

	public void RecycleAllRogueBubbles()
	{
		for (int num = rogueBubbleInstances.Count - 1; num >= 0; num--)
		{
			GameObject instance = rogueBubbleInstances[num].Instance;
			if (instance != null)
			{
				Object.Destroy(instance);
			}
		}
		rogueBubbleInstances.Clear();
		rogueGateBubbles.Clear();
	}

	private void RefreshRogueBubbles()
	{
		WorldManager worldManager = Singleton<GameManager>.instance.worldManager;
		if (worldManager == null || worldManager.GetCurrentWorld()?.SceneStatus != SceneStatus.Rogue)
		{
			if (rogueBubbleInstances.Count > 0)
			{
				RecycleAllRogueBubbles();
			}
			return;
		}
		for (int num = rogueBubbleInstances.Count - 1; num >= 0; num--)
		{
			RogueBubbleFollowInfo rogueBubbleFollowInfo = rogueBubbleInstances[num];
			if (rogueBubbleFollowInfo.Instance == null || rogueBubbleFollowInfo.Target == null)
			{
				rogueBubbleInstances.RemoveAt(num);
				if (rogueBubbleFollowInfo.Instance != null)
				{
					Object.Destroy(rogueBubbleFollowInfo.Instance);
				}
			}
			else
			{
				RefreshRogueBubble(rogueBubbleFollowInfo);
			}
		}
	}

	private void RefreshRogueBubble(RogueBubbleFollowInfo followInfo)
	{
		if (!(followInfo.RectTransform == null) && !(BubbleUIRoot == null) && !(GameUtility.mainCamera == null))
		{
			Vector3 vector = GameUtility.mainCamera.WorldToScreenPoint(followInfo.Target.position + followInfo.WorldOffset);
			if (RectTransformUtility.ScreenPointToWorldPointInRectangle(BubbleUIRoot, vector, GameUtility.uiCamera, out var worldPoint))
			{
				followInfo.RectTransform.position = worldPoint;
			}
		}
	}

	public RogueArrow SetRogueMonsterArrow(int index, Transform target, bool visible, bool showDistance)
	{
		return SetRogueArrow(rogueMonsterArrows, index, RogueMonsterArrowPrefab, target, visible, showDistance);
	}

	public RogueArrow SetRogueInteractArrow(int index, Transform target, bool visible, bool showDistance)
	{
		return SetRogueArrow(rogueInteractArrows, index, RogueInteractArrowPrefab, target, visible, showDistance);
	}

	private RogueArrow SetRogueArrow(Dictionary<int, RogueArrow> arrows, int index, RogueArrow prefab, Transform target, bool visible, bool showDistance)
	{
		if (!visible)
		{
			DestroyRogueArrow(arrows, index);
			return null;
		}
		if (prefab == null)
		{
			Debug.LogError("Rogue箭头预制体未配置");
			return null;
		}
		if (target == null)
		{
			Debug.LogError($"Rogue箭头目标为空: {index}");
			DestroyRogueArrow(arrows, index);
			return null;
		}
		if (!arrows.TryGetValue(index, out var value) || value == null)
		{
			value = (arrows[index] = Object.Instantiate(prefab, (RogueArrowRoot != null) ? RogueArrowRoot : transform));
			rogueArrowInstances.Add(value);
			value.Initialize(target, showDistance);
		}
		else
		{
			value.UpdateTarget(target, showDistance);
		}
		return value;
	}

	private void DestroyRogueArrow(Dictionary<int, RogueArrow> arrows, int index)
	{
		if (arrows.Remove(index, out var value) && !(value == null))
		{
			rogueArrowInstances.Remove(value);
			value.UnInitialize();
			Object.Destroy(value.gameObject);
		}
	}

	public void DestroyAllRogueArrows()
	{
		for (int num = rogueArrowInstances.Count - 1; num >= 0; num--)
		{
			RogueArrow rogueArrow = rogueArrowInstances[num];
			if (!(rogueArrow == null))
			{
				rogueArrow.UnInitialize();
				Object.Destroy(rogueArrow.gameObject);
			}
		}
		rogueArrowInstances.Clear();
		rogueMonsterArrows.Clear();
		rogueInteractArrows.Clear();
		automaticRogueChestArrowIndices.Clear();
		currentAutomaticRogueChestArrowIndices.Clear();
		staleAutomaticRogueChestArrowIndices.Clear();
		automaticMonsterArrowTarget = Entity.Invalid;
	}

	private void RefreshRogueArrow(RogueArrow arrow, Vector3 playerPosition, bool hasPlayerPosition)
	{
		if (!arrow.TryGetTargetWorldPosition(out var worldPosition) || arrowArea == null || GameUtility.mainCamera == null)
		{
			arrow.SetVisible(visible: false);
			return;
		}
		Vector3 targetScreenPosition = GameUtility.mainCamera.WorldToScreenPoint(worldPosition);
		Vector2 arrowScreenPosition;
		Vector2 direction;
		Vector3 worldPoint;
		if (IsRogueArrowTargetVisible(targetScreenPosition))
		{
			arrow.SetVisible(visible: false);
		}
		else if (!TryGetRogueArrowScreenPosition(targetScreenPosition, out arrowScreenPosition, out direction))
		{
			arrow.SetVisible(visible: false);
		}
		else if (!RectTransformUtility.ScreenPointToWorldPointInRectangle(arrowArea, arrowScreenPosition, GameUtility.uiCamera, out worldPoint))
		{
			arrow.SetVisible(visible: false);
		}
		else
		{
			arrow.ApplyView(worldPoint, direction, playerPosition, hasPlayerPosition);
		}
	}

	private bool IsRogueArrowTargetVisible(Vector3 targetScreenPosition)
	{
		if (targetScreenPosition.z < 0f)
		{
			return false;
		}
		if (arrowInvisibleArea != null)
		{
			return RectTransformUtility.RectangleContainsScreenPoint(arrowInvisibleArea, targetScreenPosition, GameUtility.uiCamera);
		}
		if (targetScreenPosition.x >= 0f && targetScreenPosition.x <= (float)Screen.width && targetScreenPosition.y >= 0f)
		{
			return targetScreenPosition.y <= (float)Screen.height;
		}
		return false;
	}

	private bool TryGetRogueArrowScreenPosition(Vector3 targetScreenPosition, out Vector2 arrowScreenPosition, out Vector2 direction)
	{
		arrowArea.GetWorldCorners(rogueArrowAreaCorners);
		Vector2 vector = RectTransformUtility.WorldToScreenPoint(GameUtility.uiCamera, rogueArrowAreaCorners[0]);
		Vector2 vector2 = RectTransformUtility.WorldToScreenPoint(GameUtility.uiCamera, rogueArrowAreaCorners[1]);
		Vector2 vector3 = RectTransformUtility.WorldToScreenPoint(GameUtility.uiCamera, rogueArrowAreaCorners[2]);
		Vector2 vector4 = RectTransformUtility.WorldToScreenPoint(GameUtility.uiCamera, rogueArrowAreaCorners[3]) - vector;
		Vector2 vector5 = vector2 - vector;
		float num = vector4.magnitude * 0.5f;
		float num2 = vector5.magnitude * 0.5f;
		if (num <= Mathf.Epsilon || num2 <= Mathf.Epsilon)
		{
			arrowScreenPosition = default;
			direction = default;
			return false;
		}
		Vector2 vector6 = (vector + vector3) * 0.5f;
		Vector2 vector7 = vector4 / (num * 2f);
		Vector2 vector8 = vector5 / (num2 * 2f);
		Vector2 vector9 = (Vector2)targetScreenPosition - vector6;
		if (targetScreenPosition.z < 0f)
		{
			vector9 = -vector9;
		}
		if (vector9.sqrMagnitude <= Mathf.Epsilon)
		{
			vector9 = Vector2.down;
		}
		float num3 = Vector2.Dot(vector9, vector7);
		float num4 = Vector2.Dot(vector9, vector8);
		float num5 = num3 * num3 / (num * num) + num4 * num4 / (num2 * num2);
		if (num5 <= Mathf.Epsilon)
		{
			arrowScreenPosition = default;
			direction = default;
			return false;
		}
		float num6 = 1f / Mathf.Sqrt(num5);
		arrowScreenPosition = vector6 + vector7 * (num3 * num6) + vector8 * (num4 * num6);
		direction = (arrowScreenPosition - vector6).normalized;
		return true;
	}

	private static bool TryGetRogueArrowPlayerPosition(out Vector3 playerPosition)
	{
		playerPosition = default;
		if (MonoECS.instance == null || !MonoECS.instance.mainEntity.IsValid)
		{
			return false;
		}
		CompTransform compTransform = MonoECS.instance.mainEntity.GetCompTransform();
		if (compTransform == null)
		{
			return false;
		}
		playerPosition = compTransform.physicsPosition;
		return true;
	}

	private void Reset()
	{
		RogueEquipTipComponent.GameObject.SetActive(value: false);
		RogueHudCharacterTipComponent.GameObject.SetActive(value: false);
		RogueHudCharacterReplaceTipComponent.GameObject.SetActive(value: false);
		RogueHudBloodbottleTipComponent.GameObject.SetActive(value: false);
		RogueHudCharacterTipComponent.Unbind();
		RogueHudBloodbottleTipComponent.Unbind();
		RogueHudCharacterReplaceTipComponent.Unbind();
		RogueEquipTipComponent.Unbind();
	}

	private void OnRogueCloseInteractTips(BaseEventContent obj)
	{
		if (obj is RogueCloseInteractTips rogueCloseInteractTips && rogueCloseInteractTips.swuid == stateWorldAssetUid)
		{
			stateWorldAssetUid = 0;
			if (CurrentComponent == null)
			{
				Reset();
				return;
			}
			CurrentComponent.GameObject.SetActive(value: false);
			CurrentComponent.Unbind();
		}
	}

	private void OnRogueOpenInteractTips(BaseEventContent obj)
	{
		if (obj is RogueOpenInteractTips rogueOpenInteractTips)
		{
			stateWorldAssetUid = rogueOpenInteractTips.Entity.swid;
			rogueelement = CoreUtils.GetData(rogueOpenInteractTips.newItemId, RuntimeConfigs.data.rogueElements);
			RefreshTips();
		}
	}

	private void RefreshTips()
	{
		bool item = Model<RogueNewModel>.Interface.IsNeedUpgrade(rogueelement.id).Item1;
		bool flag = Model<RogueNewModel>.Interface.IsNeedReplace(rogueelement.id);
		if (rogueelement.elementType == 3)
		{
			InitRogueEquipTipsPickUp(flag);
		}
		else if (rogueelement.elementType == 1)
		{
			InitRogueBloodbottleTipsPickUp(flag);
		}
		else if (flag && !item)
		{
			InitRogueCharacterReplace();
		}
		else
		{
			InitRogueCharacterTipsPickUp();
		}
	}

	private void InitRogueEquipTipsPickUp(bool isreplace)
	{
		CurrentComponent = RogueEquipTipComponent;
		RogueEquipTipComponent.Init(rogueelement, isreplace, stateWorldAssetUid);
		RogueEquipTipComponent.GameObject.SetActive(value: true);
		RogueEquipTipComponent.betterAnimation.GetSequence("Show").Play();
		RogueEquipTipComponent.Bind();
	}

	private void InitRogueCharacterTipsPickUp()
	{
		CurrentComponent = RogueHudCharacterTipComponent;
		RogueHudCharacterTipComponent.Init(rogueelement, stateWorldAssetUid);
		RogueHudCharacterTipComponent.gameObject.SetActive(value: true);
		RogueHudCharacterTipComponent.betterAnimation.GetSequence("Show").Play();
		RogueHudCharacterTipComponent.Bind();
	}

	private void InitRogueCharacterReplace()
	{
		CurrentComponent = RogueHudCharacterReplaceTipComponent;
		RogueHudCharacterReplaceTipComponent.Init(rogueelement, stateWorldAssetUid);
		RogueHudCharacterReplaceTipComponent.gameObject.SetActive(value: true);
		RogueHudCharacterReplaceTipComponent.betterAnimation.GetSequence("Show").Play();
		RogueHudCharacterReplaceTipComponent.Bind();
	}

	private void InitRogueBloodbottleTipsPickUp(bool isreplace)
	{
		CurrentComponent = RogueHudBloodbottleTipComponent;
		RogueHudBloodbottleTipComponent.Init(rogueelement, isreplace, stateWorldAssetUid);
		RogueHudBloodbottleTipComponent.gameObject.SetActive(value: true);
		RogueHudBloodbottleTipComponent.betterAnimation.GetSequence("Show").Play();
		RogueHudBloodbottleTipComponent.Bind();
	}

	private void InitRogueBloodbottleReplace()
	{
	}

	private void OnUpdateRogueCoin(BaseEventContent obj)
	{
		WorldManager worldManager = Singleton<GameManager>.instance.worldManager;
		if (worldManager != null && worldManager.GetCurrentWorld()?.SceneStatus == SceneStatus.Rogue)
		{
			RefreshRogueCoinNum();
		}
	}

	private void RefreshRogueCoinNum()
	{
		RogueCoin.TextRogueInCoinNum.SetText("{0:0}", Model<RogueNewModel>.Interface.Info.GameInfo.Coin);
	}

	public void UnInitialize()
	{
		RecycleAllRogueBubbles();
		DestroyAllRogueArrows();
		WorldManager worldManager = Singleton<GameManager>.instance.worldManager;
		if (worldManager != null && worldManager.GetCurrentWorld()?.SceneStatus == SceneStatus.Rogue)
		{
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.RogueCoinUpdate, OnUpdateRogueCoin);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.RogueOpenInteractTips, OnRogueOpenInteractTips);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.RogueCloseInteractTips, OnRogueCloseInteractTips);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.RogueOpenGateBubble, OnRogueOpenGateBubble);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.RogueCloseGateBubble, OnRogueCloseGateBubble);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Rogue_Exit, OnRogueExit);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.RogueReplace, OnRogueReplace);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MonsterDieCount, UpdateMonsterCount);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.RogueRecycleItem, OnRogueRecycle);
		}
	}

	public void OpenComponent()
	{
		WorldManager worldManager = Singleton<GameManager>.instance.worldManager;
		if (worldManager != null && worldManager.GetCurrentWorld()?.SceneStatus == SceneStatus.Rogue)
		{
			RefreshRogueCoinIcon();
			RefreshRogueCoinNum();
			RefreshRogueOutCoinNum();
		}
	}

	public void RefreshRogueCoinIcon()
	{
		ItemData data = CoreUtils.GetData(87, RuntimeConfigs.data.itemDatas);
		Station.LoadItemIcon(data.iconAddress, RogueCoin.RogueTalentTreeCoinImage);
		ItemData data2 = CoreUtils.GetData(89, RuntimeConfigs.data.itemDatas);
		Station.LoadItemIcon(data2.iconAddress, RogueCoin.RogueOutCoinImage);
	}

	private void RefreshRogueOutCoinNum()
	{
		RogueMode data = CoreUtils.GetData(Model<RogueNewModel>.Interface.Info.GameInfo.ModeId, RuntimeConfigs.data.rogueModes);
		int index = Model<RogueNewModel>.Interface.Info.GameInfo.Index;
		if (index == 0)
		{
			RogueCoin.TextRogueOutCoinNum.SetText("{0:0}", 0f);
			RogueCoin.TextRogueTalentTreeCoinNum.SetText("{0:0}", 0f);
		}
		else
		{
			MapNodeConfig data2 = CoreUtils.GetData(data.mapNodeList[index - 1], RuntimeConfigs.data.mapNodeConfigs);
			RogueCoin.TextRogueOutCoinNum.SetText("{0:0}", data2.totalShopTokenGained[0].count);
			RogueCoin.TextRogueTalentTreeCoinNum.SetText("{0:0}", data2.totaltalentReward[0].count);
		}
	}

	private int GetTotalMonsterCount()
	{
		int num = 0;
		foreach (StateWorldAssetData item in Singleton<GameManager>.instance.worldManager.FetchActiveWorldStateAssetDatas())
		{
			if ((item.serviceSaveTag == ServiceSaveTag.Monster || item.serviceSaveTag == ServiceSaveTag.WorldMonsterPoint) && (!(item is WorldMonsterPointData worldMonsterPointData) || worldMonsterPointData.HasMonster()))
			{
				num++;
			}
		}
		return num;
	}

	public void CloseComponent()
	{
		DestroyAllRogueArrows();
	}

	public void PushStack()
	{
	}

	public void PopStack()
	{
	}
}
