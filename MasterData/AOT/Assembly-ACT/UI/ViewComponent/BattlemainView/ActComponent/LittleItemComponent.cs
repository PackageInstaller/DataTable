using System;
using System.Collections.Generic;
using ACT;
using ACT.Battle;
using ACT.Battle.ECS.System;
using ACT.Event;
using ACT.Model;
using ACT.MultiPlayer;
using ACT.UI;
using ACT.Utility;
using Bamboo.ECS;
using Bamboo.ImageCenter;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace UI.ViewComponent.BattlemainView.ActComponent;

public class LittleItemComponent : StateButton
{
	[Serializable]
	public class ButtonStateGoPair
	{
		public CanvasGroup canvas;
	}

	public string skillName;

	public ActButton selfBtn;

	public Image recoverUseCountCdImage;

	public Image cdMask;

	public TextMeshProUGUI cdText;

	private int maxCount = 1;

	private int nowCount = 1;

	private int maxMaxCount = 1;

	private Skill m_BindSkill;

	public List<Image> buttonStateImage;

	public GameObject PcBtnPrompts;

	public CommonNumberComponent number;

	public BImage icon;

	public BImage useCountIcon;

	private int itemId;

	private ImageAssetStation _station;

	private int m_lastRightCount;

	private int lastEquipItemId;

	private BloodBottleModel m_bloodBottleModel;

	private float _originalSize;

	[SerializeField]
	private OnScreenControlNodeBool _onScreenControlNode;

