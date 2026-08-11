using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class WeaponSuccessView : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private GameObject levelTitle;

	[SerializeField]
	private GameObject starTitle;

	[SerializeField]
	private GameObject refineTitle;

	[SerializeField]
	private TextMeshProUGUI levelOld;

	[SerializeField]
	private TextMeshProUGUI levelNew;

	[SerializeField]
	private UIStarGroup uiStarGroup;

	[SerializeField]
	private TextMeshProUGUI lvMax;

	[SerializeField]
	private GameObject levelRoot;

	[SerializeField]
	private GameObject starRoot;

	[SerializeField]
	private GameObject refineRoot;

	[SerializeField]
	private TextMeshProUGUI refineText;

	[SerializeField]
	private Transform root;

	[SerializeField]
	private GameObject attributeItem;

	[SerializeField]
	private GameObject entryItem;

	[SerializeField]
	private GameObject effectItem;

	[SerializeField]
	private UIGameObjectSort uIGameObjectSort;

	private WeaponSuccessViewModel _viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<WeaponSuccessViewModel>();
		BindingSet<WeaponSuccessView, WeaponSuccessViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((WeaponSuccessView v) => v.OnDismissRequest).To((WeaponSuccessViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((WeaponSuccessViewModel vm) => vm.Close);
		bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((WeaponSuccessViewModel vm) => vm.WeaponData.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Build();
		Load();
	}

	private void Load()
	{
		if (_viewModel.WeaponUpMode == WeaponUpMode.UpStar)
		{
			starTitle.SetActive(value: true);
			starRoot.SetActive(value: true);
			uiStarGroup.CurCount = _viewModel.WeaponData.Star - 1;
			((TMP_Text)lvMax).text = $"等级上限开放至{_viewModel.WeaponData.MaxLevel}";
			for (int i = 0; i < _viewModel.AttributeUpgradeItemDataList.Count; i++)
			{
				GameObject obj = Object.Instantiate(attributeItem, root);
				obj.transform.GetComponent<AttributeUpgradeItem>().Init(_viewModel.AttributeUpgradeItemDataList[i]);
				obj.gameObject.SetActive(value: true);
			}
			for (int j = 0; j < _viewModel.EntryUpgradeItemDataList.Count; j++)
			{
				GameObject obj2 = Object.Instantiate(entryItem, root);
				obj2.transform.GetComponent<EntryUpgradeItem>().Init(_viewModel.EntryUpgradeItemDataList[j]);
				obj2.gameObject.SetActive(value: true);
			}
		}
		else if (_viewModel.WeaponUpMode == WeaponUpMode.Upgrade)
		{
			levelTitle.SetActive(value: true);
			levelRoot.SetActive(value: true);
			((TMP_Text)levelOld).text = _viewModel.OldLevel.ToString();
			((TMP_Text)levelNew).text = _viewModel.WeaponData.Level.ToString();
			for (int k = 0; k < _viewModel.AttributeUpgradeItemDataList.Count; k++)
			{
				GameObject obj3 = Object.Instantiate(attributeItem, root);
				obj3.transform.GetComponent<AttributeUpgradeItem>().Init(_viewModel.AttributeUpgradeItemDataList[k]);
				obj3.gameObject.SetActive(value: true);
			}
		}
		else
		{
			refineTitle.SetActive(value: true);
			refineRoot.SetActive(value: true);
			((TMP_Text)refineText).text = $"精炼至{_viewModel.WeaponData.WeaponRefine}阶";
			((TMP_Text)effectItem.transform.Find("EffectName").GetComponent<TextMeshProUGUI>()).text = _viewModel.WeaponData.EffectName;
			((TMP_Text)effectItem.transform.Find("EffectDesc").GetComponent<TextMeshProUGUI>()).text = _viewModel.WeaponData.EffectDesc;
			effectItem.SetActive(value: true);
		}
		uIGameObjectSort.Sort();
	}
}
