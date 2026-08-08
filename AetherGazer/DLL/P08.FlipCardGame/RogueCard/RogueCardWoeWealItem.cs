using ControllerExSpace;
using UnityEngine;
using UnityEngine.UI;

namespace RogueCard;

public class RogueCardWoeWealItem : MonoBehaviour
{
	public Text wealText;

	public Text woeText;

	public ControllerExCollection conEx;

	[HideInInspector]
	private ControllerEx wealCon;

	[HideInInspector]
	private ControllerEx woeCon;

	[HideInInspector]
	private ControllerEx numCon;

	public void OnEnter()
	{
		wealCon = conEx.GetController("nonactivated");
		woeCon = conEx.GetController("eliminated");
		numCon = conEx.GetController("num");
	}

	public void SetData(int wealID, int woeID, bool isFinish, bool isLast)
	{
		numCon.SetSelectedState(isLast ? "one" : "two");
		RogueCardWealAndWoeCfg rogueCardWealAndWoeCfg = RogueCardDataManager.wealAndWoeDatabase[wealID];
		RogueCardWealAndWoeCfg rogueCardWealAndWoeCfg2 = RogueCardDataManager.wealAndWoeDatabase[woeID];
		RogueCardTipSystem.SetRichText(wealText, rogueCardWealAndWoeCfg.desc);
		RogueCardTipSystem.SetRichText(woeText, rogueCardWealAndWoeCfg2.desc);
		if (isFinish)
		{
			wealCon.SetSelectedState("off");
			woeCon.SetSelectedState("on");
		}
		else
		{
			wealCon.SetSelectedState("on");
			woeCon.SetSelectedState("off");
		}
	}

	public void SetActive(bool isActive)
	{
		base.gameObject.SetActive(isActive);
	}
}
