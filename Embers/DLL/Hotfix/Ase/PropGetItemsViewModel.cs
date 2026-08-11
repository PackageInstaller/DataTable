using System.Collections.Generic;

namespace Ase;

public class PropGetItemsViewModel : OptionBase
{
	private List<KnapsackItemViewModel> propGetList;

	public List<KnapsackItemViewModel> PropGetList => propGetList;

	public override void ItemOnClick(object obj)
	{
		parent?.ItemOnClick(obj);
	}

	public PropGetItemsViewModel()
	{
	}

	public PropGetItemsViewModel(OptionBase parent, List<PropDataBase> itemsGet)
	{
		base.parent = parent;
		propGetList = new List<KnapsackItemViewModel>();
		if (itemsGet != null)
		{
			foreach (PropDataBase item in itemsGet)
			{
				propGetList.Add(new KnapsackItemViewModel(this, item));
			}
		}
		propGetList.Sort(new PropGetSort());
	}

	public PropGetItemsViewModel(OptionBase parent, List<KnapsackPropData> itemsGet)
	{
		base.parent = parent;
		propGetList = new List<KnapsackItemViewModel>();
		if (itemsGet != null)
		{
			foreach (KnapsackPropData item in itemsGet)
			{
				propGetList.Add(new KnapsackItemViewModel(this, item));
			}
		}
		propGetList.Sort(new PropGetSort());
	}

	public PropGetItemsViewModel(OptionBase parent, List<PropData> itemsGet)
	{
		base.parent = parent;
		propGetList = new List<KnapsackItemViewModel>();
		if (itemsGet != null)
		{
			foreach (PropData item in itemsGet)
			{
				propGetList.Add(new KnapsackItemViewModel(this, item));
			}
		}
		propGetList.Sort(new PropGetSort());
	}

	public void MergeProp()
	{
		Dictionary<int, KnapsackItemViewModel> dictionary = new Dictionary<int, KnapsackItemViewModel>();
		foreach (KnapsackItemViewModel propGet in propGetList)
		{
			if (propGet.PropDataBase.PropTypeEnum != PropTypeEnum.Hero)
			{
				if (dictionary.ContainsKey(propGet.PropDataBase.Id))
				{
					dictionary[propGet.PropDataBase.Id].PropDataBase.Amount += propGet.PropDataBase.Amount;
				}
				else
				{
					dictionary.Add(propGet.PropDataBase.Id, propGet);
				}
			}
		}
		propGetList.Clear();
		foreach (KeyValuePair<int, KnapsackItemViewModel> item in dictionary)
		{
			propGetList.Add(item.Value);
		}
	}
}
