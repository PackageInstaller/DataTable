using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Net;
using ACT.UI.DataProxy;
using ACT.Utility;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using Fundamental;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class CoinComponent : ActButton, IUIFrameElement
{
	private enum AttributeMode
	{
		PlayerAttribute,
		CustomAttribute
	}

	[SerializeField]
	private AttributeMode m_AttributeMode;

	public TextMeshProUGUI possessNumText;

	public TextMeshProUGUI costNumText;

	public Color normalColor;

	public Color lackColor;

	public PlayerAttribute itemId = PlayerAttribute.COIN;

	public int customId;

	public new BImage image;

	public BImage image_cost;

	public PublicToggle isCost;

	[Header("ItemDetail相关")]
	public bool dontShowDetail;

	private long _currentNumber;

	private ImageAssetStation m_Station;

	private bool _listenerAdded;

	public bool IsEnough { get; private set; }

	public ImageAssetStation Station
	{
		get
		{
			if (m_Station == null)
			{
				m_Station = this.GetImageStation();
			}
			return m_Station;
		}
		set
		{
			m_Station = value;
		}
	}

	private void LoadItemIcon(int itemId, BImage target)
	{
		Station.LoadItemIcon(RuntimeConfigs.data.itemDatas[itemId].iconAddress, target);
	}

	protected override void Awake()
	{
		base.Awake();
		OnClick.AddListener(ShowDetailPanel);
		AddListener();
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		OnClick.RemoveListener(ShowDetailPanel);
		RemoveListener();
	}

	public void Initialize()
	{
		if (m_AttributeMode == AttributeMode.PlayerAttribute)
		{
			G.detailUserInfo.Attributes.TryGetValue((int)itemId, out var value);
			possessNumText.SetText(value.FastToString());
			_currentNumber = value;
			LoadItemIcon((int)itemId, image);
		}
		else
		{
			int itemCount = G.localPlayer.Inventory.GetItemCount(customId);
			possessNumText.SetText("{0:0}", itemCount);
			_currentNumber = itemCount;
			LoadItemIcon(customId, image);
		}
		isCost.isOn = false;
	}

	public void InitializeCustom(int itemId)
	{
		if (m_AttributeMode != AttributeMode.PlayerAttribute)
		{
			customId = itemId;
			int itemCount = G.localPlayer.Inventory.GetItemCount(customId);
			possessNumText.SetText("{0:0}", itemCount);
			_currentNumber = itemCount;
			LoadItemIcon(customId, image);
			isCost.isOn = false;
		}
	}

	public void Init(int id, bool isPlayerAttribute)
	{
		itemId = (PlayerAttribute)id;
		customId = id;
		m_AttributeMode = ((!isPlayerAttribute) ? AttributeMode.CustomAttribute : AttributeMode.PlayerAttribute);
		Initialize();
	}

	public void Init(int costNum)
	{
		isCost.isOn = true;
		long num = ((m_AttributeMode == AttributeMode.PlayerAttribute) ? G.TryGetAttribute((int)itemId) : G.localPlayer.Inventory.GetItemCount(customId));
		costNumText.SetText("{0:0}", costNum);
		_currentNumber = num;
		LoadItemIcon((m_AttributeMode == AttributeMode.PlayerAttribute) ? ((int)itemId) : customId, image_cost);
		if (num < costNum)
		{
			costNumText.color = lackColor;
			IsEnough = false;
		}
		else
		{
			costNumText.color = normalColor;
			IsEnough = true;
		}
	}

	public void AddListenerCustomEvent(ClientEvent eventName)
	{
		Singleton<EventManager>.instance.AddEventListener(eventName, ReFreshCustomItemNum);
	}

	public void RemoveListenerCustomEvent(ClientEvent eventName)
	{
		Singleton<EventManager>.instance.RemoveEventListener(eventName, ReFreshCustomItemNum);
	}

	public void AddListener()
	{
		if (!_listenerAdded)
		{
			_listenerAdded = true;
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_PlayerAttribute_Refresh, ReFreshCoinNum);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.BagItemChange, ReFreshCustomItemNum);
		}
	}

	public void RemoveListener()
	{
		if (_listenerAdded)
		{
			_listenerAdded = false;
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_PlayerAttribute_Refresh, ReFreshCoinNum);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BagItemChange, ReFreshCustomItemNum);
		}
	}

	public void ReFreshCoinNum(BaseEventContent obj)
	{
		PlayerAttributeChangeEvt playerAttributeChangeEvt = (PlayerAttributeChangeEvt)obj;
		int num = ((m_AttributeMode == AttributeMode.PlayerAttribute) ? ((int)itemId) : customId);
		if (playerAttributeChangeEvt.id == num && playerAttributeChangeEvt.currentNum != playerAttributeChangeEvt.lastNum)
		{
			Initialize();
		}
	}

	public void ReFreshCustomItemNum(BaseEventContent obj)
	{
		if (obj is ItemChangeEvt itemChangeEvt && itemChangeEvt.ItemProxies.Exists((ItemUnifierProxy x) => x.Id == customId))
		{
			Initialize();
		}
	}

	private void ShowDetailPanel()
	{
		if (!dontShowDetail)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPITEMDETAIL, new Item
			{
				Id = ((m_AttributeMode == AttributeMode.PlayerAttribute) ? ((int)itemId) : customId),
				Count = (int)_currentNumber
			});
		}
	}
}
