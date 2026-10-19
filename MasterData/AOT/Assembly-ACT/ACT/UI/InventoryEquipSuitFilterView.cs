using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Model.EquipSuit;
using ACT.UI.InputController;
using ACT.UI.ItemDetail;
using ACT.UI.ViewComponent.InventoryView;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using UnityEngine.Localization;
using UnityEngine.UI;

namespace ACT.UI;

public class InventoryEquipSuitFilterView : BaseUIView<InventoryEquipSuitFilterViewInputController>
{
	[SerializeField]
	private LoopScrollRect equipSuitBag;

	[SerializeField]
	private CommonItemDetail itemDetail;

	[SerializeField]
	private ActButton btnClearFilter;

	[SerializeField]
	private ActButton btnConfirmFilter;

	public ViewControlRoot ViewControlRoot;

	public ViewControlLayer ViewControlLayer;

	public GameObject GamepadTips;

	private List<EquipSuitData> _allSuits;

	private HashSet<EquipSuitData> _selectedSuits;

	private const int MAX_SELECT_COUNT = 5;

	protected InventoryEquipSuitFilterViewData m_data => uiViewData as InventoryEquipSuitFilterViewData;

	protected override void OnInputControllerCreate()
	{
		base.OnInputControllerCreate();
		OnInputDeviceChange(MonoECS.instance.InputMode);
		if (!ViewControlRoot.ReFocus())
		{
			ViewControlLayer.Focus();
		}
	}

	protected override void AddEventListener()
	{
		base.AddEventListener();
		btnClearFilter.SetBtnClick(CleanSelectedEquipSuits, "event:/UI/Interface/Bag/Clear");
		btnConfirmFilter.SetBtnClick(OnConfirmButtonHandle, "event:/UI/Interface/Bag/Screen");
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
	}

	protected override void Init()
	{
		base.Init();
		_allSuits = ListPool<EquipSuitData>.Get();
		_selectedSuits = HashSetPool<EquipSuitData>.Get();
		foreach (KeyValuePair<int, EquipSuitData> equipSuitData in RuntimeConfigs.data.equipSuitDatas)
		{
			_allSuits.Add(equipSuitData.Value);
			List<int> equipSuitIds = m_data.EquipSuitIds;
			if (equipSuitIds != null && equipSuitIds.Contains(equipSuitData.Key))
			{
				_selectedSuits.Add(equipSuitData.Value);
			}
		}
		itemDetail.Context = new EquipSuit(_allSuits.FirstOrDefault()?.id ?? 0);
		equipSuitBag.totalCount = _allSuits.Count;
		equipSuitBag.OnItemShow.RemoveAllListeners();
		equipSuitBag.OnItemShow.AddListener((ILoopScrollDataSource l) =>
		{
			InventoryEquipSuitItem equipSuitItem = l as InventoryEquipSuitItem;
			if ((object)equipSuitItem != null)
			{
				equipSuitItem.Station = Station;
				equipSuitItem.OnToggleValueChanged = null;
				equipSuitItem.SuitData = _allSuits[equipSuitItem.index];
				equipSuitItem.toggle.SetIsOn(_selectedSuits.Contains(equipSuitItem.SuitData));
				InventoryEquipSuitItem inventoryEquipSuitItem = equipSuitItem;
				inventoryEquipSuitItem.OnToggleValueChanged = (UnityAction<bool>)Delegate.Combine(inventoryEquipSuitItem.OnToggleValueChanged, (UnityAction<bool>)((bool arg0) =>
				{
					Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Bag/Click");
					if ((_selectedSuits.Count >= 5) & arg0)
					{
						equipSuitItem.toggle.SetIsOn(val: false);
						GameUtility.OpenToolTip(LocalizationCommonData.CommonString.FilterMaxCount);
					}
					else if (arg0)
					{
						_selectedSuits.Add(equipSuitItem.SuitData);
						itemDetail.Context = new EquipSuit(equipSuitItem.SuitData.id);
					}
					else
					{
						_selectedSuits.Remove(equipSuitItem.SuitData);
					}
				}));
			}
		});
		equipSuitBag.RefillCells();
		ViewControlLayer.UnFocus();
		ViewControlLayer.Focus();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
		_allSuits.Clear();
		_selectedSuits.Clear();
		ListPool<EquipSuitData>.Release(_allSuits);
		HashSetPool<EquipSuitData>.Release(_selectedSuits);
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}

