using System;
using System.Runtime.CompilerServices;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Config;
using ACT.Core;
using ACT.MissionSystem;
using ACT.Model;
using ACT.NPC;
using ACT.Utility;
using ACT.World.StateObject;
using Bamboo.ECS;
using Bamboo.ImageCenter;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class CommonInteractUI : MonoBehaviour
{
	[SerializeField]
	private Transform bubbleRoot;

	[SerializeField]
	private NpcUIComponentBase alwaysShow;

	[SerializeField]
	private NpcUIComponentBase enterShow;

	[SerializeField]
	private NpcUIComponentBase delayHide;

	[Header("Npc信息部分")]
	[SerializeField]
	private GameObject npcInfoRoot;

	[SerializeField]
	private LocalizeStringEvent npcName;

	[SerializeField]
	private LocalizeStringEvent npcTitle;

	[SerializeField]
	private RedDotItem redDotItem;

	[SerializeField]
	private CanvasGroup canvasGroup;

	[SerializeField]
	private BetterAnimation anim;

	[SerializeField]
	private GameObject missionFx;

	private NPCHeadIconConfig.ShowType m_ShowType;

	private NPCHeadIconConfig.IconConfig m_CurrentIconConfig;

	private bool m_IsMission;

	private bool m_IsReturnedToPool = true;

	private bool m_HasLoggedDestroyedSetActive;

	private bool m_IsInArea;

	private Transform m_CachedTransform;

	private ImageAssetStation m_ImageStation;

	private bool m_IsInit;

	private bool m_IsVisibilityDirty = true;

	private bool m_IsScaleDirty = true;

	private bool m_IsVisible = true;

	private bool m_HasDistanceCache;

	private bool m_HasPlayerPositionCache;

	private Vector3 m_LastCameraPosition;

	private Vector3 m_LastCameraForward;

	private Vector3 m_LastPlayerPosition;

	private Vector3 m_LastGameObjectPosition;

	private bool m_LastInteractTipVisible;

	private static readonly Vector3 s_DefaultTipOffset = new Vector3(0f, 2.5f, 0f);

	private const float DefaultTipScale = 0.01f;

	private const string ActiveAnimationName = "NameShow";

	private const string DeActiveAnimationName = "NameHide";

	private StateObjectBase m_StateObject;

	private int m_SafeConfigId = -1;

	private bool m_HasDefaultConfigId;

	private IShowInteractTip m_InteractEntry;

	private NPCHeadIconConfig Config => GameLoader.meta.npcOrInteractObjectIconConfig;

	public Transform BubbleRoot
	{
		get
		{
			if (IsPooledCallInvalid("BubbleRoot"))
			{
				return null;
			}
			return bubbleRoot;
		}
	}

	private bool IsNpc => EntityReference.IsNPC();

	internal Vector3 CullingPosition
	{
		get
		{
			if (IsPooledCallInvalid("CullingPosition"))
			{
				return Vector3.zero;
			}
			Vector3 vector = ((m_CachedTransform == m_StateObject?.transform) ? s_DefaultTipOffset : Vector3.zero);
			if (!m_CachedTransform)
			{
				return transform.position;
			}
			return m_CachedTransform.position + vector;
		}
	}

	internal bool IsReturnedToPool => m_IsReturnedToPool;

	private NPCHeadIconConfig.IconConfig DefaultConfig
	{
		get
		{
			if (!m_HasDefaultConfigId)
			{
				return null;
			}
			return Config.FindConfigById(DefaultConfigId);
		}
	}

	private NpcDataConfig NpcDataConfig => EntityReference.GetCompNpc()?.NpcDataConfig;

	private int NpcUid => NpcDataConfig?.npcConfigUid ?? 0;

	private NPCHeadIconConfig.IconConfig MainMissionConfig => Config.FindConfigById(0);

	private NPCHeadIconConfig.IconConfig SideMissionConfig => Config.FindConfigById(1);

	private NPCHeadIconConfig.IconConfig DailyMissionConfig => Config.FindConfigById(10);

	private NPCHeadIconConfig.IconConfig LegendMissionConfig => Config.FindConfigById(11);

	private int DefaultConfigId
	{
		get
		{
			if (!m_HasDefaultConfigId)
			{
				return -1;
			}
			return m_SafeConfigId;
		}
		set
		{
			if (value < 0)
			{
				m_HasDefaultConfigId = false;
				m_SafeConfigId = value;
			}
			else if (Config.FindConfigById(value) != null)
			{
				m_HasDefaultConfigId = true;
				m_SafeConfigId = value;
			}
		}
	}

	private Entity EntityReference { get; set; }

	private bool IsPooledCallInvalid([CallerMemberName] string memberName = null)
	{
		if (!this)
		{
			return true;
		}
		if (!m_IsReturnedToPool)
		{
			return false;
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogError("[CommonInteractUI] 对象已回池，忽略外部调用 " + memberName + "。go=" + name);
		}
		return true;
	}

	private bool SafeSetActive(GameObject target, bool active)
	{
		if (!this || target == null)
		{
			return false;
		}
		if (target.activeSelf == active)
		{
			return false;
		}
		try
		{
			target.SetActive(active);
		}
		catch (Exception ex)
		{
			if (!m_HasLoggedDestroyedSetActive && LuminApplication.LogEnabled)
			{
				m_HasLoggedDestroyedSetActive = true;
				Debug.LogWarning(string.Format("[{0}] 对象可能正在销毁，忽略 SetActive({1})。target={2}\n{3}", "CommonInteractUI", active, target.name, ex));
			}
			return false;
		}
		return true;
	}

	private void UpdateNpcStyle()
	{
		if (IsNpc && (bool)NpcDataConfig)
		{
			SafeSetActive(npcInfoRoot, active: true);
			npcName.SetTable(LocalizeTable.ShortCommon);
			NpcConfig data = CoreUtils.GetData(NpcDataConfig.npcConfigUid, RuntimeConfigs.data.npcConfigs);
			int num = data?.name ?? 0;
			int num2 = data?.title ?? 0;
			if (num != 0)
			{
				SafeSetActive(npcName.gameObject, active: true);
				npcName.SetTable(LocalizeTable.ShortCommon);
				npcName.StringReference.TableEntryReference = num;
			}
			else
			{
				SafeSetActive(npcName.gameObject, active: false);
			}
			if (num2 != 0)
			{
				SafeSetActive(npcTitle.gameObject, active: true);
				npcTitle.SetTable(LocalizeTable.ShortCommon);
				npcTitle.StringReference.TableEntryReference = num2;
			}
			else
			{
				SafeSetActive(npcTitle.gameObject, active: false);
			}
		}
		else
		{
			SafeSetActive(npcInfoRoot, active: false);
		}
	}

	public void Init(Entity entityReference, IShowInteractTip interactEntry)
	{
		m_IsReturnedToPool = false;
		m_InteractEntry = interactEntry;
		int configId = m_InteractEntry?.InteractTipId ?? (-1);
		InitComponents();
		AttachToNpcInfoRoot();
		BindEntity(entityReference, configId);
		SetDefaultTip();
		ApplyMissionTipFromMapPoints();
		RefreshAnimation();
		ResetVisibilityAndScaleState();
		m_IsInit = true;
	}

	private void InitComponents()
	{
		if ((bool)alwaysShow)
		{
			alwaysShow.Init();
		}
		if ((bool)enterShow)
		{
			enterShow.Init();
		}
		if ((bool)delayHide)
		{
			delayHide.Init();
		}
	}

	private void AttachToNpcInfoRoot()
	{
		transform.SetParent(GameUtility.npcInfoRoot, worldPositionStays: true);
		transform.localScale = Vector3.one * 0.01f;
		SafeSetActive(gameObject, active: true);
	}

	private void BindEntity(Entity entityReference, int configId)
	{
		bool flag = entityReference.IsNPC();
		CompStateObject compStateObject = entityReference.GetCompStateObject();
		EntityReference = entityReference;
		m_StateObject = compStateObject?.StateObjectBase;
		DefaultConfigId = configId;
		SafeSetActive(npcName.gameObject, entityReference.IsValid & flag);
		m_CachedTransform = ((!flag) ? compStateObject?.StateObjectBase.GetInteractTipTransform() : entityReference.GetCompInteract()?.TipSyncTransform);
	}

	public void RefreshNpcTipSyncTransform(Transform syncTransform)
	{
		if (!IsPooledCallInvalid("RefreshNpcTipSyncTransform") && EntityReference.IsValid && EntityReference.IsNPC())
		{
			m_CachedTransform = syncTransform;
			ResetVisibilityAndScaleState();
		}
	}

	private void ApplyMissionTipFromMapPoints()
	{
		foreach (MissionPointData point in Model<BattleMainMarkModelV2>.Interface.Points)
		{
			if (!point.ShowIcon)
			{
				continue;
			}
			if (!(point is ChaseMissionPoint) && point is StateObjectMissionPoint { InteractObjId: var interactObjId } stateObjectMissionPoint && interactObjId == m_StateObject?.swid)
			{
				if (!IsMissionFinished(stateObjectMissionPoint.MissionId))
				{
					SetMissionTip(stateObjectMissionPoint.MissionId);
					break;
				}
			}
			else if (point is NPCMissionPoint nPCMissionPoint && IsNpc && NpcUid == nPCMissionPoint.NpcUid && !IsMissionFinished(nPCMissionPoint.MissionId))
			{
				SetMissionTip(nPCMissionPoint.MissionId);
				break;
			}
		}
	}

	private static bool IsMissionFinished(int missionId)
	{
		return Singleton<MissionManager>.instance.MissionDatabase.QueryMissionState(missionId)?.IsFinished ?? true;
	}

	public void UnInit()
	{
		if (!IsPooledCallInvalid("UnInit"))
		{
			m_IsReturnedToPool = true;
			m_InteractEntry = null;
			SafeSetActive(redDotItem.gameObject, active: false);
			if ((bool)alwaysShow)
			{
				alwaysShow.UnInit();
			}
			if ((bool)enterShow)
			{
				enterShow.UnInit();
			}
			if ((bool)delayHide)
			{
				delayHide.UnInit();
			}
			DefaultConfigId = -1;
			m_StateObject = null;
			m_CachedTransform = null;
			ImageManager.instance.UnloadAssetStation(m_ImageStation);
			m_ImageStation = null;
			m_IsInArea = false;
			m_IsInit = false;
			ResetVisibilityAndScaleState();
			m_ShowType = NPCHeadIconConfig.ShowType.None;
			m_CurrentIconConfig = null;
			m_HasDefaultConfigId = false;
			m_IsMission = false;
			ResetAnimation();
			SafeSetActive(gameObject, active: false);
			transform.localScale = Vector3.one * 0.01f;
			SetVisible(isVisible: true);
		}
	}

	internal void ResetScaleToDefault()
	{
		if ((bool)this)
		{
			transform.localScale = Vector3.one * 0.01f;
			m_IsScaleDirty = true;
		}
	}

	internal void ResetPositionToDefault()
	{
		Vector3 vector = ((m_CachedTransform == m_StateObject?.transform) ? s_DefaultTipOffset : Vector3.zero);
		transform.position = m_CachedTransform.position + vector;
	}

	private void UpdateMissionFxActive(bool show, int missionId, MissionType missionType)
	{
		bool active = show && missionId != 0 && missionType == MissionType.Main;
		SafeSetActive(missionFx, active);
	}

	public void SetMissionTip(int missionID)
	{
		if (!IsPooledCallInvalid("SetMissionTip"))
		{
			m_IsMission = true;
			MissionConfig missionConfig = Singleton<MissionManager>.instance.GetMissionConfig(missionID);
			SwitchShowType(missionConfig.MissionTypeEnum switch
			{
				MissionType.Main => MainMissionConfig, 
				MissionType.Side => SideMissionConfig, 
				MissionType.Daily => DailyMissionConfig, 
				MissionType.Legend => LegendMissionConfig, 
				_ => SideMissionConfig, 
			});
			UpdateMissionFxActive(show: true, missionID, missionConfig.MissionTypeEnum);
		}
	}

	public void SetDefaultTip()
	{
		if (!IsPooledCallInvalid("SetDefaultTip"))
		{
			m_IsMission = false;
			SwitchShowType(DefaultConfig);
			UpdateNpcStyle();
			UpdateMissionFxActive(show: false, 0, MissionType.Main);
		}
	}

	public void SetDefaultInteractEntry(IShowInteractTip interactEntry)
	{
		if (!IsPooledCallInvalid("SetDefaultInteractEntry"))
		{
			m_InteractEntry = interactEntry;
			DefaultConfigId = m_InteractEntry?.InteractTipId ?? (-1);
			if (!m_IsMission)
			{
				SetDefaultTip();
			}
		}
	}

	private void ActiveGroup(NPCHeadIconConfig.ShowType type)
	{
		if ((bool)this)
		{
			m_ShowType = type;
			SafeSetActive(alwaysShow.gameObject, type == NPCHeadIconConfig.ShowType.AlwaysShow);
			SafeSetActive(enterShow.gameObject, type == NPCHeadIconConfig.ShowType.EnterShow);
			SafeSetActive(delayHide.gameObject, type == NPCHeadIconConfig.ShowType.HideDelay);
		}
	}

	private void SwitchShowType(NPCHeadIconConfig.IconConfig iconConfig)
	{
		m_CurrentIconConfig = iconConfig;
		if (iconConfig == null)
		{
			ActiveGroup(NPCHeadIconConfig.ShowType.None);
			return;
		}
		if (!this || !EntityReference.IsValid || (m_StateObject != null && m_StateObject.currentStateId == -1))
		{
			ActiveGroup(NPCHeadIconConfig.ShowType.None);
			return;
		}
		if (m_ImageStation == null)
		{
			m_ImageStation = ImageManager.instance.GetAssetStation();
		}
		switch (iconConfig.showType)
		{
		case NPCHeadIconConfig.ShowType.AlwaysShow:
			ActiveGroup(NPCHeadIconConfig.ShowType.AlwaysShow);
			m_ImageStation.LoadImage(237, iconConfig.icon, alwaysShow.icon);
			break;
		case NPCHeadIconConfig.ShowType.EnterShow:
			ActiveGroup(NPCHeadIconConfig.ShowType.EnterShow);
			m_ImageStation.LoadImage(237, iconConfig.icon, enterShow.icon);
			enterShow.ShowRefresh(m_IsInArea);
			break;
		case NPCHeadIconConfig.ShowType.HideDelay:
			ActiveGroup(NPCHeadIconConfig.ShowType.HideDelay);
			m_ImageStation.LoadImage(237, iconConfig.icon, delayHide.icon);
			break;
		case NPCHeadIconConfig.ShowType.None:
			ActiveGroup(NPCHeadIconConfig.ShowType.None);
			break;
		}
	}

	public void OnEnterInteractObj()
	{
		if (!IsPooledCallInvalid("OnEnterInteractObj"))
		{
			m_IsInArea = true;
			RefreshAnimation();
			SwitchShowType(m_CurrentIconConfig);
		}
	}

	public void OnExitInteractObj()
	{
		if (!IsPooledCallInvalid("OnExitInteractObj"))
		{
			m_IsInArea = false;
			RefreshAnimation();
			SwitchShowType(m_CurrentIconConfig);
		}
	}

	private void RefreshAnimation()
	{
		anim?.GetSequence(m_IsInArea ? "NameShow" : "NameHide")?.Play();
	}

	private void ResetAnimation()
	{
		anim?.GetSequence("NameHide")?.Complete();
	}

	private static Quaternion GetCameraAlignedRotation(Transform cameraTransform)
	{
		return Quaternion.LookRotation(cameraTransform.forward, cameraTransform.up);
	}

	private void OnDestroy()
	{
		ImageManager.instance.UnloadAssetStation(m_ImageStation);
		m_ImageStation = null;
	}

	internal void LateUpdateByUpdater()
	{
		if (!IsPooledCallInvalid("LateUpdateByUpdater") && m_IsInit && (m_ShowType != NPCHeadIconConfig.ShowType.None || IsNpc) && (bool)m_CachedTransform)
		{
			Transform cameraTransform = GameUtility.mainCamera.transform;
			transform.rotation = GetCameraAlignedRotation(cameraTransform);
			ResetPositionToDefault();
			CheckVisibilityAndScaleDirty(cameraTransform);
		}
	}

	private void ResetVisibilityAndScaleState()
	{
		m_IsVisibilityDirty = true;
		m_IsScaleDirty = true;
		m_IsVisible = true;
		m_HasDistanceCache = false;
		m_HasPlayerPositionCache = false;
	}

	private void CheckVisibilityAndScaleDirty(Transform cameraTransform)
	{
		Vector3 position = m_CachedTransform.position;
		Vector3 position2 = cameraTransform.position;
		Vector3 forward = cameraTransform.forward;
		if (!m_HasDistanceCache || (position - m_LastGameObjectPosition).sqrMagnitude > 1E-06f)
		{
			m_IsVisibilityDirty = true;
			m_IsScaleDirty = true;
		}
		if (!m_HasDistanceCache || (position2 - m_LastCameraPosition).sqrMagnitude > 1E-06f)
		{
			m_IsScaleDirty = true;
		}
		if (!m_HasDistanceCache || (forward - m_LastCameraForward).sqrMagnitude > 1E-06f)
		{
			m_IsVisibilityDirty = true;
			m_IsScaleDirty = true;
		}
		bool flag = m_InteractEntry == null || m_InteractEntry.ShowInteractTip;
		if (!m_HasDistanceCache || flag != m_LastInteractTipVisible)
		{
			m_IsVisibilityDirty = true;
		}
		Entity mainEntity = MonoECS.instance.mainEntity;
		Transform transform = (mainEntity.IsValid ? mainEntity.GetModelTrans() : null);
		Transform transform2 = transform;
		Vector3 vector = (transform2 ? transform.position : Vector3.zero);
		if ((bool)transform2)
		{
			if (!m_HasPlayerPositionCache || (vector - m_LastPlayerPosition).sqrMagnitude > 1E-06f)
			{
				m_IsVisibilityDirty = true;
			}
			m_LastPlayerPosition = vector;
			m_HasPlayerPositionCache = true;
		}
		else if (m_HasPlayerPositionCache)
		{
			m_IsVisibilityDirty = true;
			m_HasPlayerPositionCache = false;
		}
		m_LastGameObjectPosition = position;
		m_LastCameraPosition = position2;
		m_LastCameraForward = forward;
		m_LastInteractTipVisible = flag;
		m_HasDistanceCache = true;
		if (m_IsVisibilityDirty)
		{
			UpdateVisibility(flag, transform2, vector, position, forward);
		}
		if (m_IsScaleDirty && m_IsVisible)
		{
			UpdateScale(position2, forward);
		}
	}

	private void UpdateVisibility(bool interactTipVisible, bool hasPlayerPosition, Vector3 playerPosition, Vector3 gameObjectPosition, Vector3 cameraForward)
	{
		m_IsVisibilityDirty = false;
		m_IsVisible = interactTipVisible;
		float maxVisibleDistance = Config.maxVisibleDistance;
		if ((m_IsVisible && maxVisibleDistance > 0f) & hasPlayerPosition)
		{
			float num = maxVisibleDistance * maxVisibleDistance;
			float num2 = Vector3.Dot(playerPosition - gameObjectPosition, cameraForward);
			m_IsVisible = num2 * num2 <= num;
		}
		canvasGroup.alpha = (m_IsVisible ? 1f : 0f);
	}

	private void UpdateScale(Vector3 cameraPosition, Vector3 cameraForward)
	{
		m_IsScaleDirty = false;
		float minScaleDistance = Config.minScaleDistance;
		float num = 0.01f;
		if (minScaleDistance > 0f)
		{
			float num2 = Mathf.Abs(Vector3.Dot(transform.position - cameraPosition, cameraForward));
			if (num2 >= minScaleDistance)
			{
				num *= Mathf.Max(num2 / minScaleDistance, Config.minScaleFactor);
			}
		}
		transform.localScale = Vector3.one * num;
	}

	public void SetVisible(bool isVisible)
	{
		if ((bool)gameObject)
		{
			int num = (isVisible ? 15 : 3);
			if (gameObject.layer != num)
			{
				gameObject.layer = num;
			}
		}
	}
}
