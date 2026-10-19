using System;
using System.Collections.Generic;
using Pb;

namespace ACT.UI;

public class AcquireCharacterShowConfig
{
	public List<AcquireCharacterShowData> _listsNeedShow;

	public List<GachaCardDrawItem> _listsCardDrawSettle;

	public bool isNeedSettle;

	public bool isNeedShowOpenAni;

	public Action onAllShowComplete;

	public Action onCloseCallback;
}
