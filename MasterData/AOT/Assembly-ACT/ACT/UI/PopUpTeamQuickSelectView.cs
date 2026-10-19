using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Event;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.UI.CommonComponent.CommonScrollBag;
using Runtime.Utility;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT.UI;

public class PopUpTeamQuickSelectView : BaseUIView<PopUpTeamQuickSelectViewInputController>
{
	private PopUpTeamQuickSelectViewData m_data;

	[SerializeField]
	private CommonScrollBagComponent _bag;

	[SerializeField]
	private ActButton _closeBtn;

	[SerializeField]
	private ActButton _saveBtn;

	private TeamModel _model;

	private List<ItemUnifierProxy> _itemUnifierProxys;

	[SerializeField]
	private StartList _elementRoot;

	[SerializeField]
	private GamePadTipsComp _gamePadTips;

	[SerializeField]
	[Header("手柄选择角色Layer")]
	private ViewControlLayer _gamePadControlLayer;

	private readonly List<GamePadTipsAction> _gamePadTipsActions = new List<GamePadTipsAction>();

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
		_model = Model<TeamModel>.Interface;
		m_data = uiViewData as PopUpTeamQuickSelectViewData;
		_closeBtn.SetBtnClick(Close, "event:/UI/Common/Return_Click");
		_saveBtn.SetBtnClick(SaveBtnEvent, "event:/UI/Interface/Team/FastFormation_SaveConfig");
		_model.quickSelectCharacters = Model<TeamModel>.Interface.DeepCopyArray(_model.CurSelectedTeamCharacters);
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
					int num2 = _model.quickSelectCharacters.IndexOf(id2);
					if (num2 != -1)
					{
						_model.quickSelectCharacters[num2] = 0;
						bagCharacterItemUIComponent2.UpdateTeamIndexIcon(id2);
					}
				}
			}
		}));
		_bag.SelectMode = CommonScrollBagComponent.SelectModeType.MultipleUnique;
		_bag.ItemShowType = ItemUIComponentBase.InitType.TeamViewBagCharacter;
		_bag.CountShowType = ItemUIComponentBase.ItemCountShowType.OneSide;
		ItemUnifierProxy.ItemUnifierPool.Release(_itemUnifierProxys);
		ItemUnifierProxy.ItemUnifierPool.GetList(CharacterDataHelper.GetBagCharacters(), _itemUnifierProxys);
		if (_model.source == TeamProfileSource.Temple)
		{
			_itemUnifierProxys.Sort((ItemUnifierProxy x, ItemUnifierProxy y) => SortUtility.TempleTeamCharacterSort(x.As<Character>(), y.As<Character>()));
		}
		else
		{
			_itemUnifierProxys.Sort((ItemUnifierProxy x, ItemUnifierProxy y) => SortUtility.TeamCharacterSort(x.As<Character>(), y.As<Character>()));
		}
		_bag.ItemSource = _itemUnifierProxys;
		_bag.ForceUpdatePerformance();
		for (int num = 0; num < _model.quickSelectCharacters.Length; num++)
		{
			int id = _model.quickSelectCharacters[num];
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

	private void QuickChooseCharacter(BagCharacterItemUIComponent item)
	{
		int id = item.ItemUnifier.As<Character>().Id;
		int[] quickSelectCharacters = _model.quickSelectCharacters;
		if (Array.IndexOf(quickSelectCharacters, id) != -1)
		{
			_bag.SelectedModels.Remove(item.ItemUnifier);
			return;
		}
		int num = Array.IndexOf(quickSelectCharacters, 0);
		if (num == -1)
		{
			_bag.SelectedModels.Remove(item.ItemUnifier);
			GameUtility.OpenToolTip(LocalizationCommonData.CommonString.TeamCharacterIsFull);
		}
		else
		{
			quickSelectCharacters[num] = id;
			item.UpdateTeamIndexIcon(id);
		}
	}

	protected override void Init()
	{
		base.Init();
		_elementRoot.gameObject.SetActive(_model.source == TeamProfileSource.Temple);
		if (_model.source == TeamProfileSource.Temple)
		{
			List<int> limitElements = Model<TempleModel>.Interface.GetLimitElements(_model.templeId);
			_elementRoot.SetElementActive(limitElements);
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
		if (_model.quickSelectCharacters.All((int i) => i == 0))
		{
			GameUtility.OpenToolTip(LocalizationCommonData.CommonString.MustOneCharacterInTeam);
			return;
		}
		if (_model.curSelectedIndex == _model.curBattleIndex)
		{
			bool flag = false;
			for (int num = 0; num < _model.quickSelectCharacters.Length; num++)
			{
				int num2 = _model.quickSelectCharacters[num];
				if (num2 != 0)
				{
					CharacterDataHelper.TryGetBagCharacterById(num2, out var character);
					if (character.IsRuntimeAlive())
					{
						flag = true;
						break;
					}
				}
			}
			if (!flag)
			{
				GameUtility.OpenToolTip(2302);
				return;
			}
		}
		_model.RearrangeCharactersArray(ref _model.quickSelectCharacters);
		for (int num3 = 0; num3 < _model.quickSelectCharacters.Length; num3++)
		{
			UISceneRender.instance.ResetModel(num3, _model.quickSelectCharacters[num3]);
		}
		FireEvent(_model.quickSelectCharacters);
		Close();
	}

	private void FireEvent(int[] characters)
	{
		UITeamCharChange evt = Singleton<EventManager>.instance.GetEvt<UITeamCharChange>();
		evt.charactersId = characters;
		evt.index = _model.curSelectedIndex;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Team_UIBattleCharactersChange, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_Team_UIRefresh, null);
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
		_model.InvokeQuickSelectPopClosed();
		base.Close();
	}
}
