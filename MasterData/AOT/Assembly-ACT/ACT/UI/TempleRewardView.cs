using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Model;
using ACT.UI.InputController;
using ACT.ViewControl;
using ACT.World;
using Bamboo.Collections;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class TempleRewardView : BaseUIView<TempleRewardViewInputController>
{
	private TempleRewardViewData m_data;

	private TempleModel model;

	private BMap<int, List<InstanceDungeonStarReward>> areaStarRewardDatas;

	private int m_curPageIndex = -1;

	private int m_curAreaId = -1;

	[Header("UI组件")]
	public LoopVerticalScrollRect rewardCellRect;

	public PublicToggleGroup leftToggles;

	public BImage areaImage;

	public TextMeshProUGUI rightStarCount;

	public TextMeshProUGUI leftStarCount;

	public LocalizeStringEvent areaName;

	public ViewControlLayer ViewControlLayer;

	public GameObject Prompt_LB;

	public GameObject Prompt_RB;

	public GameObject Prompt_A;

	private List<Toggle> toggleCacheList = new List<Toggle>();

	private Dictionary<int, int> indexToAreaMap = new Dictionary<int, int>();

	private bool m_IsClick;

	public BMap<int, List<InstanceDungeonStarReward>> AreaStarRewardDatas => areaStarRewardDatas;

	private void InitToggleGroup()
	{
		ACT.World.MapArea mapArea = ((uiViewData != null) ? (uiViewData as TempleRewardViewData).tabAreaId : ACT.World.MapArea.None);
		List<int> allMapIds = model.GetAllMapIds();
		toggleCacheList.Clear();
		indexToAreaMap.Clear();
		int num = 0;
		for (int i = 0; i < leftToggles.toggles.Count; i++)
		{
			TabToggle tabToggle = leftToggles.toggles[i] as TabToggle;
			if (tabToggle != null)
			{
				toggleCacheList.Add(tabToggle);
				if (!areaStarRewardDatas.ContainsKey(allMapIds[i]))
				{
					continue;
				}
				tabToggle.InitToggle(allMapIds[i] == (int)mapArea, OnToggleClick, new TabToggleParam
				{
					localTextId = RuntimeConfigs.data.mapAreas[allMapIds[i]].name,
					pointerClickActionParam = i,
					sound = "event:/UI/Interface/Temple/Reward/Left_Click"
				});
				Station.LoadImage(156, allMapIds[i], tabToggle.normalIconBImage);
				tabToggle.betterAnimation?.GetSequence(tabToggle.IsSelected ? "SelectedShow" : "NoamalShow").Play();
				RedDotItem componentInChildren = tabToggle.gameObject.GetComponentInChildren<RedDotItem>(includeInactive: true);
				if (componentInChildren != null)
				{
					string[] array = (allMapIds[i] switch
					{
						1001 => RedDotPathDefine.ArsenalTempleReward, 
						1002 => RedDotPathDefine.ArumTempleReward, 
						1003 => RedDotPathDefine.SewerTempleReward, 
						1004 => RedDotPathDefine.TepcTempleReward, 
						1005 => RedDotPathDefine.VoidTempleReward, 
						1006 => RedDotPathDefine.CraterTempleReward, 
						1007 => RedDotPathDefine.WalkureTempleReward, 
						_ => "", 
					}).Split('|');
					componentInChildren.fullPath.Clear();
					for (int j = 0; j < array.Length; j++)
					{
						componentInChildren.fullPath.Add(array[j]);
					}
					componentInChildren.BindTrieNode();
					componentInChildren.UpdateDisplay();
				}
				if (allMapIds[i] == (int)mapArea)
				{
					num = i;
				}
				indexToAreaMap.Add(i, allMapIds[i]);
				UpdateAreaRewardEvt evt = Singleton<EventManager>.instance.GetEvt<UpdateAreaRewardEvt>();
				evt.AreaId = allMapIds[i];
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.UpdateAreaRewardState, evt);
				Singleton<EventManager>.instance.ReleaseEvt(evt);
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogError("左侧 Toggle 不是 TabToggle");
			}
		}
		for (int k = 0; k < toggleCacheList.Count; k++)
		{
			(toggleCacheList[k] as TabToggle).gameObject.SetActive(areaStarRewardDatas.ContainsKey(allMapIds[k]));
		}
		if (toggleCacheList[num].isOn)
		{
			OnTabChange(num);
		}
	}

	private void OnToggleClick(int targetIndex)
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Temple/Reward/Left_Click");
		if (toggleCacheList[targetIndex].isOn)
		{
			OnTabChange(targetIndex);
		}
	}

	private void OnTabChange(int targetIndex)
	{
		if (m_curPageIndex != -1)
		{
			TabToggle tabToggle = toggleCacheList[m_curPageIndex] as TabToggle;
			if ((bool)tabToggle)
			{
				tabToggle.SetNormal();
			}
		}
		if (targetIndex != m_curPageIndex)
		{
			TabToggle tabToggle2 = toggleCacheList[targetIndex] as TabToggle;
			if (tabToggle2 != null)
			{
				tabToggle2.SetSelect();
				m_curPageIndex = targetIndex;
			}
		}
		ChangeTab(targetIndex);
	}

	private void ChangeTab(int index)
	{
		m_curAreaId = indexToAreaMap[index];
		List<InstanceDungeonStarReward> list = areaStarRewardDatas[m_curAreaId];
		rewardCellRect.ClearCells();
		rewardCellRect.totalCount = list.Count;
		rewardCellRect.RefillCells();
		int areaTempleMaxStarCount = model.GetAreaTempleMaxStarCount(m_curAreaId);
		rightStarCount.text = "/" + areaTempleMaxStarCount.FastToString();
		int curAreaTempleStarCount = model.GetCurAreaTempleStarCount(m_curAreaId);
		leftStarCount.text = curAreaTempleStarCount.FastToString();
		Station.LoadImage(127, index + 1, areaImage);
	}

	public void OnScrollIndex(LoopScrollBaseItem newItem)
	{
		InstanceDungeonStarReward param = areaStarRewardDatas[m_curAreaId][newItem.index];
		newItem.Init(param);
		newItem.gameObject.SetActive(value: true);
	}

	private async void BackLastView()
	{
		if (!m_IsClick)
		{
			m_IsClick = true;
			await Singleton<NewUIManager>.instance.BlackLoad.Enable();
			await CloseAsync();
			LargeMapViewData uiData = new LargeMapViewData
			{
				initMapArea = MapUtility.LastQuitMapArea,
				templeAreaOpen = true
			};
			await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_LARGEMAP, uiData);
			Singleton<NewUIManager>.instance.BlackLoad.Disable().Forget();
			m_IsClick = false;
		}
	}

	protected override void AddEventListener()
	{
		base.AddEventListener();
		MonoECS.instance.onInputModeChange.AddListener(OnInputModeChange);
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
		MonoECS.instance.onInputModeChange.RemoveListener(OnInputModeChange);
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
	}

	protected override void Init()
	{
		areaStarRewardDatas = BMapPool<int, List<InstanceDungeonStarReward>>.Default.Get();
		foreach (InstanceDungeonStarReward value in RuntimeConfigs.data.instanceDungeonStarRewards.Values)
		{
			if (areaStarRewardDatas.ContainsKey(value.area))
			{
				areaStarRewardDatas[value.area].Add(value);
				continue;
			}
			areaStarRewardDatas.Add(value.area, new List<InstanceDungeonStarReward>());
			areaStarRewardDatas[value.area].Add(value);
		}
		model = Model<TempleModel>.Interface;
		foreach (Toggle toggle in leftToggles.toggles)
		{
			TabToggle tabToggle = toggle as TabToggle;
			if (tabToggle != null)
			{
				tabToggle.UnInitToggle();
			}
		}
		InitToggleGroup();
		base.Init();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Temple/Reward/Open");
		UniTask.DelayFrame(1);
		OnInputModeChange(MonoECS.instance.InputMode);
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		BMapPool<int, List<InstanceDungeonStarReward>>.Default.Recycle(areaStarRewardDatas);
		areaStarRewardDatas = null;
		base.UnInit();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		BackLastView();
		base.Close();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Return_Click");
	}

	public void OnInputModeChange(DeviceInputMode deviceInputMode)
	{
		if (deviceInputMode != DeviceInputMode.Gamepad)
		{
			UnFocus();
			EventSystemHelper.SetSelectedGameObject(null);
		}
		else
		{
			GetController().TempleRewardControlType = TempleRewardControlType.main;
			Focus();
		}
	}

	public void Focus()
	{
		ViewControlLayer.UnFocus();
		ViewControlLayer.Focus();
		Prompt_LB.SetActive(value: true);
		Prompt_RB.SetActive(value: true);
	}

	public void UnFocus()
	{
		ViewControlLayer.UnFocus();
		Prompt_LB.SetActive(value: false);
		Prompt_RB.SetActive(value: false);
	}

	public void OnGamePadChangeTab(int value)
	{
		if (value > 0)
		{
			if (m_curPageIndex + 1 < toggleCacheList.Count && toggleCacheList[m_curPageIndex + 1].gameObject.activeSelf)
			{
				OnTabChange(m_curPageIndex + 1);
				ViewControlLayer.DefaultSelect = rewardCellRect.Children[0].GetComponent<ACT.ViewControl.SelectableEx>();
				Focus();
			}
		}
		else if (m_curPageIndex > 0 && toggleCacheList[m_curPageIndex - 1].gameObject.activeSelf)
		{
			OnTabChange(m_curPageIndex - 1);
			ViewControlLayer.DefaultSelect = rewardCellRect.Children[0].GetComponent<ACT.ViewControl.SelectableEx>();
			Focus();
		}
	}

	public void HandleOnBackPressed(TempleRewardControlType templeRewardControlType)
	{
		if (templeRewardControlType == TempleRewardControlType.main)
		{
			Close();
			return;
		}
		GetController().TempleRewardControlType = TempleRewardControlType.main;
		Focus();
		Prompt_A.SetActive(value: false);
	}

	public void HandleOnConfirm(TempleRewardControlType templeRewardControlType)
	{
		if (templeRewardControlType == TempleRewardControlType.main)
		{
			EventSystemHelper.CurrentSelected.GetComponent<TempleRewardCell>()?.OnSubmit();
			return;
		}
		ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
		{
			handler.OnSubmit(data);
		});
	}
}
