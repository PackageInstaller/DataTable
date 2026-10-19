using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.UI.InputController;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class CharacterSkinView : BaseUIView<CharacterSkinViewInputController>
{
	public ActToggleGroup toggleGroup;

	public GameObject TabSkin;

	public GameObject TabDecoration;

	public GameObject UIRoot;

	public SubSkinView SkinView;

	public DecorationView DecorationView;

	public ActButton BtnHideUI;

	public List<GameObject> gamepadTips;

	private CharacterSkinViewData m_data;

	public SkinSubType CurrentSubView;

	private bool isHide;

	private bool isHaveDecoration;

	private bool isInitializingSubView;

	private string SwitchPageUpAction = "UI/SwitchPageUp";

	private string SwitchPageDownAction = "UI/SwitchPageDown";

	public bool IsHideUI => isHide;

	public override async UniTask PreInit()
	{
		await base.PreInit();
		isHide = false;
		m_data = uiViewData as CharacterSkinViewData;
		await Singleton<UISceneManager>.instance.LoadScene<CharacterSkinViewScene>(GameLoader.meta.characterSkinViewSceneReferenceAssetID.GUID);
		SkinView.onClose = Close;
		DecorationView.onClose = Close;
		BtnHideUI.SetBtnClick(OnHideUI);
		isHaveDecoration = m_data.FormType != OpenForm.Shop && CheckIsHaveDecoration(m_data.RoleId);
	}

	private bool CheckIsHaveDecoration(int RoleId)
	{
		foreach (KeyValuePair<int, EffectDress> item in RuntimeConfigs.data.effectDresss)
		{
			if (item.Value.roleid == RoleId)
			{
				return true;
			}
		}
		return false;
	}

	private void OnHideUI()
	{
		isHide = !isHide;
		UIRoot.SetActive(!isHide);
		toggleGroup.gameObject.SetActive(!isHide);
	}

	protected override void AddEventListener()
	{
		base.AddEventListener();
		MonoECS.instance.onInputModeChange.AddListener(OnControllerStatusChange);
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void OnMoveToShow()
	{
		Singleton<UISceneManager>.instance.OpenScene<CharacterSkinViewScene>();
	}

	protected override void OnMoveToHide()
	{
		Singleton<UISceneManager>.instance.CloseScene<CharacterSkinViewScene>();
	}

	protected override void Init()
	{
		base.Init();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Role/Cloth/Open");
		if (m_data != null)
		{
			CurrentSubView = m_data.DefaultSubType;
		}
		CharacterSkinViewScene.Default.ToType(CurrentSubView);
		InitGamepad();
		InitToggleGroup();
	}

	private void InitGamepad()
	{
		SetScatteredGamepadTipsVisible(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
	}

	private void InitToggleGroup()
	{
		SkinView.gameObject.SetActive(value: false);
		DecorationView.gameObject.SetActive(value: false);
		toggleGroup.SetToggleOnCall(0, OnSelectTab);
		toggleGroup.SetToggleOnCall(1, OnSelectTab);
		isInitializingSubView = true;
		try
		{
			toggleGroup.Init((int)CurrentSubView);
		}
		finally
		{
			isInitializingSubView = false;
		}
		TabDecoration.gameObject.SetActive(isHaveDecoration);
	}

	private void OnSelectTab(int index)
	{
		if (index != 1 || isHaveDecoration)
		{
			SwitchSubView((SkinSubType)index, isInitializingSubView);
		}
	}

	private void SwitchSubView(SkinSubType subType, bool isInit)
	{
		CurrentSubView = subType;
		if (!isInit && CharacterDataHelper.TryGetBagCharacterById(m_data.RoleId, out var character))
		{
			m_data.SkinId = character.SkinId;
			CharacterSkinViewScene.Default?.ChangeCharacterModel(m_data.RoleId, character, character.GetCharacterSkinId());
		}
		CharacterSkinViewScene.Default?.SwitchSub(subType, m_data.RoleId);
		switch (subType)
		{
		case SkinSubType.Skin:
			if (DecorationView.IsInited)
			{
				DecorationView.UnInit(isClose: false);
			}
			SkinView.Init(m_data, isInit);
			break;
		case SkinSubType.Decoration:
			if (SkinView.IsInited)
			{
				SkinView.UnInit(isClose: false);
			}
			DecorationView.Init(m_data, isInit);
			break;
		}
	}

	public void SwitchTabUp()
	{
		SwitchTabByOffset(-1);
	}

	public void SwitchTabDown()
	{
		SwitchTabByOffset(1);
	}

	private void SwitchTabByOffset(int offset)
	{
		if (isHide)
		{
			return;
		}
		int length = Enum.GetValues(typeof(SkinSubType)).Length;
		for (int i = (int)(CurrentSubView + offset); i >= 0 && i < length; i += offset)
		{
			SkinSubType subType = (SkinSubType)i;
			if (IsTabAvailable(subType))
			{
				toggleGroup.SetToggleOn(i);
				break;
			}
		}
	}

	private bool IsTabAvailable(SkinSubType subType)
	{
		if (subType == SkinSubType.Decoration)
		{
			return isHaveDecoration;
		}
		return true;
	}

	protected override void UnInit()
	{
		if (SkinView.IsInited)
		{
			SkinView.UnInit();
		}
		if (DecorationView.IsInited)
		{
			DecorationView.UnInit();
		}
		CharacterSkinViewScene.Default?.SetGamepadModelControlEnabled(enabled: false);
		base.UnInit();
	}

	protected override void CloseComplete()
	{
		Singleton<UISceneManager>.instance.ReleaseScene<CharacterSkinViewScene>();
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
		MonoECS.instance.onInputModeChange.RemoveListener(OnControllerStatusChange);
	}

	protected override void OnPopStack()
	{
		Singleton<UISceneManager>.instance.GetScene<CharacterSkinViewScene>().ResetCharcterAni();
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

	private void OnControllerStatusChange(DeviceInputMode deviceInputMode)
	{
		if (EventSystemHelper.Available)
		{
			EventSystemHelper.SetSelectedGameObject(null);
		}
		SetScatteredGamepadTipsVisible(deviceInputMode == DeviceInputMode.Gamepad);
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
				string bindingAction = gamepadTip.GetComponent<OperateBtnPrompt>().GetBindingAction();
				if (bindingAction == SwitchPageUpAction || bindingAction == SwitchPageDownAction)
				{
					gamepadTip.SetActive(visible && isHaveDecoration);
				}
				else
				{
					gamepadTip.SetActive(visible);
				}
			}
		}
	}
}
