using System.Collections.Generic;
using System.Linq;
using System.Text;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.NumberString;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class PopupMultiBoxView : BaseUIView<PopupMultiBoxViewInputController>
{
	public LoopVerticalScrollRect scrollRect;

	public LimitedSlider useNumSlider;

	public ActButton closeBtn;

	public ActButton reduceBtn;

	public ActButton addBtn;

	public ActButton confirmBtn;

	public LocalizeStringEvent giftPackageName;

	public TextMeshProUGUI useNumText;

	public TextMeshProUGUI minNumText;

	public TextMeshProUGUI maxNumText;

	public TextMeshProUGUI selectNumDes;

	public GameObject holdingLimitDesRoot;

	public LocalizeStringEvent holdingLimitDes;

	private PopupMultiBoxViewData m_data;

	private StringBuilder _sb;

	private int _selectNum = 1;

	private List<Item> _curShowRewardData;

	private const int HOLDINGISMAX = 2528;

	private const int APPROCHINGLIMIT = 2836;

	private Item curSelectItem;

	public GameObject GamepadTips;

	public ViewControlRoot ViewControlRoot;

	public ViewControlLayer ViewControlLayer;

	public Item curSelectItemData => curSelectItem;

	public int selectItemIndex { get; set; } = -1;

	protected override void AddEventListener()
	{
		base.AddEventListener();
		useNumSlider.onValueChanged.RemoveAllListeners();
		useNumSlider.onValueChanged.AddListener(OnSliderValueChanged);
		closeBtn.SetBtnClick(Close);
		addBtn.SetBtnClick(OnAdd);
		reduceBtn.SetBtnClick(OnReduce);
		confirmBtn.SetBtnClick(OnClickConfirmBtn);
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
		m_data = uiViewData as PopupMultiBoxViewData;
		_sb = new StringBuilder();
		_curShowRewardData = ListPool<Item>.Get();
	}

	protected override void Init()
	{
		base.Init();
		if (m_data == null)
		{
			return;
		}
		List<ItemKv> rewardItemData = m_data.rewardItemData;
		if (rewardItemData == null || rewardItemData.Count <= 0 || m_data.selectedGiftPackage == null)
		{
			return;
		}
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Window");
		giftPackageName.SetTable("shortcommon");
		giftPackageName.StringReference.TableEntryReference = m_data.selectedGiftPackage.GetLocalizationName();
		_curShowRewardData.Clear();
		foreach (ItemKv rewardItemDatum in m_data.rewardItemData)
		{
			Item item = new Item
			{
				Id = rewardItemDatum.id,
				Count = rewardItemDatum.count
			};
			_curShowRewardData.Add(item);
		}
		if (_curShowRewardData.Count > 0)
		{
			_curShowRewardData.Sort(SortUtility.ItemQualityAndIdSort);
			_curShowRewardData.Sort((Item x, Item y) => SortUtility.SelfSelectBoxItemCanUseCountSort(m_data.selectedGiftPackage, x, y));
		}
		scrollRect.OnItemLoad.RemoveAllListeners();
		scrollRect.OnItemLoad.AddListener(OnMultiCellShow);
		scrollRect.ClearCells();
		scrollRect.totalCount = _curShowRewardData.Count;
		selectItemIndex = 0;
		scrollRect.RefillCells();
		curSelectItem = _curShowRewardData.First();
		RefreshDisPlayOnSelectCell(curSelectItem);
		RefreshOnSelectNumText();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation?.GetSequence("Show").Play();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	public void OnAdd()
	{
		_selectNum++;
		if ((float)_selectNum > useNumSlider.maxValue)
		{
			_selectNum = (int)useNumSlider.maxValue;
		}
		useNumSlider.SetValueWithoutNotify(_selectNum);
		useNumText.SetText(_selectNum.FastToString());
		RefreshBtnState();
	}

	public void OnReduce()
	{
		_selectNum--;
		if (_selectNum <= 0)
		{
			_selectNum = 1;
		}
		useNumSlider.SetValueWithoutNotify(_selectNum);
		useNumText.SetText(_selectNum.FastToString());
		RefreshBtnState();
	}

	private void OnClickConfirmBtn()
	{
		if (curSelectItem == null)
		{
			return;
		}
		if (TryGetCurrentOverflowCount(out var overflowCount))
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ITEMCONVERTOVERFLOW, new ItemConvertOverflowViewData
			{
				Items = new List<ItemKv>
				{
					new ItemKv(curSelectItem.Id, overflowCount)
				},
				ConfirmAction = () =>
				{
					Model<GiftPackageModel>.Interface.SendRewardSelfSelectGiftPackage(m_data.selectedGiftPackage, _selectNum, curSelectItem.Id, Close);
				}
			});
		}
		else
		{
			Model<GiftPackageModel>.Interface.SendRewardSelfSelectGiftPackage(m_data.selectedGiftPackage, _selectNum, curSelectItem.Id, Close);
		}
	}

	private void OnSliderValueChanged(float value)
	{
		_selectNum = (int)value;
		useNumText.SetText(_selectNum.FastToString());
		RefreshBtnState();
	}

	public void RefreshBtnState(bool extraCondition = true)
	{
		reduceBtn.Interactable((selectItemIndex != -1 && _selectNum != 1) & extraCondition);
		addBtn.Interactable((selectItemIndex != -1 && !Mathf.Approximately(_selectNum, useNumSlider.maxValue)) & extraCondition);
		confirmBtn.Interactable((selectItemIndex != -1) & extraCondition);
		useNumSlider.interactable = (selectItemIndex != -1) & extraCondition;
		if (selectItemIndex == -1)
		{
			useNumSlider.value = 1f;
		}
	}

	public void RefreshOnSelectNumText()
	{
		_sb.Clear();
		_sb.Append("(").Append((selectItemIndex != -1) ? 1.FastToString() : 0.FastToString()).Append("/")
			.Append(1.FastToString())
			.Append(")");
		selectNumDes.SetText(_sb);
	}

	private void OnMultiCellShow(ILoopScrollDataSource source)
	{
		if (source is GiftPackageMultiCell giftPackageMultiCell)
		{
			PackageMultiCellData param = new PackageMultiCellData
			{
				itemData = _curShowRewardData[giftPackageMultiCell.index],
				canChooseCount = Model<GiftPackageModel>.Interface.GetCanChooseCountInSelfSelectBagChest(m_data.selectedGiftPackage, _curShowRewardData[giftPackageMultiCell.index])
			};
			giftPackageMultiCell.Init(param);
			if (selectItemIndex != -1 && giftPackageMultiCell.index == selectItemIndex && !giftPackageMultiCell.curSelectedState)
			{
				giftPackageMultiCell.SetSelectedState(state: true);
			}
		}
	}

	public void DisableLastCellSelectedState()
	{
		if (selectItemIndex != -1 && scrollRect.GetItem(selectItemIndex) is GiftPackageMultiCell { curSelectedState: not false } giftPackageMultiCell)
		{
			giftPackageMultiCell.SetSelectedState(state: false);
		}
	}

	public void SetCurSelectItem(Item item)
	{
		curSelectItem = item;
	}

	public void RefreshDisPlayOnSelectCell(Item rewardItem)
	{
		curSelectItem = rewardItem;
		if (rewardItem == null || m_data?.selectedGiftPackage == null)
		{
			SetSliderState(enable: false, 1);
			RefreshHoldingLimitDisplayOnSelect();
			return;
		}
		int rewardItemCanChooseCount = Model<GiftPackageModel>.Interface.GetRewardItemCanChooseCount(m_data.selectedGiftPackage, rewardItem);
		if (rewardItemCanChooseCount <= 0)
		{
			SetSliderState(enable: false, 1);
		}
		else
		{
			SetSliderState(enable: true, rewardItemCanChooseCount);
		}
		RefreshHoldingLimitDisplayOnSelect();
	}

	private void RefreshHoldingLimitDisplayOnSelect()
	{
		if (curSelectItem == null || m_data?.selectedGiftPackage == null)
		{
			holdingLimitDesRoot.SetActive(value: false);
			return;
		}
		ItemData data = CoreUtils.GetData(curSelectItem.Id, RuntimeConfigs.data.itemDatas);
		if (data == null || data.stackLimit <= 0)
		{
			holdingLimitDesRoot.SetActive(value: false);
			return;
		}
		int itemCount = G.localPlayer.Inventory.GetItemCount(curSelectItem.Id);
		int num = Mathf.Max(0, data.stackLimit - itemCount);
		ItemKv itemKv = m_data.selectedGiftPackage.GetSelfSelectRewardsData()?.FirstOrDefault((ItemKv reward) => reward.id == curSelectItem.Id);
		int num2 = ((itemKv == null || itemKv.count <= 0) ? 1 : itemKv.count);
		int canChooseCountInSelfSelectBagChest = Model<GiftPackageModel>.Interface.GetCanChooseCountInSelfSelectBagChest(m_data.selectedGiftPackage, curSelectItem);
		int num3 = ((canChooseCountInSelfSelectBagChest < 0) ? (m_data.selectedGiftPackage.GetCount() * num2) : (canChooseCountInSelfSelectBagChest * num2));
		if (num <= 0)
		{
			holdingLimitDesRoot.SetActive(value: true);
			string localizeString = LocalizationUtility.GetLocalizeString("Common", 2528, new List<object> { curSelectItem.GetNameString() });
			holdingLimitDes?.OnUpdateString.Invoke(localizeString);
		}
		else if (num3 > num)
		{
			holdingLimitDesRoot.SetActive(value: true);
			string localizeString2 = LocalizationUtility.GetLocalizeString("Common", 2836, new List<object>
			{
				curSelectItem.GetNameString(),
				num.FastToString()
			});
			holdingLimitDes?.OnUpdateString.Invoke(localizeString2);
		}
		else
		{
			holdingLimitDesRoot.SetActive(value: false);
		}
	}

	private bool TryGetCurrentOverflowCount(out int overflowCount)
	{
		overflowCount = 0;
		if (curSelectItem == null || m_data?.selectedGiftPackage == null || _selectNum <= 0)
		{
			return false;
		}
		ItemData data = CoreUtils.GetData(curSelectItem.Id, RuntimeConfigs.data.itemDatas);
		if (data == null || data.stackLimit <= 0)
		{
			return false;
		}
		ItemType data2 = CoreUtils.GetData(data.type, RuntimeConfigs.data.itemTypes);
		if (data2 == null || !data2.CanOverflowConvert)
		{
			return false;
		}
		ItemKv itemKv = m_data.selectedGiftPackage.GetSelfSelectRewardsData()?.FirstOrDefault((ItemKv reward) => reward.id == curSelectItem.Id);
		int num = ((itemKv == null || itemKv.count <= 0) ? 1 : itemKv.count);
		int itemCount = G.localPlayer.Inventory.GetItemCount(curSelectItem.Id);
		overflowCount = _selectNum * num + itemCount - data.stackLimit;
		return overflowCount > 0;
	}

	private void SetSliderState(bool enable, int sliderMaxValue)
	{
		LimitedSlider limitedSlider = useNumSlider;
		float limit = (useNumSlider.maxValue = sliderMaxValue);
		limitedSlider.limit = limit;
		_selectNum = 1;
		useNumSlider.SetValueWithoutNotify(1f);
		minNumText.SetText(1.FastToString());
		maxNumText.SetText(sliderMaxValue.FastToString());
		useNumText.SetText(1.FastToString());
		RefreshBtnState(enable);
	}

	protected override void UnInit()
	{
		base.UnInit();
		selectItemIndex = -1;
		curSelectItem = null;
		ListPool<Item>.Release(_curShowRewardData);
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation?.GetSequence("Hide").Play();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}

	public override void BackToBattleMain()
	{
		base.BackToBattleMain();
	}

	protected override async void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		GamepadTips.SetActive(type == DeviceInputMode.Gamepad);
		await UniTask.DelayFrame(1);
		if (ViewControlRoot.CurrentFocusLayer == null)
		{
			ViewControlLayer.Focus();
		}
		else
		{
			ViewControlLayer.ReFocus();
		}
		if (EventSystemHelper.CurrentSelected != null)
		{
			EventSystemHelper.CurrentSelected.GetComponent<ActButton>().OnSubmit(null);
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
		case MoveDirection.Up:
			ViewControlRoot.SelectUp();
			break;
		case MoveDirection.Down:
			ViewControlRoot.SelectDown();
			break;
		case MoveDirection.Left:
			ViewControlRoot.SelectLeft();
			break;
		case MoveDirection.Right:
			ViewControlRoot.SelectRight();
			break;
		}
		EventSystemHelper.CurrentSelected.GetComponent<ActButton>().OnSubmit(null);
	}

	public void OnConfirm()
	{
		if (confirmBtn.gameObject.activeSelf && confirmBtn.IsInteractable())
		{
			m_data?.onConfirmAction?.Invoke();
			confirmBtn.OnSubmit(null);
		}
	}
}
