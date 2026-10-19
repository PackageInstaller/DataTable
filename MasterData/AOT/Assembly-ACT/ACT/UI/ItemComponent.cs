using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class ItemComponent : MonoBehaviour
{
	public TMP_Text TextItemNum;

	public BImage ImageItemIcon;

	public int Itemid;

	private long ItemNum;

	public void Init(int id, BaseUIView view)
	{
		Itemid = id;
		ItemData data = CoreUtils.GetData(Itemid, RuntimeConfigs.data.itemDatas);
		SetNum();
		view.Station.LoadItemIcon(data.iconAddress, ImageItemIcon);
	}

	private void SetNum()
	{
		int countById = G.localPlayer.GetCountById(Itemid);
		FreshItemNum(countById);
	}

	private void OnEnable()
	{
		AddListener();
	}

	private void OnDisable()
	{
		RemoveListener();
	}

	private void FreshItemNum(long Count)
	{
		ItemNum = Count;
		TextItemNum.text = Count.ToString();
	}

	public void AddListener()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.ItemAdd, ReFreshItemNum);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.ItemMinus, ReFreshItemNum);
	}

	public void RemoveListener()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ItemAdd, ReFreshItemNum);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ItemMinus, ReFreshItemNum);
	}

	public void ReFreshItemNum(BaseEventContent obj)
	{
		if (((ItemUnifierProxyEvt)obj).data.Id == Itemid)
		{
			SetNum();
		}
	}
}
