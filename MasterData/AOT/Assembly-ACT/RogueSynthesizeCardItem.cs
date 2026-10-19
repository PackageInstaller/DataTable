using System.Collections.Generic;
using ACT.Model;
using ACT.UI;
using ACT.Utility;
using Fundamental;
using UnityEngine;
using UnityEngine.UI;

public class RogueSynthesizeCardItem : LoopScrollBaseItem
{
	public GameObject GoMain;

	public GameObject GoVicerogue;

	public Button BtnClick;

	public List<GameObject> Gorarity;

	public override void ScrollCellIndex(int idx)
	{
		RogueCardSynthesizeView synthesizeview = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_ROGUECARDSYNTHESIZE) as RogueCardSynthesizeView;
		if (synthesizeview != null)
		{
			RogueCard CardInfo = Model<RoGueModel>.Interface.GetRogueCardData(idx);
			GoMain.SetActive(synthesizeview.GetCurrentMainCardId == CardInfo.id);
			GoVicerogue.SetActive(synthesizeview.GetCurrentVicerogueCardId == CardInfo.id);
			BtnClick.SetBtnClick(() =>
			{
				synthesizeview.ShowCard(CardInfo);
			});
			for (int num = 0; num < Gorarity.Count; num++)
			{
				Gorarity[num].SetActive(CardInfo.rarity - 1 == num);
			}
		}
	}
}
