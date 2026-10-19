using System;
using System.Collections.Generic;
using ACT.Game.Data;
using Pb;

namespace ACT.UI;

public class AcquireCharacterShowViewData : UIViewData
{
	public List<AcquireCharacterShowItemData> _listsNeedShow;

	public List<GachaCardDrawItem> _listsCardDrawSettle;

	public List<Item> items;

	public bool isNeedSettle;

	public UI_TYPE _backUIType = UI_TYPE.UI_CARDDRAW;

	public bool isNeedShowOpenAni;

	public Action onAllShowComplete;

	public Action onCloseCallback;
}
