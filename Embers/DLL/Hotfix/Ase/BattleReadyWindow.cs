using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using FMOD.Studio;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace Ase;

public class BattleReadyWindow : UGuiWindow, IDragHandler, IEventSystemHandler, IBeginDragHandler, IEndDragHandler
{
	[SerializeField]
	private int teamGuideId = 111;

	[SerializeField]
	private List<int> guideConfigHeros = new List<int> { 1104, 1005 };

	[SerializeField]
	private TeamBPConfigView teamBpConfigView;

	[SerializeField]
	private Button startBattleBtn;

	[SerializeField]
	private Button cancelBtn;

	[SerializeField]
	private BattleReadySeatView seatTpl;

	[SerializeField]
	private List<Transform> seatRoots;

	[SerializeField]
	private BattleReadySeatView dragSeat;

	[SerializeField]
	private TextMeshProUGUI targetName;

	[SerializeField]
	private GameObject presetRoot;

	[SerializeField]
	private Transform presetPoints;

	[SerializeField]
	private Button leftArrowBtn;

	[SerializeField]
	private Button rightArrowBtn;

	[SerializeField]
	private Button teamPresetBtn;

	[SerializeField]
	private GameObject teamAlibitytipsGo;

	[SerializeField]
	private TextMeshProUGUI teamAlibityTips;

	[SerializeField]
	private Button teamNameSetBtn;

	[SerializeField]
	private Text teamNameText;

	[SerializeField]
	private TeamAttributeView teamAttributeView;

	[SerializeField]
	private GameObject costRoot;

	[SerializeField]
	private LoopListView2 costItemList;

	[SerializeField]
	private GameObject costItemListObj;

	[SerializeField]
	private Button btnOpenCostList;

	[SerializeField]
	private Button btnCloseCostList;

	[SerializeField]
	private TextMeshProUGUI curCostDesc;

	[SerializeField]
	private GameObject arrowUP;

	[SerializeField]
	private GameObject arrowDown;

	[SerializeField]
	private GameObject costProp;

	[SerializeField]
	private Image costIcon;

	[SerializeField]
	private TextMeshProUGUI costText;

	[SerializeField]
	private TextMeshProUGUI costTextNotEnough;

	[SerializeField]
	private GameObject startBattleBtnBg;

	[SerializeField]
	private GameObject firstPassTag;

	[SerializeField]
	private int pickUpSound;

	[SerializeField]
	private int putDownSound;

	[SerializeField]
	private GameObject buffRoot;

	[SerializeField]
	private LoopListView2 attributeList;

	private int _lastPointIndex;

	private EventInstance _pickUpSoundIns;

	private List<GameObject> _pointList;

	private EventInstance _putDownSoundIns;

	private List<BattleReadySeatView> _seatList = new List<BattleReadySeatView>();

	private BattleReadySeatView.SeatState seatState;

	private BattleReadyViewModel _viewModel;

	private ChangeTeamNameView changeNameView;

	private HeroSelectionWindow heroSelectionView;

	private MoneyView moneyView;

