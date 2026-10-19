using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.UI.DataProxy;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf.Collections;
using Runtime.UI.CommonComponent.CommonScrollBag;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT.UI;

public class PopupCharacterQuickSelectView : BaseUIView<PopupCharacterQuickSelectViewInputController>
{
	private PopupCharacterQuickSelectViewData m_data;

	[SerializeField]
	private CommonScrollBagComponent _bag;

	[SerializeField]
	private ActButton _closeBtn;

	[SerializeField]
	private ActButton _saveBtn;

	private List<ItemUnifierProxy> _itemUnifierProxys;

	[SerializeField]
	private StartList _elementRoot;

	[SerializeField]
	private GamePadTipsComp _gamePadTips;

	[SerializeField]
	[Header("手柄选择角色Layer")]
	private ViewControlLayer _gamePadControlLayer;

	private readonly List<GamePadTipsAction> _gamePadTipsActions = new List<GamePadTipsAction>();

	private const int SHOW_CHARACTER_MAX = 3;

	private List<int> quickSelectCharacters;

	public ViewControlLayer GamePadControlLayer => _gamePadControlLayer;

	protected override void AddEventListener()
	{
		base.AddEventListener();
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}

	private void Awake()
	{
		_itemUnifierProxys = ListPool<ItemUnifierProxy>.Get();
	}

	private void OnDestroy()
	{
		ListPool<ItemUnifierProxy>.Release(_itemUnifierProxys);
		_itemUnifierProxys = null;
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
		m_data = uiViewData as PopupCharacterQuickSelectViewData;
		_closeBtn.SetBtnClick(Close, "event:/UI/Common/Return_Click");
		_saveBtn.SetBtnClick(SaveBtnEvent, "event:/UI/Interface/Team/FastFormation_SaveConfig");
		RepeatedField<int> repeatedField = G.localPlayer?.Profile?.EscInfo?.ShowCharacterIds;
		quickSelectCharacters = new List<int>(3);
		for (int i = 0; i < 3; i++)
		{
			quickSelectCharacters.Add((repeatedField != null && i < repeatedField.Count) ? repeatedField[i] : 0);
		}
		_bag.OnItemShow = null;
		_bag.OnItemSelect = null;
		_bag.OnItemUnSelect = null;
		_bag.SelectedModels.Clear();
		CommonScrollBagComponent bag = _bag;
		bag.OnItemSelect = (Action<ItemUIComponentBase>)Delegate.Combine(bag.OnItemSelect, (Action<ItemUIComponentBase>)((ItemUIComponentBase item) =>
		{
			if (item is BagCharacterItemUIComponent { CanChose: not false } bagCharacterItemUIComponent2)
			{
				QuickChooseCharacter(bagCharacterItemUIComponent2);
			}
		}));
		CommonScrollBagComponent bag2 = _bag;
		bag2.OnItemUnSelect = (Action<ItemUIComponentBase>)Delegate.Combine(bag2.OnItemUnSelect, (Action<ItemUIComponentBase>)((ItemUIComponentBase item) =>
		{
			if (item is BagCharacterItemUIComponent bagCharacterItemUIComponent2)
			{
				int id2 = item.ItemUnifier.As<Character>().Id;
				if (bagCharacterItemUIComponent2.CanChose)
				{
					int num2 = quickSelectCharacters.IndexOf(id2);
					if (num2 != -1)
					{
						quickSelectCharacters[num2] = 0;
						bagCharacterItemUIComponent2.SetShowIndex(0);
					}
				}
			}
		}));
		CommonScrollBagComponent bag3 = _bag;
		bag3.OnItemShow = (Action<ItemUIComponentBase>)Delegate.Combine(bag3.OnItemShow, (Action<ItemUIComponentBase>)((ItemUIComponentBase item) =>
		{
			if (item is BagCharacterItemUIComponent bagCharacterItemUIComponent2)
			{
				bagCharacterItemUIComponent2.CanChose = true;
				int id2 = item.ItemUnifier.As<Character>().Id;
				bagCharacterItemUIComponent2.SetShowIndex(quickSelectCharacters.IndexOf(id2) + 1);
			}
		}));
		_bag.SelectMode = CommonScrollBagComponent.SelectModeType.MultipleUnique;
		_bag.ItemShowType = ItemUIComponentBase.InitType.CharacterViewBagCharacter;
		_bag.CountShowType = ItemUIComponentBase.ItemCountShowType.OneSide;
		ItemUnifierProxy.ItemUnifierPool.Release(_itemUnifierProxys);
		ItemUnifierProxy.ItemUnifierPool.GetList(CharacterDataHelper.GetBagCharacters(), _itemUnifierProxys);
		_itemUnifierProxys.Sort((ItemUnifierProxy x, ItemUnifierProxy y) => ShowCharacterSort(x.As<Character>(), y.As<Character>()));
		_bag.ItemSource = _itemUnifierProxys;
		_bag.ForceUpdatePerformance();
		for (int num = 0; num < quickSelectCharacters.Count; num++)
		{
			int id = quickSelectCharacters[num];
			if (id != 0)
			{
				_bag.AddSelectedModelWithoutNotify(_itemUnifierProxys.FirstOrDefault((ItemUnifierProxy x) => x.Id == id));
			}
		}
		foreach (ItemUnifierProxy selectedModel in _bag.SelectedModels)
		{
			BagCharacterItemUIComponent bagCharacterItemUIComponent = selectedModel.Context as BagCharacterItemUIComponent;
			if (bagCharacterItemUIComponent != null)
			{
				bagCharacterItemUIComponent.IsChosen = true;
			}
		}
		_bag.Station = Station;
		RefreshGamePadTips(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
		RefreshGamePadFocus(refocus: false);
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		RefreshGamePadTips(type == DeviceInputMode.Gamepad);
	}

	private void RefreshGamePadTips(bool active)
	{
		if (!(_gamePadTips == null))
		{
			_gamePadTips.gameObject.SetActive(active);
			_gamePadTips.ClearAllPrompts();
			if (active)
			{
				_gamePadTipsActions.Clear();
				_gamePadTipsActions.Add(new GamePadTipsAction
				{
					inputAction = "UI/Confirm",
					localizeKey = 13,
					localizeTable = "Common"
				});
				_gamePadTipsActions.Add(new GamePadTipsAction
				{
					inputAction = "UI/Back",
					localizeKey = 606,
					localizeTable = "Common"
				});
				_gamePadTips.RegisterInputActions(_gamePadTipsActions);
			}
		}
	}

	public void RefreshGamePadFocus(bool refocus = true)
	{
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			if (refocus)
			{
				_gamePadControlLayer?.ReFocus();
			}
			else
			{
				_gamePadControlLayer?.Focus();
			}
		}
	}

