using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Model.Jump;
using ACT.UI.CommonComponent;
using ACT.UI.CommonComponent.CoinComponent;
using ACT.UI.InputController;
using ACT.Utility;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class SubSkinView : SubUIViewBase<SkinSubInputController>
{
	public ActButton BtnClose;

	public GameObject UIRoot;

	public Transform TfSkinPrefab;

	public GameObject SkinPrefab;

	public LocalizeStringEvent TextName;

	public BImage ExtraRewardIcon;

	public LocalizeStringEvent TextDescription;

	public GameObject GoPrice;

	public CommonPriceComponent PriceComponent;

	public ActButton BtnBuy;

	public GameObject GoEquip;

	public ActButton BtnJumpShop;

	public ActButton BtnSwitch;

	public GameObject GoHaved;

	public GameObject GoActivity;

	public GameObject GoCoinRoot;

	public GameObject GoCharacterNoHave;

	public List<GameObject> gamepadTips;

	public GamePadTipsComp gamePadTipsComp;

	public RightStickScrollSupport RightStickScrollSupport;

	private CharacterSkinViewData m_data;

	private SkinItem _lastSelectSkinItem;

	private Character _character;

	private readonly List<SkinItem> _skinItems = new List<SkinItem>();

	private bool isHide;

	private bool _characterIsHave;

	private bool isFocusInText;

	public bool IsFocusInText => isFocusInText;

	private bool isGamepadFocusInText
	{
		get
		{
			if (isFocusInText)
			{
				return MonoECS.instance.IsGamePadMode();
			}
			return false;
		}
	}

	public bool IsGamepadFocusInText => isGamepadFocusInText;

	protected override void OnInit(object param)
	{
		_lastSelectSkinItem = null;
		m_data = param as CharacterSkinViewData;
		isHide = false;
		isFocusInText = false;
		BindButtons();
		RegisterEvents();
		if (CharacterDataHelper.TryGetBagCharacterById(m_data.RoleId, out var character))
		{
			_character = character;
		}
		InitSceneAndPanelAsync().Forget();
	}

	private void BindButtons()
	{
		BtnClose.SetBtnClick(Close);
		BtnBuy.SetBtnClick(OnBuy);
		BtnSwitch.SetBtnClick(OnSwitch);
		BtnJumpShop.SetBtnClick(OnJumpShop);
		GoActivity.GetComponent<ActButton>().SetBtnClick(OnJumpActivity);
	}

	private async UniTaskVoid InitSceneAndPanelAsync()
	{
		InitPanel();
		InitGamepad();
	}

	protected override void OnUnInit()
	{
		UnregisterEvents();
		CharacterSkinViewScene.Default?.SetGamepadModelControlEnabled(enabled: false);
	}

	protected override void OnCloseAnimationComplete()
	{
		base.OnCloseAnimationComplete();
	}

	public void Close()
	{
		if (!(ParentUIView is CharacterSkinView characterSkinView) || !characterSkinView.TryRestoreHideUI())
		{
			if (IsGamepadFocusInText)
			{
				InFocusInText(visible: false);
				return;
			}
			UnInit();
			onClose?.Invoke();
		}
	}

	private void RegisterEvents()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.AddSkin, OnAddSkin);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.SwitchSkin, OnSwitchSkin);
		MonoECS.instance.onInputModeChange.AddListener(OnControllerStatusChange);
	}

	private void UnregisterEvents()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.AddSkin, OnAddSkin);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.SwitchSkin, OnSwitchSkin);
		MonoECS.instance.onInputModeChange.RemoveListener(OnControllerStatusChange);
	}

	private void OnJumpActivity()
	{
		if (_lastSelectSkinItem.SkinData.skinType == 2)
		{
			RuntimeJumpData runTimeJumpData = ItemJumpHelper.GetRunTimeJumpData(_lastSelectSkinItem.SkinData.skinJump);
			JumpResult jumpResult = Model<JumpModel>.Interface.CanJump(runTimeJumpData);
			if (jumpResult.ShowType != JumpResult.JumpShowType.CanJump)
			{
				jumpResult.Release();
				return;
			}
			Model<JumpModel>.Interface.JumpTo(runTimeJumpData);
			jumpResult.Release();
		}
	}

	private void OnHideUI()
	{
		isHide = !isHide;
		UIRoot.SetActive(!isHide);
		RefreshGamepadVisible();
	}

	private void OnJumpShop()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_SHOP, new ShopViewData
		{
			FirstTabID = 3
		});
	}

	private void SetState()
	{
	}

	private void InitPanel()
	{
		UIRoot.SetActive(!isHide);
		CreateSkinItem();
	}

	private void CreateSkinItem()
	{
		_skinItems.Clear();
		if (TfSkinPrefab.childCount > 0)
		{
			TfSkinPrefab.DestroyChildren();
		}
		List<Skin> characterSkins = GetCharacterSkins();
		int num = ((m_data.SkinId != 0) ? m_data.SkinId : (_character?.SkinId ?? 0));
		for (int i = 0; i < characterSkins.Count; i++)
		{
			SkinItem item = UIUtility.AddWidget<SkinItem>(TfSkinPrefab, SkinPrefab);
			item.Init(characterSkins[i], Station, _character);
			_skinItems.Add(item);
			item.BtnClick.SetBtnClick(() =>
			{
				ItmeClick(item);
			});
			if (num == 0)
			{
				if (item.SkinData.skinType == 1)
				{
					ItmeClick(item, isInit: true);
				}
			}
			else if (num == item.SkinData.id)
			{
				ItmeClick(item, isInit: true);
			}
		}
	}

	private void ItmeClick(SkinItem item, bool isInit = false)
	{
		if (_lastSelectSkinItem?.SkinData.id != item.SkinData.id)
		{
			if (!isInit)
			{
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Role/Cloth/Change");
			}
			_lastSelectSkinItem?.SetSelect(isSelect: false);
			item.SetSelect(isSelect: true);
			RefreshPanel(item.SkinData, isInit);
			_lastSelectSkinItem = item;
		}
	}

	private void RefreshPanel(Skin data, bool init = false, bool isSwitch = false)
	{
		_characterIsHave = _character != null;
		bool flag = Model<SkinModel>.Interface.CheckSkinIsHave(data.id);
		bool flag2 = false;
		bool flag3 = false;
		bool flag4 = data.skinType == 3 && !flag && m_data.FormType == OpenForm.Shop;
		bool active = data.skinType == 3 && !flag && m_data.FormType == OpenForm.Other;
		bool active2 = data.skinType == 2 && !flag && m_data.FormType == OpenForm.Other;
		BtnBuy.gameObject.SetActive(flag4);
		BtnJumpShop.gameObject.SetActive(active);
		TextName.StringReference.TableEntryReference = data.skinname;
		TextDescription.StringReference.TableEntryReference = data.skindetail;
		if (data.skinType == 3)
		{
			SkinShop data2 = CoreUtils.GetData(data.id, RuntimeConfigs.data.skinShops);
			if (data2 != null)
			{
				UpdatePrice(data2);
			}
		}
		if (_characterIsHave)
		{
			if (data.skinType == 1)
			{
				bool flag5 = false;
				flag5 = ((_character.SkinId != 0) ? (_character.SkinId == data.id) : (_character.SkinId == 0));
				flag2 = flag && !flag5;
				flag3 = flag & flag5;
			}
			else
			{
				flag2 = flag && _character.SkinId != data.id;
				flag3 = flag && _character.SkinId == data.id;
			}
		}
		if (!isSwitch)
		{
			if (!init)
			{
				CharacterSkinViewScene.Default.ChangeCharacterModel(m_data.RoleId, _character, data.id);
			}
			else
			{
				CharacterSkinViewScene.Default.ShowCharacterModel(m_data.RoleId, _character, data.id);
			}
		}
		GoCharacterNoHave.SetActive(!_characterIsHave && !flag4);
		BtnSwitch.gameObject.SetActive(flag2 && m_data.FormType == OpenForm.Other);
		GoEquip.SetActive(flag3 && m_data.FormType == OpenForm.Other);
		GoHaved.SetActive(flag && m_data.FormType == OpenForm.Shop && _characterIsHave);
		GoPrice.SetActive(flag4);
		GoActivity.SetActive(active2);
		GoCoinRoot.SetActive(m_data.FormType == OpenForm.Shop);
		if (!flag)
		{
			Model<SkinModel>.Interface.DispatchClickSkinEvent(m_data.RoleId, data.id, SkinModel.SkinClickStatus.Preview);
		}
	}

	private void UpdatePrice(SkinShop _skinShop)
	{
		if (PriceComponent == null)
		{
			return;
		}
		switch (_skinShop.paytype)
		{
		case 1:
		{
			ItemKv itemKv = _skinShop.itemNeed?.FirstOrDefault();
			if (itemKv != null)
			{
				PriceComponent.Init(itemKv.id, itemKv.count);
			}
			break;
		}
		case 2:
			PriceComponent.Init(Model<PayModel>.Interface.GetPrice(_skinShop.id));
			break;
		case 3:
			PriceComponent.Init();
			break;
		}
	}

	private List<Skin> GetCharacterSkins()
	{
		List<Skin> list = new List<Skin>();
		foreach (KeyValuePair<int, Skin> skin in RuntimeConfigs.data.Skins)
		{
			if (skin.Value.roleid == m_data.RoleId)
			{
				list.Add(skin.Value);
			}
		}
		return list;
	}

	private void OnSwitchSkin(BaseEventContent obj)
	{
		RefreshSkinItems();
		RefreshPanel(_lastSelectSkinItem.SkinData, init: false, isSwitch: true);
	}

	private void RefreshSkinItems()
	{
		if (TfSkinPrefab.childCount > 0)
		{
			if (CharacterDataHelper.TryGetBagCharacterById(m_data.RoleId, out var character))
			{
				_character = character;
			}
			for (int i = 0; i < TfSkinPrefab.childCount; i++)
			{
				TfSkinPrefab.GetChild(i).GetComponent<SkinItem>().SetState(_character);
			}
		}
	}

	private void OnAddSkin(BaseEventContent obj)
	{
		RefreshPanel(_lastSelectSkinItem.SkinData);
	}

	private void OnBuy()
	{
		Skin skinData = _lastSelectSkinItem.SkinData;
		Model<SkinModel>.Interface.DispatchClickSkinEvent(skinData.roleid, skinData.id, SkinModel.SkinClickStatus.GotoShop);
		if (!_characterIsHave)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTPANEL, new TextPanel.Param
			{
				commonId = 2662,
				OnConfirm = () =>
				{
					FunBuy();
				}
			});
		}
		else
		{
			FunBuy();
		}
	}

	private void FunBuy()
	{
		SkinShop data = CoreUtils.GetData(_lastSelectSkinItem.SkinData.id, RuntimeConfigs.data.skinShops);
		if (data.paytype == 1 && G.localPlayer.GetCountById(data.itemNeed[0].id) < data.itemNeed[0].count)
		{
			ShopEventTrackHelper.Dispatch(m_data.SubShopId, 5, data.id, 1);
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_JUMPTOCOSTDIAMOND);
		}
		else
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPCHARACTERSKINBUY, new PopupCharacterSkinBuyViewData
			{
				SubShopId = m_data.SubShopId,
				SkinId = _lastSelectSkinItem.SkinData.id
			});
		}
	}

	private void OnSwitch()
	{
		Model<SkinModel>.Interface.SendChangeSkin(m_data.RoleId, _lastSelectSkinItem.SkinData.id);
		int characterSkinId = G.localPlayer.GetCharacter(m_data.RoleId).GetCharacterSkinId();
		Model<SkinModel>.Interface.DispatchClickSkinEvent(m_data.RoleId, characterSkinId, SkinModel.SkinClickStatus.UnDress);
		Model<SkinModel>.Interface.DispatchClickSkinEvent(m_data.RoleId, _lastSelectSkinItem.SkinData.id, SkinModel.SkinClickStatus.Dress);
	}

	private void InitGamepad()
	{
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			SetScatteredGamepadTipsVisible(!isHide);
			if (!isHide)
			{
				ReBindBtnPrompt();
			}
		}
		else
		{
			SetScatteredGamepadTipsVisible(visible: false);
		}
		RefreshModelControlEnabled();
	}

	private void OnControllerStatusChange(DeviceInputMode deviceInputMode)
	{
		if (EventSystemHelper.Available)
		{
			EventSystemHelper.SetSelectedGameObject(null);
		}
		if (deviceInputMode != DeviceInputMode.Gamepad)
		{
			SetScatteredGamepadTipsVisible(visible: false);
			gamePadTipsComp?.ClearAllPrompts();
			RefreshModelControlEnabled();
			return;
		}
		if (isFocusInText)
		{
			InFocusInText(visible: false);
		}
		SetScatteredGamepadTipsVisible(!isHide);
		if (!isHide)
		{
			ReBindBtnPrompt();
		}
		RefreshModelControlEnabled();
	}

	private void RefreshGamepadVisible()
	{
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			SetScatteredGamepadTipsVisible(!isHide);
			if (isHide)
			{
				gamePadTipsComp?.ClearAllPrompts();
			}
			else
			{
				ReBindBtnPrompt();
			}
			RefreshModelControlEnabled();
		}
	}

	private void SetScatteredGamepadTipsVisible(bool visible)
	{
		if (gamepadTips == null)
		{
			return;
		}
		foreach (GameObject gamepadTip in gamepadTips)
		{
			if (gamepadTip != null)
			{
				gamepadTip.SetActive(visible);
			}
		}
	}

	private void ReBindBtnPrompt()
	{
		if (!(gamePadTipsComp == null))
		{
			gamePadTipsComp.ClearAllPrompts();
			GamePadTipsAction gamePadTipsAction = new GamePadTipsAction
			{
				inputAction = "UI/RSLeftRightSelect",
				localizeTable = "Common",
				localizeKey = 1327
			};
			GamePadTipsAction gamePadTipsAction2 = new GamePadTipsAction
			{
				inputAction = "UI/SwitchPageLeft",
				localizeTable = "Common",
				localizeKey = 2739
			};
			GamePadTipsAction gamePadTipsAction3 = new GamePadTipsAction
			{
				inputAction = "UI/SwitchPageRight",
				localizeTable = "Common",
				localizeKey = 2740
			};
			GamePadTipsAction gamePadTipsAction4 = new GamePadTipsAction
			{
				inputAction = "UI/RSUpDownSelect",
				localizeTable = "Common",
				localizeKey = 2741
			};
			gamePadTipsComp.RegisterInputActions(GamePadTipHelper.BackAction, gamePadTipsAction, gamePadTipsAction2, gamePadTipsAction3, gamePadTipsAction4);
		}
	}

	public void InFocusInText(bool visible)
	{
		if (isFocusInText != visible)
		{
			isFocusInText = visible;
			if (isFocusInText)
			{
				ReBindBtnPromptInFocusInText();
				GoCoinRoot.GetComponent<CommonCoinGroup>().FocusOut();
			}
			else
			{
				GoCoinRoot.GetComponent<CommonCoinGroup>().FocusIn();
				ReBindBtnPrompt();
			}
			SetScatteredGamepadTipsVisible(!isFocusInText);
			RefreshRightStickScrollSupportEnabled(isFocusInText);
		}
	}

	private void RefreshRightStickScrollSupportEnabled(bool enabled)
	{
		RightStickScrollSupport.SetEnabled(enabled);
	}

	private void ReBindBtnPromptInFocusInText()
	{
		if (!(gamePadTipsComp == null))
		{
			gamePadTipsComp.ClearAllPrompts();
			gamePadTipsComp.RegisterInputActions(GamePadTipHelper.BackAction, GamePadTipHelper.ScrollAction);
		}
	}

	public void SelectSkinByOffset(int offset)
	{
		if (!isHide && _skinItems.Count != 0)
		{
			int num = ((_lastSelectSkinItem != null) ? _skinItems.IndexOf(_lastSelectSkinItem) : (-1));
			int num2 = Mathf.Clamp(num + offset, 0, _skinItems.Count - 1);
			if (num2 >= 0 && num2 != num)
			{
				ItmeClick(_skinItems[num2]);
			}
		}
	}

	private void RefreshModelControlEnabled()
	{
		CharacterSkinViewScene characterSkinViewScene = CharacterSkinViewScene.Default;
		if (!(characterSkinViewScene == null))
		{
			bool gamepadModelControlEnabled = MonoECS.instance.InputMode == DeviceInputMode.Gamepad;
			characterSkinViewScene.SetGamepadModelControlEnabled(gamepadModelControlEnabled);
		}
	}

	public void OnGamepadConfirm()
	{
		if (!isHide)
		{
			if (BtnSwitch.gameObject.activeSelf)
			{
				BtnSwitch.OnSubmit(null);
			}
			else if (BtnBuy.gameObject.activeSelf)
			{
				BtnBuy.OnSubmit(null);
			}
			else if (BtnJumpShop.gameObject.activeSelf)
			{
				BtnJumpShop.OnSubmit(null);
			}
			else if (GoActivity.gameObject.activeSelf)
			{
				GoActivity.GetComponent<ActButton>().OnSubmit(null);
			}
		}
	}

	public void OnGamepadLessen()
	{
		Singleton<UISceneManager>.instance.GetScene<CharacterSkinViewScene>().GamepadScroll(-1f);
	}

	public void OnGamepadSpecial4()
	{
		if (MonoECS.instance.IsGamePadMode())
		{
			InFocusInText(visible: true);
		}
	}

	public void OnGamepadZoom()
	{
		Singleton<UISceneManager>.instance.GetScene<CharacterSkinViewScene>().GamepadScroll(1f);
	}

	public void ToggleHideUI()
	{
		OnHideUI();
	}

	public bool TryRestoreHideUI()
	{
		if (!isHide)
		{
			return false;
		}
		OnHideUI();
		return true;
	}
}
