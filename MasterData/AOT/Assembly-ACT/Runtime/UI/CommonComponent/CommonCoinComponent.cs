using System;
using ACT;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Net;
using ACT.UI;
using ACT.UI.DataProxy;
using ACT.Utility;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace Runtime.UI.CommonComponent;

[RequireComponent(typeof(CommonNumberComponent))]
public class CommonCoinComponent : ActButton, IUIFrameElement
{
	private ImageAssetStation _station;

	[SerializeField]
	private AttributeMode m_AttributeMode;

	[SerializeField]
	private CommonNumberComponent m_NumberComp;

	public PlayerAttribute itemId = PlayerAttribute.COIN;

	public int customId;

	[SerializeField]
	private BImage m_Icon;

	[Header("ItemDetail相关")]
	public bool dontShowDetail;

	[Header("补充按钮")]
	public ActButton supplementBtn;

	private bool _listenerAdded;

	public ImageAssetStation Station
	{
		get
		{
			return _station ?? (_station = GetComponentInParent<IBaseUIView>(includeInactive: true).Station);
		}
		set
		{
			_station = value;
		}
	}

	public bool UseItemIcon { get; set; }

	public bool IsEnough => m_NumberComp.LeftCount >= m_NumberComp.RightCount;

	public AttributeMode AttributeMode
	{
		get
		{
			return m_AttributeMode;
		}
		set
		{
			m_AttributeMode = value;
		}
	}

	protected override void Awake()
	{
		try
		{
			Initialize();
			if ((bool)supplementBtn)
			{
				supplementBtn.SetBtnClick(JumpToSupplementPanel);
			}
		}
		catch (Exception value)
		{
			Console.WriteLine(value);
			throw;
		}
		AddListener();
	}

	protected override void OnDestroy()
	{
		RemoveListener();
	}

	public void Initialize()
	{
		try
		{
			if (m_AttributeMode == AttributeMode.PlayerAttribute)
			{
				ItemData data = CoreUtils.GetData((int)itemId, RuntimeConfigs.data.itemDatas);
				if (data != null)
				{
					G.detailUserInfo.Attributes.TryGetValue((int)itemId, out var value);
					m_NumberComp.UpdateNumber(value);
					LoadIconAsync(data.iconAddress);
				}
			}
			else
			{
				ItemData data2 = CoreUtils.GetData(customId, RuntimeConfigs.data.itemDatas);
				if (data2 != null)
				{
					int itemCount = G.localPlayer.Inventory.GetItemCount(customId);
					m_NumberComp.UpdateNumber(itemCount);
					LoadIconAsync(data2.iconAddress);
				}
			}
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
		}
	}

	public void Init(int costNum)
	{
		ItemData data = CoreUtils.GetData((m_AttributeMode == AttributeMode.PlayerAttribute) ? ((int)itemId) : customId, RuntimeConfigs.data.itemDatas);
		if (data != null)
		{
			long left = ((m_AttributeMode == AttributeMode.PlayerAttribute) ? G.TryGetAttribute((int)itemId) : G.localPlayer.Inventory.GetItemCount(customId));
			m_NumberComp.UpdateNumber(left, costNum);
			LoadIconAsync(data.iconAddress);
		}
	}

	public void InitData(int _itemId, bool isBagItem)
	{
		if (isBagItem)
		{
			customId = _itemId;
		}
		else
		{
			itemId = (PlayerAttribute)_itemId;
		}
		m_AttributeMode = (isBagItem ? AttributeMode.CustomAttribute : AttributeMode.PlayerAttribute);
	}

	public void Refresh(ItemKv item)
	{
		ItemData data = CoreUtils.GetData(item.id, RuntimeConfigs.data.itemDatas);
		if (data == null)
		{
			return;
		}
		Array values = Enum.GetValues(typeof(PlayerAttribute));
		long num = -1L;
		long right = item.count;
		m_AttributeMode = AttributeMode.CustomAttribute;
		foreach (object item2 in values)
		{
			if (item.id == (int)item2)
			{
				itemId = (PlayerAttribute)item.id;
				num = G.TryGetAttribute(item.id);
				m_AttributeMode = AttributeMode.PlayerAttribute;
				break;
			}
		}
		if (num == -1)
		{
			num = G.localPlayer.Inventory.GetItemCount(item.id);
			customId = item.id;
		}
		m_NumberComp.UpdateNumber(num, right);
		LoadIconAsync(data.iconAddress);
	}

	private void LoadIconAsync(int iconAddress)
	{
		if (UseItemIcon)
		{
			Station.LoadItemIconAsync(iconAddress, m_Icon).Forget();
		}
		else
		{
			Station.LoadImageAsync(165, iconAddress, m_Icon).Forget();
		}
	}

	public void AddListener()
	{
		if (!_listenerAdded)
		{
			_listenerAdded = true;
			OnClick.AddListener(ShowDetailPanel);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_PlayerAttribute_Refresh, ReFreshCoinNum);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.BagItemChange, ReFreshCoinNum);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.SyncGameInfo, ReFreshCoinNum);
		}
	}

	public void RemoveListener()
	{
		if (_listenerAdded)
		{
			_listenerAdded = false;
			OnClick.RemoveListener(ShowDetailPanel);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_PlayerAttribute_Refresh, ReFreshCoinNum);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BagItemChange, ReFreshCoinNum);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.SyncGameInfo, ReFreshCoinNum);
		}
	}

	public void ReFreshCoinNum(BaseEventContent obj)
	{
		if (obj is PlayerAttributeChangeEvt playerAttributeChangeEvt)
		{
			if (playerAttributeChangeEvt.id == (int)itemId || playerAttributeChangeEvt.id == customId)
			{
				Initialize();
			}
		}
		else if (obj is ItemChangeEvt itemChangeEvt && itemChangeEvt.ItemProxies.Exists((ItemUnifierProxy x) => x.Id == customId || x.Id == (int)itemId))
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
				Count = (int)m_NumberComp.LeftCount
			});
		}
	}

	private void JumpToSupplementPanel()
	{
		switch ((m_AttributeMode == AttributeMode.PlayerAttribute) ? ((int)itemId) : customId)
		{
		case 97:
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_FREEDIAMONDEXCHANGE);
			break;
		case 98:
			if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Shop))
			{
				GameUtility.OpenToolTip(Singleton<SystemUnlockManager>.instance.GetSystemLockTips(SystemType.Shop));
				break;
			}
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_SHOP, new ShopViewData
			{
				FirstTabID = 5
			});
			break;
		case 200129:
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_BUYITEM, new ShopBuyPanelData
			{
				ShopId = 4,
				SubShopId = 403,
				SaleId = 40300
			});
			break;
		case 200130:
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_BUYITEM, new ShopBuyPanelData
			{
				ShopId = 4,
				SubShopId = 403,
				SaleId = 40301
			});
			break;
		}
	}

	public void InputClick()
	{
		if (MonoECS.instance.InputMode != DeviceInputMode.TouchScreen)
		{
			OnClick?.Invoke();
		}
	}
}
