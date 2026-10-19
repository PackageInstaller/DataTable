using System.Collections.Generic;
using ACT.Game;
using ACT.Game.Data;
using ACT.UI.DataProxy;
using Fundamental;
using Runtime.UI.CommonComponent.CommonScrollBag;
using UnityEngine;

namespace ACT.UI;

public class MonoTempleRewardView : BaseUIView
{
	public class TempleRewardData : UIViewData
	{
		public MonoScrollBagComponent.Param scrollBagParam;

		public bool noReward;

		public bool bossChallenge;
	}

	public CommonScrollBagComponent scrollBag;

	public GameObject complete;

	private bool m_canReceive;

	private bool m_subReceive;

	private bool m_isOption;

	public TempleRewardData param;

	protected override void Init()
	{
		base.Init();
		m_isOption = false;
		if (uiViewData != null)
		{
			param = (TempleRewardData)uiViewData;
			if (!param.noReward)
			{
				List<ItemUnifierProxy> list = new List<ItemUnifierProxy>();
				ItemUnifierProxy.ItemUnifierPool.GetList(param.scrollBagParam.allItems.items, list);
				scrollBag.gameObject.SetActive(value: true);
				scrollBag.ItemSource = list;
				scrollBag.CountShowType = ItemUIComponentBase.ItemCountShowType.OneSide;
			}
			else
			{
				scrollBag.gameObject.SetActive(value: false);
			}
		}
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Temple/Challenge_Success");
	}

	protected override void UnInit()
	{
		base.UnInit();
	}

	protected override void PlayOpenAnimation()
	{
		betterAnimation.GetSequence("RewardShow").Play();
	}

	protected override void PlayCloseAnimation()
	{
		betterAnimation.GetSequence("RewardHide").Play();
	}

	public async void LeaveTemple()
	{
		if (!m_isOption)
		{
			m_isOption = true;
			await CloseAsync();
			G.service.LeaveTemple((bool t) =>
			{
				Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Main);
			});
		}
	}

	public async void ReChallenge()
	{
		if (m_isOption)
		{
			return;
		}
		m_isOption = true;
		await CloseAsync();
		await Singleton<GameManager>.instance.worldManager.LeaveWorld();
		G.service.TempleRechallenge((bool t) =>
		{
			if (t)
			{
				Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Temple);
			}
		});
	}
}
