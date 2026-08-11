using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ArmourSuccessView : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private GameObject levelRoot;

	[SerializeField]
	private GameObject levelTitle;

	[SerializeField]
	private TextMeshProUGUI levelOld;

	[SerializeField]
	private TextMeshProUGUI levelNew;

	[SerializeField]
	private GameObject mainAttributeItem;

	[SerializeField]
	private GameObject subAttributeItem;

	[SerializeField]
	private Transform attributeRoot;

	[SerializeField]
	private GameObject unLockObj;

	private ArmourSuccessViewModel _viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<ArmourSuccessViewModel>();
		BindingSet<ArmourSuccessView, ArmourSuccessViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((ArmourSuccessView v) => v.OnDismissRequest).To((ArmourSuccessViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((ArmourSuccessViewModel vm) => vm.Close);
		bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((ArmourSuccessViewModel vm) => vm.ArmourData.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Build();
		Load();
	}

	private void Load()
	{
		levelRoot.SetActive(value: true);
		levelTitle.SetActive(value: true);
		((TMP_Text)levelOld).text = $"{_viewModel.OldLevel}";
		((TMP_Text)levelNew).text = $"{_viewModel.ArmourData.Level}";
		foreach (AttributeUpgradeItemData mainAttributeItem in _viewModel.MainAttributeItemList)
		{
			GameObject obj = Object.Instantiate(this.mainAttributeItem, attributeRoot);
			obj.transform.GetComponent<AttributeUpgradeItem>().Init(mainAttributeItem);
			obj.gameObject.SetActive(value: true);
		}
		foreach (AttributeUpgradeItemData subAttributeItem in _viewModel.SubAttributeItemList)
		{
			GameObject obj2 = Object.Instantiate(this.subAttributeItem, attributeRoot);
			obj2.transform.GetComponent<AttributeUpgradeItem>().Init(subAttributeItem);
			obj2.gameObject.SetActive(value: true);
		}
		unLockObj.gameObject.SetActive(_viewModel.ArmourData.Level == _viewModel.ArmourData.MaxLevel && _viewModel.ArmourData.AdditionalEntryNum > 0);
	}
}