	public override void OnLoadComplete(IBaseUIView ui)
	{
		m_bloodBottleModel = Model<BloodBottleModel>.Interface;
		_originalSize = ((RectTransform)transform).sizeDelta.x;
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_UpdateCustomUIScheme, OnUpdateCustomUIScheme);
		SetTransform(Model<CustomUIModel>.Interface.GetCurScheme().PropBtnTransform);
		Init();
		selfBtn.SetBtnClick(() =>
		{
			_onScreenControlNode?.SendValue(value: true);
			UseLittleItemEntry();
			_onScreenControlNode?.SendValue(value: false);
		});
		SystemBloodBottleRecoverUseCount bloodBottleRecoverUseCountSystem = GameManager.bloodBottleRecoverUseCountSystem;
		bloodBottleRecoverUseCountSystem.OnCdDurationChanged += UpdateDisplayOnRecoverCountCd;
		bloodBottleRecoverUseCountSystem.OnCdEnd += OnRecoverCountCdEnd;
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Input_Down, OnInput);
		Model<BattleMainModel>.Interface.OnLittleItemDisabledChangeEventHandler += InterfaceOnOnLittleItemDisabledChangeEventHandler;
	}

	private void InterfaceOnOnLittleItemDisabledChangeEventHandler()
	{
		if ((bool)this && !IsDestroyed)
		{
			gameObject.SetActive(!Model<BattleMainModel>.Interface.LittleItemDisabled);
			if (!Model<BattleMainModel>.Interface.LittleItemDisabled)
			{
				SetTransform(Model<CustomUIModel>.Interface.GetCurScheme().PropBtnTransform);
			}
		}
	}

	public void Init()
	{
		UpdateLittleItemEvt curEquipBottleUIData = Model<BattleMainModel>.Interface.curEquipBottleUIData;
		itemId = curEquipBottleUIData?.itemId ?? 0;
		int num = curEquipBottleUIData?.bottleUid ?? m_bloodBottleModel.curSceneEquipBloodBottleId;
		if (_station == null)
		{
			_station = ImageManager.instance.GetAssetStation();
		}
		if (((num == m_bloodBottleModel.curSceneEquipBloodBottleId) ? m_bloodBottleModel.CurTeamEquipBottle : m_bloodBottleModel.GetBloodBottleById(num)) != null)
		{
			m_bloodBottleModel.ChangeCurEquipRightCount(m_bloodBottleModel.CurTeamEquipBottle.maxUseCount);
			CommonNumberComponent commonNumberComponent = number;
			commonNumberComponent.frontPostProcessor = (UnityAction<List<RichTagConfig>>)Delegate.Combine(commonNumberComponent.frontPostProcessor, (UnityAction<List<RichTagConfig>>)((List<RichTagConfig> frontColor) =>
			{
				if (m_bloodBottleModel.leftCount == 0)
				{
					for (int i = 0; i < frontColor.Count; i++)
					{
						RichTagConfig value = frontColor[i];
						if (value.tag == RichTextTag.TagType.Color)
						{
							ColorUtility.TryParseHtmlString("f56e71", out value.ColorValue);
							frontColor[i] = value;
							break;
						}
					}
				}
			}));
			UpdateIcon();
			UpdateNumber();
		}
		gameObject.SetActive(!Model<BattleMainModel>.Interface.LittleItemDisabled);
	}

	private void OnInput(BaseEventContent obj)
	{
		if (obj is InputEvt { inputKey: InputKey.itemShortCut })
		{
			UseLittleItemEntry();
		}
	}

	private void UpdateNumber()
	{
		if (m_bloodBottleModel.leftCount == 0)
		{
			useCountIcon.icon.fillAmount = 0f;
		}
		else if (m_bloodBottleModel.leftCount != m_bloodBottleModel.curEquipRightCount)
		{
			if (m_bloodBottleModel.leftCount >= m_bloodBottleModel.curEquipRightCount)
			{
				useCountIcon.icon.fillAmount = 1f;
				return;
			}
			useCountIcon.icon.fillAmount = (float)m_bloodBottleModel.leftCount / (float)m_bloodBottleModel.curEquipRightCount;
		}
		else
		{
			useCountIcon.icon.fillAmount = 1f;
		}
		number.UpdateNumber(m_bloodBottleModel.leftCount, m_bloodBottleModel.curEquipRightCount);
	}

	private void UpdateIcon()
	{
		if (m_lastRightCount != m_bloodBottleModel.curEquipRightCount)
		{
			m_lastRightCount = m_bloodBottleModel.curEquipRightCount;
		}
		if (lastEquipItemId != itemId)
		{
			lastEquipItemId = itemId;
		}
	}

	private void UpdateDisplayOnRecoverCountCd()
	{
		if (recoverUseCountCdImage != null)
		{
			if (!Mathf.Approximately(recoverUseCountCdImage.color.a, 1f))
			{
				recoverUseCountCdImage.color = new Color(recoverUseCountCdImage.color.r, recoverUseCountCdImage.color.g, recoverUseCountCdImage.color.b, 1f);
			}
			recoverUseCountCdImage.fillAmount = GameManager.bloodBottleRecoverUseCountSystem.RecoverCdFillAmount;
		}
	}

	private void OnRecoverCountCdEnd()
	{
		if (recoverUseCountCdImage != null && !Mathf.Approximately(recoverUseCountCdImage.color.a, 0f))
		{
			recoverUseCountCdImage.color = new Color(recoverUseCountCdImage.color.r, recoverUseCountCdImage.color.g, recoverUseCountCdImage.color.b, 0f);
		}
	}

	public override void BeforeDestroy()
	{
		if (_station != null)
		{
			ImageManager.instance.UnloadAssetStation(_station);
			_station = null;
		}
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Input_Down, OnInput);
		Station.UnloadSprite(GameLoader.meta.itemAtlasNameAssetID);
		SystemBloodBottleRecoverUseCount bloodBottleRecoverUseCountSystem = GameManager.bloodBottleRecoverUseCountSystem;
		bloodBottleRecoverUseCountSystem.OnCdDurationChanged -= UpdateDisplayOnRecoverCountCd;
		bloodBottleRecoverUseCountSystem.OnCdEnd -= OnRecoverCountCdEnd;
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_UpdateCustomUIScheme, OnUpdateCustomUIScheme);
		Model<BattleMainModel>.Interface.OnLittleItemDisabledChangeEventHandler -= InterfaceOnOnLittleItemDisabledChangeEventHandler;
	}

	public override void ChangeButtonState(StateButtonState targetState)
	{
		switch (targetState)
		{
		case StateButtonState.Normal:
			buttonStateImage?.ForEach((Image i) =>
			{
				i.color = new Color(i.color.r, i.color.g, i.color.b, 1f);
			});
			break;
		case StateButtonState.Disable:
			buttonStateImage?.ForEach((Image i) =>
			{
				i.color = new Color(i.color.r, i.color.g, i.color.b, 0.4f);
			});
			break;
		case StateButtonState.Pressed:
			break;
		}
	}

	private void Update()
	{
		if (!(Singleton<NewUIManager>.instance.GetTopActivePanel() is BattleMainUIController { State: UIState.Opened }) || MonoECS.instance == null || !Model<BloodBottleModel>.HasInstance())
		{
			return;
		}
		SystemBloodBottleRecoverUseCount bloodBottleRecoverUseCountSystem = GameManager.bloodBottleRecoverUseCountSystem;
		if (bloodBottleRecoverUseCountSystem != null && !(cdMask == null) && !(cdText == null))
		{
			if (!(bloodBottleRecoverUseCountSystem.useCdDuration > 0f))
			{
				cdMask.color = new Color(cdMask.color.r, cdMask.color.g, cdMask.color.b, 0f);
				cdMask.fillAmount = 1f;
				cdText.text = string.Empty;
				ChangeButtonState((m_bloodBottleModel.leftCount == 0) ? StateButtonState.Disable : StateButtonState.Normal);
			}
			else
			{
				ChangeButtonState(StateButtonState.Disable);
				cdMask.color = new Color(cdMask.color.r, cdMask.color.g, cdMask.color.b, 0.6f);
				cdMask.fillAmount = bloodBottleRecoverUseCountSystem.useCdDuration;
				float arg = (float)Math.Round(bloodBottleRecoverUseCountSystem.curUseCd, 1);
				cdText.SetText("{0:0.0}", arg);
			}
		}
	}

	public void SetTransform(CustomUITransform customUITransform)
	{
		if (!IsDestroyed)
		{
			RectTransform rectTransform = transform as RectTransform;
			if (!(rectTransform == null))
			{
				Vector2 anchorMin = (rectTransform.anchorMax = new Vector2(customUITransform.AnchorX, customUITransform.AnchorY));
				rectTransform.anchorMin = anchorMin;
				rectTransform.anchoredPosition = customUITransform.Pos;
				rectTransform.localScale = customUITransform.Diameter / _originalSize * Vector3.one;
			}
		}
	}

	private void OnUpdateCustomUIScheme(BaseEventContent eventContent)
	{
		if (eventContent is UpdateCustomUISchemeEvt updateCustomUISchemeEvt)
		{
			SetTransform(updateCustomUISchemeEvt.scheme.PropBtnTransform);
		}
	}

	private void UseLittleItemEntry()
	{
		if (m_bloodBottleModel.CurTeamEquipBottle != null && MPPlayer.local.battleEntity.IsAlive())
		{
			if (m_bloodBottleModel.leftCount == 0)
			{
				GameUtility.OpenToolTip(1154);
				return;
			}
			if (GameManager.bloodBottleRecoverUseCountSystem.curUseCd > 0f)
			{
				GameUtility.OpenToolTip(1153);
				return;
			}
			Singleton<BloodBottleHandler>.instance.UseBloodBottle();
			GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.UseBloodBottle);
			UpdateNumber();
		}
	}
}
