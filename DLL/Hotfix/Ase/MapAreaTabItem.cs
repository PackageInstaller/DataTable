using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class MapAreaTabItem : UGuiView
{
	[SerializeField]
	private GameObject normal;

	[SerializeField]
	private GameObject highLight;

	[SerializeField]
	private Image normalIcon;

	[SerializeField]
	private Image highLightIcon;

	[SerializeField]
	private TextMeshProUGUI normalText;

	[SerializeField]
	private TextMeshProUGUI highLightText;

	[SerializeField]
	private List<Image> trackTagIcons;

	[SerializeField]
	private List<GameObject> playerLocationTags;

	[SerializeField]
	private Button tabBtn;

	private MapAreaTabItemData _viewModel;

	public MapAreaTabItemData ViewModel => _viewModel;

	protected override void OnInit(object userData)
	{
		_viewModel = GetUserData<MapAreaTabItemData>(userData);
		BindingSet<MapAreaTabItem, MapAreaTabItemData> bindingSet = this.CreateBindingSet(_viewModel);
		if (normalIcon != null && highLightIcon != null && _viewModel.DrSectionMap != null)
		{
			bindingSet.Bind(normalIcon).For((Image v) => v.sprite).ToExpression((MapAreaTabItemData vm) => $"section_{vm.Id}_normal")
				.WithConversion("ItemIcon");
			bindingSet.Bind(highLightIcon).For((Image v) => v.sprite).ToExpression((MapAreaTabItemData vm) => $"section_{vm.Id}_selected")
				.WithConversion("ItemIcon");
		}
		if ((UnityEngine.Object)(object)normalText != null && (UnityEngine.Object)(object)highLightText != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(normalText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((MapAreaTabItemData vm) => vm.Name);
			bindingSet.Bind<TextMeshProUGUI>(highLightText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((MapAreaTabItemData vm) => vm.Name);
		}
		if (highLight != null)
		{
			bindingSet.Bind(highLight).For((GameObject v) => v.activeSelf).To((MapAreaTabItemData vm) => vm.IsSelected);
		}
		if (normal != null)
		{
			bindingSet.Bind(normal).For((GameObject v) => v.activeSelf).ToExpression((MapAreaTabItemData vm) => !vm.IsSelected);
		}
		if (trackTagIcons != null && trackTagIcons.Count > 0)
		{
			foreach (Image trackTagIcon in trackTagIcons)
			{
				bindingSet.Bind(trackTagIcon.gameObject).For((GameObject v) => v.activeSelf).ToExpression((MapAreaTabItemData vm) => !string.IsNullOrEmpty(vm.TagIcon) && !vm.DisableAllTags);
				bindingSet.Bind(trackTagIcon).For((Image v) => v.sprite).To((MapAreaTabItemData vm) => vm.TagIcon)
					.WithConversion("ItemIcon");
			}
		}
		if (playerLocationTags != null && playerLocationTags.Count > 0)
		{
			foreach (GameObject playerLocationTag in playerLocationTags)
			{
				bindingSet.Bind(playerLocationTag).For((GameObject v) => v.activeSelf).ToExpression((MapAreaTabItemData vm) => vm.PlayerLocationTag && !vm.DisableAllTags);
			}
		}
		bindingSet.Bind(tabBtn).For((Button v) => v.onClick).To((MapAreaTabItemData vm) => vm.OnItemClick);
		bindingSet.Build();
	}

	public void RefreshData(MapAreaTabItemData data)
	{
		_viewModel = data;
		this.SetDataContext(data);
	}

	public void SetTextVisible(bool visible)
	{
		if ((UnityEngine.Object)(object)normalText != null)
		{
			((Component)(object)normalText).gameObject.SetActive(visible);
		}
		if ((UnityEngine.Object)(object)highLightText != null)
		{
			((Component)(object)highLightText).gameObject.SetActive(visible);
		}
	}
}
