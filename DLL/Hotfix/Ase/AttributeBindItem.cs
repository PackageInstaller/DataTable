using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class AttributeBindItem : UGuiView
{
	[SerializeField]
	private Image heroAttributeIcon;

	[SerializeField]
	private Image heroImage;

	[SerializeField]
	private RectTransform rect;

	[SerializeField]
	private GameObject skillDesc;

	[SerializeField]
	private UIGameObjectSort uiGameObjectSort;

	[SerializeField]
	private GameObject emptyObj;

	[SerializeField]
	private GameObject realObj;

	private AttributeBindItemData viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<AttributeBindItemData>(userData);
		BindingSet<AttributeBindItem, AttributeBindItemData> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(heroAttributeIcon).For((Image v) => v.sprite).To((AttributeBindItemData vm) => vm.HeroAttribute)
			.WithConversion("ItemIcon");
		bindingSet.Bind(heroImage).For((Image v) => v.sprite).To((AttributeBindItemData vm) => vm.HeroImg)
			.WithConversion("ItemIcon");
		bindingSet.Bind(emptyObj).For((GameObject v) => v.activeSelf).To((AttributeBindItemData vm) => vm.IsEmpty);
		bindingSet.Bind(realObj).For((GameObject v) => v.activeSelf).ToExpression((AttributeBindItemData vm) => !vm.IsEmpty);
		bindingSet.Build();
		SetContextRect();
	}

	public void RefreshAttributeData(AttributeBindItemData viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(this);
		SetContextRect();
	}

	private void SetContextRect()
	{
		for (int i = 0; i < rect.childCount; i++)
		{
			Object.Destroy(rect.GetChild(i).gameObject);
		}
		GameObject obj = Object.Instantiate(skillDesc, rect);
		((TMP_Text)obj.transform.GetComponent<TextMeshProUGUI>()).text = viewModel.HeroSkillDesc;
		obj.gameObject.SetActive(value: true);
		uiGameObjectSort.Sort();
	}
}
