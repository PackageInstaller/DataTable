using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class AnnouncementTabItem : UGuiView
{
	[SerializeField]
	private Button btn;

	[SerializeField]
	private GameObject selected;

	[SerializeField]
	private GameObject normal;

	[SerializeField]
	private AnnouncementTabData viewModel;

	public void Init(AnnouncementTabData viewModel)
	{
		if (viewModel != null)
		{
			this.viewModel = viewModel;
			BindingSet<AnnouncementTabItem, AnnouncementTabData> bindingSet = this.CreateBindingSet(this.viewModel);
			bindingSet.Bind(btn).For((Button v) => v.onClick).To((AnnouncementTabData vm) => vm.TabOnClick);
			bindingSet.Bind(selected).For((GameObject v) => v.activeSelf).To((AnnouncementTabData vm) => vm.IsSelected);
			bindingSet.Bind(normal).For((GameObject v) => v.activeSelf).ToExpression((AnnouncementTabData vm) => !vm.IsSelected);
			bindingSet.Build();
		}
	}
}
