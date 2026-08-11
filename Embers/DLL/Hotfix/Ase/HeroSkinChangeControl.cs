using System;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class HeroSkinChangeControl : MonoBehaviour
{
	private bool isInit;

	private ISubscription<HeroMessage> subscription_HeroSkinChangeNotify;

	private Action<int> onHeroSkinChange;

	private void OnEnable()
	{
		if (!isInit)
		{
			subscription_HeroSkinChangeNotify = Context.GetApplicationContext()?.GetService<IMessenger>()?.Subscribe<HeroMessage>(OnHeroSkinChanged);
			isInit = true;
		}
	}

	private void OnHeroSkinChanged(HeroMessage message)
	{
		if (onHeroSkinChange != null && message.Type == HeroMessageEnum.HeroSkinChanged)
		{
			int obj = (int)message.Arg;
			onHeroSkinChange(obj);
		}
	}

	public void AddHeroSkinChangeAction(Action<int> heroSkinChangeAction)
	{
		onHeroSkinChange = (Action<int>)Delegate.Combine(onHeroSkinChange, heroSkinChangeAction);
	}

	private void OnDestroy()
	{
		if (subscription_HeroSkinChangeNotify != null)
		{
			subscription_HeroSkinChangeNotify.Dispose();
		}
		if (onHeroSkinChange != null)
		{
			onHeroSkinChange = null;
		}
	}
}
