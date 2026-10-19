using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Define;
using ACT.Event;
using ACT.Model;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using Pb;
using Runtime.Model;
using UnityEngine;

namespace ACT.UI;

public class RogueReplacementItemView : BaseUIView<RogueReplacementItemViewInputController>
{
	private RogueReplacementItemViewData m_data;

	public ActButton BtnClose;

	public Transform TfInscription;

	public GameObject InscriptionPrefab;

	public RogueInfoItem CurrentSelectedItem;

	public RogueInfoItem NewItem;

	public List<RogueBagItem> PropItems;

	public ActButton BtnReplace;

	[Header("Input Binding")]
	public ViewControlLayer viewControlLayer;

	public GamePadTipsComp gamePadGroup;

	private List<RogueBagItemData> _rogueBagsItems = new List<RogueBagItemData>();

	private int _currentItemId;

	private RogueBagItemData _currentSelectedItemData;

	private Dictionary<int, InscriptionData> _dicInscriptions = new Dictionary<int, InscriptionData>();

	private RogueBagItem _lastSelectedItem;

	private List<int> _temporaryBags = new List<int>();

	private bool isCompleted;

	private bool m_canRightStickScroll;

	private Dictionary<string, GamePadTipsAction> _allInputPrompt = new Dictionary<string, GamePadTipsAction>();

