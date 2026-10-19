using ACT.UI;
using Fundamental;
using UnityEngine;

namespace ACT.Config;

public class FindObjByCustomUICompType : FindHighlightObjAction
{
	public CustomUICompType customUICompType;

	public FindObjByCustomUICompType()
	{
		uiType = UI_TYPE.UI_BATTLEMAIN;
	}

	public FindObjByCustomUICompType(FindObjByCustomUICompType other)
		: base(other)
	{
		uiType = other.uiType;
		path = other.path;
		customUICompType = other.customUICompType;
	}

	public override Transform Find(object findParam = null)
	{
		MonoBattleMainBaseView monoBattleMainBaseView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_BATTLEMAIN) as MonoBattleMainBaseView;
		if (monoBattleMainBaseView?.operateBtnComp == null)
		{
			return null;
		}
		return monoBattleMainBaseView.operateBtnComp.GetBattleCharacterOperateBtnUI(customUICompType)?.transform;
	}
}