	private int ShowCharacterSort(Character x, Character y)
	{
		List<int> list = quickSelectCharacters;
		int num = list?.IndexOf(x.Id) ?? (-1);
		int num2 = list?.IndexOf(y.Id) ?? (-1);
		if (num == -1 && num2 != -1)
		{
			return 1;
		}
		if (num != -1 && num2 == -1)
		{
			return -1;
		}
		if (num >= 0 && num2 >= 0)
		{
			return num - num2;
		}
		if (x.Level != y.Level)
		{
			return y.Level - x.Level;
		}
		if (x.GetQuality() != y.GetQuality())
		{
			return y.GetQuality() - x.GetQuality();
		}
		if (x.Stage != y.Stage)
		{
			return y.Stage - x.Stage;
		}
		return x.Id - y.Id;
	}

	private void QuickChooseCharacter(BagCharacterItemUIComponent item)
	{
		int id = item.ItemUnifier.As<Character>().Id;
		List<int> list = quickSelectCharacters;
		if (list.IndexOf(id) != -1)
		{
			_bag.SelectedModels.Remove(item.ItemUnifier);
			return;
		}
		int num = list.IndexOf(0);
		if (num == -1)
		{
			_bag.SelectedModels.Remove(item.ItemUnifier);
			GameUtility.OpenToolTip(LocalizationCommonData.CommonString.TeamCharacterIsFull);
		}
		else
		{
			list[num] = id;
			item.SetShowIndex(num + 1);
		}
	}

	protected override void Init()
	{
		base.Init();
		if (_elementRoot != null)
		{
			_elementRoot.gameObject.SetActive(value: false);
		}
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

	public void CloseByGamePad()
	{
		_closeBtn.OnSubmit(null);
	}

	public void SaveByGamePad()
	{
		_saveBtn.OnSubmit(null);
	}

	private void SaveBtnEvent()
	{
		List<int> showCharacterIds = new List<int>();
		for (int i = 0; i < quickSelectCharacters.Count; i++)
		{
			int item = quickSelectCharacters[i];
			showCharacterIds.Add(item);
		}
		G.service.ChangeShowCharacter(showCharacterIds, (bool changed) =>
		{
			if (changed)
			{
				EscInfo escInfo = G.localPlayer?.Profile?.EscInfo;
				if (escInfo != null)
				{
					escInfo.ShowCharacterIds.Clear();
					escInfo.ShowCharacterIds.AddRange(showCharacterIds);
				}
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.ChangeShowCharacter, null);
				Close();
			}
		});
	}

	protected override void UnInit()
	{
		RefreshGamePadTips(active: false);
		_gamePadControlLayer?.UnFocus();
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
		base.Close();
	}
}
