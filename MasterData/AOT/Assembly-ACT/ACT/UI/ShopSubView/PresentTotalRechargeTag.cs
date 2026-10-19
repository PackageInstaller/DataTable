using ACT.Config;
using ACT.Model;
using TMPro;
using UnityEngine;

namespace ACT.UI.ShopSubView;

public class PresentTotalRechargeTag : MonoBehaviour
{
	[SerializeField]
	private TextMeshProUGUI rechargeAmountText;

	public void SetAmount(int amount)
	{
		bool flag = amount > 0 && IsTotalRechargeActivityOpening();
		gameObject.SetActive(flag);
		if (flag)
		{
			rechargeAmountText?.SetText("{0}", amount);
		}
	}

	private static bool IsTotalRechargeActivityOpening()
	{
		foreach (ActivityCenterData openingActivity in Model<ActivityCenterModel>.Interface.GetOpeningActivitys())
		{
			ActivityData staticActivityData = openingActivity.StaticActivityData;
			if (staticActivityData != null && staticActivityData.activityType == 10)
			{
				return true;
			}
		}
		return false;
	}
}
