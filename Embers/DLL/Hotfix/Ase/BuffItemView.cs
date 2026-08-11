using System;
using System.Linq.Expressions;
using DG.Tweening;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BuffItemView : UGuiView
{
	[SerializeField]
	private Image buffIcon;

	[SerializeField]
	private TextMeshProUGUI buffLayer;

	[SerializeField]
	private GameObject buffLayerObj;

	[SerializeField]
	private GameObject lifeTime;

	[SerializeField]
	private Image lifeTimeImg;

	private Tween buffTween;

	private bool showAlphaValue;

	private BuffItemViewModel buffViewModel;

	public bool ShowAlphaValue
	{
		get
		{
			return showAlphaValue;
		}
		set
		{
			SetAlphaValue(value);
		}
	}

	public void Init(BuffItemViewModel buffViewModel)
	{
		this.buffViewModel = buffViewModel;
		BindingSet<BuffItemView, BuffItemViewModel> bindingSet = this.CreateBindingSet(buffViewModel);
		bindingSet.Bind(buffIcon).For((Image v) => v.sprite).ToExpression((BuffItemViewModel vm) => vm.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(buffLayer).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BuffItemViewModel vm) => $"{vm.Layer}");
		bindingSet.Bind(lifeTime).For((GameObject v) => v.activeSelf).To((BuffItemViewModel vm) => vm.ShowTime);
		bindingSet.Bind(lifeTimeImg).For((Image v) => v.fillAmount).To((BuffItemViewModel vm) => vm.LeftTimePercent);
		bindingSet.Bind().For((BuffItemView v) => v.ShowAlphaValue).To((BuffItemViewModel vm) => vm.ShowAlphaValue);
		bindingSet.Bind(buffLayerObj).For((GameObject v) => v.activeSelf).To((BuffItemViewModel vm) => vm.ShowLayer);
		bindingSet.Build();
	}

	public void RefreshData(BuffItemViewModel buffViewModel)
	{
		this.SetDataContext(buffViewModel);
	}

	private void SetAlphaValue(bool isShow)
	{
		if (buffTween != null)
		{
			buffTween.Kill();
		}
		if (isShow)
		{
			buffTween = DOTweenModuleUI.DOFade(CanvasGroup, 0.5f, 0.2f).SetLoops(5).OnComplete(delegate
			{
				CanvasGroup.alpha = 1f;
			});
		}
		else
		{
			CanvasGroup.alpha = 1f;
		}
	}
}
