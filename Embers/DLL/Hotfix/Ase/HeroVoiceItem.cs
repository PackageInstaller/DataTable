using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HeroVoiceItem : UGuiView
{
	[SerializeField]
	private GameObject normal;

	[SerializeField]
	private GameObject selected;

	[SerializeField]
	private TextMeshProUGUI textNormal;

	[SerializeField]
	private TextMeshProUGUI textSelected;

	[SerializeField]
	private GameObject playIcon;

	[SerializeField]
	private GameObject mask;

	[SerializeField]
	private GameObject red;

	[SerializeField]
	private Button btn;

	private HeroVoiceItemData _viewModel;

	protected override void OnInit(object userData)
	{
		_viewModel = GetUserData<HeroVoiceItemData>(userData);
		BindingSet<HeroVoiceItem, HeroVoiceItemData> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(normal).For((GameObject v) => v.activeSelf).ToExpression((HeroVoiceItemData vm) => !vm.Selected);
		bindingSet.Bind(selected).For((GameObject v) => v.activeSelf).To((HeroVoiceItemData vm) => vm.Selected);
		bindingSet.Bind<TextMeshProUGUI>(textNormal).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroVoiceItemData vm) => vm.TextDisplay);
		bindingSet.Bind<TextMeshProUGUI>(textSelected).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroVoiceItemData vm) => vm.TextDisplay);
		bindingSet.Bind(playIcon).For((GameObject v) => v.activeSelf).To((HeroVoiceItemData vm) => vm.Unlock);
		bindingSet.Bind(mask).For((GameObject v) => v.activeSelf).ToExpression((HeroVoiceItemData vm) => !vm.Unlock);
		bindingSet.Bind(red).For((GameObject v) => v.activeSelf).To((HeroVoiceItemData vm) => vm.Red);
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((HeroVoiceItemData vm) => vm.OnVoiceItemClick);
		bindingSet.Build();
	}
}
