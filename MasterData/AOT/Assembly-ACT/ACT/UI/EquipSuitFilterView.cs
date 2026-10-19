using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using ACT.Model.EquipSuit;
using ACT.UI.InputController;
using ACT.UI.ItemDetail;
using ACT.UI.ViewComponent.EquipSuitFilter;
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

public class EquipSuitFilterView : BaseUIView<EquipSuitFilterViewInputController>
{
	[SerializeField]
	private LoopScrollRect equipSuitBag;

	[SerializeField]
	private CommonItemDetail itemDetail;

	[SerializeField]
	private ActButton btnClearFilter;

	[SerializeField]
	private ActButton btnConfirmFilter;

	public GamePadTipsComp gamePadGroup;

	private Dictionary<string, GamePadTipsAction> _allInputPrompt;

	private List<GamePadTipsAction> _tipsActions;

	[SerializeField]
	private ViewControlRoot m_ViewControlRoot;

	[SerializeField]
	private ViewControlLayer m_ViewControlLayer;

	private List<EquipSuitData> _allSuits;

	private HashSet<EquipSuitData> _selectedSuits;

	private Character _character;

	private EquipSlotInfo _equipSlotInfo;

	private EntityCharacterData _entityCharacterData;

	private const int MAX_SELECT_COUNT = 5;

	private ContinuousNavigateData m_NavigateData;

	private EquipSuitFilterViewData m_data => uiViewData as EquipSuitFilterViewData;

	private void Awake()
	{
		btnClearFilter.SetBtnClick(CleanSelectedEquipSuits);
		btnConfirmFilter.SetBtnClick(ApplyConfigAndCloseView);
		itemDetail.gameObject.SetActive(value: true);
	}

	protected override void OnInputControllerCreate()
	{
		base.OnInputControllerCreate();
		if (m_ViewControlRoot != null && !m_ViewControlRoot.ReFocus())
		{
			m_ViewControlLayer?.Focus();
		}
	}

