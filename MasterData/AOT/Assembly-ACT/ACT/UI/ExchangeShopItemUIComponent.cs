using ACT.UI.CommonComponent;
using ACT.UI.DataProxy;
using ACT.Utility;
using Runtime.UI.CommonComponent.CommonTimer;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class ExchangeShopItemUIComponent : ItemUIComponentBase
{
	[Header("限购相关")]
	public GameObject limitRoot;

	public LocalizeStringEvent limitText;

	[Space(10f)]
	public CommonPriceComponent priceComponent;

	public GameObject soldOutRoot;

	[Header("限购倒计时")]
	public GameObject commonTimerRoot;

	public CommonTimerComponent commonTimer;

	[Header("数量已达上限提示")]
	public GameObject limitCountRoot;

	public BetterAnimation BetterAnimation => m_Animation;

	protected override void UpdateItemCount()
	{
		if ((bool)m_ItemCountRoot && (bool)m_NumberComponent)
		{
			if (m_ItemUnifier == null || m_ItemUnifier == ItemUnifierProxy.Empty)
			{
				m_ItemCountRoot.SetActive(value: false);
			}
			else
			{
				m_ItemCountRoot.SetActive(value: true);
			}
		}
	}

	public void SetItemCount(int count)
	{
		m_NumberComponent.UpdateNumber(count);
	}

	public override void UpdatePerformance()
	{
		base.UpdatePerformance();
		RefreshItemLimitState();
	}

	private void RefreshItemLimitState()
	{
		if (!(limitCountRoot == null))
		{
			if (m_ItemUnifier == null || m_ItemUnifier == ItemUnifierProxy.Empty)
			{
				limitCountRoot.SetActive(value: false);
				return;
			}
			GameUtility.CheckItemQuantityOwnedIsValid(m_ItemUnifier.Id, 0, out var result);
			limitCountRoot.SetActive(result.maxNum > 0 && result.leftCount == 0);
		}
	}
}
