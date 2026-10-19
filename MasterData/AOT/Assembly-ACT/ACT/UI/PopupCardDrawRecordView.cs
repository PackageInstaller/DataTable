using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using ACT.Sound;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using Pb;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class PopupCardDrawRecordView : BaseUIView<PopupCardDrawRecordViewController>
{
	private PopupCardDrawRecordViewData m_data;

	public ActButton BtnClose;

	public PopupTargetGachaViewTab Tab;

	public TextMeshProUGUI TextCurrentPage;

	public Button BtnLast;

	public Button BtnNext;

	public GameObject GoDeTail;

	public LocalizeStringEvent TextDeTailDes;

	public GameObject GoReCord;

	public GameObject GoReCordEmpty;

	public GameObject GoReCordShow;

	public GameObject GoInventory;

	public Transform TfInventoryItemRoot;

	public GameObject InventoryItemPrefab;

	public LocalizeStringEvent TextGachaPoolName;

	public List<RecordCell> _RecordCells;

	public Color NormalColor;

	public Color SelectColor;

	private Dictionary<int, List<GachaHistoryItem>> _historyItems = new Dictionary<int, List<GachaHistoryItem>>();

	private int CurrentPage;

	private int TotalPage;

	private GachaDisplay gachaDisplay;

	private int CurrentTabIndex;

	[Header("右摇杆滚动")]
	public ScrollRect DetailScrollRect;

	public ScrollRect InventoryScrollRect;

	[Header("手柄按键组")]
	public GamePadTipsComp gamePadTips;

	private Dictionary<string, GamePadTipsAction> _inputActionDic;

	private List<GamePadTipsAction> _tipsActions;

	private static readonly int TabCount = 3;

	public RightStickScrollSupport RightStickScrollSupport;

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
		m_data = uiViewData as PopupCardDrawRecordViewData;
		_historyItems.Clear();
		BtnLast.SetBtnClick(Last);
		BtnNext.SetBtnClick(Next);
		BindTabEvents();
		BtnClose.SetBtnClick(Close, "event:/UI/Common/Popup_Close");
		OnGamePadInit();
		await base.PreInit();
	}

	protected override void Init()
	{
		base.Init();
		InitPanel();
	}

	private void BindTabEvents()
	{
		if (!(Tab == null) && Tab.tabItems != null && Tab.tabItems.Count >= TabCount)
		{
			Tab.tabItems[0].onClick.RemoveListener(OnTabDetailClick);
			Tab.tabItems[1].onClick.RemoveListener(OnTabRecordClick);
			Tab.tabItems[2].onClick.RemoveListener(OnTabInventoryClick);
			Tab.tabItems[0].onClick.AddListener(OnTabDetailClick);
			Tab.tabItems[1].onClick.AddListener(OnTabRecordClick);
			Tab.tabItems[2].onClick.AddListener(OnTabInventoryClick);
		}
	}

	private void UnbindTabEvents()
	{
		if (!(Tab == null) && Tab.tabItems != null)
		{
			Tab.tabItems[0].onClick.RemoveListener(OnTabDetailClick);
			Tab.tabItems[1].onClick.RemoveListener(OnTabRecordClick);
			Tab.tabItems[2].onClick.RemoveListener(OnTabInventoryClick);
		}
	}

	private void OnTabDetailClick()
	{
		PlayTabClickSound();
		OnShowDeTail();
	}

	private void OnTabRecordClick()
	{
		PlayTabClickSound();
		OnShowRecord();
	}

	private void OnTabInventoryClick()
	{
		PlayTabClickSound();
		OnShowInventory();
	}

	private void PlayTabClickSound()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/DrawCard/Tab");
	}

	private void InitPanel()
	{
		CurrentTabIndex = 0;
		gachaDisplay = CoreUtils.GetData(m_data.CurrentCardPool.id, RuntimeConfigs.data.gachaDisplays);
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Window", new AudioPlayOptions
		{
			attachTarget = transform
		});
		OnShowDeTail();
		ReBindBtnPrompt();
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		if (type != DeviceInputMode.TouchScreen)
		{
			OnDeviceChange(type);
		}
	}

	public void OnShowDeTail()
	{
		if (CurrentTabIndex != 1)
		{
			ShowPanel(1);
			if (DetailScrollRect != null)
			{
				DetailScrollRect.verticalNormalizedPosition = 1f;
			}
			TextDeTailDes.StringReference.TableEntryReference = gachaDisplay.checkDes;
		}
	}

	public void OnShowRecord()
	{
		if (CurrentTabIndex != 2)
		{
			ShowPanel(2);
			CurrentPage = 1;
			ShowHisToryPanel(CurrentPage);
			TextGachaPoolName.StringReference.TableEntryReference = m_data.CurrentCardPool.gachaName;
		}
	}

	public void OnShowInventory()
	{
		if (CurrentTabIndex != 3)
		{
			ShowPanel(3);
			ShowInventoryPanel();
			RefreshRightStickScrollForbid();
		}
	}

	private void ShowInventoryPanel()
	{
		int[] gachaPoolProbability = m_data.CurrentCardPool.gachaPoolProbability;
		if (TfInventoryItemRoot.childCount > 0)
		{
			TfInventoryItemRoot.DestroyChildren();
		}
		for (int i = 0; i < gachaPoolProbability.Length; i++)
		{
			int num = i;
			UIUtility.AddWidget<InventoryItem>(TfInventoryItemRoot, InventoryItemPrefab).Init(m_data.CurrentCardPool, gachaPoolProbability[i], Station, num == 0, num == gachaPoolProbability.Length - 1);
		}
	}

	private void ShowPanel(int index)
	{
		GoDeTail.SetActive(index == 1);
		GoReCord.SetActive(index == 2);
		GoInventory.SetActive(index == 3);
		Tab?.TrySwitchTo(index - 1);
		CurrentTabIndex = index;
		RefreshRightStickScrollForbid();
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
		UnbindTabEvents();
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

	public void Next()
	{
		CurrentPage++;
		ShowHisToryPanel(CurrentPage);
	}

	public void Last()
	{
		CurrentPage--;
		ShowHisToryPanel(CurrentPage);
	}

	private void Refresh()
	{
		TextCurrentPage.SetText("{0:0}", CurrentPage);
		BtnNext.interactable = CurrentPage < TotalPage;
		BtnLast.interactable = CurrentPage > 1;
	}

	private void ShowHisToryPanel(int page)
	{
		if (_historyItems.ContainsKey(page))
		{
			ShowHisTory();
		}
		else
		{
			SendGachaQueryHistory(page);
		}
	}

	private void ShowHisTory()
	{
		if (_historyItems.TryGetValue(CurrentPage, out var value))
		{
			if (value.Count > 0)
			{
				for (int i = 0; i < _RecordCells.Count; i++)
				{
					_RecordCells[i].gameObject.SetActive(i < value.Count);
					if (i < value.Count)
					{
						_RecordCells[i].Init(value[i]);
					}
				}
			}
			GoReCordEmpty.SetActive(value.Count <= 0);
			GoReCordShow.SetActive(value.Count > 0);
		}
		else
		{
			GoReCordEmpty.SetActive(value: true);
			GoReCordShow.SetActive(value: false);
		}
		Refresh();
	}

	public void SendGachaQueryHistory(int Page)
	{
		Model<CardDrawModel>.Interface.SendGachaQueryHistory(m_data.CurrentCardPool.gachaType, Page, (GachaQueryHistoryAck ack) =>
		{
			if (ack != null && ack.Code == 0)
			{
				if (_historyItems.ContainsKey(Page))
				{
					_historyItems[Page] = ack.PageItems.ToList();
				}
				else
				{
					_historyItems.Add(Page, ack.PageItems.ToList());
				}
				TotalPage = ack.TotalPage;
			}
			ShowHisTory();
		});
	}

	private ScrollRect GetActiveScrollRect()
	{
		if (CurrentTabIndex == 1)
		{
			return DetailScrollRect;
		}
		if (CurrentTabIndex == 3)
		{
			return InventoryScrollRect;
		}
		return null;
	}

	private bool CanActiveScrollRectScroll()
	{
		ScrollRect activeScrollRect = GetActiveScrollRect();
		if (activeScrollRect == null || activeScrollRect.content == null || activeScrollRect.viewport == null)
		{
			return false;
		}
		Canvas.ForceUpdateCanvases();
		LayoutRebuilder.ForceRebuildLayoutImmediate(activeScrollRect.content);
		return activeScrollRect.content.rect.height > activeScrollRect.viewport.rect.height;
	}

	private void RefreshRightStickScrollForbid()
	{
		RightStickScrollSupport rightStickScrollSupport = RightStickScrollSupport;
		ScrollRect activeScrollRect = GetActiveScrollRect();
		if (rightStickScrollSupport == null)
		{
			ReBindBtnPrompt();
			return;
		}
		if (activeScrollRect == null)
		{
			rightStickScrollSupport.SetForbidScroll(isForbid: true);
			ReBindBtnPrompt();
			return;
		}
		rightStickScrollSupport.SetTargetScrollRect(activeScrollRect);
		bool flag = CanActiveScrollRectScroll();
		rightStickScrollSupport.SetForbidScroll(!flag);
		ReBindBtnPrompt();
	}

	private void OnGamePadInit()
	{
		_inputActionDic = new Dictionary<string, GamePadTipsAction>
		{
			["UI/Back"] = new GamePadTipsAction
			{
				inputAction = "UI/Back",
				localizeKey = 606,
				localizeTable = "Common"
			},
			["UI/RSUpDownSelect"] = new GamePadTipsAction
			{
				inputAction = "UI/RSUpDownSelect",
				localizeKey = 2165,
				localizeTable = "Common"
			}
		};
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
		if (!(gamePadTips == null) && _inputActionDic != null && MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			List<GamePadTipsAction> tipsActions = _tipsActions;
			if (tipsActions == null || tipsActions.Count <= 0)
			{
				_tipsActions = new List<GamePadTipsAction>();
			}
			gamePadTips.ClearAllPrompts();
			_tipsActions.Clear();
			_tipsActions.Add(_inputActionDic["UI/Back"]);
			if ((CurrentTabIndex == 1 || CurrentTabIndex == 3) && CanActiveScrollRectScroll())
			{
				_tipsActions.Add(_inputActionDic["UI/RSUpDownSelect"]);
			}
			gamePadTips.RegisterInputActions(_tipsActions);
		}
	}

	public void SwitchTab(bool next)
	{
		switch (next ? (CurrentTabIndex % TabCount + 1) : ((CurrentTabIndex - 2 + TabCount) % TabCount + 1))
		{
		case 1:
			OnTabDetailClick();
			break;
		case 2:
			OnTabRecordClick();
			break;
		case 3:
			OnTabInventoryClick();
			break;
		}
	}

	public void OnPrevPage()
	{
		if (CurrentTabIndex == 2 && CurrentPage > 1)
		{
			BtnLast.onClick.Invoke();
		}
	}

	public void OnNextPage()
	{
		if (CurrentTabIndex == 2 && CurrentPage < TotalPage)
		{
			BtnNext.onClick.Invoke();
		}
	}

	public void CloseFromGamepad()
	{
		BtnClose.OnSubmit(null);
	}
}
