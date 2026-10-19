using System.Collections.Generic;
using System.Linq;
using System.Text;
using ACT.Battle;
using ACT.Core;
using ACT.Model;
using ACT.UI.InputController;
using ACT.UI.ItemDetail;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoAbyssBloodBottleView : BaseUIView<AbyssBloodBottleViewInputController>
{
	public ActButton CloseButton;

	public LoopScrollRect LoopScrollRect;

	public CommonItemDetail CommonItemDetail;

	public ActButton Disboard;

	public ActButton Change;

	public ActButton Confirm;

	public ActButton JumpToBottleView;

	public GameObject BloodBottleUp;

	public ActButton BloodBottleButtonUp;

	public BImage BloodBottleIconUp;

	public GameObject BloodBottleSelectUp;

	public GameObject BloodBottleMiddle;

	public BImage BloodBottleIconMiddle;

	public GameObject BloodBottleSelectMiddle;

	public GameObject BloodBottleDown;

	public ActButton BloodBottleButtonDown;

	public BImage BloodBottleIconDown;

	public GameObject BloodBottleSelectDown;

	public GameObject GamepadTipsRoot;

	public ViewControlRoot ViewControlRoot;

	public ViewControlLayer ViewControlLayer;

	private AbyssTeamSubView _abyssTeamSubView;

	public int _selectIndex = -1;

	private BloodBottleData _selectBloodBottleData;

	private List<BloodBottleData> bloodBottles;

	private StringBuilder sb;

	private bool isInit;

	protected override void Init()
	{
		base.Init();
		CloseButton.SetBtnClick(Close);
		Disboard.SetBtnClick(OnClickDisboardBtnHandle, "event:/UI/Interface/Abyss/Unequip");
		Change.SetBtnClick(OnClickChangeBtnHandle, "event:/UI/Interface/Abyss/Equip");
		JumpToBottleView.Interactable(Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.BloodBottleCultivate));
		JumpToBottleView.OnUnInteractableClick.RemoveAllListeners();
		JumpToBottleView.OnUnInteractableClick.AddListener(() =>
		{
			Singleton<BloodBottleHandler>.instance.JumpToBottleView(_selectBloodBottleData.uid, needFuzzy: true, isFromTeam: false, isFromAbyss: true);
		});
		JumpToBottleView.SetBtnClick(() =>
		{
			Singleton<BloodBottleHandler>.instance.JumpToBottleView(_selectBloodBottleData.uid, needFuzzy: true, isFromTeam: false, isFromAbyss: true);
		}, "event:/UI/Interface/Abyss/Equip");
		Confirm.SetBtnClick(OnClickConfirmBtnHandle, "event:/UI/Interface/Abyss/Equip");
		BloodBottleButtonUp.SetBtnClick(OnClickBloodBottleUpBtnHandle);
		BloodBottleButtonDown.SetBtnClick(OnClickBloodBottleDownBtnHandle);
		MonoAbyssListView monoAbyssListView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_ABYSSLIST) as MonoAbyssListView;
		_abyssTeamSubView = monoAbyssListView.GetAbyssTeamSubView();
		bloodBottles = new List<BloodBottleData>(Model<BloodBottleModel>.Interface.GetMainAlreadyHaveBottles());
		sb = new StringBuilder();
		LoopScrollRect.OnItemShow.RemoveAllListeners();
		LoopScrollRect.OnItemShow.AddListener(OnItemShow);
		LoopScrollRect.ClearCells();
		LoopScrollRect.totalCount = bloodBottles.Count;
		LoopScrollRect.RefillCells();
		if (LoopScrollRect.GetItem(0) as AbyssBloodBottleItem != null)
		{
			CommonItemDetail.gameObject.SetActive(value: true);
			OnClickItemButtonHandle(0);
		}
		else
		{
			CommonItemDetail.gameObject.SetActive(value: false);
		}
		_abyssTeamSubView.SetDownButtonState(value: false);
		if (_abyssTeamSubView.GetIsHasSecondHalf())
		{
			BloodBottleUp.SetActive(value: true);
			BloodBottleDown.SetActive(value: true);
			BloodBottleMiddle.SetActive(value: false);
		}
		else
		{
			BloodBottleUp.SetActive(value: false);
			BloodBottleDown.SetActive(value: false);
			BloodBottleMiddle.SetActive(value: true);
		}
		BloodBottleUp.transform.position = _abyssTeamSubView.GetBloodBottlePosition(0);
		BloodBottleMiddle.transform.position = _abyssTeamSubView.GetBloodBottlePosition(0);
		BloodBottleDown.transform.position = _abyssTeamSubView.GetBloodBottlePosition(1);
		RefreshBtnState();
		SetSelect(_abyssTeamSubView.CurSelectTeam);
		isInit = true;
	}

	private void OnItemShow(ILoopScrollDataSource item)
	{
		AbyssBloodBottleItem cell = item as AbyssBloodBottleItem;
		BloodBottleData bottleData = bloodBottles[cell.index];
		cell.Refresh(bottleData, Station, null, sb);
		cell.SetBtnClick(() =>
		{
			OnClickItemButtonHandle(cell.index);
		});
		cell.gameObject.SetActive(value: true);
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation?.GetSequence("Show").Play();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation?.GetSequence("Hide").Play();
	}

	protected override void UnInit()
	{
		base.UnInit();
		_abyssTeamSubView.SetDownButtonState(value: true);
		sb.Clear();
		sb = null;
		isInit = false;
	}

	protected override void OnMoveToShow()
	{
		base.OnMoveToShow();
		if (isInit)
		{
			LoopScrollRect.RefreshCells();
			CommonItemDetail.Context = _selectBloodBottleData;
			RefreshBtnState();
		}
	}

	private void OnClickDisboardBtnHandle()
	{
		_abyssTeamSubView.ConfigurationBloodBottle(0);
		RefreshBtnState();
	}

	private void OnClickChangeBtnHandle()
	{
		_abyssTeamSubView.ConfigurationBloodBottle(_selectBloodBottleData.id);
		RefreshBtnState();
	}

	private void OnClickConfirmBtnHandle()
	{
		_abyssTeamSubView.ConfigurationBloodBottle(_selectBloodBottleData.id);
		RefreshBtnState();
	}

	private void OnClickBloodBottleUpBtnHandle()
	{
		_abyssTeamSubView.CurSelectTeam = 1;
		RefreshBtnState();
		SetSelect(1);
	}

	private void OnClickBloodBottleDownBtnHandle()
	{
		_abyssTeamSubView.CurSelectTeam = 2;
		RefreshBtnState();
		SetSelect(2);
	}

	public void OnClickItemButtonHandle(int index)
	{
		_selectIndex = index;
		_selectBloodBottleData = Model<BloodBottleModel>.Interface.GetMainAlreadyHaveBottles().ToArray()[_selectIndex];
		CommonItemDetail.Context = _selectBloodBottleData;
		RefreshBtnState();
	}

	public void RefreshBtnState()
	{
		if (_selectBloodBottleData == null)
		{
			return;
		}
		if (Model<AbyssModel>.Interface.GetCurBloodBottleId() == 0)
		{
			Confirm.gameObject.SetActive(value: true);
			Disboard.gameObject.SetActive(value: false);
			Change.gameObject.SetActive(value: false);
		}
		else if (Model<AbyssModel>.Interface.GetCurBloodBottleId() == _selectBloodBottleData.id)
		{
			Confirm.gameObject.SetActive(value: false);
			Disboard.gameObject.SetActive(value: true);
			Change.gameObject.SetActive(value: false);
		}
		else
		{
			Confirm.gameObject.SetActive(value: false);
			Disboard.gameObject.SetActive(value: false);
			Change.gameObject.SetActive(value: true);
		}
		for (int i = 0; i < LoopScrollRect.Children.Count; i++)
		{
			AbyssBloodBottleItem component = LoopScrollRect.Children[i].GetComponent<AbyssBloodBottleItem>();
			if (component != null)
			{
				component.RefreshState(_selectIndex);
			}
		}
		RefreshEquipBloodBottle();
	}

	private void SetSelect(int index)
	{
		if (_abyssTeamSubView.GetIsHasSecondHalf())
		{
			BloodBottleSelectUp.SetActive(index == 1);
			BloodBottleSelectDown.SetActive(index == 2);
		}
		else
		{
			BloodBottleSelectMiddle.SetActive(value: true);
		}
		_abyssTeamSubView.CurSelectTeam = index;
	}

	private void RefreshEquipBloodBottle()
	{
		if (_abyssTeamSubView.GetIsHasSecondHalf())
		{
			BloodBottleIconUp.icon.gameObject.SetActive(value: false);
			if (Model<AbyssModel>.Interface.AbyssModifyData[0].EquipPotionId > 0)
			{
				BloodBottleIconUp.icon.gameObject.SetActive(value: true);
				Station.LoadItemIcon(RuntimeConfigs.data.itemDatas[Model<AbyssModel>.Interface.AbyssModifyData[0].EquipPotionId].iconAddress, BloodBottleIconUp);
			}
			BloodBottleIconDown.icon.gameObject.SetActive(value: false);
			if (Model<AbyssModel>.Interface.AbyssModifyData[1].EquipPotionId > 0)
			{
				BloodBottleIconDown.icon.gameObject.SetActive(value: true);
				Station.LoadItemIcon(RuntimeConfigs.data.itemDatas[Model<AbyssModel>.Interface.AbyssModifyData[1].EquipPotionId].iconAddress, BloodBottleIconDown);
			}
		}
		else
		{
			BloodBottleIconMiddle.icon.gameObject.SetActive(value: false);
			if (Model<AbyssModel>.Interface.AbyssModifyData[0].EquipPotionId > 0)
			{
				BloodBottleIconMiddle.icon.gameObject.SetActive(value: true);
				Station.LoadItemIcon(RuntimeConfigs.data.itemDatas[Model<AbyssModel>.Interface.AbyssModifyData[0].EquipPotionId].iconAddress, BloodBottleIconMiddle);
			}
		}
	}

	protected override void OnInputDeviceChange(DeviceInputMode inputMode)
	{
		GamepadTipsRoot.gameObject.SetActive(inputMode == DeviceInputMode.Gamepad);
		if (inputMode == DeviceInputMode.Gamepad)
		{
			ViewControlLayer.UnFocus();
			ViewControlLayer.Focus();
		}
	}

	public void OnControllerActivate()
	{
		OnInputDeviceChange(MonoECS.instance.InputMode);
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
		if (EventSystemHelper.CurrentSelected != null)
		{
			AbyssBloodBottleItem componentInParent = EventSystemHelper.CurrentSelected.GetComponentInParent<AbyssBloodBottleItem>();
			if (componentInParent != null)
			{
				OnClickItemButtonHandle(componentInParent._index);
			}
		}
	}

	public void HandleConfirm()
	{
		if (!(EventSystemHelper.CurrentSelected == null))
		{
			ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler.OnSubmit(data);
			});
		}
	}

	public void HandleGamePadY()
	{
		if (Disboard.gameObject.activeSelf)
		{
			Disboard.OnSubmit(null);
		}
		else if (Change.gameObject.activeSelf)
		{
			Change.OnSubmit(null);
		}
		else if (Confirm.gameObject.activeSelf)
		{
			Confirm.OnSubmit(null);
		}
	}

	public void HandleGamePadX()
	{
		if (JumpToBottleView.IsInteractable())
		{
			JumpToBottleView?.OnClick?.Invoke();
		}
	}
}