	private List<GamePadTipsAction> _tipsActions;

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
		await base.PreInit();
		m_data = uiViewData as RogueReplacementItemViewData;
		BtnReplace.SetBtnClick(OnReplace);
		BtnClose.SetBtnClick(Close);
		isCompleted = false;
		_currentSelectedItemData = null;
		_currentItemId = 0;
	}

	protected override void Init()
	{
		base.Init();
		InitPanel();
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
		if (!isCompleted)
		{
			SendRoguePropReplace(0, 0, 0, isCompleted: false);
		}
	}

	public override void BackToBattleMain()
	{
		base.BackToBattleMain();
	}

	private void InitPanel()
	{
		InitBag();
		SetRogueItem();
		InscriptionItemData();
		RefreshInscriptionItem();
		InitNewRogueInfoItem();
		OnGamePadInit();
		ReBindBtnPrompt();
	}

	private void InitBag()
	{
		_rogueBagsItems.Clear();
		_rogueBagsItems.AddRange(Model<RogueNewModel>.Interface.GetRogueBagByType(3));
		InitTemporaryBags();
	}

	private void InitTemporaryBags()
	{
		_temporaryBags.Clear();
		for (int i = 0; i < _rogueBagsItems.Count; i++)
		{
			_temporaryBags.Add(_rogueBagsItems[i].RogueItem.ItemId);
		}
		_temporaryBags.Add(m_data.newItemId);
	}

	private void SetRogueItem()
	{
		for (int i = 0; i < PropItems.Count; i++)
		{
			RogueBagItem item = PropItems[i];
			RogueBagItemData rogueBagItemDataByPosIndex = GetRogueBagItemDataByPosIndex(i, 3);
			if (rogueBagItemDataByPosIndex != null)
			{
				item.Init(rogueBagItemDataByPosIndex.RogueItem.ItemId, RogueItemType.Prop, Station);
				item.BtnClick.SetBtnClick(() =>
				{
					RogueItemClick(item.Itemid, item);
				});
			}
			else
			{
				item.Init(0, RogueItemType.None);
			}
			if (i == 0)
			{
				item.BtnClick.OnClick.Invoke();
			}
		}
	}

	private RogueBagItemData GetRogueBagItemDataByPosIndex(int PosIndex, int RogueItemType)
	{
		RogueBagItemData result = null;
		for (int i = 0; i < _rogueBagsItems.Count; i++)
		{
			if (_rogueBagsItems[i].RogueItem.Position == PosIndex)
			{
				result = _rogueBagsItems[i];
			}
		}
		return result;
	}

	private void InscriptionItemData()
	{
		for (int i = 0; i < _rogueBagsItems.Count; i++)
		{
			RogueItem data = RuntimeConfigs.data.rogueItems[_rogueBagsItems[i].RogueItem.ItemId];
			AddDicInscription(data);
		}
		RogueItem data2 = RuntimeConfigs.data.rogueItems[m_data.newItemId];
		AddDicInscription(data2);
	}

	private void AddDicInscription(RogueItem data)
	{
		for (int i = 0; i < data.inscriptionIds.Length; i++)
		{
			if (_dicInscriptions.TryGetValue(data.inscriptionIds[i], out var value))
			{
				value.count++;
			}
			else
			{
				_dicInscriptions.Add(data.inscriptionIds[i], new InscriptionData(data.inscriptionIds[i], 1));
			}
		}
	}

	private void RefreshInscriptionItem()
	{
		if (TfInscription.childCount > 0)
		{
			TfInscription.DestroyChildren();
		}
		foreach (InscriptionData value in _dicInscriptions.Values)
		{
			RogueReplaceInscriptionItem rogueReplaceInscriptionItem = UIUtility.AddWidget<RogueReplaceInscriptionItem>(TfInscription, InscriptionPrefab);
			rogueReplaceInscriptionItem.Init(value.id, value.count, Station);
			rogueReplaceInscriptionItem.RefreshCount(Model<RogueNewModel>.Interface.GetInscriptionById(value.id), GetNewInscriptionById(value.id));
		}
	}

	private int GetNewInscriptionById(int id)
	{
		int num = 0;
		for (int i = 0; i < _temporaryBags.Count; i++)
		{
			if (CoreUtils.GetData(_temporaryBags[i], RuntimeConfigs.data.rogueElements).elementType != 3)
			{
				continue;
			}
			RogueItem data = CoreUtils.GetData(_temporaryBags[i], RuntimeConfigs.data.rogueItems);
			if (data == null)
			{
				continue;
			}
			for (int j = 0; j < data.inscriptionIds.Length; j++)
			{
				if (id == data.inscriptionIds[j])
				{
					num++;
				}
			}
		}
		return num;
	}

	private void RogueItemClick(int id, RogueBagItem item)
	{
		_currentItemId = id;
		_currentSelectedItemData = Model<RogueNewModel>.Interface.GetRogueBagItemByItemId(id);
		SetCurrentRogueInfo();
		_lastSelectedItem?.SetSelected(isSelected: false);
		item?.SetSelected(isSelected: true);
		_lastSelectedItem = item;
		InitTemporaryBags();
		_temporaryBags.Remove(_currentItemId);
		RefreshInscriptionItem();
	}

	private void InitNewRogueInfoItem()
	{
		NewItem.Init(m_data.newItemId, Station);
	}

	private void SetCurrentRogueInfo()
	{
		CurrentSelectedItem.Init(_currentItemId, Station);
	}

	private void OnReplace()
	{
		if (_currentItemId == 0)
		{
			return;
		}
		isCompleted = true;
		if (Model<RogueNewModel>.Interface.IsInDiscards(m_data.newItemId))
		{
			Model<RogueNewModel>.Interface.ReplaceRogueItem(_currentItemId, m_data.newItemId);
			SendRoguePropReplace(_currentSelectedItemData.RogueItem.Position, m_data.swuid, _currentItemId);
			Close();
		}
		else
		{
			Model<RogueNewModel>.Interface.SendRogueBuyItem(m_data.newItemId, (RogueBuyItemAck ack) =>
			{
				SendRoguePropReplace(_currentSelectedItemData.RogueItem.Position, m_data.swuid, _currentItemId);
				Close();
			}, _currentItemId, isReplace: true, _currentSelectedItemData.RogueItem.Position);
		}
	}

	private void SendRoguePropReplace(int index = 0, int swuid = 0, int newItemId = 0, bool isCompleted = true)
	{
		RoguePropReplace roguePropReplace = new RoguePropReplace();
		roguePropReplace.isCompleted = isCompleted;
		if (isCompleted)
		{
			roguePropReplace.index = index;
			roguePropReplace.swuid = swuid;
			roguePropReplace.newItemId = newItemId;
		}
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.RogueReplace, roguePropReplace);
		Singleton<EventManager>.instance.ReleaseEvt(roguePropReplace);
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
		_tipsActions.Add(_allInputPrompt["UI/Confirm"]);
		if (m_canRightStickScroll)
		{
			_tipsActions.Add(_allInputPrompt["UI/RSUpDownSelect"]);
		}
		gamePadGroup.RegisterInputActions(_tipsActions);
	}
}
