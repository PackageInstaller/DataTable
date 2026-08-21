using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ArmourPresetEmptyItem : UGuiView
{
	[SerializeField]
	private Button btn;

	[SerializeField]
	private TextMeshProUGUI positionText;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private GameObject redPoint;

	private ArmourPresetEquipItemData viewModel;

	public void Init(ArmourPresetEquipItemData viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<ArmourPresetEmptyItem, ArmourPresetEquipItemData> bindingSet = this.CreateBindingSet(viewModel);
		if ((UnityEngine.Object)(object)positionText != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(positionText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ArmourPresetEquipItemData vm) => vm.PositionName);
		}
		if (icon != null)
		{
			bindingSet.Bind(icon).For((Image v) => v.sprite).To((ArmourPresetEquipItemData vm) => vm.EmptyIconPath)
				.WithConversion("ItemIcon");
		}
		if (redPoint != null)
		{
			bindingSet.Bind(redPoint).For((GameObject v) => v.activeSelf).To((ArmourPresetEquipItemData vm) => vm.ShowRedPoint);
		}
		bindingSet.Build();
		if (btn != null)
		{
			btn.onClick.AddListener(OnClick);
		}
	}

	public void RefreshData(ArmourPresetEquipItemData viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
	}

	private void OnClick()
	{
		viewModel?.OnClick();
	}
}
