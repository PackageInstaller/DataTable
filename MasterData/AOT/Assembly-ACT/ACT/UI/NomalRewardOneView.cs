using System.Collections.Generic;
using ACT.UI.DataProxy;
using Cysharp.Threading.Tasks;

namespace ACT.UI;

public class NomalRewardOneView : BaseRewardView
{
	private NomalRewardOneViewData m_data;

	private List<ItemUnifierProxy> _displayItemList;

	protected override void AddEventListener()
	{
		base.AddEventListener();
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
		m_data = uiViewData as NomalRewardOneViewData;
	}

	protected override void ProcessRewardItems()
	{
	}

	protected override void ConfigureScrollBag()
	{
		base.ConfigureScrollBag();
		if (m_data?.itemList != null)
		{
			_displayItemList = BuildRewardItemProxies(m_data.itemList);
			scrollBag.ItemSource = _displayItemList;
		}
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	public override void Close()
	{
		if (m_data?.onClose != null)
		{
			m_data.onClose();
		}
		base.Close();
	}

	protected override void UnInit()
	{
		base.UnInit();
		if (_displayItemList != null)
		{
			ItemUnifierProxy.ItemUnifierPool.Release(_displayItemList);
			_displayItemList = null;
		}
	}
}