	private PrepareTeamWindow presetWindow;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<BattleReadyViewModel>();
		BindingSet<BattleReadyWindow, BattleReadyViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind().For((BattleReadyWindow v) => v.OnDismissRequest).To((BattleReadyViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((BattleReadyWindow v) => v.OpenUguiWindow).To((BattleReadyViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(teamNameText).For((Text v) => v.text).To((BattleReadyViewModel vm) => vm.CurTeamName);
		bindingSet.Bind(cancelBtn).For((Button v) => v.onClick).To((BattleReadyViewModel vm) => vm.Cancel);
		bindingSet.Bind(cancelBtn.gameObject).For((GameObject v) => v.activeSelf).To((BattleReadyViewModel vm) => vm.BtnBackEnable);
		bindingSet.Bind(startBattleBtn).For((Button v) => v.onClick).To((BattleReadyViewModel vm) => vm.StartBattleCommand);
		bindingSet.Bind().For((BattleReadyWindow v) => v.UpdatePoints).To((BattleReadyViewModel vm) => vm.OnPointChangeRequest);
		bindingSet.Bind().For((BattleReadyWindow v) => v.CloseChangeNameWindow).To((BattleReadyViewModel vm) => vm.ChangeNameViewCloseRequest);
		bindingSet.Bind().For((BattleReadyWindow v) => v.OnTeamChanged).To((BattleReadyViewModel vm) => vm.TeamChangedRequest);
		bindingSet.Bind().For((BattleReadyWindow v) => v.OnSeatStateChanged).To((BattleReadyViewModel vm) => vm.SeatStateChangeRst);
		bindingSet.Bind(leftArrowBtn).For((Button v) => v.onClick).To((BattleReadyViewModel vm) => vm.OnLeftArrowBtnClick);
		bindingSet.Bind(rightArrowBtn).For((Button v) => v.onClick).To((BattleReadyViewModel vm) => vm.OnRightArrowBtnClick);
		bindingSet.Bind(costRoot).For((GameObject v) => v.activeSelf).To((BattleReadyViewModel vm) => vm.ShowCost);
		bindingSet.Bind(btnOpenCostList).For((Button v) => v.onClick).To((BattleReadyViewModel vm) => vm.OpenCostList);
		bindingSet.Bind(btnCloseCostList).For((Button v) => v.onClick).To((BattleReadyViewModel vm) => vm.CloseCostList);
		bindingSet.Bind(costItemListObj).For((GameObject v) => v.activeSelf).To((BattleReadyViewModel vm) => vm.ShowCostItemList);
		bindingSet.Bind<TextMeshProUGUI>(curCostDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BattleReadyViewModel vm) => vm.CurCostDesc);
		bindingSet.Bind(costProp.gameObject).For((GameObject v) => v.activeSelf).To((BattleReadyViewModel vm) => vm.ShowCostProp);
		bindingSet.Bind(startBattleBtnBg.gameObject).For((GameObject v) => v.activeSelf).To((BattleReadyViewModel vm) => vm.ShowCostProp);
		bindingSet.Bind(costIcon).For((Image v) => v.sprite).To((BattleReadyViewModel vm) => vm.CostPropIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(costText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BattleReadyViewModel vm) => (float)vm.CostPropCount * vm.CostPropRate);
		bindingSet.Bind(((Component)(object)costText).gameObject).For((GameObject v) => v.activeSelf).To((BattleReadyViewModel vm) => vm.CostEnough);
		bindingSet.Bind<TextMeshProUGUI>(costTextNotEnough).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BattleReadyViewModel vm) => (float)vm.CostPropCount * vm.CostPropRate);
		bindingSet.Bind(((Component)(object)costTextNotEnough).gameObject).For((GameObject v) => v.activeSelf).ToExpression((BattleReadyViewModel vm) => !vm.CostEnough);
		bindingSet.Bind(arrowUP).For((GameObject v) => v.activeSelf).To((BattleReadyViewModel vm) => vm.ShowCostItemList);
		bindingSet.Bind(arrowDown).For((GameObject v) => v.activeSelf).ToExpression((BattleReadyViewModel vm) => !vm.ShowCostItemList);
		bindingSet.Bind(buffRoot).For((GameObject v) => v.activeSelf).To((BattleReadyViewModel vm) => vm.HasCopyBuff);
		bindingSet.Build();
		Init();
		GetComponent<HeroSkinChangeControl>()?.AddHeroSkinChangeAction(delegate(int heroId)
		{
			for (int i = 0; i < _seatList.Count; i++)
			{
				_seatList[i].UpdateSeatData(heroId);
			}
		});
	}

