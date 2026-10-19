using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Model;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class IntegratedExploringChallengeView : ActivityCenterBaseUIView<IntegratedExploringChallengeController>
{
	[SerializeField]
	[Header("item出现延迟时间,单位秒")]
	private float _itemDelaytime = 0.05f;

	public List<PhaseItem> phaseItemList;

	[SerializeField]
	private BetterAnimation betterAnimation;

	[SerializeField]
	private TimeAndDesItem TimeAndDesItem;

	[SerializeField]
	private LocalizeStringEvent stageName;

	[SerializeField]
	private GameObject taskPrefab;

	[SerializeField]
	private RectTransform taskRoot;

	[SerializeField]
	private RectTransform lockRoot;

	[SerializeField]
	private TextMeshProUGUI lockDesc;

	[SerializeField]
	private Button btnDialogArea;

	[SerializeField]
	private TextMeshProUGUI unlockLeftTime;

	[SerializeField]
	private LocalizeStringEvent unlockDesc;

	[SerializeField]
	private GameObject dialog1Line;

	[SerializeField]
	private GameObject dialog2Line;

	[SerializeField]
	private GameObject dialog3Line;

	[SerializeField]
	private LocalizeStringEvent txtDialog1Line;

	[SerializeField]
	private LocalizeStringEvent txtDialog2Line;

	[SerializeField]
	private LocalizeStringEvent txtDialog3Line;

	[SerializeField]
	private TextMeshProUGUI txtDialog;

	[SerializeField]
	private Button BtnShop;

	[SerializeField]
	private TextMeshProUGUI TxtShopCoin;

	[SerializeField]
	private LocalizeStringEvent TxtShopTitle;

	public GameObject GamepadTipsRoot;

	public Dictionary<IntegratedExploringChallengeControlType, List<GameObject>> ControlDownPromts;

	public Dictionary<IntegratedExploringChallengeControlType, List<GameObject>> ControlPromts;

	public Dictionary<IntegratedExploringChallengeControlType, ViewControlLayer> ControlLayerDic;

	public ViewControlRoot ViewControlRoot;

	private IntegratedExploringChallengeViewData m_data;

	private PhaseItem _currentPhaseItem;

	private List<TaskItem> _taskItemList = new List<TaskItem>();

	private static int sCurrentPhaseItemIndex;

	private ActivityCenterData _activityCenterData;

	private CancellationTokenSource _refreshTaskListCts;

	private IntegratedExploringChallengeControlType ControlType
	{
		get
		{
			return GetController().ControlType;
		}
		set
		{
			GetController().ControlType = value;
		}
	}

	protected override void Init()
	{
		base.Init();
		_activityCenterData = Model<ActivityCenterModel>.Interface.GetActivityCenterData(1005);
		BtnShop.SetBtnClick(OnShop, "event:/UI/Interface/Plan/Select");
		Model<ActivityExploreChallengeModel>.Interface.RefreshTaskData();
		RefreshPhaseList();
		TimeAndDesItem.Init(_activityCenterData, -1L);
		TxtShopTitle.StringReference.TableEntryReference = 2738L;
		RefreshShopCoin();
		GameUtility.RefreshExploreChallengeRedDot();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Plan/List/Open");
		if (betterAnimation != null)
		{
			betterAnimation.GetSequence("Show")?.Play();
		}
		OnInputDeviceChange(MonoECS.instance.InputMode);
	}

	public override void OnPopStack()
	{
		base.OnPopStack();
		RefreshTaskList().Forget();
		RefreshShopCoin();
	}

	private void RefreshShopCoin()
	{
		int shopCoinId = Model<ActivityExploreChallengeModel>.Interface.GetShopCoinId();
		if (RuntimeConfigs.data.itemDatas[shopCoinId].type == 999 && G.detailUserInfo.Attributes.ContainsKey(shopCoinId))
		{
			TxtShopCoin.text = G.detailUserInfo.Attributes[shopCoinId].ToString();
		}
		else if (RuntimeConfigs.data.itemDatas[shopCoinId].type != 999 && G.localPlayer.Inventory.GetItemInfo(shopCoinId) != null)
		{
			TxtShopCoin.SetText("{0:0}", G.localPlayer.Inventory.GetItemInfo(shopCoinId).Count);
		}
		else
		{
			TxtShopCoin.text = "0";
		}
	}

	private void OnShop()
	{
		ShopData shopData = RuntimeConfigs.data.shopDatas[6];
		if (TimeManager.IsInTimeRange(shopData.shopStartTs, shopData.shopEndTs))
		{
			Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_SHOP, new ShopViewData
			{
				FirstTabID = 6,
				SecondTabID = 306
			}).Forget();
		}
		else
		{
			Singleton<TipManager>.instance.GetTip(TIP_TYPE.TIP_COMMONTIP, new CommonTipData
			{
				localizeId = 1845,
				tableName = LocalizationUtility.localizeTableName_Common
			});
		}
	}

	private void RefreshPhaseList()
	{
		for (int i = 0; i < phaseItemList.Count; i++)
		{
			phaseItemList[i].gameObject.SetActive(value: false);
			phaseItemList[i].SetSelected(flag: false);
		}
		for (int j = 0; j < Model<ActivityExploreChallengeModel>.Interface.ChallengePhaseInfos.Count; j++)
		{
			phaseItemList[j].gameObject.SetActive(value: true);
			phaseItemList[j].Init(Model<ActivityExploreChallengeModel>.Interface.GetPhaseTxt(j), Model<ActivityExploreChallengeModel>.Interface.ChallengePhaseInfos[j]);
			phaseItemList[j].OnItemClickAction = OnPhaseItemClick;
		}
		RefreshPhaseCompleteState();
		if (m_data != null)
		{
			if (m_data.PageIndex != -1)
			{
				sCurrentPhaseItemIndex = m_data.PageIndex;
				if (Model<ActivityExploreChallengeModel>.Interface.ChallengePhaseInfos.Count > 0)
				{
					SelectPhaseItem(phaseItemList[sCurrentPhaseItemIndex]);
				}
			}
		}
		else if (Model<ActivityExploreChallengeModel>.Interface.ChallengePhaseInfos.Count > 0)
		{
			SelectPhaseItem(phaseItemList[sCurrentPhaseItemIndex]);
		}
	}

	private void RefreshPhaseCompleteState()
	{
		int num = Mathf.Min(phaseItemList.Count, Model<ActivityExploreChallengeModel>.Interface.ChallengePhaseInfos.Count);
		for (int i = 0; i < num; i++)
		{
			PhaseItem phaseItem = phaseItemList[i];
			PhaseItem.State state = phaseItem.GetState();
			state = ((!Model<ActivityExploreChallengeModel>.Interface.IsPhaseAllTaskFinished(phaseItem.StaticInfo.id)) ? (state & (PhaseItem.State)(-17)) : (state | PhaseItem.State.Completed));
			phaseItem.SetState(state);
		}
	}

	private void SelectPhaseItem(PhaseItem item)
	{
		for (int i = 0; i < phaseItemList.Count; i++)
		{
			PhaseItem phaseItem = phaseItemList[i];
			phaseItem.SetSelected(phaseItem == item);
			if (item == phaseItem)
			{
				stageName.StringReference.TableEntryReference = item.StaticInfo.stageName;
				_currentPhaseItem = item;
				sCurrentPhaseItemIndex = i;
			}
		}
		RefreshTaskList().Forget();
	}

	private void OnPhaseItemClick(PhaseItem item)
	{
		SelectPhaseItem(item);
	}

	private void CancelRefreshTaskList()
	{
		if (_refreshTaskListCts != null)
		{
			_refreshTaskListCts.Cancel();
			_refreshTaskListCts.Dispose();
			_refreshTaskListCts = null;
		}
	}

	private async UniTask RefreshTaskList()
	{
		CancelRefreshTaskList();
		_refreshTaskListCts = new CancellationTokenSource();
		CancellationToken token = _refreshTaskListCts.Token;
		try
		{
			if ((_currentPhaseItem.GetState() & PhaseItem.State.Locked) != 0)
			{
				lockRoot.gameObject.SetActive(value: true);
				for (int i = 0; i < _taskItemList.Count; i++)
				{
					_taskItemList[i].gameObject.SetActive(value: false);
				}
				lockDesc.text = Model<ActivityExploreChallengeModel>.Interface.GetPhaseUnlockLeftTime(_currentPhaseItem.StaticInfo.id);
				unlockDesc.StringReference.TableEntryReference = 1745L;
				return;
			}
			lockRoot.gameObject.SetActive(value: false);
			List<ActivityExploreChallengeModel.ChallengeInfo> taskList = new List<ActivityExploreChallengeModel.ChallengeInfo>();
			taskList.AddRange(Model<ActivityExploreChallengeModel>.Interface.GetTaskList(_currentPhaseItem.StaticInfo.id));
			while (_taskItemList.Count < taskList.Count)
			{
				TaskItem component = UnityEngine.Object.Instantiate(taskPrefab, taskRoot).GetComponent<TaskItem>();
				_taskItemList.Add(component);
			}
			if (_taskItemList.Count > taskList.Count)
			{
				for (int j = 0; j < _taskItemList.Count - taskList.Count; j++)
				{
					_taskItemList[_taskItemList.Count - j - 1].gameObject.SetActive(value: false);
				}
			}
			for (int k = 0; k < taskList.Count; k++)
			{
				TaskItem taskItem = _taskItemList[k];
				taskItem.CancelCurrentShowAnim();
				taskItem.gameObject.SetActive(value: false);
			}
			for (int l = 0; l < taskList.Count; l++)
			{
				if (token.IsCancellationRequested)
				{
					break;
				}
				TaskItem taskItem2 = _taskItemList[l];
				if ((bool)taskItem2)
				{
					taskItem2.gameObject.SetActive(value: true);
					taskItem2.Init(l, taskList[l], OnGiftCb, ActivityCenterView.Station);
					await UniTask.Delay(TimeSpan.FromSeconds(_itemDelaytime), ignoreTimeScale: false, PlayerLoopTiming.Update, token);
				}
			}
		}
		catch (OperationCanceledException message)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError(message);
			}
		}
		catch (Exception message2)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError(message2);
			}
		}
	}

	public void OnGiftCb()
	{
		RefreshTaskList().Forget();
		RefreshShopCoin();
		RefreshPhaseCompleteState();
		ControlLayerDic[ControlType].ReFocus();
	}

	protected override void UnInit()
	{
		CancelRefreshTaskList();
		base.UnInit();
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		GamepadTipsRoot.SetActive(type == DeviceInputMode.Gamepad);
		ChangeControlType(IntegratedExploringChallengeControlType.Item, reFocus: true);
		for (int i = 0; i < _taskItemList.Count; i++)
		{
			_taskItemList[i].OnInputDeviceChange(type);
		}
	}

	public async void ChangeControlType(IntegratedExploringChallengeControlType controlType, bool reFocus = false)
	{
		await UniTask.DelayFrame(2);
		IntegratedExploringChallengeControlType controlType2 = ControlType;
		ControlType = controlType;
		if (reFocus)
		{
			ControlLayerDic[controlType].ReFocus();
		}
		else
		{
			ControlLayerDic[controlType2].UnFocus();
			ControlLayerDic[controlType].Focus();
		}
		for (int i = 0; i < GamepadTipsRoot.transform.GetChild(0).childCount; i++)
		{
			GamepadTipsRoot.transform.GetChild(0).GetChild(i).gameObject.SetActive(value: false);
		}
		foreach (GameObject item in ControlDownPromts[controlType])
		{
			item.SetActive(value: true);
		}
		for (int j = 0; j < ControlPromts[controlType2].Count; j++)
		{
			ControlPromts[controlType2][j].SetActive(value: false);
		}
		for (int k = 0; k < ControlPromts[controlType].Count; k++)
		{
			ControlPromts[controlType][k].SetActive(value: true);
		}
		if (ControlType == IntegratedExploringChallengeControlType.Item)
		{
			OnSelectItem();
		}
	}

	public void ExecuteNavigate(MoveDirection dir)
	{
		switch (dir)
		{
		case MoveDirection.Left:
			ViewControlRoot.SelectLeft();
			break;
		case MoveDirection.Right:
			ViewControlRoot.SelectRight();
			break;
		case MoveDirection.Up:
			ViewControlRoot.SelectUp();
			break;
		case MoveDirection.Down:
			ViewControlRoot.SelectDown();
			break;
		}
		if (ControlType == IntegratedExploringChallengeControlType.Item)
		{
			OnSelectItem();
		}
	}

	private void OnSelectItem()
	{
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (!(currentSelected == null))
		{
			TaskItem component = currentSelected.GetComponent<TaskItem>();
			if (component != null)
			{
				ControlLayerDic[IntegratedExploringChallengeControlType.Reward] = component.ViewControlLayer;
			}
		}
	}

	public void Close()
	{
		ActivityCenterView.Exit();
	}

	public void SwitchPageLeft()
	{
		if (sCurrentPhaseItemIndex > 0)
		{
			int index = sCurrentPhaseItemIndex - 1;
			OnPhaseItemClick(phaseItemList[index]);
			ControlLayerDic[IntegratedExploringChallengeControlType.Item].UnFocus();
			ControlLayerDic[IntegratedExploringChallengeControlType.Item].Focus();
		}
	}

	public void SwitchPageRight()
	{
		if (sCurrentPhaseItemIndex < Model<ActivityExploreChallengeModel>.Interface.ChallengePhaseInfos.Count - 1)
		{
			int index = sCurrentPhaseItemIndex + 1;
			OnPhaseItemClick(phaseItemList[index]);
			ControlLayerDic[IntegratedExploringChallengeControlType.Item].UnFocus();
			ControlLayerDic[IntegratedExploringChallengeControlType.Item].Focus();
		}
	}

	public void OpenActivityDetail()
	{
		TimeAndDesItem.OnClickActivityDetailButtonHandle();
	}

	public void OpenShop()
	{
		OnShop();
	}

	public void OnConfirm()
	{
		if (!(EventSystemHelper.CurrentSelected == null))
		{
			ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler.OnSubmit(data);
			});
		}
	}
}
