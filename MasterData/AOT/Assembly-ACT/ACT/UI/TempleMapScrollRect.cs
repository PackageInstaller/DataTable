using System.Collections.Generic;
using ACT.Battle;
using ACT.EventTrack;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using ACT.World;
using ACT.World.Asset;
using Bamboo.ECS;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class TempleMapScrollRect : ScrollRect
{
	private UnityAction<bool> toWorldMap;

	private UnityAction toAreaMap;

	private TempleModel model;

	private List<TempleData> _infos;

	public BImage templeBackGround;

	public LargeMapView view;

	public ActButton backToAreaMap;

	public ActButton btnStartReward;

	public LoopVerticalScrollRect templeList;

	public List<TempleIcon> templeIcons = new List<TempleIcon>();

	public GameObject rightPanel;

	public LocalizeStringEvent txtDetalName;

	public LocalizeStringEvent txtRecomendLevelDesc;

	public TextMeshProUGUI txtRecomendLevel;

	public BImage[] limitAttrImageList;

	public GameObject limitAttrGo;

	public LocalizeStringEvent txtDesc;

	public LocalizeStringEvent[] txtGoalList;

	public Image[] imgGoalActiveList;

	public GameObject treasureBox;

	public TextMeshProUGUI treasureBoxCount;

	public LocalizeStringEvent txtFirstPassReward;

	public List<ItemUIComponentBase> itemRewardList = new List<ItemUIComponentBase>();

	public ActButton btnTeleport;

	public ActButton btnCloseDetal;

	public BetterAnimation BetterAnimation;

	public List<GameObject> templeBtnPropmts;

	public List<GameObject> templeSideBarBtnPropmts;

	public List<TempleData> infos => _infos;

	public TempleData nowSelectData { get; set; }

	public TempleCell lastSelect { get; set; }

	public bool iconSelectFromScrollMap { get; set; } = true;

	public void Init(UnityAction toArea)
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Temple/Open");
		model = Model<TempleModel>.Interface;
		view.templeMapRoot.SetActive(value: true);
		_infos = model.areaTempleDatas[(int)view.CurShowArea];
		toAreaMap = toArea;
		backToAreaMap.SetBtnClick(() =>
		{
			toAreaMap?.Invoke();
			Uninit();
		}, "event:/UI/Common/Return_Click");
		MapArea curShowArea = view.CurShowArea;
		int id = curShowArea switch
		{
			MapArea.Aurum => 1, 
			MapArea.Arsenal => 1, 
			MapArea.TEPC => 2, 
			MapArea.Sewer => 3, 
			MapArea.Crater => 4, 
			MapArea.Walkure => 4, 
		};
		view.Station.LoadImage(128, id, templeBackGround);
		templeList.ClearCells();
		templeList.totalCount = _infos.Count;
		templeList.OnItemLoad.AddListener(OnItemLoaded);
		templeList.RefillCells();
		rightPanel.gameObject.SetActive(value: false);
		RefreshTempleIcons();
		btnStartReward.SetBtnClick(() =>
		{
			GoToRewardView().Forget();
		});
		btnTeleport.SetBtnClick(() =>
		{
			if (nowSelectData != null)
			{
				TempleEnterData templeEnterData = Model<MapModel>.Interface.FindTempleEnterDataByInstanceId(nowSelectData.staticData.id);
				if (templeEnterData != null)
				{
					Transfer(templeEnterData);
				}
			}
		});
		BetterAnimation.GetSequence("Show").Play();
	}

	public void SetInitTempleDungeon(int templeDungeonId)
	{
		foreach (TempleIcon templeIcon2 in templeIcons)
		{
			TempleIcon templeIcon = templeIcon2;
			if (templeIcon.gameObject.activeSelf && templeIcon.TempleData != null && templeIcon.TempleData.templeId == templeDungeonId)
			{
				Button component = templeIcon2.GetComponent<Button>();
				if (component != null)
				{
					component.onClick?.Invoke();
					break;
				}
			}
		}
	}

	public void Transfer(TempleEnterData templeEnterData)
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Temple/Transfer");
		TPEvt evt = EventTrackSolver.Instance.GetEvt<TPEvt>();
		evt.currentPosition = MonoECS.instance.mainEntity.GetCompTransform().physicsPosition;
		evt.targetPosition = templeEnterData.initPos;
		EventTrackSolver.Instance.Dispatch(evt);
		TeleportUtility.TeleportWithInteractObject(templeEnterData).Forget();
		view.Close();
	}

	private void RefreshTempleIcons()
	{
		for (int i = 0; i < templeIcons.Count; i++)
		{
			bool flag = i < _infos.Count;
			templeIcons[i].gameObject.SetActive(flag);
			TempleIcon templeIcon = templeIcons[i];
			Button component = templeIcons[i].GetComponent<Button>();
			if (!flag)
			{
				continue;
			}
			templeIcon.SetSelected(flag: false);
			component.onClick.RemoveAllListeners();
			templeIcon.SetInfo(_infos[i]);
			component.onClick.AddListener(() =>
			{
				if (templeIcon.TempleData.unLock)
				{
					Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Temple/Select");
					nowSelectData = templeIcon.TempleData;
					OnSelectIcon(templeIcon.TempleData);
					ShowDetail(templeIcon.TempleData);
					OnSelectItem(templeIcon.TempleData);
				}
			});
		}
	}

	public void CloseRightPanel()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Popup_Close");
		view.ChangeToGamePadInputState(SubControllerType.templeMap);
		BetterAnimation.GetSequence("RightHide").OnComplete((AnimationBuilder animationBuilder) =>
		{
			rightPanel.SetActive(value: false);
		}).Play();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Temple/Window_Close");
	}

	private void OnSelectIcon(TempleData data)
	{
		for (int i = 0; i < _infos.Count; i++)
		{
			templeIcons[i].SetSelected(templeIcons[i].TempleData.templeId == data.templeId);
		}
	}

	private void OnSelectItem(TempleData data)
	{
		for (int i = 0; i < templeList.totalCount; i++)
		{
			if (templeList.GetItem(i) is TempleItem templeItem)
			{
				templeItem.SetSelected(templeItem.TempleData?.templeId == data.templeId);
			}
		}
	}

	private async void ShowDetail(TempleData data)
	{
		if (!rightPanel.activeSelf)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Temple/Window_Open");
		}
		rightPanel.SetActive(value: true);
		view.ChangeToGamePadInputState(SubControllerType.templeMapSideBar);
		txtDetalName.StringReference.TableEntryReference = data.staticData.name;
		TextMeshProUGUI textMeshProUGUI = txtRecomendLevel;
		int recommendedLevel = data.staticData.recommendedLevel;
		textMeshProUGUI.text = recommendedLevel.ToString() ?? "";
		txtDesc.StringReference.TableEntryReference = data.staticData.desc;
		List<int> limitElements = Model<TempleModel>.Interface.GetLimitElements(data);
		for (int i = 0; i < limitAttrImageList.Length; i++)
		{
			bool flag = i < limitElements.Count;
			limitAttrImageList[i].icon.gameObject.SetActive(flag);
			if (flag)
			{
				view.Station.LoadImage(102, limitElements[i], limitAttrImageList[i]);
			}
		}
		limitAttrGo.SetActive(limitElements.Count > 0);
		int totalTreasureBox = await Model<TempleModel>.Interface.GetTotalTreasureBoxCount(data.templeId);
		int num = await Model<TempleModel>.Interface.GetTreasureBoxCount(data.templeId);
		treasureBox.SetActive(totalTreasureBox > 0);
		treasureBoxCount.SetText("{0:0}/{1:0}", num, totalTreasureBox);
		for (int j = 0; j < imgGoalActiveList.Length; j++)
		{
			imgGoalActiveList[j].gameObject.SetActive(j < Model<TempleModel>.Interface.GetTempleActiveRobotCount(data.templeId));
		}
		List<ItemUnifierProxy> templeRewardList = Model<TempleModel>.Interface.GetTempleRewardList(data);
		for (int k = 0; k < itemRewardList.Count; k++)
		{
			bool flag2 = k < templeRewardList.Count;
			ItemUIComponentBase itemUIComponentBase = itemRewardList[k];
			itemUIComponentBase.gameObject.SetActive(flag2);
			if (flag2)
			{
				itemUIComponentBase.IsComplete = data.isComplate;
				itemUIComponentBase.SetData(templeRewardList[k], long.MinValue, ItemUIComponentBase.InitType.RewardItem, ItemUIComponentBase.ItemCountShowType.OneSide);
				itemUIComponentBase.UpdatePerformance();
			}
		}
		BetterAnimation.GetSequence("RightShow").Play();
	}

	private void OnItemLoaded(ILoopScrollDataSource iSource)
	{
		LoopScrollBaseItem loopScrollBaseItem = iSource as LoopScrollBaseItem;
		TempleData data = _infos[loopScrollBaseItem.index];
		TempleEnterData templeEnterData = Model<MapModel>.Interface.FindTempleEnterDataByInstanceId(data.staticData.id);
		TempleItem templeItem = (TempleItem)loopScrollBaseItem;
		if (templeEnterData == null)
		{
			templeItem.gameObject.SetActive(value: false);
			Debug.LogError($"请策划检查配置神庙的配置数据InstanceDungeon的ID:{data.staticData.id}，它在WorldStateAssetDatas中找不到对应的templeEnterData！");
			return;
		}
		templeItem.gameObject.SetActive(value: true);
		templeItem.OnItemClickAction = (TempleItem templeItem2) =>
		{
			for (int i = 0; i < _infos.Count; i++)
			{
				TempleData templeData = _infos[i];
				if (!data.unLock)
				{
					return;
				}
				if (data.templeId == templeData.templeId)
				{
					templeItem2.SetSelected(flag: true);
					nowSelectData = data;
					ShowDetail(data);
					OnSelectIcon(data);
				}
				else
				{
					(templeList.GetItem(i) as TempleItem).SetSelected(flag: false);
				}
			}
			view.ViewControlLayers[SubControllerType.templeMap].DefaultSelect = templeItem2.GetComponent<ACT.ViewControl.SelectableEx>();
		};
		(int, int) tuple = MapUtility.GetGridXY(logPos: new Vector2Int(Mathf.FloorToInt(templeEnterData.initPos.x), Mathf.FloorToInt(templeEnterData.initPos.y)), area: view.CurShowArea, layer: view.CurShowLayer);
		Vector2Int gridId = new Vector2Int
		{
			x = tuple.Item1,
			y = tuple.Item2
		};
		MapModel.AreaExploreInfo areaExploreInfo = Model<MapModel>.Interface.GetAreaExploreInfo(view.CurShowArea);
		data.isExplored = areaExploreInfo?.TryGetNearbyGridInfo(gridId, 0f, out var _) ?? false;
		templeItem.Init(data);
	}

	public void Uninit()
	{
		view.templeOpen = false;
		view.templeMapRoot.SetActive(value: false);
		view.mapPlayerIcon.SetActive(active: true);
		backToAreaMap.OnClick.RemoveListener(toAreaMap);
		if (view.iconSidebar.IsNormal)
		{
			view.iconSidebar.Hide();
		}
		templeList.OnItemLoad.RemoveListener(OnItemLoaded);
		BetterAnimation.GetSequence("Hide").Play();
	}

	public async UniTask GoToRewardView()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Temple/Click");
		await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_TEMPLEREWARD, new TempleRewardViewData
		{
			tabAreaId = view.CurShowArea
		});
	}

	public void Focus(SubControllerType subControllerType)
	{
		for (int i = 0; i < templeBtnPropmts.Count; i++)
		{
			templeBtnPropmts[i].SetActive(subControllerType == SubControllerType.templeMap);
		}
		for (int j = 0; j < templeSideBarBtnPropmts.Count; j++)
		{
			templeSideBarBtnPropmts[j].SetActive(subControllerType == SubControllerType.templeMapSideBar);
		}
	}

	public void UnFocus(SubControllerType subControllerType)
	{
		for (int i = 0; i < templeBtnPropmts.Count; i++)
		{
			templeBtnPropmts[i].SetActive(value: false);
		}
		for (int j = 0; j < templeSideBarBtnPropmts.Count; j++)
		{
			templeSideBarBtnPropmts[j].SetActive(value: false);
		}
	}

	public void OnGamepadActive(bool isActive)
	{
		SubControllerType curSubControllerType = view.GetCurSubControllerType();
		switch (curSubControllerType)
		{
		case SubControllerType.templeMapSideBarReward:
			if (isActive)
			{
				(EventSystemHelper.CurrentSelected?.GetComponent<ItemUIComponentBase>())?.OnSelect(null);
			}
			else
			{
				(EventSystemHelper.CurrentSelected?.GetComponent<ItemUIComponentBase>())?.OnDeselect(null);
			}
			break;
		case SubControllerType.templeMap:
		{
			ViewControlLayer viewControlLayer = view.ViewControlLayers[curSubControllerType];
			if ((bool)viewControlLayer.Root.CurrentFocusLayer)
			{
				viewControlLayer.ReFocus();
			}
			else
			{
				viewControlLayer.Focus();
			}
			break;
		}
		}
	}
}
