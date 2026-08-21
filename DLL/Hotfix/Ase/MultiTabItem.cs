using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class MultiTabItem : TabItem
{
	[SerializeField]
	private RectTransform subTabRoot;

	[SerializeField]
	private TabItem subTabTpl;

	private MultiTabItemData _viewModel;

	private GameObjectPool _subTabPool;

	public new MultiTabItemData ViewModel => _viewModel;

	public void Init(MultiTabItemData viewModel)
	{
		Init((TabItemData)viewModel);
		_viewModel = viewModel;
		_subTabPool = new GameObjectPool(subTabTpl.gameObject, subTabRoot);
		subTabRoot.gameObject.SetActive(value: false);
		BindingSet<MultiTabItem, MultiTabItemData> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind().For((MultiTabItem v) => v.ShowSubTabs).To((MultiTabItemData vm) => vm.ShowSubTabsRst);
		bindingSet.Bind().For((MultiTabItem v) => v.HideSubTabs).To((MultiTabItemData vm) => vm.HideSubTabsRst);
		bindingSet.Build();
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		if (_viewModel.CacheVisible)
		{
			ShowSubTabs();
		}
		else
		{
			HideSubTabs();
		}
	}

	public void RefreshData(MultiTabItemData viewModel)
	{
		RefreshData((object)viewModel);
		_viewModel = viewModel;
		this.SetDataContext(viewModel);
		HideSubTabs();
	}

	private void ShowSubTabs(object sender = null, InteractionEventArgs e = null)
	{
		int num = _viewModel.SubTabSelectIndex;
		_subTabPool.RecycleAll();
		subTabRoot.gameObject.SetActive(_viewModel.SubTabDatas.Count > 0);
		if (num > 0)
		{
			bool flag = false;
			foreach (TabItemData subTabData in _viewModel.SubTabDatas)
			{
				if (subTabData.TabIndex == num)
				{
					flag = true;
					break;
				}
			}
			num = (flag ? num : 0);
		}
		for (int i = 0; i < _viewModel.SubTabDatas.Count; i++)
		{
			TabItem component = _subTabPool.Allocate(out var newCreate).GetComponent<TabItem>();
			if (newCreate)
			{
				component.Init(_viewModel.SubTabDatas[i]);
			}
			else
			{
				component.RefreshData(_viewModel.SubTabDatas[i]);
			}
			if (num == 0 && i == 0)
			{
				component.ViewModel.TabOnClick();
			}
			else if (num > 0 && _viewModel.SubTabDatas[i].TabIndex == num)
			{
				component.ViewModel.TabOnClick();
			}
			component.transform.SetAsLastSibling();
			component.gameObject.SetActive(value: true);
		}
	}

	private void HideSubTabs(object sender = null, InteractionEventArgs e = null)
	{
		_subTabPool.RecycleAll();
		subTabRoot.gameObject.SetActive(value: false);
	}

	protected override void OnDestroy()
	{
		_subTabPool?.Dispose();
		_subTabPool = null;
		base.OnDestroy();
	}
}
