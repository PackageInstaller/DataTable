using System.Collections.Generic;

namespace Ase;

public class GuildActivityViewModel : OptionBase
{
	private List<GuildActivityItemViewModel> itemDatas;

	public List<GuildActivityItemViewModel> ItemDatas => itemDatas;

	public GuildActivityViewModel()
	{
	}

	public GuildActivityViewModel(OptionBase parent)
	{
		base.parent = parent;
		itemDatas = new List<GuildActivityItemViewModel>();
		GuildActivityItemViewModel item = new GuildActivityItemViewModel(this, Singleton<ServiceSystem>.Instance.GetService<IGuildService>()?.GetGuildActivityData());
		itemDatas.Add(item);
	}

	public override void ItemOnClick(object obj)
	{
		parent?.ItemOnClick(obj);
	}

	public GuildActivityItemViewModel GetValidExpetionItem(CopyData copyData)
	{
		for (int i = 0; i < itemDatas.Count; i++)
		{
			if (itemDatas[i].Data != null && itemDatas[i].Data.GetGuildCopyDataByCopyId(copyData.Id) != null)
			{
				if (itemDatas[i].Data.IsEntireTimeLock)
				{
					return null;
				}
				return itemDatas[i];
			}
		}
		return null;
	}
}
