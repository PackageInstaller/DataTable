using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.LocalizationExtension;
using ACT.UI.DataProxy;
using ACT.UI.ItemDetail;
using ACT.UI.ItemDetail.Interface;
using ACT.UI.ItemDetail.Styles;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf.Collections;
using Runtime.UI.CommonComponent.CommonScrollBag;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.SmartFormat.PersistentVariables;
using UnityEngine.UI;

namespace ACT.UI;

public class EquipDissolveView : BaseUIView
{
	private EquipDissolveViewData m_data;

	[Header("左侧")]
	[SerializeField]
	private CommonScrollBagComponent m_EquipScrollView;

	[SerializeField]
	private GameObject m_EmptyStatus;

	[SerializeField]
	private GameObject m_EquipDetailRoot;

	[SerializeField]
	private CommonItemDetail m_EquipDetailComp;

	[Header("右侧")]
	[SerializeField]
	private CommonNumberComponent m_EquipHasSelected;

	[SerializeField]
	private LocalizeTMP_Dropdown m_FilterDropDown;

	[SerializeField]
	private ActButton m_FastFillBtn;

	[SerializeField]
	private CommonScrollBagComponent m_PrepareToDissolve;

	[SerializeField]
	private LoopHorizontalScrollRect m_Dissolve;

	[SerializeField]
	private ActButton m_ClearButton;

	[SerializeField]
	private ActButton m_DissolveButton;

	private List<ItemUnifierProxy> m_Equips;

	private List<LocalizeTMP_Dropdown.OptionData> m_OptionDatas;

	private List<ItemUnifierProxy> m_GetItems;

	private int m_ClickedIndex = -1;

	private int m_DropDownOldValue;

	private void Awake()
	{
		m_Equips = ListPool<ItemUnifierProxy>.Get();
		m_OptionDatas = ListPool<LocalizeTMP_Dropdown.OptionData>.Get();
		m_GetItems = ListPool<ItemUnifierProxy>.Get();
		m_PrepareToDissolve.ItemSource = ListPool<ItemUnifierProxy>.Get();
		m_FastFillBtn.OnClick.AddListener(QuickFill);
		m_ClearButton.OnClick.AddListener(ClearEquips);
		m_DissolveButton.OnClick.AddListener(DoDissolve);
		m_EquipDetailComp.TopStylePostProcess = null;
		CommonItemDetail equipDetailComp = m_EquipDetailComp;
		equipDetailComp.TopStylePostProcess = (Action<IStyle>)Delegate.Combine(equipDetailComp.TopStylePostProcess, (Action<IStyle>)((IStyle style) =>
		{
			if (style is CommonStyle commonStyle)
			{
				commonStyle.lockBtn.CanLock = null;
				EquipGemIsLockBtn lockBtn = commonStyle.lockBtn;
				lockBtn.CanLock = (Func<int, bool>)Delegate.Combine(lockBtn.CanLock, new Func<int, bool>(CanLockEquip));
			}
		}));
	}

	protected override void OnUnityDestroy()
	{
		ItemUnifierProxy.ItemUnifierPool.Release(m_Equips);
		ListPool<ItemUnifierProxy>.Release(m_Equips);
		m_Equips = null;
		ListPool<LocalizeTMP_Dropdown.OptionData>.Release(m_OptionDatas);
		m_OptionDatas.Clear();
		m_OptionDatas = null;
		ItemUnifierProxy.ItemUnifierPool.Release(m_GetItems);
		ListPool<ItemUnifierProxy>.Release(m_GetItems);
		m_GetItems = null;
		m_FastFillBtn.OnClick.RemoveListener(QuickFill);
		m_ClearButton.OnClick.RemoveListener(ClearEquips);
		m_DissolveButton.OnClick.RemoveListener(DoDissolve);
		List<ItemUnifierProxy> obj = m_PrepareToDissolve.ItemSource as List<ItemUnifierProxy>;
		ItemUnifierProxy.ItemUnifierPool.Release(obj);
		ListPool<ItemUnifierProxy>.Release(obj);
		m_PrepareToDissolve.ItemSource = null;
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
		InitializeDropDownOpt();
		FillLeftEquipBag();
		UpdateSelectedNumber();
		FillRightEquip();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		if ((bool)betterAnimation)
		{
			betterAnimation.GetSequence("Show")?.OnComplete((AnimationBuilder _) =>
			{
				OpenEffectFinishNew();
			}).Play();
		}
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		if ((bool)betterAnimation)
		{
			betterAnimation.GetSequence("Hide")?.OnComplete((AnimationBuilder _) =>
			{
				CloseEffectFinishNew();
			}).Play();
		}
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}

