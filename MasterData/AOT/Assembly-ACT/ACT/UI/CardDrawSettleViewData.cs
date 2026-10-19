using System.Collections.Generic;
using Pb;

namespace ACT.UI;

public class CardDrawSettleViewData : UIViewData
{
	public List<GachaCardDrawItem> lististResult;

	public bool isNeedShowOpenAni;

	public bool isShowCharacter;

	public List<AcquireCharacterShowData> listNeedShow;

	public int gachaId;

	public int gachaType;
}
