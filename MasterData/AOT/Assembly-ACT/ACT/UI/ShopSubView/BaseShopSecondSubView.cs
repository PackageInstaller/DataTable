using System;
using ACT.Config;
using ACT.Sound;
using ACT.UI.CommonComponent.CoinComponent;
using ACT.UI.Interface;
using Fundamental;

namespace ACT.UI.ShopSubView;

public class BaseShopSecondSubView : BaseShopSecondSubView<BaseShopSecondSubViewInputController>
{
}
public class BaseShopSecondSubView<T> : BaseTabContent<T> where T : class, ISubInputController, new()
{
	public AudioEventReference openAudioEvent;

	protected ShopSecondTab ShopSecondTab => Tab as ShopSecondTab;

	protected override void OnTabActive(ITabItem tabItem)
	{
		base.OnTabActive(tabItem);
		RefreshFirstSubViewCoinGroup();
		FocusIn();
		PlayOpenSound();
	}

	private void RefreshFirstSubViewCoinGroup()
	{
		SubshopData subshopData = ShopSecondTab?.SubShopData;
		if (!(ShopSecondTab?.ParentTab?.Content is BaseShopFirstSubView baseShopFirstSubView) || baseShopFirstSubView.CoinGroup == null)
		{
			return;
		}
		int[] array = subshopData?.moneyId;
		if (array == null || array.Length <= 0)
		{
			baseShopFirstSubView.CoinGroup.RefreshCoinComponents();
			return;
		}
		CoinComponentConfig[] array2 = new CoinComponentConfig[subshopData.moneyId.Length];
		for (int i = 0; i < subshopData.moneyId.Length; i++)
		{
			array2[i] = new CoinComponentConfig
			{
				itemId = subshopData.moneyId[i],
				hasPlusButton = IsDiamondCoin(subshopData.moneyId[i])
			};
		}
		baseShopFirstSubView.CoinGroup.RefreshCoinComponents(array2);
	}

	private bool IsDiamondCoin(int itemId)
	{
		if (itemId != 98)
		{
			return itemId == 97;
		}
		return true;
	}

	protected override void OnTabDeActive(ITabItem tabItem)
	{
		base.OnTabDeActive(tabItem);
		FocusOut();
	}

	protected override void OnRelease()
	{
		base.OnRelease();
		OnTabDeActive(Tab);
	}

	public override void PlayOpenAnim()
	{
		if (anim != null)
		{
			anim.GetSequence("Show")?.Play();
		}
	}

	public override void PlayCloseAnim(Action onComplete = null)
	{
		if (anim != null)
		{
			anim.GetSequence("Hide")?.OnComplete((AnimationBuilder _) =>
			{
				onComplete?.Invoke();
			}).Play();
		}
		else
		{
			onComplete?.Invoke();
		}
	}

	private void PlayOpenSound()
	{
		if (!openAudioEvent.IsNull())
		{
			Singleton<GameManager>.instance.audioManager.PlaySound(openAudioEvent);
		}
	}
}