	private void FillLeftEquipBag()
	{
		UpdateEquipDetailPanel(null);
		ItemUnifierProxy.ItemUnifierPool.Release(m_Equips);
		foreach (Equip item in CharacterDependHelper.GetCurWorldAllEquip())
		{
			if (CanAddToBag(item))
			{
				m_Equips.Add(ItemUnifierProxy.ItemUnifierPool.Get(item));
			}
		}
		if (m_Equips.Count == 0)
		{
			m_EmptyStatus.gameObject.SetActive(value: true);
			m_EquipScrollView.gameObject.SetActive(value: false);
			m_EquipScrollView.OnItemShow = null;
			m_EquipScrollView.OnItemSelect = null;
			m_EquipScrollView.OnItemUnSelect = null;
			m_EquipScrollView.SelectedModels.Clear();
			UpdateButtonStyle();
			UpdateSelectedNumber();
			return;
		}
		m_EmptyStatus.gameObject.SetActive(value: false);
		m_EquipScrollView.gameObject.SetActive(value: true);
		m_Equips.Sort((ItemUnifierProxy x, ItemUnifierProxy y) => SortUtility.SortEquip(y.As<Equip>(), x.As<Equip>()));
		m_EquipScrollView.Station = Station;
		m_EquipScrollView.OnItemShow = null;
		m_EquipScrollView.OnItemSelect = null;
		m_EquipScrollView.OnItemUnSelect = null;
		m_EquipScrollView.SelectedModels.Clear();
		m_EquipScrollView.ItemSource = m_Equips;
		m_EquipScrollView.SelectMode = CommonScrollBagComponent.SelectModeType.MultipleUnique;
		m_EquipScrollView.ItemShowType = ItemUIComponentBase.InitType.EquipDissolveStyle;
		CommonScrollBagComponent equipScrollView = m_EquipScrollView;
		equipScrollView.OnItemShow = (Action<ItemUIComponentBase>)Delegate.Combine(equipScrollView.OnItemShow, (Action<ItemUIComponentBase>)((ItemUIComponentBase l) =>
		{
			l.IsHighLight = l.Index == m_ClickedIndex;
		}));
		CommonScrollBagComponent equipScrollView2 = m_EquipScrollView;
		equipScrollView2.OnItemSelect = (Action<ItemUIComponentBase>)Delegate.Combine(equipScrollView2.OnItemSelect, (Action<ItemUIComponentBase>)((ItemUIComponentBase l) =>
		{
			Equip equip = l.ItemUnifier.As<Equip>();
			UpdateEquipDetailPanel(equip);
			if (m_EquipScrollView.SelectedModels.Count > RuntimeConfigs.data.game.equipRecycleLimit)
			{
				m_EquipScrollView.SelectedModels.Remove(l.ItemUnifier);
				GameUtility.OpenToolTip(41000063);
			}
			else if (equip.IsLock)
			{
				m_EquipScrollView.SelectedModels.Remove(l.ItemUnifier);
				GameUtility.OpenToolTip(41000065);
			}
			else
			{
				UpdateSelectedNumber();
				FillRightEquip();
				FillDissolveMaterials();
				m_ClickedIndex = l.Index;
				UpdateButtonStyle();
			}
		}));
		CommonScrollBagComponent equipScrollView3 = m_EquipScrollView;
		equipScrollView3.OnItemUnSelect = (Action<ItemUIComponentBase>)Delegate.Combine(equipScrollView3.OnItemUnSelect, (Action<ItemUIComponentBase>)((ItemUIComponentBase l) =>
		{
			UpdateSelectedNumber();
			FillRightEquip();
			FillDissolveMaterials();
			UpdateButtonStyle();
		}));
		UpdateButtonStyle();
		UpdateSelectedNumber();
	}

	private void UpdateEquipDetailPanel(Equip target)
	{
		if (target == null)
		{
			m_EquipDetailRoot.SetActive(value: false);
			return;
		}
		m_EquipDetailRoot.SetActive(value: true);
		m_EquipDetailComp.Station = Station;
		m_EquipDetailComp.Context = target;
	}

	private void UpdateSelectedNumber()
	{
		m_EquipHasSelected.UpdateNumber(m_EquipScrollView.SelectedModels.Count, RuntimeConfigs.data.game.equipRecycleLimit);
	}