	private void Init()
	{
		InitSound();
		_pointList = new List<GameObject>();
		for (int i = 0; i < 6; i++)
		{
			_pointList.Add(presetPoints.GetChild(i).gameObject);
		}
		InitSeatViews();
		teamAttributeView.Init(_viewModel.TeamAttributeViewModel);
		teamPresetBtn.onClick.AddListener(ShowPrepareView);
		teamNameSetBtn.onClick.AddListener(ShowChangeTeamNameView);
		InitInfo();
		InitCostItemList();
		AttachMoneyView();
		teamBpConfigView.Init(_viewModel.BpConfigViewModel);
		if (_viewModel.HasCopyBuff)
		{
			attributeList.InitListView(_viewModel.AdItemList.Count, OnGetAttributeItemByIndex);
		}
	}

	protected override void OnShow()
	{
		base.OnShow();
		int curSelectTeamId = Singleton<ServiceSystem>.Instance.GetService<ITeamService>().GetCurSelectTeamId();
		if (curSelectTeamId > 0 && _pointList.Count >= curSelectTeamId)
		{
			_pointList[curSelectTeamId - 1].SetActive(value: true);
			_lastPointIndex = curSelectTeamId - 1;
		}
		if (_viewModel.ReadyData.Target == BattleReadyTarget.HeroChallenge || _viewModel.ReadyData.Target == BattleReadyTarget.CopyType3FirePower)
		{
			int num = ((_viewModel.ReadyData.Target == BattleReadyTarget.HeroChallenge) ? Singleton<ServiceSystem>.Instance.GetService<ITeamService>().GetHeroIdForHeroChallenge() : Singleton<ServiceSystem>.Instance.GetService<ITeamService>().GetHeroIdForCopyType3FirePower());
			num = ((num == 0) ? 1104 : num);
			_viewModel.SetTeamModel(new TeamModel(-1, "", new List<int> { num }));
		}
		else if (_viewModel.ReadyData.Target == BattleReadyTarget.ActivityHeroTry)
		{
			TeamModel teamModel = TeamModel.CreateHeroTry(_viewModel.ReadyData.TargetId, _viewModel.ReadyData.TeamSetId);
			_viewModel.SetTeamModel(teamModel);
			Singleton<ServiceSystem>.Instance.GetService<ITeamService>().AddActivityHeroTryTeamModel(teamModel);
		}
		else if (!Singleton<GuidanceManager>.Instance.CheckGuidanceFinish(teamGuideId) && !GuidanceManager.skip)
		{
			_viewModel.SetTeamModel(new TeamModel(curSelectTeamId, $"队伍{curSelectTeamId}", guideConfigHeros));
		}
		else
		{
			_viewModel.SelectionTeamChanged(curSelectTeamId, setService: false);
		}
		UpdateTeamAbilityTips();
	}

	private void InitSound()
	{
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_0018: Unknown result type (might be due to invalid IL or missing references)
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		//IL_0035: Unknown result type (might be due to invalid IL or missing references)
		_pickUpSoundIns = Singleton<AudioSystem>.Instance.CreateInstance(pickUpSound, 1f);
		_putDownSoundIns = Singleton<AudioSystem>.Instance.CreateInstance(putDownSound, 1f);
	}

	private void InitSeatViews()
	{
		for (int i = 0; i < 3; i++)
		{
			GameObject obj = UnityEngine.Object.Instantiate(seatTpl.gameObject, seatRoots[i]);
			obj.name = $"Seat{i + 1}";
			obj.GetComponent<RectTransform>().anchoredPosition = Vector2.zero;
			BattleReadySeatView component = obj.GetComponent<BattleReadySeatView>();
			component.Init(_viewModel.SeatVmList[i], i + 1, i + 1 == 1);
			_seatList.Add(component);
			component.Visibility = true;
		}
		dragSeat.Init(_viewModel.DragSeatVm, 4, isCaptain: false);
	}

