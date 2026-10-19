using System;
using System.Collections.Generic;
using ACT.CharacterProperty;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.Model;
using ACT.Sound;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Serialization;
using UnityEngine.UI;

namespace ACT.UI;

public class CvEquipment : SubUIView<CvEquipmentSubInputController>, ICharacterSubView, ISubUIView, IBaseUIComponent
{
	public EquipItemGroup equipItemGroup;

	[FormerlySerializedAs("equipPropertyChipComponent")]
	public EquipPropertyEquipComponent equipPropertyEquipComponent;

	[SerializeField]
	private RectTransform m_ItemGroupRoot;

	private Character m_Character;

	private CvOverview m_Overview;

	private bool isTrialCharacter;

	public GamePadTipsComp gamePadGroup;

	private Dictionary<string, GamePadTipsAction> _allInputPrompt;

	private List<GamePadTipsAction> _tipsActions;

	public EquipBuffDetail equipBuffDetail;

	public ScrollRect ActiveDescScrollRect;

	private bool _afterAnimation;

	private bool m_canRightStickScroll = true;

	public RightStickScrollSupport RightStickScrollSupport;

	public CharacterView CharacterView { get; private set; }

	public int DefaultEquipIndex { get; set; } = -1;

	public int Depth => 1;

	public ICharacterSubView lastSubView { get; set; }

	public CharacterViewScene.CvSceneType SceneType => CharacterViewScene.CvSceneType.Equipment;

	public new object Context { get; set; }

	public bool AfterAnimation
	{
		get
		{
			return _afterAnimation;
		}
		set
		{
			_afterAnimation = value;
			if (value)
			{
				((ICharacterSubView)this).SendAfterAnimationEvent();
			}
		}
	}

	public void Init(CharacterView characterView)
	{
		CharacterView = characterView;
	}

	protected void Init(ICharacterSource characterSource)
	{
		if (DefaultEquipIndex != -1)
		{
			SendCharacterInJump(isinjump: true);
		}
		gameObject.SetActive(value: true);
		m_Character = (characterSource as Character) ?? CharacterDataHelper.GetCharacterByCharacterSource(characterSource);
		equipItemGroup.transform.SetParent(m_ItemGroupRoot, worldPositionStays: false);
		equipItemGroup.InitData(OpenEquipView);
		equipItemGroup.SetHoverEnabled(enabled: true);
		equipItemGroup.Open(m_Character);
		equipItemGroup.Refresh(m_Character);
		if (!(lastSubView is EquipmentSubView))
		{
			equipItemGroup.PlayAnimation("Show");
		}
		else
		{
			equipItemGroup.PlayAnimation("SubviewHide");
			lastSubView = null;
		}
		AfterAnimation = true;
		equipPropertyEquipComponent.Open(m_Character);
		if (m_Overview == null)
		{
			m_Overview = ((CharacterView)Context).GetComponentInChildren<CvOverview>(includeInactive: true);
		}
		equipPropertyEquipComponent.RefreshOverview(m_Overview.PropertyList, SystemPropertySource.Equip);
		OnGamePadInit();
		RefreshRightStickScrollForbid();
		ReBindBtnPrompt();
	}

	public void OpenEquipView(int index)
	{
		if (isTrialCharacter)
		{
			GameUtility.OpenToolTip(1814);
			return;
		}
		((CharacterView)Context).OpenEquipSubViewExternal(new EquipmentSubView.EquipData
		{
			selectedIndex = index,
			characterView = (CharacterView)Context
		});
		GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.EquipClick);
		equipItemGroup.PlayAnimation("SubviewShow", (AnimationBuilder _) =>
		{
			gameObject.SetActive(value: false);
		});
	}

	public async void ClickPropertyDetail()
	{
	}

	public void Show(int characterId, ImageAssetStation station, ICharacterSource characterSource)
	{
		isTrialCharacter = characterSource.IsTrailCharacter;
		AfterAnimation = false;
		Init(characterSource);
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Equip/Open", new AudioPlayOptions
		{
			attachTarget = transform
		});
		FocusIn();
		CharacterView.equipmentSubView.FocusOut();
	}

	public void Hide()
	{
		AfterAnimation = false;
		try
		{
			DefaultEquipIndex = -1;
			CharacterViewScene.Default.OverrideAnimationName = null;
			equipItemGroup.PlayAnimation("Hide", (AnimationBuilder _) =>
			{
				gameObject.SetActive(value: false);
			});
			FocusOut();
		}
		catch (Exception exception)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(exception);
			}
		}
	}

	public void Freeze()
	{
		gameObject.SetActive(value: false);
	}

	public void UnFreeze(int characterId)
	{
		gameObject.SetActive(value: true);
	}

	public void OnSelectCharacter(ICharacterSource characterSource)
	{
		isTrialCharacter = characterSource.IsTrailCharacter;
		Init(characterSource);
	}

	private void SendCharacterInJump(bool isinjump)
	{
		CharacterJumpToEquipEvent evt = Singleton<EventManager>.instance.GetEvt<CharacterJumpToEquipEvent>();
		evt.isinjump = isinjump;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_CharacterJumpToEquip, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	private void RefreshRightStickScrollForbid()
	{
		ScrollRect activeDescScrollRect = ActiveDescScrollRect;
		RightStickScrollSupport rightStickScrollSupport = RightStickScrollSupport;
		if (!(rightStickScrollSupport == null) && !(activeDescScrollRect == null))
		{
			Canvas.ForceUpdateCanvases();
			if (activeDescScrollRect.content != null)
			{
				LayoutRebuilder.ForceRebuildLayoutImmediate(activeDescScrollRect.content);
			}
			bool flag = activeDescScrollRect.content != null && activeDescScrollRect.viewport != null && activeDescScrollRect.content.rect.height > activeDescScrollRect.viewport.rect.height;
			rightStickScrollSupport.SetForbidScroll(!flag);
			m_canRightStickScroll = flag;
		}
	}

	private void OnGamePadInit()
	{
		_allInputPrompt = new Dictionary<string, GamePadTipsAction>();
		_allInputPrompt["UI/RSUpDownSelect"] = new GamePadTipsAction
		{
			inputAction = "UI/RSUpDownSelect",
			localizeKey = 2165,
			localizeTable = "Common"
		};
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
		List<GamePadTipsAction> tipsActions = _tipsActions;
		if (tipsActions == null || tipsActions.Count <= 0)
		{
			_tipsActions = new List<GamePadTipsAction>();
		}
		gamePadGroup.ClearAllPrompts();
		_tipsActions.Clear();
		_tipsActions.Add(_allInputPrompt["UI/Confirm"]);
		_tipsActions.Add(_allInputPrompt["UI/Back"]);
		if (m_canRightStickScroll)
		{
			_tipsActions.Add(_allInputPrompt["UI/RSUpDownSelect"]);
		}
		gamePadGroup.RegisterInputActions(_tipsActions);
	}

	public void OnConfirm()
	{
		equipItemGroup.BtnClick();
	}

	public void OnNavigate(MoveDirection value)
	{
		if (value == MoveDirection.Up || value == MoveDirection.Right)
		{
			equipItemGroup.TurnToPrevious();
		}
		else
		{
			equipItemGroup.TurnToNext();
		}
	}

	public void OnScrollbarNavigate(Vector2 value)
	{
		if (m_canRightStickScroll)
		{
			ScrollRect activeDescScrollRect = ActiveDescScrollRect;
			if (!(activeDescScrollRect == null))
			{
				activeDescScrollRect.velocity = new Vector2(0f, value.y * ActiveDescScrollRect.scrollSensitivity);
			}
		}
	}
}
