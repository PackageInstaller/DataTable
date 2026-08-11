using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BoardHeroItem : UGuiView
{
	[SerializeField]
	private Image headIcon;

	[SerializeField]
	private GameObject select;

	[SerializeField]
	private Button itemBtn;

	[SerializeField]
	private GameObject customTag;

	private BoardHeroItemData _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<BoardHeroItemData>(userData);
		BindingSet<BoardHeroItem, BoardHeroItemData> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(headIcon).For((Image v) => v.sprite).To((BoardHeroItemData vm) => vm.HeadIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(select.gameObject).For((GameObject v) => v.activeSelf).To((BoardHeroItemData vm) => vm.IsSelected);
		bindingSet.Bind(itemBtn).For((Button v) => v.onClick).To((BoardHeroItemData vm) => vm.OnClick);
		bindingSet.Bind(customTag).For((GameObject v) => v.activeSelf).To((BoardHeroItemData vm) => vm.ShowCustomTag);
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		if (userData is BoardHeroItemData boardHeroItemData)
		{
			_viewModel = boardHeroItemData;
			this.SetDataContext(boardHeroItemData);
		}
	}
}
