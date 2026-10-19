using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class CardPool
{
	public readonly int id;

	public readonly int name;

	public readonly int poolType;

	public readonly int[] showPrice = new int[0];

	public readonly long poolStartTs;

	public readonly long poolEndTs;

	public readonly List<ItemKv> poolPrice;

	public readonly int fiveStarMustDrawNum;

	public readonly int fourStarMustDrawNum;

	public readonly int fiveStarWeight;

	public readonly int fiveStarRewardID;

	public readonly int upFiveStarWeight;

	public readonly int upFiveStarRewardID;

	public readonly int mustGotUpFiveStarNeedFiveStarNum;

	public readonly int fiveStarCorrectionNeedDrawNum;

	public readonly int fiveStarCorrection;

	public readonly int fourStarWeight;

	public readonly int fourStarRewardID;

	public readonly int totalWeight;

	public readonly int threeStarRewardID;

	public readonly bool cardPoolDefineFiveStar;

	public readonly int fiveStarShowAddress;

	public readonly int fiveStarShow;

	public readonly int[] fourStarShowAddress = new int[0];

	public readonly int btnIconNormal;

	public readonly int btnIconSelected;

	public readonly int[] rulePopupFiveItem = new int[0];

	public readonly int[] rulePopupFourItem = new int[0];

	public readonly int rulePupupDesc;

	public CardPool(int id, int name, int poolType, int[] showPrice, long poolStartTs, long poolEndTs, List<ItemKv> poolPrice, int fiveStarMustDrawNum, int fourStarMustDrawNum, int fiveStarWeight, int fiveStarRewardID, int upFiveStarWeight, int upFiveStarRewardID, int mustGotUpFiveStarNeedFiveStarNum, int fiveStarCorrectionNeedDrawNum, int fiveStarCorrection, int fourStarWeight, int fourStarRewardID, int totalWeight, int threeStarRewardID, bool cardPoolDefineFiveStar, int fiveStarShowAddress, int fiveStarShow, int[] fourStarShowAddress, int btnIconNormal, int btnIconSelected, int[] rulePopupFiveItem, int[] rulePopupFourItem, int rulePupupDesc)
	{
		this.id = id;
		this.name = name;
		this.poolType = poolType;
		this.showPrice = showPrice;
		this.poolStartTs = poolStartTs;
		this.poolEndTs = poolEndTs;
		this.poolPrice = poolPrice;
		this.fiveStarMustDrawNum = fiveStarMustDrawNum;
		this.fourStarMustDrawNum = fourStarMustDrawNum;
		this.fiveStarWeight = fiveStarWeight;
		this.fiveStarRewardID = fiveStarRewardID;
		this.upFiveStarWeight = upFiveStarWeight;
		this.upFiveStarRewardID = upFiveStarRewardID;
		this.mustGotUpFiveStarNeedFiveStarNum = mustGotUpFiveStarNeedFiveStarNum;
		this.fiveStarCorrectionNeedDrawNum = fiveStarCorrectionNeedDrawNum;
		this.fiveStarCorrection = fiveStarCorrection;
		this.fourStarWeight = fourStarWeight;
		this.fourStarRewardID = fourStarRewardID;
		this.totalWeight = totalWeight;
		this.threeStarRewardID = threeStarRewardID;
		this.cardPoolDefineFiveStar = cardPoolDefineFiveStar;
		this.fiveStarShowAddress = fiveStarShowAddress;
		this.fiveStarShow = fiveStarShow;
		this.fourStarShowAddress = fourStarShowAddress;
		this.btnIconNormal = btnIconNormal;
		this.btnIconSelected = btnIconSelected;
		this.rulePopupFiveItem = rulePopupFiveItem;
		this.rulePopupFourItem = rulePopupFourItem;
		this.rulePupupDesc = rulePupupDesc;
	}
}