	public void CleanSelectedEquipSuits()
	{
		foreach (EquipSuitData item in _selectedSuits.ToList())
		{
			_selectedSuits.Remove(item);
		}
		equipSuitBag.RefillCells();
	}

	public void OnConfirmButtonHandle()
	{
		m_data.EquipSuitIds.Clear();
		foreach (EquipSuitData selectedSuit in _selectedSuits)
		{
			m_data.EquipSuitIds.Add(selectedSuit.id);
		}
		Close();
		IBaseUIController topActivePanel = Singleton<NewUIManager>.instance.GetTopActivePanel();
		if (topActivePanel is BagPanelUIController bagPanelUIController)
		{
			(bagPanelUIController.GetUIView() as MonoInventoryView).InventoryFilterView.RefreshEquipSuitFilter();
		}
		else if (topActivePanel is EquipDecomposeUIController equipDecomposeUIController)
		{
			(equipDecomposeUIController.GetUIView() as EquipDecomposeView).InventoryFilterView.RefreshEquipSuitFilter();
		}
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		GamepadTips.SetActive(type == DeviceInputMode.Gamepad);
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
		InventoryEquipSuitItem componentInParent = EventSystemHelper.CurrentSelected.GetComponentInParent<InventoryEquipSuitItem>();
		if (!(componentInParent == null))
		{
			itemDetail.Context = new EquipSuit(componentInParent.SuitData.id);
			ScrollTargetToShow(componentInParent.transform, 80f);
		}
	}

	private void ScrollTargetToShow(Transform target, float scrollToShowOffset)
	{
		LoopScrollRect componentInParent = target.GetComponentInParent<LoopScrollRect>();
		if (componentInParent != null)
		{
			TargetToShow(target, componentInParent.viewport, componentInParent.content, componentInParent.vertical, componentInParent.horizontal, scrollToShowOffset);
			componentInParent.UpdateBounds(updateItems: true);
		}
		ScrollRect componentInParent2 = target.GetComponentInParent<ScrollRect>();
		if (componentInParent2 != null)
		{
			TargetToShow(target, componentInParent2.viewport, componentInParent2.content, componentInParent2.vertical, componentInParent2.horizontal, scrollToShowOffset);
		}
	}

	private void TargetToShow(Transform target, RectTransform viewport, RectTransform content, bool vertical, bool horizontal, float showOffset)
	{
		RectTransform component = target.GetComponent<RectTransform>();
		RectTransformUtility.ScreenPointToLocalPointInRectangle(viewport, RectTransformUtility.WorldToScreenPoint(null, target.position), null, out var localPoint);
		Vector2 zero = Vector2.zero;
		if (vertical)
		{
			float num = localPoint.y + component.rect.yMin;
			float num2 = localPoint.y + component.rect.yMax;
			if (num2 > viewport.rect.yMax)
			{
				zero.y = num2 - viewport.rect.yMax + showOffset;
			}
			else if (num < viewport.rect.yMin)
			{
				zero.y = num - viewport.rect.yMin - showOffset;
			}
		}
		if (horizontal)
		{
			float num3 = localPoint.x + component.rect.xMin;
			float num4 = localPoint.x + component.rect.xMax;
			if (num3 < viewport.rect.xMin)
			{
				zero.x = num3 - viewport.rect.xMin + showOffset;
			}
			else if (num4 > viewport.rect.xMax)
			{
				zero.x = num4 - viewport.rect.xMax - showOffset;
			}
		}
		content.anchoredPosition -= zero;
	}
}
