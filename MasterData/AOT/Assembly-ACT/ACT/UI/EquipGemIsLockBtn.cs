using System;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.UI.DataProxy;
using ACT.Utility;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class EquipGemIsLockBtn : BaseUIComponent
{
	public ActButton lockBtn;

	public EquipGem equipGem;

	public GameObject isLocked;

	public GameObject noLock;

	private int uid;

	public Func<int, bool> CanLock { get; set; }

	private void Awake()
	{
		if ((bool)lockBtn)
		{
			lockBtn.SetBtnClick(ClickLock);
		}
	}

	public void Init(int uid, bool isLock)
	{
		this.uid = uid;
		if (!(Context is ItemUIComponentBase))
		{
			isLocked.SetActive(isLock);
			noLock.SetActive(!isLock);
		}
		else
		{
			isLocked.SetActive(isLock);
			noLock.SetActive(value: false);
		}
	}

	public void Init(ItemUnifierProxy itemUnifierProxy)
	{
		Equip equip = itemUnifierProxy.As<Equip>();
		if (equip != null)
		{
			Init(equip);
			return;
		}
		Gem gem = itemUnifierProxy.As<Gem>();
		if (gem != null)
		{
			Init(gem);
		}
	}

	public void Init(Equip equip)
	{
		equipGem = EquipGem.Equip;
		if (equip == null)
		{
			isLocked.SetActive(value: false);
			noLock.SetActive(value: false);
		}
		else
		{
			Init(equip.Uid, equip.IsLock);
		}
	}

	public void Init(Gem gem)
	{
		equipGem = EquipGem.Gem;
		if (gem == null)
		{
			isLocked.SetActive(value: false);
			noLock.SetActive(value: false);
		}
		else
		{
			Init(gem.Uid, gem.IsLock);
		}
	}

	public void ClickLock()
	{
		switch (equipGem)
		{
		case EquipGem.Equip:
		{
			Func<int, bool> canLock2 = CanLock;
			if (canLock2 != null && !canLock2(uid))
			{
				break;
			}
			Equip equip = G.localPlayer.Inventory.GetEquip(uid);
			G.service.LockEquip(equip.Uid, !equip.IsLock, (bool isSuccess) =>
			{
				if (isSuccess)
				{
					Equip equip2 = G.localPlayer.Inventory.GetEquip(uid);
					isLocked.SetActive(equip2.IsLock);
					noLock.SetActive(!equip2.IsLock);
					ItemChangeEvt evt = Singleton<EventManager>.instance.GetEvt<ItemChangeEvt>();
					evt.ItemProxies = ListPool<ItemUnifierProxy>.Get();
					evt.ItemProxies.Add(ItemUnifierProxy.ItemUnifierPool.Get(equip2));
					Singleton<EventManager>.instance.EventDispatch(ClientEvent.BagItemChange, evt);
					Singleton<EventManager>.instance.ReleaseEvt(evt);
				}
			});
			break;
		}
		case EquipGem.Gem:
		{
			Func<int, bool> canLock = CanLock;
			if (canLock != null && !canLock(uid))
			{
				break;
			}
			Gem gem = G.localPlayer.Inventory.GetGem(uid);
			G.service.LockGem(gem.Uid, !gem.IsLock, (bool isSuccess) =>
			{
				if (isSuccess)
				{
					Gem gem2 = G.localPlayer.Inventory.GetGem(uid);
					isLocked.SetActive(gem2.IsLock);
					noLock.SetActive(!gem2.IsLock);
					ItemChangeEvt evt = Singleton<EventManager>.instance.GetEvt<ItemChangeEvt>();
					evt.ItemProxies = ListPool<ItemUnifierProxy>.Get();
					evt.ItemProxies.Add(ItemUnifierProxy.ItemUnifierPool.Get(gem2));
					Singleton<EventManager>.instance.EventDispatch(ClientEvent.BagItemChange, evt);
					Singleton<EventManager>.instance.ReleaseEvt(evt);
				}
			});
			break;
		}
		}
	}
}