	private void InitializeDropDownOpt()
	{
		m_FilterDropDown.ClearOptions();
		m_OptionDatas.Clear();
		int num = int.MaxValue;
		int num2 = 0;
		foreach (KeyValuePair<int, EquipData> equipData in RuntimeConfigs.data.equipDatas)
		{
			if (equipData.Value.quality < num)
			{
				num = equipData.Value.quality;
			}
			if (equipData.Value.quality > num2)
			{
				num2 = equipData.Value.quality;
			}
		}
		for (int i = num; i <= num2; i++)
		{
			LocalizedString localizedString = new LocalizedString("Common", LocalizationCommonData.CommonString.XLevelEquip);
			localizedString["0"] = new StringVariable
			{
				Value = LocalizationUtility.GetLocalizeString("shortcommon", RuntimeConfigs.data.itemQualitys[i].name)
			};
			m_OptionDatas.Add(new LocalizeTMP_Dropdown.OptionData(localizedString)
			{
				customData = i
			});
		}
		m_FilterDropDown.AddOptions(m_OptionDatas);
		m_FilterDropDown.value = 0;
		m_FilterDropDown.onValueChanged.RemoveListener(OnFilterDropDownValueChanged);
		m_FilterDropDown.onValueChanged.AddListener(OnFilterDropDownValueChanged);
	}

	private void OnFilterDropDownValueChanged(int newValue)
	{
		bool flag = false;
		foreach (Equip item in CharacterDependHelper.GetCurWorldAllEquip())
		{
			if (CanAddToBag(item))
			{
				flag = true;
				break;
			}
		}
		if (!flag)
		{
			GameUtility.OpenToolTip(LocalizationCommonData.CommonString.NoEquipSatisfied);
			m_FilterDropDown.SetValueWithoutNotify(m_DropDownOldValue);
			m_FilterDropDown.RefreshShownValue();
		}
		else
		{
			m_DropDownOldValue = newValue;
			FillLeftEquipBag();
			FillRightEquip();
			FillDissolveMaterials();
		}
	}

	private void QuickFill()
	{
		int num = 0;
		foreach (ItemUnifierProxy selectedModel in m_EquipScrollView.SelectedModels)
		{
			if (m_Equips.IndexOf(selectedModel) < RuntimeConfigs.data.game.equipRecycleLimit)
			{
				num++;
			}
		}
		int num2 = Mathf.Min(RuntimeConfigs.data.game.equipRecycleLimit - m_EquipScrollView.SelectedModels.Count + num, m_Equips.Count);
		for (int i = 0; i < num2; i++)
		{
			if (!m_Equips[i].As<Equip>().IsLock)
			{
				m_EquipScrollView.AddSelectedModelWithoutNotify(m_Equips[i]);
			}
		}
		foreach (ItemUnifierProxy selectedModel2 in m_EquipScrollView.SelectedModels)
		{
			if (selectedModel2.Context is ItemUIComponentBase itemUIComponentBase)
			{
				itemUIComponentBase.IsChosen = true;
				itemUIComponentBase.UpdatePerformance();
			}
		}
		FillRightEquip();
		UpdateSelectedNumber();
		UpdateButtonStyle();
		FillDissolveMaterials();
	}

	private void FillRightEquip()
	{
		List<ItemUnifierProxy> list = m_PrepareToDissolve.ItemSource as List<ItemUnifierProxy>;
		ItemUnifierProxy.ItemUnifierPool.Release(list);
		foreach (ItemUnifierProxy selectedModel in m_EquipScrollView.SelectedModels)
		{
			ItemUnifierProxy item = ItemUnifierProxy.ItemUnifierPool.Get(selectedModel.Source);
			list.Add(item);
			m_PrepareToDissolve.SelectedModels.Add(item);
		}
		if (m_EquipScrollView.SelectedModels.Count < RuntimeConfigs.data.game.equipRecycleLimit)
		{
			list.Add(ItemUnifierProxy.Empty);
		}
		m_PrepareToDissolve.Station = Station;
		m_PrepareToDissolve.SelectMode = CommonScrollBagComponent.SelectModeType.MultipleUnique;
		m_PrepareToDissolve.ItemShowType = ItemUIComponentBase.InitType.EquipDissolveStyle;
		m_PrepareToDissolve.OnItemUnSelect = null;
		CommonScrollBagComponent prepareToDissolve = m_PrepareToDissolve;
		prepareToDissolve.OnItemUnSelect = (Action<ItemUIComponentBase>)Delegate.Combine(prepareToDissolve.OnItemUnSelect, (Action<ItemUIComponentBase>)((ItemUIComponentBase l) =>
		{
			m_EquipScrollView.SelectedModels.Remove(m_EquipScrollView.SelectedModels.First((ItemUnifierProxy x) => x.Source.Equals(l.ItemUnifier.Source)));
			FillRightEquip();
		}));
		m_PrepareToDissolve.SetDirty();
	}

