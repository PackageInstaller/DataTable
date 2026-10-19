using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.MissionSystem;
using ACT.Model;
using ACT.Utility;
using ACT.ViewControl;
using ACT.World;
using ACT.World.Asset;
using Bamboo.ImageCenter;
using DG.Tweening;
using Fundamental;
using Sirenix.OdinInspector;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class EnterAreaMapBtn : MonoBehaviour, IPointerDownHandler, IEventSystemHandler, IPointerUpHandler, IPointerEnterHandler, IPointerExitHandler
{
	private const string HoverStateName = "Show";

	private const string NormalStateName = "Normal";

	public ACT.World.MapArea area;

	public LocalizeStringEvent areaNameLocalize;

	public BetterAnimation btnAnimation;

	[Unit(Units.Second)]
	public float exploreBarShowDuration;

	public Button btn;

	public GameObject unlockAreaImage;

	public GameObject infoRoot;

	public GameObject missionHereGo;

	public BImage trackMissionTypeImage;

	public GameObject playerHereGo;

	public GameObject trackMonsterPointHere;

	public GameObject selfTrackPointHere;

	public BImage selfTrackPointAtlasImage;

	public BImage trackMonsterPointAtlasImage;

	public TextMeshProUGUI exploreRatioText;

	public Image exploreRatioImage;

	public Animator areaAnimator;

	[Tooltip("仅手柄模式下生效：手柄导航选中本按钮时与鼠标悬停表现一致（播放 Show 状态）。键鼠/触屏模式下选中不驱动悬停视觉。")]
	public bool selectAsHover = true;

	public int lockTipLocalizeId;

	private UnityAction clickAction;

	private bool unlock;

	private float _exploreRatio;

	private bool _canExplore;

	private GameObject _targetBg;

	private ACT.ViewControl.SelectableEx _selectableEx;

	private bool _hovered;

	private bool _selected;

	private bool _lastHoverVisual;

	private void Awake()
	{
		_selectableEx = GetComponent<ACT.ViewControl.SelectableEx>();
		if (_selectableEx != null)
		{
			_selectableEx.OnSelectChanged.AddListener(OnSelectChanged);
		}
		if (MonoECS.instance != null)
		{
			MonoECS.instance.onInputModeChange.AddListener(OnInputModeChanged);
		}
	}

	public void OnDestroy()
	{
		if (_selectableEx != null)
		{
			_selectableEx.OnSelectChanged.RemoveListener(OnSelectChanged);
		}
		if (MonoECS.instance != null)
		{
			MonoECS.instance.onInputModeChange.RemoveListener(OnInputModeChanged);
		}
		_targetBg = null;
		trackMonsterPointAtlasImage?.UnLoad();
	}

	private void OnDisable()
	{
		_hovered = false;
		_selected = false;
		_lastHoverVisual = false;
	}

	public void BindTarget(GameObject targetBg)
	{
		_targetBg = targetBg;
	}

	public void Init(bool unlock, bool missionHere, bool playerHere, bool selfTrackHere, bool trackSpecialPoint, UnityAction clickAction)
	{
		this.unlock = unlock;
		transform.gameObject.SetActive(unlock);
		unlockAreaImage.SetActive(unlock);
		exploreRatioImage.fillAmount = 0f;
		infoRoot.SetActive(unlock);
		ACT.Config.MapArea data = CoreUtils.GetData((int)area, RuntimeConfigs.data.mapAreas);
		areaNameLocalize.StringReference.TableReference = "shortcommon";
		areaNameLocalize.StringReference.TableEntryReference = data.name;
		_canExplore = MapUtility.GetAreaCanExplore(area);
		exploreRatioText.gameObject.SetActive(_canExplore & unlock);
		btn.interactable = unlock;
		if (unlock)
		{
			BindClickAction(clickAction);
			missionHereGo.SetActive(missionHere);
			if (missionHere)
			{
				foreach (MissionArrowData currentTrackMissionData in Model<BattleMainMarkModel>.Interface.GetCurrentTrackMissionDatas())
				{
					if (currentTrackMissionData.missionPointData.MapArea == area)
					{
						CoreUtils.GetData(currentTrackMissionData.missionPointData.MissionId, RuntimeConfigs.data.missionBases);
						MissionConfig missionConfig = Singleton<MissionManager>.instance.GetMissionConfig(currentTrackMissionData.missionPointData.MissionId);
						this.GetImageStation().LoadImage(200, missionConfig.MissionType, trackMissionTypeImage);
						break;
					}
				}
			}
			playerHereGo.SetActive(playerHere);
			trackMonsterPointHere.SetActive(trackSpecialPoint);
			selfTrackPointHere.SetActive(selfTrackHere);
			if (selfTrackHere)
			{
				MapPointTraceInfo currentTraceMapPoint = Model<MapModel>.Interface.CurrentTraceMapPoint;
				switch (currentTraceMapPoint.iconType)
				{
				case MapIconType.SelfPoint:
				{
					SelfNodeData selfNode = Model<MapSelfNodeModel>.Interface.GetSelfNode(currentTraceMapPoint.pointId);
					this.GetImageStation().LoadSprite(GameLoader.meta.mapIconNameAssetID, selfNode.iconTypeId, selfTrackPointAtlasImage);
					break;
				}
				case MapIconType.WorldBoss:
				{
					MonsterPointData monsterPointData = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(currentTraceMapPoint.pointId) as MonsterPointData;
					bool flag = Model<MonsterHandModel>.Interface.WildBossUnLock(monsterPointData.monsterPointId);
					HashSet<BakeStaticMapIconData> mapIconDataBy = MapUtility.ConfigWorldMapGraph.GetMapIconDataBy(currentTraceMapPoint.mapArea);
					if (mapIconDataBy == null)
					{
						break;
					}
					foreach (BakeStaticMapIconData item in mapIconDataBy)
					{
						if (item.uid == currentTraceMapPoint.pointId)
						{
							int monsterIcon = CoreUtils.GetData(CoreUtils.DetermineActualMonster(item.worldBossId), RuntimeConfigs.data.entityEnemyDatas).monsterIcon;
							this.GetImageStation().LoadSprite(GameLoader.meta.MonsterCircleHeadAtlasAssetID, flag ? monsterIcon : 99, selfTrackPointAtlasImage);
							break;
						}
					}
					break;
				}
				case MapIconType.Npc:
				{
					if (Model<MapModel>.Interface.MapNpcIdToSpriteId.TryGetValue(currentTraceMapPoint.pointId, out var value))
					{
						this.GetImageStation().LoadSprite(GameLoader.meta.interactIconNameAssetID, value, selfTrackPointAtlasImage);
					}
					else
					{
						selfTrackPointHere.SetActive(value: false);
					}
					break;
				}
				default:
					this.GetImageStation().LoadSprite(GameLoader.meta.mapIconNameAssetID, MapUtility.GetInteractObjSpriteId(currentTraceMapPoint.pointId), selfTrackPointAtlasImage);
					break;
				}
			}
			if (trackSpecialPoint)
			{
				if (Model<TrackModel>.Interface.IsTrackingCollectionPoint)
				{
					this.GetImageStation().LoadSprite(GameLoader.meta.mapIconNameAssetID, Model<TrackModel>.Interface.GetTrackCollectionSpriteId(), trackMonsterPointAtlasImage);
				}
				else if (Model<TrackModel>.Interface.IsTrackingMonsterPoint)
				{
					this.GetImageStation().LoadSprite(GameLoader.meta.monsterheadiconAtlasAssetID, Model<MaterialTrackModel>.Interface.GetMonsterTypeIconAtlasId(Model<MaterialTrackModel>.Interface.GetTrackEnemyId()), trackMonsterPointAtlasImage);
				}
			}
			if (Model<MapModel>.Interface.GetAreaGroupExploreData(area) != null)
			{
				_exploreRatio = Model<MapModel>.Interface.GetAreaGroupExploreData(area).GetAreaExploreRatio();
				exploreRatioText.SetText("{0:0}%", Mathf.FloorToInt(_exploreRatio));
				exploreRatioImage.gameObject.SetActive(value: true);
			}
			else
			{
				exploreRatioImage.gameObject.SetActive(value: false);
				exploreRatioText.text = "";
			}
		}
		else
		{
			RemoveClickAction();
			BindClickAction(() =>
			{
				Singleton<TipManager>.instance.GetTip(TIP_TYPE.TIP_COMMONTIP, new CommonTipData
				{
					localizeId = lockTipLocalizeId,
					tableName = LocalizationUtility.localizeTableName_Common
				});
			});
			exploreRatioImage.gameObject.SetActive(value: false);
		}
	}

	public void SetScale(float scale)
	{
		transform.localScale = new Vector3(1f / scale, 1f / scale, 1f / scale);
		if (_targetBg != null)
		{
			Vector2 screenPoint = RectTransformUtility.WorldToScreenPoint(Singleton<NewUIManager>.instance.UICamera, _targetBg.transform.position);
			if (RectTransformUtility.ScreenPointToLocalPointInRectangle(transform.parent.GetComponent<RectTransform>(), screenPoint, Singleton<NewUIManager>.instance.UICamera, out var localPoint))
			{
				transform.localPosition = localPoint;
			}
		}
	}

	private void BindClickAction(UnityAction action)
	{
		if (clickAction != null)
		{
			btn.onClick.RemoveListener(clickAction);
		}
		clickAction = action;
		btn.onClick.AddListener(action);
	}

	private void RemoveClickAction()
	{
		if (clickAction != null)
		{
			btn.onClick.RemoveListener(clickAction);
			clickAction = null;
		}
	}

	public void PlayShowAnimation()
	{
		btnAnimation.GetSequence("Show")?.Play();
		exploreRatioImage.fillAmount = 0f;
		if (_canExplore)
		{
			exploreRatioImage.DOFillAmount(_exploreRatio, exploreBarShowDuration);
		}
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		_ = unlock;
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		_ = unlock;
	}

	public void OnPointerEnter(PointerEventData eventData)
	{
		_hovered = true;
		RefreshHoverVisual();
	}

	public void OnPointerExit(PointerEventData eventData)
	{
		_hovered = false;
		RefreshHoverVisual();
	}

	private void OnSelectChanged(bool isSelected)
	{
		_selected = isSelected;
		RefreshHoverVisual();
	}

	private void OnInputModeChanged(DeviceInputMode inputMode)
	{
		RefreshHoverVisual();
	}

	private void RefreshHoverVisual()
	{
		bool flag = selectAsHover && _selected && MonoECS.instance != null && MonoECS.instance.InputMode == DeviceInputMode.Gamepad;
		bool flag2 = (_lastHoverVisual = _hovered | flag);
		areaAnimator?.Play(flag2 ? "Show" : "Normal");
	}
}
