using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ArmourScreenItem : UGuiView
{
	[SerializeField]
	private TextMeshProUGUI itemName;

	[SerializeField]
	private GameObject selected;

	[SerializeField]
	private Button rightBtn;

	[SerializeField]
	private GameObject openIcon;

	[SerializeField]
	private GameObject closeIcon;

	[SerializeField]
	private Transform content;

	[SerializeField]
	private GameObject armourScreenTagItem;

	[SerializeField]
	private RectTransform self;

	[SerializeField]
	private VerticalLayoutGroup _verticalLayoutGroup;

	[SerializeField]
	private GameObject contentObj;

	private ArmourScreenItemData _viewModel;

	private float _originalHeight;

	private float _newHeight;

	public void Init(ArmourScreenItemData viewModel)
	{
		_viewModel = viewModel;
		BindingSet<ArmourScreenItem, ArmourScreenItemData> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind<TextMeshProUGUI>(itemName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ArmourScreenItemData vm) => vm.ShowText);
		bindingSet.Bind(selected).For((GameObject v) => v.activeSelf).To((ArmourScreenItemData vm) => vm.IsSelected);
		bindingSet.Bind(rightBtn).For((Button v) => v.onClick).To((ArmourScreenItemData vm) => vm.ButtonOnclick);
		bindingSet.Bind(openIcon).For((GameObject v) => v.activeSelf).To((ArmourScreenItemData vm) => vm.IsSelected);
		bindingSet.Bind(closeIcon).For((GameObject v) => v.activeSelf).ToExpression((ArmourScreenItemData vm) => !vm.IsSelected);
		bindingSet.Bind(contentObj).For((GameObject v) => v.activeSelf).To((ArmourScreenItemData vm) => vm.IsSelected);
		bindingSet.Bind(this).For((ArmourScreenItem v) => v.CloseButton).To((ArmourScreenItemData vm) => vm.CloseRequest);
		bindingSet.Build();
		_originalHeight = self.transform.GetComponent<RectTransform>().rect.height;
		rightBtn.onClick.AddListener(SetHeight);
		InitArmourScreenItem();
	}

	private void InitArmourScreenItem()
	{
		foreach (ArmourScreenTagItemData armourScreenTagItemDatum in _viewModel.ArmourScreenTagItemData)
		{
			ArmourScreenTagItem component = UnityEngine.Object.Instantiate(armourScreenTagItem, content).GetComponent<ArmourScreenTagItem>();
			component.Init(armourScreenTagItemDatum);
			component.gameObject.SetActive(value: true);
		}
	}

	private void SetHeight()
	{
		if (_viewModel.IsSelected)
		{
			float size = content.transform.GetComponent<RectTransform>().rect.height + _verticalLayoutGroup.spacing + _originalHeight;
			self.SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, size);
			contentObj.GetComponent<RectTransform>().SetInsetAndSizeFromParentEdge(RectTransform.Edge.Bottom, 0f, 0f);
			LayoutRebuilder.ForceRebuildLayoutImmediate(content.transform.GetComponent<RectTransform>());
		}
		else
		{
			self.SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, _originalHeight);
		}
	}

	private void CloseButton(object sender, InteractionEventArgs e)
	{
		rightBtn.onClick.Invoke();
	}
}