	private void InitInfo()
	{
		BattleReadyData readyData = _viewModel.ReadyData;
		if (_viewModel.ReadyData.Target == BattleReadyTarget.Copy)
		{
			DRCopy dataRow = GameEntry.DataTable.GetDataRow<DRCopy>(readyData.TargetId);
			((TMP_Text)targetName).text = ((dataRow == null) ? string.Empty : dataRow.Name);
		}
		else if (_viewModel.ReadyData.Target == BattleReadyTarget.Level)
		{
			string text = string.Empty;
			DRTransferPoint dataRow2 = GameEntry.DataTable.GetDataRow<DRTransferPoint>(readyData.TargetId);
			if (dataRow2 != null)
			{
				DRMap dataRow3 = GameEntry.DataTable.GetDataRow<DRMap>(dataRow2.LevelId);
				text = ((dataRow3 == null) ? string.Empty : dataRow3.Name);
			}
			((TMP_Text)targetName).text = text;
		}
		else if (_viewModel.ReadyData.Target == BattleReadyTarget.HeroChallenge || _viewModel.ReadyData.Target == BattleReadyTarget.CopyType3FirePower)
		{
			((TMP_Text)targetName).text = ((_viewModel.ReadyData.Target == BattleReadyTarget.HeroChallenge) ? "极限挑战" : "火力试炼");
			if (_seatList != null && _seatList.Count > 1)
			{
				for (int i = 1; i < _seatList.Count; i++)
				{
					_seatList[i].ViewModel.ConfigDisable = true;
				}
			}
			presetRoot.SetActive(value: false);
			arrowUP.SetActive(value: false);
			arrowDown.SetActive(value: false);
			btnOpenCostList.enabled = false;
		}
		else if (_viewModel.ReadyData.Target == BattleReadyTarget.ActivityHeroTry)
		{
			DRCopy dataRow4 = GameEntry.DataTable.GetDataRow<DRCopy>(readyData.TargetId);
			if (dataRow4 != null)
			{
				((TMP_Text)targetName).text = ((dataRow4 == null) ? string.Empty : dataRow4.Name);
			}
			DRTeamSet dataRow5 = GameEntry.DataTable.GetDataRow<DRTeamSet>(readyData.TeamSetId);
			if (_seatList != null && _seatList.Count > 1)
			{
				for (int j = 1; j < _seatList.Count; j++)
				{
					bool flag = dataRow5.Lock.Count > j && dataRow5.Lock[j] == 1;
					if ((dataRow5.TryHero.Count <= j || dataRow5.TryHero[j] == 0) & flag)
					{
						_seatList[j].ViewModel.ConfigDisable = true;
					}
				}
			}
			presetRoot.SetActive(value: false);
			arrowUP.SetActive(value: false);
			arrowDown.SetActive(value: false);
			btnOpenCostList.enabled = false;
		}
		else if (_viewModel.ReadyData.Target == BattleReadyTarget.CopyFirstPass)
		{
			DRCopy dataRow6 = GameEntry.DataTable.GetDataRow<DRCopy>(readyData.TargetId);
			((TMP_Text)targetName).text = ((dataRow6 == null) ? string.Empty : dataRow6.Name);
			arrowUP.SetActive(value: false);
			arrowDown.SetActive(value: false);
			btnOpenCostList.enabled = false;
			firstPassTag.SetActive(value: true);
		}
	}

	private void SetAlibityTips(bool visible, string text = "")
	{
		((TMP_Text)teamAlibityTips).text = text;
		teamAlibitytipsGo.SetActive(visible);
		_viewModel.SecondConfirm = visible;
	}

	public async void AttachMoneyView()
	{
		moneyView = await OpenView<MoneyView>("Role/MoneyView", new MoneyViewModel(_viewModel), "BattleReadyWindow");
		moneyView.SetShow(RoleMoneyEnum.Energy);
	}

	private async void ShowPrepareView()
	{
		if (presetWindow == null)
		{
			presetWindow = await OpenView<PrepareTeamWindow>("Team/PrepareTeamPanel", _viewModel.PrepareTeamViewModel, "BattleReadyWindow");
			presetWindow.Init(_viewModel.PrepareTeamViewModel);
		}
		presetWindow.Show();
	}

