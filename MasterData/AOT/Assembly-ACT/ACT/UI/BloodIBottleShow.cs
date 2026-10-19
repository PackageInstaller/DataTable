using System;
using System.Collections.Generic;
using System.Text;
using ACT.Battle;
using ACT.Model;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Fundamental;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class BloodIBottleShow : SubUIView<BottleShowSubController>, IBottleSubPanelBase, ISubUIView, IBaseUIComponent
{
	protected int pageIndex = -1;

	protected BloodBottleView _parentView;

	protected ImageAssetStation _station;

	[Header("滚动列表组件")]
	public LoopHorizontalScrollRect bottleRect;

	[Header("血瓶详情面板")]
	public BloodBottleDetail bottleDetail;

	public ViewControlLayer bottleLayer;

	public ActButton detailMatDesMask;

	private List<BloodBottleData> bottleList;

	private BloodBottleData lastChoosen;

	private StringBuilder _sb;

	protected BloodBottleHandler _handler => Singleton<BloodBottleHandler>.instance;

	protected BloodBottleModel _model => Model<BloodBottleModel>.Interface;

	protected BloodBottleBuffHandler _buffHandler => Singleton<BloodBottleBuffHandler>.instance;

	public HashSet<BloodBottleCell> allBottleCell { get; set; }

	public void Init()
	{
		pageIndex = 0;
		_parentView = GetComponentInParent<BloodBottleView>();
		if (_parentView != null)
		{
			_station = _parentView.Station;
		}
		_sb = new StringBuilder();
		bottleRect.OnItemShow.RemoveAllListeners();
		bottleRect.OnItemShow.AddListener(OnChooseBottle);
		bottleRect.OnItemLoad.RemoveAllListeners();
		allBottleCell = HashSetPool<BloodBottleCell>.Get();
		bottleRect.OnItemLoad.AddListener((ILoopScrollDataSource data) =>
		{
			BloodBottleCell bloodBottleCell = (data as LoopScrollBaseItem) as BloodBottleCell;
			if (bloodBottleCell != null)
			{
				bloodBottleCell.selectedUGUI?.OnSelected.AddListener(bloodBottleCell.OnSelected);
				bloodBottleCell.selectedUGUI?.OnDeselected.AddListener(bloodBottleCell.OnUnSelected);
				bloodBottleCell.btn.OnEnter.AddListener(bloodBottleCell.OnCellTriggerIn);
				bloodBottleCell.btn.OnExit.AddListener(bloodBottleCell.OnCellTriggerOut);
				allBottleCell.Add(bloodBottleCell);
			}
		});
		bottleList = ListPool<BloodBottleData>.Get();
		if (_model.sceneBloodBottles.TryGetValue(0, out var value))
		{
			Dictionary<int, BloodBottleData> allBottles = value._allBottles;
			if (allBottles != null && allBottles.Count > 0)
			{
				bottleList.AddRange(value._allBottles.Values);
				goto IL_0129;
			}
		}
		bottleList.AddRange(_model.curSceneBloodBottleInfo._allBottles.Values);
		if (LuminApplication.LogEnabled)
		{
			Debug.LogError("找不到大世界的血瓶数据，检查客户端数据是否同步后端数据失败 （model的SetWorldPotions），只能给当前世界的血瓶数据");
		}
		goto IL_0129;
		IL_0129:
		BloodBottleView bottleView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_BLOODBOTTLE) as BloodBottleView;
		if (bottleView != null)
		{
			bottleDetail.Init((int index) =>
			{
				bottleView.ChangePanelPage(index).Forget();
			});
		}
	}

	public void Refresh()
	{
		gameObject.SetActive(value: true);
		if (_parentView != null)
		{
			_parentView.animFinish = false;
			try
			{
				_parentView.betterAnimation?.GetSequence("MainShow").OnAnimationPlay((AnimationBuilder _) =>
				{
					Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Team/BloodBottle/Open");
				}).OnComplete((AnimationBuilder _) =>
				{
					FocusIn();
					_parentView.animFinish = true;
				})
					.Play();
			}
			catch (Exception value)
			{
				_parentView.animFinish = true;
				Console.WriteLine(value);
				throw;
			}
		}
		if (_parentView != null)
		{
			BloodBottleViewData data = _parentView.data;
			if (data != null && data.dataFromAbyss)
			{
				bottleList.Sort(Model<AbyssModel>.Interface.SortBloodBottleInAbyss);
				goto IL_00ea;
			}
		}
		bottleList.Sort(SortUtility.SortBloodBottleInCultivate);
		goto IL_00ea;
		IL_00ea:
		bottleRect.ClearCells();
		bottleRect.totalCount = bottleList.Count;
		bottleRect.RefillCells();
		ChooseBottle();
		foreach (BottleMaterialCell slotCell in bottleDetail.slots)
		{
			slotCell.OnCellSelected = null;
			slotCell.OnCellSelected = () =>
			{
				detailMatDesMask.SetBtnClick(() =>
				{
					slotCell.UpdateMatDetailDesOnShowPanel();
					detailMatDesMask.gameObject.SetActive(slotCell.matDetailIsShow);
				});
				DetailSlotSelected(slotCell);
			};
		}
		GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.BloodBottleClickBack);
	}

	public void UnInit()
	{
		lastChoosen = null;
		if (_parentView != null)
		{
			_parentView.lastPageIndex = pageIndex;
		}
		gameObject.SetActive(value: false);
		FocusOut();
	}

	public void OnParentViewClose()
	{
		HashSetPool<BloodBottleCell>.Release(allBottleCell);
		ListPool<BloodBottleData>.Release(bottleList);
	}

	private void DetailSlotSelected(BottleMaterialCell slot)
	{
		if (slot.slotData.curState != SlotState.Empty && slot.slotData.curState != SlotState.IsLock)
		{
			slot.UpdateMatDetailDesOnShowPanel();
			detailMatDesMask.gameObject.SetActive(slot.matDetailIsShow);
		}
	}

	private void OnChooseBottle(ILoopScrollDataSource item)
	{
		BloodBottleCell bottleCell = item as BloodBottleCell;
		BloodBottleData bottle = bottleList[bottleCell.index];
		bottleCell.Refresh(bottle, _station, _sb, UpdateBottleEquipDisplay);
		bottleCell.btn.SetBtnClick(() =>
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Team/BloodBottle/Left_Click");
			if (lastChoosen != null && lastChoosen.id != bottle.id)
			{
				int id = bottleList.IndexOf(lastChoosen);
				((BloodBottleCell)bottleRect.GetItem(id)).OnUnSelected();
				lastChoosen = bottle;
				_model.SetOperationBottle(bottle);
				bottleCell.OnSelected();
				bottleDetail.Refresh(bottle, _sb, _station);
			}
		});
	}

	private void ChooseBottle()
	{
		int guideDefaultSelectBottleId = _model.guideDefaultSelectBottleId;
		if (_model.curOperationBottle == null)
		{
			int num = ((guideDefaultSelectBottleId != 0) ? bottleList.FindIndex((BloodBottleData i) => i.id == guideDefaultSelectBottleId) : ((_parentView.data != null) ? bottleList.FindIndex((BloodBottleData i) => i.id == _parentView.data.curOperateBottle) : 0));
			if (num == -1)
			{
				num = 0;
			}
			_model.SetOperationBottle(bottleList[num]);
			BloodBottleCell bloodBottleCell = bottleRect.GetItem(num) as BloodBottleCell;
			if (bloodBottleCell != null)
			{
				bloodBottleCell.OnSelected();
			}
			lastChoosen = _model.curOperationBottle;
		}
		else
		{
			lastChoosen = _model.curOperationBottle;
			BloodBottleCell bloodBottleCell2 = (BloodBottleCell)bottleRect.GetItem(bottleList.IndexOf(_model.curOperationBottle));
			if (bloodBottleCell2 != null)
			{
				bloodBottleCell2.OnSelected();
			}
		}
		bottleDetail.Refresh(_model.curOperationBottle, _sb, _station);
	}

	private bool UpdateBottleEquipDisplay(BloodBottleData bottle)
	{
		if (_parentView != null)
		{
			BloodBottleViewData data = _parentView.data;
			if (data != null && data.dataFromAbyss)
			{
				return Model<AbyssModel>.Interface.GetCurBloodBottleId() == bottle.uid;
			}
		}
		if (_parentView != null)
		{
			BloodBottleViewData data = _parentView.data;
			if (data != null && data.dataFromTeam)
			{
				return Model<TeamModel>.Interface.CurSelectedTeamProfile.EquipPotionId == bottle.uid;
			}
		}
		if (bottle.uid == Model<BloodBottleModel>.Interface.curSceneEquipBloodBottleId)
		{
			return bottle.isEquip;
		}
		return false;
	}

	public ACT.ViewControl.SelectableEx GetCurBottleCellSelectable()
	{
		List<BloodBottleData> list = bottleList;
		if (list == null || list.Count <= 0 || lastChoosen == null)
		{
			return null;
		}
		int id = bottleList.IndexOf(lastChoosen);
		BloodBottleCell bloodBottleCell = bottleRect.GetItem(id) as BloodBottleCell;
		if (!(bloodBottleCell != null))
		{
			return null;
		}
		return bloodBottleCell.GetComponentInChildren<ACT.ViewControl.SelectableEx>(includeInactive: true);
	}

	public void HandleGamePadSpecial1()
	{
		if (lastChoosen != null && !lastChoosen.isLock)
		{
			bottleDetail?.goToLevelUpBtn?.OnClick?.Invoke();
		}
	}

	public void HandleGamePadSpecial2()
	{
		if (lastChoosen != null && !lastChoosen.isLock)
		{
			bottleDetail?.goToChangeMatBtn?.OnClick?.Invoke();
		}
	}
}
