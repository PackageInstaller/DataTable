using System;
using System.Threading;
using Bamboo.ImageCenter;
using Lumin.LoungeSystem;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class LoungeInteractBtn : Selectable, IPointerDownHandler, IEventSystemHandler, IPointerUpHandler, IPointerClickHandler
{
	public ActButton specialButton;

	public ActButton normalButton;

	public GameObject specialChat;

	public GameObject specialStory;

	public BImage iconType;

	public TextMeshProUGUI text;

	public LocalizeStringEvent localizeStringEvent;

	public CancellationTokenSource CTS;

	public float duration = 0.2f;

	public RectTransform rectTransform;

	public Animator anim;

	[Tooltip("A键")]
	public OperateBtnPrompt operateBtnPromptA;

	private bool _gamepadPromptInited;

	private ImageAssetStation _imageAssetStation;

	public bool controlAllBtnAnim { get; set; }

	public event Action pointerClick;

	private new void Awake()
	{
		rectTransform = GetComponent<RectTransform>();
	}

	public void Initialize(LoungeDefine.InteractionType interactionType, ImageAssetStation imageAssetStation)
	{
		_imageAssetStation = imageAssetStation;
		switch (interactionType)
		{
		case LoungeDefine.InteractionType.PersonalStory:
		case LoungeDefine.InteractionType.Chat:
			SetActiveButton(0);
			SetSpecialType(interactionType);
			break;
		case LoungeDefine.InteractionType.Gift:
		case LoungeDefine.InteractionType.BackToMain:
		case LoungeDefine.InteractionType.Touch:
			SetActiveButton(1);
			break;
		}
		if (normalButton.gameObject.activeSelf)
		{
			_imageAssetStation.LoadImage(185, (int)interactionType, iconType);
		}
	}

	public ActButton GetActiveButton()
	{
		if (specialButton.gameObject.activeSelf)
		{
			return specialButton;
		}
		return normalButton;
	}

	public void SetActiveButton(int index)
	{
		specialButton.gameObject.SetActive(index == 0);
		normalButton.gameObject.SetActive(index == 1);
	}

	public void SetSpecialType(LoungeDefine.InteractionType interactionType)
	{
		specialChat.SetActive(interactionType == LoungeDefine.InteractionType.Chat);
		specialStory.SetActive(interactionType == LoungeDefine.InteractionType.PersonalStory);
	}

	private void EnsureGamepadPromptInitialized()
	{
		if (!_gamepadPromptInited && !(operateBtnPromptA == null))
		{
			_gamepadPromptInited = true;
			operateBtnPromptA.SetBindingAction("UI/Confirm");
			operateBtnPromptA.SetLocalizeString(0);
		}
	}

	public void RefreshGamepadPromptA(bool visible)
	{
		if (!(operateBtnPromptA == null))
		{
			EnsureGamepadPromptInitialized();
			operateBtnPromptA.SetVisible(visible);
			if (visible)
			{
				operateBtnPromptA.RefreshIcon();
			}
		}
	}

	public new virtual void OnPointerDown(PointerEventData eventData)
	{
	}

	public new virtual void OnPointerUp(PointerEventData eventData)
	{
	}

	public virtual void OnPointerClick(PointerEventData eventData)
	{
		if (eventData.button == PointerEventData.InputButton.Left)
		{
			pointerClick?.Invoke();
		}
	}

	protected override void OnDisable()
	{
		pointerClick = null;
		controlAllBtnAnim = false;
		RefreshGamepadPromptA(visible: false);
		base.OnDisable();
	}
}
