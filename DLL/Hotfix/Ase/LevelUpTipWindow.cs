using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class LevelUpTipWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private TextMeshProUGUI levelText;

	[SerializeField]
	private GameObject tipItem;

	[SerializeField]
	private RectTransform tipGroup;

	private LevelUpTipViewModel viewModel;

	private List<GameObject> tipObjList = new List<GameObject>();

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<LevelUpTipViewModel>();
		BindingSet<LevelUpTipWindow, LevelUpTipViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((LevelUpTipWindow v) => v.CloseWindow).To((LevelUpTipViewModel vm) => vm.DismissRequest);
		bindingSet.Bind<TextMeshProUGUI>(levelText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((LevelUpTipViewModel vm) => vm.Level);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((LevelUpTipViewModel vm) => vm.Close);
		bindingSet.Build();
		CreatTip();
	}

	private void CreatTip()
	{
		if (viewModel.TipList.Count == 0)
		{
			return;
		}
		tipGroup.gameObject.SetActive(value: true);
		foreach (string tip in viewModel.TipList)
		{
			GameObject gameObject = UnityEngine.Object.Instantiate(tipItem, tipGroup);
			gameObject.gameObject.SetActive(value: true);
			tipObjList.Add(gameObject);
			TextMeshProUGUI component = gameObject.transform.Find("Tip").GetComponent<TextMeshProUGUI>();
			if ((UnityEngine.Object)(object)component != null)
			{
				((TMP_Text)component).text = tip;
			}
		}
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		foreach (GameObject tipObj in tipObjList)
		{
			UnityEngine.Object.Destroy(tipObj);
		}
		tipObjList.Clear();
		Dismiss();
	}
}
