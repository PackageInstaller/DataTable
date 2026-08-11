using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class MapMarkItemViewBase : UGuiView
{
	[SerializeField]
	protected Image icon;

	[SerializeField]
	protected RectTransform item;

	[SerializeField]
	protected GameObject normalRoot;

	[SerializeField]
	protected GameObject outsideRoot;

	[SerializeField]
	protected Image outsideIcon;

	private Transform normalParent;

	private Transform overlayParent;

	private MapMarkItemViewModel.MarkLayer markLayer;

	protected MapMarkItemViewModel viewModel;

	protected virtual void LateUpdate()
	{
		if (viewModel == null)
		{
			return;
		}
		Vector2 pos = viewModel.Pos;
		if (item.anchoredPosition != pos)
		{
			item.anchoredPosition = pos;
		}
		if (normalRoot != null && outsideRoot != null)
		{
			if (normalRoot.activeSelf != !viewModel.IsOutside)
			{
				normalRoot.SetActive(!viewModel.IsOutside);
			}
			if (outsideRoot.activeSelf != viewModel.IsOutside)
			{
				outsideRoot.SetActive(viewModel.IsOutside);
			}
		}
	}

	public virtual void Init(MapMarkItemViewModel viewModel, Transform normalParent, Transform overlayParent)
	{
		this.viewModel = viewModel;
		this.normalParent = normalParent;
		this.overlayParent = overlayParent;
		ChangeMarkLayer(viewModel.Layer);
		BindingSet<MapMarkItemViewBase, MapMarkItemViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind().For((MapMarkItemViewBase v) => v.OnMarkLayerChanged).To((MapMarkItemViewModel vm) => vm.ChangeMarkLayerRst);
		if (icon != null)
		{
			bindingSet.Bind(icon).For((Image v) => v.sprite).To((MapMarkItemViewModel vm) => vm.Icon)
				.WithConversion("ItemIcon");
			bindingSet.Bind(icon.gameObject).For((GameObject v) => v.activeSelf).To((MapMarkItemViewModel vm) => vm.ShowIcon);
		}
		bindingSet.Bind(item).For((RectTransform v) => v.rotation).To((MapMarkItemViewModel vm) => vm.Rotation);
		bindingSet.Build();
	}

	public virtual void RefreshData(MapMarkItemViewModel viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
		ChangeMarkLayer(viewModel.Layer);
	}

	private void OnMarkLayerChanged(object sender, InteractionEventArgs e)
	{
		if (markLayer != viewModel.Layer)
		{
			ChangeMarkLayer(viewModel.Layer);
		}
	}

	private void ChangeMarkLayer(MapMarkItemViewModel.MarkLayer markLayer)
	{
		this.markLayer = markLayer;
		if (markLayer == MapMarkItemViewModel.MarkLayer.Normal && normalParent != null)
		{
			base.transform.SetParent(normalParent);
		}
		else if (markLayer == MapMarkItemViewModel.MarkLayer.Overlay && overlayParent != null)
		{
			base.transform.SetParent(overlayParent);
		}
	}
}
