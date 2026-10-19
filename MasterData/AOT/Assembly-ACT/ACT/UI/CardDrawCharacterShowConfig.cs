using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using Pb;

namespace ACT.UI;

public class CardDrawCharacterShowConfig
{
	public List<CardDrawCharacterShowData> showItems;

	public List<GachaCardDrawItem> settleItems;

	public bool isNeedSettle;

	public bool isNeedShowOpenAni;

	public int gachaId;

	public int gachaType;

	public Func<CardDrawCharacterShowData, UniTask> onBeforeShowItemAsync;

	public Func<bool> shouldAbortCurrentShow;

	public Action onAllShowComplete;

	public Action onCloseCallback;
}
