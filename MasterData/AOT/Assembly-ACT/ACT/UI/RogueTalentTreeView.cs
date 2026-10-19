using System.Collections.Generic;
using ACT.Config;
using ACT.Event;
using ACT.Model;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.Model;
using Runtime.UI.CommonComponent;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class RogueTalentTreeView : BaseUIView<RogueTalentTreeViewInputController>
{
	public ActButton btnClose;

	public Transform TalentTreeRoot;

	public TalentTreeItem TalentTreePrefab;

	public Transform TfRogueTalentBdCoreItem;

	public GameObject RogueTalentBdCoreItemPrefab;

	public CommonNumberComponent Capacity;

	public CommonCoinComponent CoinComponent;

	public ScrollRect ScrollRect;

	public RightStickScrollSupport RightStickScrollSupport;

	public GamePadTipsComp gamePadGroup;

	[Header("Input Binding")]
	public ViewControlLayer viewControlLayer;

	private RogueTalentTreeViewData m_data;

	private List<RogueTalentBdCoreItem> m_items = new List<RogueTalentBdCoreItem>();

	private Dictionary<string, GamePadTipsAction> _allInputPrompt = new Dictionary<string, GamePadTipsAction>();

	private List<GamePadTipsAction> _tipsActions;

	private bool m_canRightStickScroll = true;

	public override UniTask PreInit()
	{
		btnClose.SetBtnClick(Close);
		return base.PreInit();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Rogue/TalentTree/Open");
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void Init()
	{
		base.Init();
		InitPanel();
		OnGamePadInit();
		RefreshRightStickScrollForbid();
		ReBindBtnPrompt();
		viewControlLayer.ReFocus();
	}

	protected override void AddEventListener()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.RogueUpgradeTalentNode, OnRogueUpgradeTalentNode);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_CloseTalentUnLock, OnCloseTalentUnLock);
	}

	private void OnCloseTalentUnLock(BaseEventContent obj)
	{
		CheckUnLockAni();
	}

	private void OnRogueUpgradeTalentNode(BaseEventContent obj)
	{
		SetTree();
		RefreshRogueTalentBdCoreItem();
	}

	protected override void RemoveEventListener()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.RogueUpgradeTalentNode, OnRogueUpgradeTalentNode);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_CloseTalentUnLock, OnCloseTalentUnLock);
		base.RemoveEventListener();
	}

	private void InitPanel()
	{
		CreateRogueTalentBdCoreItem();
		SetTree();
	}

	private void SetTree()
	{
		TalentTreePrefab.Init(Model<RogueNewModel>.Interface.GetTalentNodeDic(), Station);
	}

	private void CreateRogueTalentBdCoreItem()
	{
		if (TfRogueTalentBdCoreItem.childCount > 0)
		{
			TfRogueTalentBdCoreItem.DestroyChildren();
		}
		m_items.Clear();
		List<BdCore> bdCoreList = Model<RogueNewModel>.Interface.GetBdCoreList();
		for (int i = 0; i < bdCoreList.Count; i++)
		{
			RogueTalentBdCoreItem rogueTalentBdCoreItem = UIUtility.AddWidget<RogueTalentBdCoreItem>(TfRogueTalentBdCoreItem, RogueTalentBdCoreItemPrefab);
			rogueTalentBdCoreItem.Init(bdCoreList[i], Station);
			m_items.Add(rogueTalentBdCoreItem);
		}
	}

	private void RefreshRogueTalentBdCoreItem()
	{
		for (int i = 0; i < m_items.Count; i++)
		{
			m_items[i].RefreshItem();
		}
	}

	private void CheckUnLockAni()
	{
		for (int i = 0; i < m_items.Count; i++)
		{
			m_items[i].PlayUnlockAnimation();
		}
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	private void OnGamePadInit()
	{
		_allInputPrompt = new Dictionary<string, GamePadTipsAction>
		{
			["UI/RSUpDownSelect"] = new GamePadTipsAction
			{
				inputAction = "UI/RSUpDownSelect",
				localizeKey = 2165,
				localizeTable = "Common"
			},
			["UI/Back"] = new GamePadTipsAction
			{
				inputAction = "UI/Back",
				localizeKey = 606,
				localizeTable = "Common"
			},
			["UI/Confirm"] = new GamePadTipsAction
			{
				inputAction = "UI/Confirm",
				localizeKey = 774,
				localizeTable = "Common"
			}
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

	private void RefreshRightStickScrollForbid()
	{
		ScrollRect scrollRect = ScrollRect;
		RightStickScrollSupport rightStickScrollSupport = RightStickScrollSupport;
		if (rightStickScrollSupport == null || scrollRect == null)
		{
			m_canRightStickScroll = scrollRect != null && scrollRect.content != null && scrollRect.viewport != null && scrollRect.content.rect.height > scrollRect.viewport.rect.height;
			return;
		}
		Canvas.ForceUpdateCanvases();
		if (scrollRect.content != null)
		{
			LayoutRebuilder.ForceRebuildLayoutImmediate(scrollRect.content);
		}
		bool flag = scrollRect.content != null && scrollRect.viewport != null && scrollRect.content.rect.height > scrollRect.viewport.rect.height;
		rightStickScrollSupport.SetForbidScroll(!flag);
		m_canRightStickScroll = flag;
	}

	public void Scroll(Vector2 value)
	{
		if (m_canRightStickScroll)
		{
			ScrollRect scrollRect = ScrollRect;
			if (!(scrollRect == null))
			{
				scrollRect.velocity = new Vector2(0f, value.y * scrollRect.scrollSensitivity);
			}
		}
	}
}
