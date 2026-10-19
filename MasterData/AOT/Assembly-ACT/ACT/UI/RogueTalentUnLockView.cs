using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using Pb;
using Runtime.Model;
using Runtime.UI.CommonComponent;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class RogueTalentUnLockView : BaseUIView<RogueTalentUnLockViewInputController>
{
	public ActButton btnClose;

	public ActButton BtnLevlUp;

	public GameObject GoMax;

	public GameObject GoLock;

	public GameObject GoTmpLeave;

	public BImage TalentNodeIcon;

	public LocalizeStringEvent TextName;

	public Image ImageBg;

	public Image ImagelvBg;

	public TextMeshProUGUI TextLevel;

	public Transform TfRogueTalentNodeDesItem;

	public GameObject RogueTalentNodeDesItemPrefab;

	public GameObject GoConsumption;

	public CommonNumberComponent ConsumptionComponent;

	public CommonCoinComponent CoinComponent;

	public ScrollRect ScrollRect;

	public RightStickScrollSupport RightStickScrollSupport;

	[Header("Input Binding")]
	public ViewControlLayer viewControlLayer;

	public GameObject btnUpgradePrompt;

	public GamePadTipsComp gamePadGroup;

	public List<Sprite> BgList = new List<Sprite>();

	public List<Sprite> LvBgList = new List<Sprite>();

	public List<Color> Colors = new List<Color>();

	private RogueTalentUnLockViewData m_data;

	private TalentNode nodeData;

	private List<RogueTalentNodeDesItem> m_items = new List<RogueTalentNodeDesItem>();

	private bool m_canRightStickScroll;

	private Dictionary<string, GamePadTipsAction> _allInputPrompt = new Dictionary<string, GamePadTipsAction>();

	private List<GamePadTipsAction> _tipsActions;

	public override async UniTask PreInit()
	{
		btnClose.SetBtnClick(Close, "event:/UI/Common/Popup_Close");
		BtnLevlUp.SetBtnClick(OnLevelUp, "event:/UI/Interface/Rogue/TalentTree/Update_Click");
		m_data = uiViewData as RogueTalentUnLockViewData;
		nodeData = CoreUtils.GetData(m_data.TalentNodeId, RuntimeConfigs.data.talentNodes);
		await base.PreInit();
	}

	protected override void Init()
	{
		InitPanel();
		base.Init();
	}

	public override void Close()
	{
		base.Close();
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_CloseTalentUnLock, null);
	}

	private void InitPanel()
	{
		TextName.StringReference.TableEntryReference = nodeData.name;
		Station.LoadImage(201, nodeData.iconAddress, TalentNodeIcon);
		if (nodeData.type <= BgList.Count)
		{
			ImageBg.sprite = BgList[nodeData.type - 1];
		}
		if (nodeData.type <= BgList.Count)
		{
			ImagelvBg.sprite = LvBgList[nodeData.type - 1];
		}
		if (nodeData.type <= Colors.Count)
		{
			TextLevel.color = Colors[nodeData.type - 1];
		}
		CreateDesItem();
		RefreshPanel();
		OnGamePadInit();
		RefreshRightStickScrollForbid();
		ReBindBtnPrompt();
		viewControlLayer.Focus();
	}

	private void RefreshPanel()
	{
		TextMeshProUGUI textLevel = TextLevel;
		string text = Model<RogueNewModel>.Interface.GetTalentNodeLevel(nodeData.id).ToString();
		int maxLevel = nodeData.maxLevel;
		textLevel.text = text + "/" + maxLevel;
		RefreshState();
		UpdateConsumptionComponent();
	}

	public void UpdateConsumptionComponent()
	{
		int num = Model<RogueNewModel>.Interface.GetTalentNodeById(nodeData.id)?.Level ?? 0;
		if (nodeData.maxLevel >= num + 1)
		{
			int itemCount = G.localPlayer.Inventory.GetItemCount(87);
			TalentNodeLevelData talentNodeLevelDataByLevel = Model<RogueNewModel>.Interface.GetTalentNodeLevelDataByLevel(nodeData.id, num + 1);
			if (talentNodeLevelDataByLevel != null)
			{
				ConsumptionComponent.UpdateNumber(talentNodeLevelDataByLevel.upgradeCost[0].count, itemCount);
			}
			bool active = itemCount >= talentNodeLevelDataByLevel.upgradeCost[0].count;
			BtnLevlUp.Interactable(active);
			btnUpgradePrompt.SetActive(active);
		}
	}

	private void CreateDesItem()
	{
		List<TalentNodeLevelData> talentNodeLevelDataList = Model<RogueNewModel>.Interface.GetTalentNodeLevelDataList(nodeData.id);
		m_items.Clear();
		if (TfRogueTalentNodeDesItem.childCount > 0)
		{
			TfRogueTalentNodeDesItem.DestroyChildren();
		}
		for (int i = 0; i < talentNodeLevelDataList.Count; i++)
		{
			RogueTalentNodeDesItem rogueTalentNodeDesItem = UIUtility.AddWidget<RogueTalentNodeDesItem>(TfRogueTalentNodeDesItem, RogueTalentNodeDesItemPrefab);
			rogueTalentNodeDesItem.Init(talentNodeLevelDataList[i]);
			m_items.Add(rogueTalentNodeDesItem);
		}
	}

	private void RefreshState()
	{
		GoMax.SetActive(value: false);
		BtnLevlUp.gameObject.SetActive(value: false);
		GoLock.SetActive(value: false);
		GoConsumption.SetActive(value: false);
		GoTmpLeave.SetActive(value: false);
		RogueTalentTreeNode talentNodeById = Model<RogueNewModel>.Interface.GetTalentNodeById(nodeData.parentId);
		RogueTalentTreeNode talentNodeById2 = Model<RogueNewModel>.Interface.GetTalentNodeById(nodeData.id);
		bool flag = (talentNodeById == null || talentNodeById.Level < nodeData.unlockLevel) && nodeData.parentId != 0;
		bool flag2 = talentNodeById2 != null && talentNodeById2.Level == nodeData.maxLevel;
		if (Model<RogueNewModel>.Interface.Info.GameState == StageStateEnum.StageStateTmpLeave)
		{
			GoTmpLeave.SetActive(value: true);
			return;
		}
		if (flag)
		{
			GoLock.SetActive(value: true);
			return;
		}
		if (flag2)
		{
			GoMax.SetActive(value: true);
			return;
		}
		GoConsumption.SetActive(value: true);
		BtnLevlUp.gameObject.SetActive(value: true);
	}

	private void RefreshDesItem()
	{
		for (int i = 0; i < m_items.Count; i++)
		{
			m_items[i].RefreshSelect();
		}
	}

	public void OnLevelUp()
	{
		Model<RogueNewModel>.Interface.SendUpgradeTalentNode(nodeData.id, (RogueUpdateTalentTreeNodeAck ack) =>
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Rogue/TalentTree/Update");
			RefreshPanel();
			RefreshDesItem();
		});
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Window");
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	protected override void UnInit()
	{
		base.UnInit();
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
		_tipsActions.Add(_allInputPrompt["UI/Back"]);
		if (m_canRightStickScroll)
		{
			_tipsActions.Add(_allInputPrompt["UI/RSUpDownSelect"]);
		}
		gamePadGroup.RegisterInputActions(_tipsActions);
	}
}