	private void FillDissolveMaterials()
	{
		ItemUnifierProxy.ItemUnifierPool.Release(m_GetItems);
		foreach (ItemUnifierProxy selectedModel in m_EquipScrollView.SelectedModels)
		{
			foreach (ItemKv item in CoreUtils.GetData(selectedModel.GetItemData(RuntimeConfigs.data.equipDatas).GetLevelMaterialId(selectedModel.As<Equip>().Level), RuntimeConfigs.data.equipMaterialDatas).RecyclingLv)
			{
				ItemUnifierProxy itemUnifierProxy = m_GetItems.Find((ItemUnifierProxy x) => x.Id == item.id);
				if (itemUnifierProxy != null)
				{
					itemUnifierProxy.Count += item.count;
				}
				else
				{
					m_GetItems.Add(ItemUnifierProxy.ItemUnifierPool.Get<Item>(item.id, item.count));
				}
			}
		}
		m_Dissolve.totalCount = m_GetItems.Count;
		m_Dissolve.OnItemShow.RemoveAllListeners();
		m_Dissolve.OnItemShow.AddListener((ILoopScrollDataSource l) =>
		{
		});
		m_Dissolve.RefillCells();
	}

	private void ClearEquips()
	{
		foreach (ItemUnifierProxy selectedModel in m_EquipScrollView.SelectedModels)
		{
			if (selectedModel.Context is ItemUIComponentBase itemUIComponentBase)
			{
				itemUIComponentBase.IsChosen = false;
				itemUIComponentBase.UpdatePerformance();
			}
		}
		m_EquipScrollView.ClearSelectedModelWithoutNotify();
		UpdateSelectedNumber();
		FillRightEquip();
		FillDissolveMaterials();
		UpdateButtonStyle();
	}

	private void UpdateButtonStyle()
	{
		m_ClearButton.Interactable(m_EquipScrollView.SelectedModels.Count > 0);
		m_DissolveButton.Interactable(m_EquipScrollView.SelectedModels.Count > 0);
		m_FastFillBtn.Interactable(m_EquipScrollView.ItemSource?.Any() ?? false);
	}

	private void DoDissolve()
	{
		foreach (ItemUnifierProxy selectedModel in m_EquipScrollView.SelectedModels)
		{
			if (selectedModel.As<Equip>().Level >= 1)
			{
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTPANEL, new TextPanel.Param
				{
					titleId = 0,
					commonId = 41000064,
					OnConfirm = SendMessage
				});
				return;
			}
		}
		SendMessage();
		void SendMessage()
		{
			List<int> equipUIDs = ListPool<int>.Get();
			foreach (ItemUnifierProxy selectedModel2 in m_EquipScrollView.SelectedModels)
			{
				equipUIDs.Add(selectedModel2.As<Equip>().Uid);
			}
			G.service.EquipDismantle(equipUIDs, (bool x, RepeatedField<Item> items) =>
			{
				if (x)
				{
					List<ItemUnifierProxy> tempList = ListPool<ItemUnifierProxy>.Get();
					ItemUnifierProxy.ItemUnifierPool.GetList(items, tempList);
					GameUtility.OpenPopReward(GameUtility.ToUniversalItems(tempList), notSort: false, () =>
					{
						ListPool<ItemUnifierProxy>.Release(tempList);
					});
					ClearEquips();
					FillLeftEquipBag();
				}
				ListPool<int>.Release(equipUIDs);
			});
		}
	}

	private bool CanAddToBag(Equip equip)
	{
		if (equip.WearCharacter != 0)
		{
			return false;
		}
		if (equip.GetQuality() > (int)m_OptionDatas[m_FilterDropDown.value].customData)
		{
			return false;
		}
		bool flag = false;
		foreach (GemSlot gemSlot in equip.GemSlots)
		{
			if (gemSlot.GemId != 0)
			{
				flag = true;
			}
		}
		return !flag;
	}

	private bool CanLockEquip(int uid)
	{
		foreach (ItemUnifierProxy selectedModel in m_EquipScrollView.SelectedModels)
		{
			if (selectedModel.As<Equip>().Uid == uid)
			{
				GameUtility.OpenToolTip(LocalizationCommonData.CommonString.CannotUnlock);
				return false;
			}
		}
		return true;
	}
}
