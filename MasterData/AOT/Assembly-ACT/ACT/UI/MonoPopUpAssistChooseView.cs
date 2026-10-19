using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using Fundamental;

namespace ACT.UI;

public class MonoPopUpAssistChooseView : BaseUIView
{
	public MonoScrollBagComponent scrollBag;

	private MonoScrollBagComponent.Param scrollBagParam;

	private int curChooseAssistId;

	private void Start()
	{
		GetAssistData();
		scrollBagParam.itemShowType = MonoScrollBagComponent.Param.ItemShowType.None;
	}

	private void GetAssistData()
	{
		scrollBagParam.allItems.items = new List<Item>();
		foreach (KeyValuePair<int, ItemAssistData> itemAssistData in RuntimeConfigs.data.itemAssistDatas)
		{
			Item item = new Item();
			item.Id = itemAssistData.Key;
			scrollBagParam.allItems.items.Add(item);
		}
	}

	protected override void Init()
	{
		base.Init();
		curChooseAssistId = (int)uiViewData;
		scrollBag.Init(scrollBagParam, curChooseAssistId);
	}

	protected override void UnInit()
	{
		base.UnInit();
		uiViewData = null;
		scrollBag.ReleaseAllItemPrefab();
	}

	public void ConfirmBtn()
	{
		AssistChoose evt = Singleton<EventManager>.instance.GetEvt<AssistChoose>();
		evt.curAssistId = curChooseAssistId;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_Assit_Choose, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
		Close();
	}
}
