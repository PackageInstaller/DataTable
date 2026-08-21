using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class RandomBuffItemView : UGuiView
{
	[SerializeField]
	private TextMeshProUGUI buffName;

	[SerializeField]
	private TextMeshProUGUI buffLv;

	[SerializeField]
	private TextMeshProUGUI buffDes;

	[SerializeField]
	private Image buffIcon;

	[SerializeField]
	private Button selectBtn;

	[SerializeField]
	private GameObject textArrow;

	[SerializeField]
	private GameObject SelectGo;

	[SerializeField]
	private GameObject notCollected;

	[SerializeField]
	private GameObject recommend;

	[SerializeField]
	private ScrollRect scrollRect;

	[SerializeField]
	private List<GameObject> qualityBgs;

	[SerializeField]
	private bool showCommendIndictor;

	[SerializeField]
	private bool showCollectIndictor;

	private RandomBuffItemViewModel viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = userData as RandomBuffItemViewModel;
		BindingSet<RandomBuffItemView, RandomBuffItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind<TextMeshProUGUI>(buffName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((RandomBuffItemViewModel vm) => vm.BuffName);
		bindingSet.Bind<TextMeshProUGUI>(buffDes).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((RandomBuffItemViewModel vm) => vm.BuffDes);
		bindingSet.Bind<TextMeshProUGUI>(buffLv).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((RandomBuffItemViewModel vm) => $"Lv.{vm.BuffQuality}");
		bindingSet.Bind(SelectGo).For((GameObject v) => v.activeSelf).To((RandomBuffItemViewModel vm) => vm.SelectItem);
		bindingSet.Bind(notCollected).For((GameObject v) => v.activeSelf).ToExpression((RandomBuffItemViewModel vm) => !vm.CollectRes && showCollectIndictor);
		bindingSet.Bind(recommend).For((GameObject v) => v.activeSelf).ToExpression((RandomBuffItemViewModel vm) => vm.CommendBuff && showCommendIndictor);
		bindingSet.Bind(buffIcon).For((Image v) => v.sprite).To((RandomBuffItemViewModel vm) => vm.IconName)
			.WithConversion("ItemIcon");
		bindingSet.Build();
		selectBtn.onClick.AddListener(ClickSelectBuff);
		ShowQualityBg();
		scrollRect.onValueChanged.AddListener(delegate
		{
			UpdateArrow();
		});
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		viewModel = userData as RandomBuffItemViewModel;
		this.SetDataContext(viewModel);
		ShowQualityBg();
	}

	private void ClickSelectBuff()
	{
		viewModel.OnClickSelectBuff();
	}

	private void ShowQualityBg()
	{
		for (int i = 0; i < qualityBgs.Count; i++)
		{
			qualityBgs[i].SetActive(viewModel.BuffQuality == i + 1);
		}
		UpdateArrow();
	}

	public bool CanScrollDown(ScrollRect scrollRect)
	{
		if (scrollRect == null || !scrollRect.vertical)
		{
			return false;
		}
		RectTransform content = scrollRect.content;
		RectTransform rectTransform = scrollRect.viewport ?? scrollRect.GetComponent<RectTransform>();
		if (content == null || rectTransform == null)
		{
			return false;
		}
		float num = content.rect.height * content.localScale.y;
		float height = rectTransform.rect.height;
		if (num <= height)
		{
			return false;
		}
		float y = content.anchoredPosition.y;
		return num - height + y > 1f;
	}

	private void UpdateArrow(object sender = null, InteractionEventArgs e = null)
	{
		if (scrollRect.verticalNormalizedPosition <= 0.0001f)
		{
			textArrow.SetActive(value: false);
			return;
		}
		bool active = CanScrollDown(scrollRect);
		textArrow.SetActive(active);
	}
}
