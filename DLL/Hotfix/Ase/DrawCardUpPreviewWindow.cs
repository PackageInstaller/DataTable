using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class DrawCardUpPreviewWindow : UGuiWindowBase
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private Button btnBack2;

	[SerializeField]
	private TextMeshProUGUI titleText;

	[SerializeField]
	private TextMeshProUGUI tipText;

	[SerializeField]
	private TextMeshProUGUI ssrText;

	[SerializeField]
	private TextMeshProUGUI srText;

	[SerializeField]
	private GameObject weaponItem;

	[SerializeField]
	private GameObject heroItem;

	[SerializeField]
	private RectTransform ssrListRect;

	[SerializeField]
	private RectTransform srListRect;

	[SerializeField]
	private RectTransform contentRect;

	[SerializeField]
	private RectTransform ssrRect;

	[SerializeField]
	private RectTransform srRect;

	[SerializeField]
	private ScrollRect scrollRect;

	[SerializeField]
	private int weaponMoveSize;

	[SerializeField]
	private int heroMoveSize;

	private DrawCardUpPreviewViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<DrawCardUpPreviewViewModel>();
		BindingSet<DrawCardUpPreviewWindow, DrawCardUpPreviewViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((DrawCardUpPreviewWindow v) => v.OpenUguiWindow).To((DrawCardUpPreviewViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((DrawCardUpPreviewViewModel vm) => vm.Close);
		bindingSet.Bind(btnBack2).For((Button v) => v.onClick).To((DrawCardUpPreviewViewModel vm) => vm.Close);
		bindingSet.Bind<TextMeshProUGUI>(titleText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DrawCardUpPreviewViewModel vm) => vm.TitleText);
		bindingSet.Bind<TextMeshProUGUI>(tipText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DrawCardUpPreviewViewModel vm) => vm.TipText);
		bindingSet.Bind<TextMeshProUGUI>(ssrText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DrawCardUpPreviewViewModel vm) => vm.TypeText);
		bindingSet.Bind<TextMeshProUGUI>(srText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DrawCardUpPreviewViewModel vm) => vm.TypeText);
		bindingSet.Bind(this).For((DrawCardUpPreviewWindow v) => v.CloseWindow).To((DrawCardUpPreviewViewModel vm) => vm.DismissRequest);
		bindingSet.Build();
		if (viewModel.Type == 5)
		{
			CreateWeaponItems();
		}
		else
		{
			CreateHeroItems();
		}
		CheckPanelMove();
	}

	private void CreateWeaponItems()
	{
		foreach (TabItemNormalData weaponSsrItem in viewModel.WeaponSsrItemList)
		{
			GameObject obj = UnityEngine.Object.Instantiate(weaponItem, ssrListRect);
			obj.transform.GetComponent<TabItemNormal>().Init(weaponSsrItem);
			obj.gameObject.SetActive(value: true);
		}
		foreach (TabItemNormalData weaponSrItem in viewModel.WeaponSrItemList)
		{
			GameObject obj2 = UnityEngine.Object.Instantiate(weaponItem, srListRect);
			obj2.transform.GetComponent<TabItemNormal>().Init(weaponSrItem);
			obj2.gameObject.SetActive(value: true);
		}
		float height = ssrRect.gameObject.GetComponent<RectTransform>().rect.height;
		float num = weaponItem.gameObject.GetComponent<RectTransform>().rect.width * (float)viewModel.WeaponSsrItemList.Count + 20f;
		ssrRect.sizeDelta = new Vector2(num, height);
		float height2 = srRect.gameObject.GetComponent<RectTransform>().rect.height;
		float num2 = weaponItem.gameObject.GetComponent<RectTransform>().rect.width * (float)viewModel.WeaponSrItemList.Count + 20f;
		srRect.sizeDelta = new Vector2(num2, height2);
		contentRect.sizeDelta = new Vector2(num + num2 + 40f, height);
		ssrRect.gameObject.SetActive(viewModel.WeaponSsrItemList.Count > 0);
		srRect.gameObject.SetActive(viewModel.WeaponSrItemList.Count > 0);
	}

	private void CreateHeroItems()
	{
		foreach (HeroItemViewModel heroSsrItem in viewModel.HeroSsrItemList)
		{
			GameObject obj = UnityEngine.Object.Instantiate(heroItem, ssrListRect);
			obj.transform.GetComponent<HeroItem>().Init(heroSsrItem);
			obj.gameObject.SetActive(value: true);
		}
		foreach (HeroItemViewModel heroSrItem in viewModel.HeroSrItemList)
		{
			GameObject obj2 = UnityEngine.Object.Instantiate(heroItem, srListRect);
			obj2.transform.GetComponent<HeroItem>().Init(heroSrItem);
			obj2.gameObject.SetActive(value: true);
		}
		float height = ssrRect.gameObject.GetComponent<RectTransform>().rect.height;
		float num = heroItem.gameObject.GetComponent<RectTransform>().rect.width * (float)viewModel.HeroSsrItemList.Count + 20f;
		ssrRect.sizeDelta = new Vector2(num, height);
		float height2 = srRect.gameObject.GetComponent<RectTransform>().rect.height;
		float num2 = heroItem.gameObject.GetComponent<RectTransform>().rect.width * (float)viewModel.HeroSrItemList.Count + 20f;
		srRect.sizeDelta = new Vector2(num2, height2);
		contentRect.sizeDelta = new Vector2(num + num2 + 40f, height);
		ssrRect.gameObject.SetActive(viewModel.HeroSsrItemList.Count > 0);
		srRect.gameObject.SetActive(viewModel.HeroSrItemList.Count > 0);
	}

	private void CheckPanelMove()
	{
		if (!(scrollRect == null))
		{
			if (viewModel.Type == 5)
			{
				scrollRect.horizontal = viewModel.WeaponSsrItemList.Count + viewModel.WeaponSrItemList.Count >= weaponMoveSize;
			}
			else
			{
				scrollRect.horizontal = viewModel.HeroSsrItemList.Count + viewModel.HeroSrItemList.Count >= heroMoveSize;
			}
		}
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		for (int i = 0; i < ssrListRect.childCount; i++)
		{
			UnityEngine.Object.Destroy(ssrListRect.GetChild(i).gameObject);
		}
		for (int j = 0; j < srListRect.childCount; j++)
		{
			UnityEngine.Object.Destroy(srListRect.GetChild(j).gameObject);
		}
		Dismiss();
	}
}
