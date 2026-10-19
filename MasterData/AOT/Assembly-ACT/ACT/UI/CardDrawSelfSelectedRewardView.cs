using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Sound;
using ACT.UI.DataProxy;
using ACT.Utility;
using Bamboo.Chronos;
using Bamboo.NumberString;
using Cysharp.Threading.Tasks;
using Fundamental;
using Pb;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class CardDrawSelfSelectedRewardView : BaseUIView<CardDrawSelfSelectedRewardViewController>
{
	private CardDrawSelfSelectedRewardViewData m_data;

	public ActButton BtnClose;

	public Transform TfCharacterCard;

	public GameObject CharacterCardPrefab;

	public ScrollRect CharacterCardScrollRect;

	public TextMeshProUGUI TextResidentoptionalRewardCurrentAndTargetNum;

	public ActButton BtnBtnResidentoptionalRewardGift;

	public ActButton BtnCharacterTrial;

	public GamePadTipsComp gamePadTips;

	private Dictionary<string, GamePadTipsAction> _inputActionDic;

	private List<GamePadTipsAction> _tipsActions;

	private Gacha CurrentCardPool;

	private int SelectResidentoptionalRewardId;

	private int SelectResidentoptionalGachaItemId;

	private List<CardDrawSelfSelectedRewardItem> ListCharacterCard = new List<CardDrawSelfSelectedRewardItem>();

	private int m_selectedCardIndex;

	private const float CharacterCardNavigateHoldDelay = 0.3f;

	private const float CharacterCardNavigateRepeatInterval = 0.15f;

	private ContinuousNavigateData m_characterCardNavigateData;

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
		m_data = uiViewData as CardDrawSelfSelectedRewardViewData;
		CurrentCardPool = CoreUtils.GetData(m_data.GaChaId, RuntimeConfigs.data.gachas);
		BtnBtnResidentoptionalRewardGift.SetBtnClick(OnBtnRwd, "event:/UI/Interface/DrawCard/Check");
		BtnClose.SetBtnClick(Close, "event:/UI/Common/Popup_Close");
		BtnCharacterTrial.SetBtnClick(OnBtnCharacterTrial, "event:/UI/Interface/DrawCard/Tryout");
		OnGamePadInit();
		await base.PreInit();
	}

	protected override void Init()
	{
		base.Init();
		InitData();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Window", new AudioPlayOptions
		{
			attachTarget = transform
		});
		ResidentoptionalRewardViewReset();
		ReBindBtnPrompt();
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		if (type != DeviceInputMode.TouchScreen)
		{
			OnDeviceChange(type);
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

	protected override void UnInit()
	{
		m_characterCardNavigateData?.Reset();
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

	private void OnGamePadInit()
	{
		_inputActionDic = new Dictionary<string, GamePadTipsAction> { ["UI/Back"] = new GamePadTipsAction
		{
			inputAction = "UI/Back",
			localizeKey = 606,
			localizeTable = "Common"
		} };
	}

	private void OnDeviceChange(DeviceInputMode type)
	{
		switch (type)
		{
		case DeviceInputMode.Gamepad:
			ReBindBtnPrompt();
			break;
		case DeviceInputMode.KeyboardAndMouse:
			gamePadTips?.ClearAllPrompts();
			_tipsActions?.Clear();
			break;
		}
	}

	private void ReBindBtnPrompt()
	{
		if (!(gamePadTips == null) && _inputActionDic != null)
		{
			List<GamePadTipsAction> tipsActions = _tipsActions;
			if (tipsActions == null || tipsActions.Count <= 0)
			{
				_tipsActions = new List<GamePadTipsAction>();
			}
			gamePadTips.ClearAllPrompts();
			_tipsActions.Clear();
			_tipsActions.Add(_inputActionDic["UI/Back"]);
			gamePadTips.RegisterInputActions(_tipsActions);
		}
	}

	private void ResidentoptionalRewardViewReset()
	{
		int currentPoolCountForNotExchangeFinalGuaranteed = Model<CardDrawModel>.Interface.GetCurrentPoolCountForNotExchangeFinalGuaranteed(CurrentCardPool.gachaType);
		bool currentFinalGuaranteed = Model<CardDrawModel>.Interface.GetCurrentFinalGuaranteed(CurrentCardPool.gachaType);
		currentFinalGuaranteed = !CurrentCardPool.isFinalGuarantRepeatable && currentFinalGuaranteed;
		bool flag = currentPoolCountForNotExchangeFinalGuaranteed >= CurrentCardPool.finalGuarantNum;
		TextMeshProUGUI textResidentoptionalRewardCurrentAndTargetNum = TextResidentoptionalRewardCurrentAndTargetNum;
		string text = currentPoolCountForNotExchangeFinalGuaranteed.ToString();
		int finalGuarantNum = CurrentCardPool.finalGuarantNum;
		textResidentoptionalRewardCurrentAndTargetNum.text = text + "/" + finalGuarantNum;
		bool flag2 = !currentFinalGuaranteed & flag;
		BtnBtnResidentoptionalRewardGift.Interactable(flag2);
		Singleton<GameInputActionManager>.instance.SetActionBlacklist(GetInputBindingController(), "UI/UISpecial1", !flag2);
	}

	private void InitData()
	{
		List<GachaItem> list = new List<GachaItem>();
		for (int i = 0; i < CurrentCardPool.finalGuarantPool.Length; i++)
		{
			GachaPool data = CoreUtils.GetData(CurrentCardPool.finalGuarantPool[i], RuntimeConfigs.data.gachaPools);
			if (data == null)
			{
				continue;
			}
			for (int j = 0; j < data.gachaItemIDs.Length; j++)
			{
				GachaItem data2 = CoreUtils.GetData(data.gachaItemIDs[j], RuntimeConfigs.data.gachaItems);
				if (data2 != null)
				{
					list.Add(data2);
				}
			}
		}
		ListCharacterCard.Clear();
		if (TfCharacterCard.childCount > 0)
		{
			TfCharacterCard.DestroyChildren();
		}
		for (int k = 0; k < list.Count; k++)
		{
			CardDrawSelfSelectedRewardItem cardDrawSelfSelectedRewardItem = UIUtility.AddWidget<CardDrawSelfSelectedRewardItem>(TfCharacterCard, CharacterCardPrefab);
			cardDrawSelfSelectedRewardItem.Init(list[k], Station);
			ListCharacterCard.Add(cardDrawSelfSelectedRewardItem);
			int cardIndex = k;
			cardDrawSelfSelectedRewardItem.BtnClick.SetBtnClick(() =>
			{
				SelectCardByIndex(cardIndex);
			}, "event:/UI/Interface/DrawCard/RoleChoise");
		}
		if (ListCharacterCard.Count > 0)
		{
			SelectCardByIndex(0);
		}
	}

	public void OnBtnRwd()
	{
		ReportGachaClick();
		if (SelectResidentoptionalRewardId == 0)
		{
			return;
		}
		ItemData data = CoreUtils.GetData(SelectResidentoptionalRewardId, RuntimeConfigs.data.itemDatas);
		TextPanel.Param param = new TextPanel.Param();
		int id = data.canBeTransited[0].id;
		EntityCharacterData data2 = CoreUtils.GetData(id, RuntimeConfigs.data.entityCharacterDatas);
		if (Model<DestinyModel>.Interface.GetCharacterCouldGetDestinyCost(id))
		{
			param.commonId = 1763;
			param.texts = new string[1] { LocalizationUtility.GetLocalizeString("shortcommon", data.nameLocal) };
			param.OnConfirm = () =>
			{
				SendRwd();
			};
		}
		else
		{
			int value = ((data2.stars == 4) ? RuntimeConfigs.data.game.gachaDraw4StarDestinedNum : RuntimeConfigs.data.game.gachaDraw5StarDestinedNum);
			param.commonId = 2148;
			param.texts = new string[1] { value.FastToString() };
			param.OnConfirm = () =>
			{
				SendRwd();
			};
		}
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTPANEL, param);
	}

	public void SendRwd()
	{
		Model<CardDrawModel>.Interface.SendGachaExchangeFinalGuaranteed(CurrentCardPool.id, SelectResidentoptionalGachaItemId, (GachaExchangeFinalGuaranteedAck OnCardDrawBack) =>
		{
			List<Item> list = new List<Item> { OnCardDrawBack.GotItem };
			List<ItemUnifierProxy> tempList = ListPool<ItemUnifierProxy>.Get();
			ItemUnifierProxy.ItemUnifierPool.GetList(list, tempList);
			GameUtility.OpenPopReward(GameUtility.ToUniversalItems(tempList), notSort: false, () =>
			{
				ListPool<ItemUnifierProxy>.Release(tempList);
			});
			for (int num = 0; num < ListCharacterCard.Count; num++)
			{
				ListCharacterCard[num].Refresh();
			}
			ResidentoptionalRewardViewReset();
		});
	}

	private void SelectCardByIndex(int index)
	{
		if (ListCharacterCard.Count != 0)
		{
			index = Mathf.Clamp(index, 0, ListCharacterCard.Count - 1);
			m_selectedCardIndex = index;
			CardDrawSelfSelectedRewardItem cardDrawSelfSelectedRewardItem = ListCharacterCard[index];
			for (int i = 0; i < ListCharacterCard.Count; i++)
			{
				ListCharacterCard[i].SetSelected(cardDrawSelfSelectedRewardItem.id == ListCharacterCard[i].id);
			}
			SelectResidentoptionalRewardId = cardDrawSelfSelectedRewardItem.GachaItem.itemId;
			SelectResidentoptionalGachaItemId = cardDrawSelfSelectedRewardItem.id;
		}
	}

	private void EnsureCardVisible(CardDrawSelfSelectedRewardItem card)
	{
		if (CharacterCardScrollRect == null)
		{
			return;
		}
		RectTransform rectTransform = ((CharacterCardScrollRect.viewport != null) ? CharacterCardScrollRect.viewport : CharacterCardScrollRect.GetComponent<RectTransform>());
		RectTransform content = CharacterCardScrollRect.content;
		if (rectTransform == null || content == null)
		{
			return;
		}
		Canvas.ForceUpdateCanvases();
		RectTransform component = card.GetComponent<RectTransform>();
		Rect rect = rectTransform.rect;
		Vector3 vector = rectTransform.InverseTransformPoint(component.position);
		float num = vector.x - component.rect.width * component.pivot.x;
		float num2 = vector.x + component.rect.width * (1f - component.pivot.x);
		float num3 = vector.y - component.rect.height * component.pivot.y;
		float num4 = vector.y + component.rect.height * (1f - component.pivot.y);
		Vector2 anchoredPosition = content.anchoredPosition;
		if (CharacterCardScrollRect.horizontal)
		{
			if (num < rect.xMin)
			{
				anchoredPosition.x += rect.xMin - num;
			}
			else if (num2 > rect.xMax)
			{
				anchoredPosition.x += rect.xMax - num2;
			}
		}
		if (CharacterCardScrollRect.vertical)
		{
			if (num3 < rect.yMin)
			{
				anchoredPosition.y += rect.yMin - num3;
			}
			else if (num4 > rect.yMax)
			{
				anchoredPosition.y += rect.yMax - num4;
			}
		}
		content.anchoredPosition = anchoredPosition;
	}

	public void OnNavigateCharacterCard(Vector2 value)
	{
		if (ListCharacterCard.Count == 0)
		{
			return;
		}
		if (m_characterCardNavigateData == null)
		{
			m_characterCardNavigateData = new ContinuousNavigateData();
		}
		float unscaledTime = Time.unscaledTime;
		m_characterCardNavigateData.currentInput = value;
		float deadZone = ((m_characterCardNavigateData.lastDirection == MoveDirection.None) ? GameLoader.meta.deadZoneOnEnter : GameLoader.meta.deadZoneOnRepeat);
		MoveDirection moveDirection = ContinuousNavigateUtility.DetermineMoveDirection(value.x, value.y, deadZone);
		if (moveDirection == MoveDirection.None)
		{
			m_characterCardNavigateData.Reset();
		}
		else
		{
			if (moveDirection == m_characterCardNavigateData.lastDirection)
			{
				return;
			}
			m_characterCardNavigateData.lastDirection = moveDirection;
			m_characterCardNavigateData.holdStartTime = unscaledTime;
			m_characterCardNavigateData.lastTriggerTime = unscaledTime;
			m_characterCardNavigateData.enteredRepeat = false;
			ContinuousNavigateData data = m_characterCardNavigateData;
			if (!m_characterCardNavigateData.repeatLooper.IsValid())
			{
				m_characterCardNavigateData.repeatLooper = UpdateTimer.Default.LoopFrame(1, () =>
				{
					float unscaledTime2 = Time.unscaledTime;
					float deadZone2 = ((data.lastDirection == MoveDirection.None) ? GameLoader.meta.deadZoneOnEnter : GameLoader.meta.deadZoneOnRepeat);
					MoveDirection moveDirection2 = ContinuousNavigateUtility.DetermineMoveDirection(data.currentInput.x, data.currentInput.y, deadZone2);
					if (moveDirection2 == MoveDirection.None)
					{
						data.Reset();
					}
					else if (moveDirection2 == data.lastDirection)
					{
						if (!data.enteredRepeat)
						{
							if (unscaledTime2 - data.holdStartTime >= 0.3f)
							{
								data.enteredRepeat = true;
								data.lastTriggerTime = unscaledTime2;
								NavigateCharacterCardByDirection(moveDirection2);
							}
						}
						else if (unscaledTime2 - data.lastTriggerTime >= 0.15f)
						{
							data.lastTriggerTime = unscaledTime2;
							NavigateCharacterCardByDirection(moveDirection2);
						}
					}
				});
			}
			NavigateCharacterCardByDirection(moveDirection);
		}
	}

	private void NavigateCharacterCardByDirection(MoveDirection direction)
	{
		int num = direction switch
		{
			MoveDirection.Right => 1, 
			MoveDirection.Left => -1, 
			MoveDirection.Down => 1, 
			MoveDirection.Up => -1, 
			_ => 0, 
		};
		if (num != 0)
		{
			int num2 = Mathf.Clamp(m_selectedCardIndex + num, 0, ListCharacterCard.Count - 1);
			if (num2 != m_selectedCardIndex)
			{
				ListCharacterCard[num2].BtnClick.OnClick.Invoke();
				EnsureCardVisible(ListCharacterCard[num2]);
			}
		}
	}

	public void OnExchangeFromGamepad()
	{
		BtnBtnResidentoptionalRewardGift.OnSubmit(null);
	}

	public void OnTrialFromGamepad()
	{
		BtnCharacterTrial.OnSubmit(null);
	}

	public void CloseFromGamepad()
	{
		BtnClose.OnSubmit(null);
	}

	private void ReportGachaClick()
	{
		GachaClickEvent evt = EventTrackSolver.Instance.GetEvt<GachaClickEvent>();
		evt.gachaId = CurrentCardPool.id;
		evt.type = 2;
		EventTrackSolver.Instance.Dispatch(evt);
	}

	public void OnBtnCharacterTrial()
	{
		if (SelectResidentoptionalRewardId == 0)
		{
			return;
		}
		ItemData data = CoreUtils.GetData(SelectResidentoptionalRewardId, RuntimeConfigs.data.itemDatas);
		if (data.type != 5 || data.canBeTransited.Count <= 0)
		{
			return;
		}
		foreach (ItemKv item in CoreUtils.GetData(data.canBeTransited[0].id, RuntimeConfigs.data.CharacterProbationRaids).typeRaidID)
		{
			if (item.id != 1)
			{
				continue;
			}
			TeamUsage raidTrialTeamUsage = Model<RaidModel>.Interface.GetRaidTrialTeamUsage(item.count);
			G.service.RaidEnterInfo(item.count, raidTrialTeamUsage, async (bool r) =>
			{
				if (r)
				{
					await Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Raid);
				}
			});
			break;
		}
	}
}
