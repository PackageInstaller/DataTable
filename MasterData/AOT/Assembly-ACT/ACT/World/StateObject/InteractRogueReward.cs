using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI;
using ACT.Utility;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.ECS;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.Model;
using TMPro;
using UnityEngine;

namespace ACT.World.StateObject;

public class InteractRogueReward : StateObjectBase
{
	public GameObject rootResult;

	public Animator _animator;

	public BImage ImageIcon;

	public GameObject ImageRoot;

	public List<GameObject> QualityEffectList;

	public GameObject rootPrice;

	public TextMeshProUGUI textPrice;

	private RogueRewardData _data;

	private InteractEntry _interactEntry;

	private List<InteractEntry> _listInteractVarietyBtn = new List<InteractEntry>();

	private List<int> iconlist = new List<int>();

	private bool interacted;

	private bool isBuy;

	private int _itemId;

	private RogueElement rogueElement;

	private Color _priceNormalColor;

	private VertexGradient _priceNormalGradient;

	private bool _priceNormalGradientEnabled;

	private ActBtnTextColorComp _priceTextColorComp;

	private bool _priceColorCached;

	public override bool serviceSave => false;

	public override void InitStateObject(int stateId)
	{
		if (entity.GetCompStateObject()?.StateWorldAssetData is RogueRewardData data)
		{
			_data = data;
		}
		iconlist = Model<RogueNewModel>.Interface.Info.GameInfo.RoomInfo.Rewards.ToList();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.RogueReplace, OnRogueReplace);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.RogueExitInteract, OnRogueExitInteract);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.RogueBuyItem, OnRogueBuyItem);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.RogueCoinUpdate, OnRogueCoinUpdate);
		base.InitStateObject(stateId);
	}

	private void OnRogueBuyItem(BaseEventContent obj)
	{
		if (obj is RogueBuyItem rogueBuyItem && rogueBuyItem.swuid == swid)
		{
			EnterState(0);
			_interactEntry?.HandleExit();
			ChangeOtherComp();
		}
	}

	private void OnRogueExitInteract(BaseEventContent obj)
	{
		interacted = false;
	}

	private void OnRogueReplace(BaseEventContent obj)
	{
		if (obj is RoguePropReplace roguePropReplace)
		{
			interacted = false;
			if (roguePropReplace.isCompleted && _data.stateWorldAssetUid == roguePropReplace.swuid)
			{
				_itemId = roguePropReplace.newItemId;
				ReplaceItem(_itemId);
				ChangeOtherComp();
			}
		}
	}

	public override void ReleaseStateObject()
	{
		_interactEntry?.HandleExit();
		base.ReleaseStateObject();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.RogueReplace, OnRogueReplace);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.RogueExitInteract, OnRogueExitInteract);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.RogueBuyItem, OnRogueBuyItem);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.RogueCoinUpdate, OnRogueCoinUpdate);
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		return true;
	}

	protected override void HandleEnterInteract()
	{
		if (currentStateId == 1 && _data.uniqueIndex <= iconlist.Count - 1)
		{
			if (isBuy && rogueElement != null)
			{
				SetPriceColor(rogueElement.shopPrice);
			}
			ShowInteractButton();
			RogueOpenInteractTips rogueOpenInteractTips = new RogueOpenInteractTips();
			rogueOpenInteractTips.Entity = this;
			rogueOpenInteractTips.newItemId = _itemId;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.RogueOpenInteractTips, rogueOpenInteractTips);
			Singleton<EventManager>.instance.ReleaseEvt(rogueOpenInteractTips);
		}
	}

	protected override void HandleExitInteract()
	{
		if (currentStateId == 1 && _data.uniqueIndex <= iconlist.Count - 1)
		{
			HideInteractButton();
			RogueCloseInteractTips rogueCloseInteractTips = new RogueCloseInteractTips
			{
				swuid = swid
			};
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.RogueCloseInteractTips, rogueCloseInteractTips);
			Singleton<EventManager>.instance.ReleaseEvt(rogueCloseInteractTips);
			if (interacted)
			{
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.RogueHudCloseLittleBag, null);
			}
		}
	}

	protected override void HandleChangeState(int fromStateId, int toStateId)
	{
		base.HandleChangeState(fromStateId, toStateId);
	}

	protected override void HandleInitState(int stateId)
	{
		switch (stateId)
		{
		default:
			InitItemData();
			break;
		case 0:
			break;
		}
		if (stateId == 0)
		{
			ImageRoot.SetActive(value: false);
			_animator?.SetInteger("state", stateId);
		}
	}

	public void SetRoot(int stateId)
	{
		rootResult.SetActive(stateId == 1 || stateId == 2);
	}

	private void InitItemData()
	{
		rootResult.SetActive(_data.uniqueIndex <= iconlist.Count - 1);
		if (_data.uniqueIndex <= iconlist.Count - 1)
		{
			_animator?.SetInteger("state", 1);
			isBuy = Model<RogueNewModel>.Interface.Info == null || Model<RogueNewModel>.Interface.Info.GameInfo.RoomInfo.RoomType == RogueRoomType.Shop;
			_itemId = iconlist[_data.uniqueIndex];
			rogueElement = CoreUtils.GetData(_itemId, RuntimeConfigs.data.rogueElements);
			if (isBuy && rogueElement != null)
			{
				TextMeshProUGUI textMeshProUGUI = textPrice;
				int shopPrice = rogueElement.shopPrice;
				textMeshProUGUI.text = shopPrice.ToString();
				SetPriceColor(rogueElement.shopPrice);
			}
			SetQuality(rogueElement.elementQuality);
			rootPrice.SetActive(isBuy);
			SetImage(_itemId);
		}
	}

	private void SetPriceColor(int price)
	{
		if (!_priceColorCached)
		{
			_priceNormalColor = textPrice.color;
			_priceNormalGradient = textPrice.colorGradient;
			_priceNormalGradientEnabled = textPrice.enableVertexGradient;
			_priceTextColorComp = textPrice.GetComponent<ActBtnTextColorComp>();
			_priceColorCached = true;
		}
		bool flag = price > Model<RogueNewModel>.Interface.GetRogueCoin();
		textPrice.color = (flag ? RoguePriceColor.LackPriceColor : _priceNormalColor);
		textPrice.enableVertexGradient = !flag && _priceNormalGradientEnabled;
		if (!flag)
		{
			textPrice.colorGradient = _priceNormalGradient;
		}
		if (_priceTextColorComp != null)
		{
			_priceTextColorComp.enabled = !flag;
		}
	}

	private void OnRogueCoinUpdate(BaseEventContent obj)
	{
		if (isBuy && rogueElement != null)
		{
			SetPriceColor(rogueElement.shopPrice);
		}
	}

	private void SetQuality(int Quality)
	{
		for (int i = 0; i < QualityEffectList.Count; i++)
		{
			QualityEffectList[i].SetActive(i == Quality - 1);
		}
	}

	private bool CanShowInteractButton()
	{
		return _data.stateId == 1;
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
		_interactEntry.HandleInteract(eb, InteractAction.InteractSource.Player);
	}

	private void ShowInteractButton()
	{
		_interactEntry?.HandleEnter();
	}

	private void HideInteractButton()
	{
		_interactEntry?.HandleExit();
	}

	private void ShowReplaceButton()
	{
		for (int i = 0; i < _listInteractVarietyBtn.Count; i++)
		{
			_listInteractVarietyBtn[i]?.HandleEnter();
		}
	}

	private void HideReplaceButton()
	{
		for (int i = 0; i < _listInteractVarietyBtn.Count; i++)
		{
			_listInteractVarietyBtn[i]?.HandleExit();
		}
	}

	public void OnAfterShow()
	{
		ImageRoot.SetActive(value: true);
	}

	private void SetImage(int Itemid)
	{
		if (rogueElement != null)
		{
			if (rogueElement.elementType == 2)
			{
				RogueAssistCharacter data = CoreUtils.GetData(Itemid, RuntimeConfigs.data.rogueAssistCharacters);
				Model<RoGueModel>.Interface.rogueStation.LoadImage(126, data.characterId, ImageIcon);
			}
			else
			{
				Model<RoGueModel>.Interface.rogueStation.LoadImage(188, rogueElement.iconAddress, ImageIcon);
			}
		}
	}

	private void SetReplaceState()
	{
		HideInteractButton();
		ShowReplaceButton();
	}

	private void ReplaceItem(int itemId)
	{
		if (isBuy)
		{
			rootPrice.SetActive(value: false);
			isBuy = false;
		}
		_itemId = itemId;
		rogueElement = CoreUtils.GetData(_itemId, RuntimeConfigs.data.rogueElements);
		SetImage(itemId);
		SetQuality(rogueElement.elementQuality);
	}

	private void ChangeOtherComp()
	{
		RogueInfo info = Model<RogueNewModel>.Interface.Info;
		if (info != null && info.GameInfo.RoomInfo.RoomType == RogueRoomType.Shop)
		{
			return;
		}
		for (int i = 0; i < _data.OtherComps.Count; i++)
		{
			if (StateWorldAsset.TryGetWorldAssetBySwid(_data.OtherComps[i].stateWorldUid, out var stateWorldAsset))
			{
				(stateWorldAsset.stateObjectBase as InteractRogueReward).EnterState(0);
			}
		}
	}

	private async UniTask OnInteractAction(Entity entityBehave)
	{
		if (isBuy && rogueElement.shopPrice > Model<RogueNewModel>.Interface.GetRogueCoin())
		{
			GameUtility.OpenToolTip(81);
			return;
		}
		bool item = Model<RogueNewModel>.Interface.IsNeedUpgrade(_itemId).Item1;
		if (Model<RogueNewModel>.Interface.IsNeedReplace(_itemId) && !item)
		{
			RogueReplacementItemViewData rogueReplacementItemViewData = new RogueReplacementItemViewData();
			rogueReplacementItemViewData.swuid = _data.stateWorldAssetUid;
			rogueReplacementItemViewData.newItemId = _itemId;
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ROGUEREPLACEMENTITEM, rogueReplacementItemViewData);
			interacted = true;
			await UniTask.WaitUntil(() => !interacted);
		}
	}
}