	protected override void AddEventListener()
	{
		base.AddEventListener();
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
		OnGamePadInit();
		_allSuits = ListPool<EquipSuitData>.Get();
		_selectedSuits = HashSetPool<EquipSuitData>.Get();
		_character = m_data.Character;
		_entityCharacterData = CoreUtils.GetData(_character.Id, RuntimeConfigs.data.entityCharacterDatas);
		if (Model<EquipModel>.Interface.SlotInfos.TryGetValue(_character.Id, out var value) && value != null && value.Length != 0)
		{
			_equipSlotInfo = value[0]?.Clone() as EquipSlotInfo;
		}
		if (_equipSlotInfo == null)
		{
			_equipSlotInfo = new EquipSlotInfo();
		}
		if (_entityCharacterData == null)
		{
			return;
		}
		foreach (KeyValuePair<int, EquipSuitData> equipSuitData in RuntimeConfigs.data.equipSuitDatas)
		{
			_allSuits.Add(equipSuitData.Value);
			HashSet<int> suitIDs = _equipSlotInfo.SuitIDs;
			if (suitIDs != null && suitIDs.Contains(equipSuitData.Key))
			{
				_selectedSuits.Add(equipSuitData.Value);
			}
		}
		_allSuits.Sort((EquipSuitData x, EquipSuitData y) =>
		{
			bool flag = _entityCharacterData.comSuit.Contains(x.id);
			bool flag2 = _entityCharacterData.comSuit.Contains(y.id);
			if (flag)
			{
				if (!flag2)
				{
					return -1;
				}
			}
			else if (flag2)
			{
				return 1;
			}
			int id = x.id;
			return id.CompareTo(y.id);
		});
		itemDetail.Context = new EquipSuit(_allSuits.FirstOrDefault()?.id ?? 0);
		equipSuitBag.totalCount = _allSuits.Count;
		equipSuitBag.OnItemShow.RemoveAllListeners();
		equipSuitBag.OnItemShow.AddListener((ILoopScrollDataSource l) =>
		{
			EquipSuitItem equipSuitItem = l as EquipSuitItem;
			if ((object)equipSuitItem != null)
			{
				equipSuitItem.Station = Station;
				equipSuitItem.OnToggleValueChanged = null;
				equipSuitItem.SuitData = _allSuits[equipSuitItem.index];
				equipSuitItem.toggle.SetIsOn(_selectedSuits.Contains(equipSuitItem.SuitData));
				EquipSuitItem equipSuitItem2 = equipSuitItem;
				equipSuitItem2.OnToggleValueChanged = (UnityAction<bool>)Delegate.Combine(equipSuitItem2.OnToggleValueChanged, (UnityAction<bool>)((bool arg0) =>
				{
					if ((_selectedSuits.Count >= 5) & arg0)
					{
						equipSuitItem.toggle.SetIsOn(val: false);
						GameUtility.OpenToolTip(LocalizationCommonData.CommonString.FilterMaxCount);
					}
					else
					{
						if (arg0)
						{
							_selectedSuits.Add(equipSuitItem.SuitData);
							itemDetail.Context = new EquipSuit(equipSuitItem.SuitData.id);
						}
						else
						{
							_selectedSuits.Remove(equipSuitItem.SuitData);
						}
						UpdateButtonStyle();
					}
				}));
				equipSuitItem.recommendStyle.SetActive(_entityCharacterData.comSuit.Contains(equipSuitItem.SuitData.id));
			}
		});
		equipSuitBag.RefillCells();
		UpdateButtonStyle();
		ReBindBtnPrompt();
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
		Singleton<GameInputActionManager>.instance.SetActionBlacklist(GetInputBindingController(), "UI/UISpecial2", value: false);
		base.UnInit();
		_allSuits.Clear();
		_selectedSuits.Clear();
		ListPool<EquipSuitData>.Release(_allSuits);
		HashSetPool<EquipSuitData>.Release(_selectedSuits);
		Model<EquipModel>.Interface.SerializeSlots();
		m_NavigateData?.Reset();
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

	private void CleanSelectedEquipSuits()
	{
		foreach (EquipSuitData item in _selectedSuits.ToList())
		{
			_selectedSuits.Remove(item);
		}
		equipSuitBag.RefillCells();
		UpdateButtonStyle();
	}

	private void ApplyConfigAndCloseView()
	{
		if (m_data != null)
		{
			_equipSlotInfo.SuitIDs.Clear();
			_equipSlotInfo.SuitIDs.AddRange(_selectedSuits.Select((EquipSuitData x) => x.id));
			if (!Model<EquipModel>.Interface.SlotInfos.TryGetValue(_character.Id, out var value) || value == null || value.Length == 0)
			{
				value = new EquipSlotInfo[4];
				Model<EquipModel>.Interface.SlotInfos[_character.Id] = value;
			}
			value[0] = _equipSlotInfo;
			m_data?.CloseAction?.Invoke();
		}
		Close();
	}

	private void UpdateButtonStyle()
	{
		bool flag = _selectedSuits.Count > 0;
		btnClearFilter.Interactable(flag);
		Singleton<GameInputActionManager>.instance.SetActionBlacklist(GetInputBindingController(), "UI/UISpecial2", !flag);
	}

	private void OnGamePadInit()
	{
		_allInputPrompt = new Dictionary<string, GamePadTipsAction>();
		_allInputPrompt["UI/Back"] = new GamePadTipsAction
		{
			inputAction = "UI/Back",
			localizeKey = 606,
			localizeTable = "Common"
		};
		_allInputPrompt["UI/Confirm"] = new GamePadTipsAction
		{
			inputAction = "UI/Confirm",
			localizeKey = 774,
			localizeTable = "Common"
		};
	}

	private void ReBindBtnPrompt()
	{
		if (!(gamePadGroup == null) && _allInputPrompt != null)
		{
			List<GamePadTipsAction> tipsActions = _tipsActions;
			if (tipsActions == null || tipsActions.Count <= 0)
			{
				_tipsActions = new List<GamePadTipsAction>();
			}
			gamePadGroup.ClearAllPrompts();
			_tipsActions.Clear();
			_tipsActions.Add(_allInputPrompt["UI/Confirm"]);
			_tipsActions.Add(_allInputPrompt["UI/Back"]);
			gamePadGroup.RegisterInputActions(_tipsActions);
		}
	}

	public void OnConfirm()
	{
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (currentSelected != null)
		{
			ExecuteEvents.Execute(currentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler?.OnSubmit(data);
			});
		}
	}

	public void OnSpecial1ClearSelected()
	{
		if (_selectedSuits.Count != 0)
		{
			CleanSelectedEquipSuits();
			if (m_ViewControlLayer != null)
			{
				m_ViewControlLayer.UnFocus();
				m_ViewControlLayer.Focus();
			}
		}
	}

	public void OnSpecial2Confirm()
	{
		ApplyConfigAndCloseView();
	}

	public void OnNavigate(Vector2 value)
	{
		if (EventSystemHelper.CurrentSelected != null)
		{
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref m_NavigateData, ExecuteNavigate);
		}
		else if (!m_ViewControlRoot.ReFocus())
		{
			m_ViewControlLayer?.Focus();
		}
	}

	public void ExecuteNavigate(MoveDirection dir)
	{
		if (!(m_ViewControlRoot == null))
		{
			switch (dir)
			{
			case MoveDirection.Up:
				m_ViewControlRoot.SelectUp();
				break;
			case MoveDirection.Down:
				m_ViewControlRoot.SelectDown();
				break;
			case MoveDirection.Left:
				m_ViewControlRoot.SelectLeft();
				break;
			case MoveDirection.Right:
				m_ViewControlRoot.SelectRight();
				break;
			}
			EquipSuitItem equipSuitItem = EventSystemHelper.CurrentSelected?.GetComponentInParent<EquipSuitItem>();
			if (!(equipSuitItem == null))
			{
				itemDetail.Context = new EquipSuit(equipSuitItem.SuitData.id);
				ScrollTargetToShow(equipSuitItem.transform, 80f);
			}
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

	private static void TargetToShow(Transform target, RectTransform viewport, RectTransform content, bool vertical, bool horizontal, float showOffset)
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