	private async void ShowChangeTeamNameView()
	{
		if (changeNameView == null)
		{
			changeNameView = await OpenView<ChangeTeamNameView>("Team/ChangeTeamNamePanel", _viewModel.ChangeTeamNameViewModel, "BattleReadyWindow");
		}
		int curSelectTeamId = Singleton<ServiceSystem>.Instance.GetService<ITeamService>().GetCurSelectTeamId();
		changeNameView.Show(curSelectTeamId, _viewModel.CurTeamName);
	}

	private LoopListViewItem2 OnGetCostItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= _viewModel.CostItemDataList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("CostItem");
		if (loopListViewItem != null)
		{
			MultiRoomCostItem component = loopListViewItem.GetComponent<MultiRoomCostItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(_viewModel.CostItemDataList[index]);
			}
			else
			{
				component.RefreshData(_viewModel.CostItemDataList[index]);
			}
		}
		return loopListViewItem;
	}

	private void InitCostItemList()
	{
		int count = _viewModel.CostItemDataList.Count;
		if (count < 3)
		{
			RectTransform component = costItemList.GetComponent<RectTransform>();
			float num = ((costItemList.ItemPrefabDataList.Count > 0) ? costItemList.ItemPrefabDataList[0].mPadding : 0f);
			float num2 = ((costItemList.ItemPrefabDataList.Count > 0 && costItemList.ItemPrefabDataList[0].mItemPrefab != null) ? costItemList.ItemPrefabDataList[0].mItemPrefab.GetComponent<RectTransform>().sizeDelta.y : 0f);
			component.sizeDelta = new Vector2(component.sizeDelta.x, costItemList.PaddingTop + costItemList.PaddingBottom + num2 * (float)count + num * (float)(count - 1));
		}
		costItemList.InitListView(_viewModel.CostItemDataList.Count, OnGetCostItemByIndex);
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		GameEntry.Resource.UnloadAsset("Assets/Art/UI/UIForms/Role/MoneyView");
	}

	private void UpdatePoints(object sender, InteractionEventArgs e)
	{
		if (_lastPointIndex >= 0)
		{
			_pointList[_lastPointIndex].SetActive(value: false);
		}
		_lastPointIndex = Singleton<ServiceSystem>.Instance.GetService<ITeamService>().GetCurSelectTeamId() - 1;
		_pointList[_lastPointIndex].SetActive(value: true);
	}

	private void OnTeamChanged(object sender, InteractionEventArgs e)
	{
		UpdateTeamAbilityTips();
	}

	private void UpdateTeamAbilityTips()
	{
		BattleReadyData readyData = _viewModel.ReadyData;
		int num = 0;
		if (readyData.Target == BattleReadyTarget.Copy)
		{
			DRCopy dataRow = GameEntry.DataTable.GetDataRow<DRCopy>(readyData.TargetId);
			if (dataRow != null)
			{
				num = dataRow.MatchTeamLevel;
			}
		}
		else if (readyData.Target == BattleReadyTarget.Level)
		{
			DRMap dataRow2 = GameEntry.DataTable.GetDataRow<DRMap>(readyData.TargetId);
			if (dataRow2 != null)
			{
				num = dataRow2.MatchTeamLevel;
			}
		}
		if (num <= 0)
		{
			SetAlibityTips(visible: false);
			return;
		}
		int num2 = 0;
		float num3 = 0f;
		foreach (TeamMember member in readyData.TeamModel.GetMemberList())
		{
			if (!member.HeroModel.IsNullOrEmpty())
			{
				num2++;
				num3 += (float)member.HeroModel.Level;
			}
		}
		if (num2 < 3)
		{
			SetAlibityTips(visible: true, "队伍角色数量未满");
		}
		else if (num3 / (float)num2 < (float)num)
		{
			SetAlibityTips(visible: true, "队伍平均等级过低");
		}
		else
		{
			SetAlibityTips(visible: false);
		}
	}

	private void OnSeatStateChanged(object sender, InteractionEventArgs e)
	{
		BattleReadySeatView.SeatState seatState = (BattleReadySeatView.SeatState)e.Context;
		UpdateSeatState(seatState);
	}

	private void UpdateSeatState(BattleReadySeatView.SeatState state)
	{
		seatState = state;
		foreach (BattleReadySeatView seat in _seatList)
		{
			seat.UpdateState(state);
		}
	}

	public void OnDrag(PointerEventData eventData)
	{
		if (_viewModel.ReadyData.Target != BattleReadyTarget.HeroChallenge && _viewModel.ReadyData.Target != BattleReadyTarget.CopyType3FirePower)
		{
			Vector3 position = default(Vector3);
			RectTransformUtility.ScreenPointToWorldPointInRectangle(RectTransform, eventData.position, eventData.enterEventCamera, ref position);
			dragSeat.gameObject.transform.position = position;
		}
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		//IL_00a2: Unknown result type (might be due to invalid IL or missing references)
		if (_viewModel.ReadyData.Target == BattleReadyTarget.HeroChallenge || _viewModel.ReadyData.Target == BattleReadyTarget.CopyType3FirePower || seatState == BattleReadySeatView.SeatState.Dragging)
		{
			return;
		}
		GameObject gameObject = eventData.pointerCurrentRaycast.gameObject;
		if (!(gameObject != null))
		{
			return;
		}
		BattleReadySeatView component = gameObject.GetComponent<BattleReadySeatView>();
		if (!(component == null))
		{
			if (_viewModel.ReadyData.Target == BattleReadyTarget.ActivityHeroTry && component.ViewModel.SeatLockTag)
			{
				component.ViewModel.ShowHeroTryLockToast();
			}
			else if (!component.ViewModel.Data.IsNullOrEmpty())
			{
				((EventInstance)(ref _pickUpSoundIns)).start();
				dragSeat.gameObject.SetActive(value: true);
				_viewModel.OnBeginDrag(component.ViewModel);
				UpdateSeatState(BattleReadySeatView.SeatState.Dragging);
			}
		}
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		//IL_003e: Unknown result type (might be due to invalid IL or missing references)
		if (_viewModel.ReadyData.Target != BattleReadyTarget.HeroChallenge && _viewModel.ReadyData.Target != BattleReadyTarget.CopyType3FirePower && seatState == BattleReadySeatView.SeatState.Dragging)
		{
			UpdateSeatState(BattleReadySeatView.SeatState.EndDrag);
			((EventInstance)(ref _putDownSoundIns)).start();
			_viewModel.OnEndDrag();
			dragSeat.gameObject.SetActive(value: false);
		}
	}

	private void CloseChangeNameWindow(object sender, InteractionEventArgs e)
	{
		changeNameView.Hide();
	}

	protected override void OnDismiss()
	{
		//IL_0054: Unknown result type (might be due to invalid IL or missing references)
		//IL_0060: Unknown result type (might be due to invalid IL or missing references)
		for (int num = _seatList.Count - 1; num >= 0; num--)
		{
			_seatList[num].Dispose();
			UnityEngine.Object.DestroyImmediate(_seatList[num]);
			_seatList[num] = null;
		}
		_seatList = null;
		((EventInstance)(ref _pickUpSoundIns)).release();
		((EventInstance)(ref _putDownSoundIns)).release();
		teamAttributeView.Dispose();
		base.OnDismiss();
	}

	private LoopListViewItem2 OnGetAttributeItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= _viewModel.AdItemList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("AttriItem");
		if (loopListViewItem != null)
		{
			CopyBuffItemView component = loopListViewItem.GetComponent<CopyBuffItemView>();
			component.Init();
			component.SetIcon(_viewModel.AdItemList[index]);
		}
		return loopListViewItem;
	}
}
