using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoUseItemView : BaseUIView<MonoUseItemViewInputController>
{
	public class UseItemData : UIViewData
	{
		public Item Item;

		public int limitMin;

		public int limitMax;

		public Action<int> confirmClick;

		public Action onClose;
	}

	public ActButton CloseButton;

	public NormalItemUIComponent LiteItemUIComponent;

	public TextMeshProUGUI ItemName;

	public TextMeshProUGUI ItemDescription;

	public TextMeshProUGUI UseCount;

	public ActButton SubButton;

	public TextMeshProUGUI SubCount;

	public LimitedSlider LimitedSlider;

	public ActButton AddButton;

	public TextMeshProUGUI AddCount;

	public ActButton MaxButton;

	public ActButton ConfirmButton;

	public PowerBar PowerBar;

	public GameObject GamepadTipsRoot;

	public Dictionary<MonoUseItemViewControllerType, List<GameObject>> ControlDownPromts;

	public Dictionary<MonoUseItemViewControllerType, List<GameObject>> ControlPromts;

	public Dictionary<MonoUseItemViewControllerType, ViewControlLayer> ControlLayerDic;

	public ViewControlRoot ViewControlRoot;

	private int minCount;

	private int maxCount;

	private int curCount;

	private UseItemData useItemData;

	private MonoUseItemViewControllerType ControlType
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

	protected override void OnInputControllerCreate()
	{
		base.OnInputControllerCreate();
		ChangeUseItemViewControl(MonoUseItemViewControllerType.Main);
	}

	public void OnControllerActivate()
	{
		OnInputDeviceChange(MonoECS.instance.InputMode);
	}

	protected override void AddEventListener()
	{
		base.AddEventListener();
		CloseButton.SetBtnClick(OnClickCloseBtnHandle);
		SubButton.SetBtnClick(OnClickSubBtnHandle);
		AddButton.SetBtnClick(OnClickAddBtnHandle);
		MaxButton.SetBtnClick(OnClickMaxBtnHandle);
		ConfirmButton.SetBtnClick(OnClickConfirmBtnHandle);
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}

	protected override void Init()
	{
		base.Init();
		useItemData = uiViewData as UseItemData;
		RefreshUI(useItemData);
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		BetterAnimation componentInChildren = ControlTransform.GetComponentInChildren<BetterAnimation>();
		if (componentInChildren != null)
		{
			componentInChildren.GetSequence("Show").OnComplete((AnimationBuilder _) =>
			{
				OpenEffectFinishNew();
			}).Play();
		}
		betterAnimation?.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Window");
	}

	protected override void UnInit()
	{
		base.UnInit();
	}

	public override void Close()
	{
		useItemData?.onClose?.Invoke();
		base.Close();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		BetterAnimation componentInChildren = ControlTransform.GetComponentInChildren<BetterAnimation>();
		if (componentInChildren != null)
		{
			componentInChildren.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
			{
				CloseEffectFinishNew();
			}).Play();
		}
		betterAnimation?.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	private void RefreshUI(UseItemData useItemData)
	{
		if (useItemData != null)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Window");
			LiteItemUIComponent.SetData(useItemData.Item, 0L, ItemUIComponentBase.InitType.BagItem, ItemUIComponentBase.ItemCountShowType.OneSide);
			LiteItemUIComponent.UpdatePerformance();
			ItemData itemData = RuntimeConfigs.data.itemDatas[useItemData.Item.Id];
			ItemName.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, itemData.nameLocal);
			ItemDescription.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_longcommon, itemData.descLocal);
			minCount = useItemData.limitMin;
			maxCount = useItemData.limitMax;
			curCount = minCount;
			UseCount.SetText("{0:0}", minCount);
			RefreshBtn();
			SubCount.SetText("{0:0}", minCount);
			AddCount.SetText("{0:0}", maxCount);
			LimitedSlider.onValueChanged.AddListener((float value) =>
			{
				curCount = (int)value;
				UseCount.SetText("{0:0}", curCount);
				RefreshBtn();
			});
			LimitedSlider.maxValue = maxCount;
			LimitedSlider.limit = maxCount;
			LimitedSlider.minValue = minCount;
			LimitedSlider.value = minCount;
			if (minCount == maxCount)
			{
				LimitedSlider.value = 1f;
			}
			PowerBar.gameObject.SetActive(itemData.type == 23);
		}
	}

	private void RefreshBtn()
	{
		AddButton.Interactable(active: true);
		SubButton.Interactable(active: true);
		ConfirmButton.Interactable(active: true);
		MaxButton.Interactable(active: true);
		if (curCount >= maxCount)
		{
			AddButton.Interactable(active: false);
			MaxButton.Interactable(active: false);
		}
		SubButton.Interactable(curCount > 1);
		ConfirmButton.Interactable(curCount > 0);
	}

	private void OnClickCloseBtnHandle()
	{
		Close();
	}

	public void OnClickSubBtnHandle()
	{
		curCount = Mathf.Max(curCount - 1, minCount);
		UseCount.SetText("{0:0}", curCount);
		LimitedSlider.value = curCount;
		RefreshBtn();
	}

	public void OnClickAddBtnHandle()
	{
		curCount = Mathf.Min(curCount + 1, maxCount);
		UseCount.SetText("{0:0}", curCount);
		LimitedSlider.value = curCount;
		RefreshBtn();
	}

	public void OnClickMaxBtnHandle()
	{
		curCount = maxCount;
		UseCount.SetText("{0:0}", curCount);
		LimitedSlider.value = curCount;
		RefreshBtn();
	}

	private void OnClickConfirmBtnHandle()
	{
		if (useItemData != null)
		{
			Close();
			useItemData.confirmClick?.Invoke(curCount);
		}
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		if (type != DeviceInputMode.Gamepad)
		{
			if (EventSystemHelper.CurrentSelected != null)
			{
				ItemUIComponentBase component = EventSystemHelper.CurrentSelected.GetComponent<ItemUIComponentBase>();
				if ((bool)component)
				{
					component.SetIsOn(val: false);
				}
			}
		}
		else
		{
			ChangeUseItemViewControl(ControlType);
		}
	}

	public void ChangeUseItemViewControl(MonoUseItemViewControllerType useItemViewControllerType)
	{
		MonoUseItemViewControllerType controlType = ControlType;
		ControlType = useItemViewControllerType;
		ControlLayerDic[controlType].UnFocus();
		ControlLayerDic[useItemViewControllerType].Focus();
		for (int i = 0; i < GamepadTipsRoot.transform.GetChild(0).childCount; i++)
		{
			GamepadTipsRoot.transform.GetChild(0).GetChild(i).gameObject.SetActive(value: false);
		}
		foreach (GameObject item in ControlDownPromts[useItemViewControllerType])
		{
			item.SetActive(value: true);
		}
		LayoutRebuilder.ForceRebuildLayoutImmediate(GamepadTipsRoot.transform.GetChild(0).GetComponent<RectTransform>());
		for (int j = 0; j < ControlPromts[controlType].Count; j++)
		{
			ControlPromts[controlType][j].SetActive(value: false);
		}
		for (int k = 0; k < ControlPromts[useItemViewControllerType].Count; k++)
		{
			ControlPromts[useItemViewControllerType][k].SetActive(value: true);
		}
		if (useItemViewControllerType == MonoUseItemViewControllerType.Main)
		{
			EventSystemHelper.SetSelectedGameObject(ConfirmButton.gameObject);
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

	public void LeftStickPress()
	{
		LiteItemUIComponent.OnSubmit(null);
	}

	public void RightStickPress()
	{
		if (PowerBar.gameObject.activeSelf)
		{
			PowerBar.OnClick();
		}
	}
}
