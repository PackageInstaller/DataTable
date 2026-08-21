using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class UITipGuidanceView : UGuiView
{
	public RectTransform root;

	public Image characterIcon;

	public TextMeshProUGUI characterName;

	public TextMeshProUGUI tipText_Left;

	public TextMeshProUGUI tipText_Middle;

	public AnimatorAnimation animatorAnimation;

	private string characterIconUrl;

	public void Init(UIGuidanceViewModel viewModel)
	{
		BindingSet<UITipGuidanceView, UIGuidanceViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(base.gameObject).For((GameObject v) => v.activeSelf).ToExpression((UIGuidanceViewModel vm) => !string.IsNullOrEmpty(vm.TipText) && !vm.VideoClipOpen);
		bindingSet.Bind(root).For((RectTransform v) => v.anchoredPosition).To((UIGuidanceViewModel vm) => vm.TipPosition);
		bindingSet.Bind(characterIcon.gameObject).For((GameObject v) => v.activeSelf).ToExpression((UIGuidanceViewModel vm) => !string.IsNullOrEmpty(vm.TipCharacterName));
		bindingSet.Bind().For((UITipGuidanceView v) => v.characterIconUrl).To((UIGuidanceViewModel vm) => vm.TipCharacter);
		bindingSet.Bind().For((UITipGuidanceView v) => v.OnCharacterIconRequest).To((UIGuidanceViewModel vm) => vm.OnCharacterIconRequest);
		bindingSet.Bind(((Component)(object)characterName).gameObject).For((GameObject v) => v.activeSelf).ToExpression((UIGuidanceViewModel vm) => !string.IsNullOrEmpty(vm.TipCharacterName));
		bindingSet.Bind<TextMeshProUGUI>(characterName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((UIGuidanceViewModel vm) => vm.TipCharacterName);
		bindingSet.Bind(((Component)(object)tipText_Left).gameObject).For((GameObject v) => v.activeSelf).ToExpression((UIGuidanceViewModel vm) => vm.TipType == 1);
		bindingSet.Bind<TextMeshProUGUI>(tipText_Left).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((UIGuidanceViewModel vm) => vm.TipText);
		bindingSet.Bind(((Component)(object)tipText_Middle).gameObject).For((GameObject v) => v.activeSelf).ToExpression((UIGuidanceViewModel vm) => vm.TipType == 2);
		bindingSet.Bind<TextMeshProUGUI>(tipText_Middle).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((UIGuidanceViewModel vm) => vm.TipText);
		bindingSet.Build();
	}

	private async void OnCharacterIconRequest(object sender, InteractionEventArgs e)
	{
		if (!string.IsNullOrEmpty(characterIconUrl))
		{
			Image image = characterIcon;
			image.sprite = await LoadSpriteAsync(AssetUtility.GetFGImageSprite("Head/" + characterIconUrl + ".png"));
			characterIcon.SetNativeSize();
			if ((bool)animatorAnimation)
			{
				animatorAnimation.Play();
			}
		}
	}
}
