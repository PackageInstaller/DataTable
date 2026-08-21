using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using Spine.Unity;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HeroSkinGetWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private Button btnEmptyArea;

	[SerializeField]
	private Button btnApply;

	[SerializeField]
	private GameObject skinApplied;

	[SerializeField]
	private RectTransform skinSpineRoot;

	private string _skinSpinePath;

	private GameObject _skinSpine;

	[SerializeField]
	private Image skinTagIcon;

	[SerializeField]
	private TextMeshProUGUI skinName;

	[SerializeField]
	private TextMeshProUGUI heroName;

	[SerializeField]
	private Image qualityIcon;

	[SerializeField]
	private Image qualityLargeIcon;

	[SerializeField]
	private TextMeshProUGUI voiceText;

	private HeroSkinGetViewModel _viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<HeroSkinGetViewModel>();
		BindingSet<HeroSkinGetWindow, HeroSkinGetViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((HeroSkinGetWindow v) => v.OpenUguiWindow).To((HeroSkinGetViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((HeroSkinGetWindow v) => v.OnDismissRequest).To((HeroSkinGetViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((HeroSkinGetViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(btnEmptyArea).For((Button v) => v.onClick).To((HeroSkinGetViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(btnApply).For((Button v) => v.onClick).To((HeroSkinGetViewModel vm) => vm.ApplySkinCmd);
		bindingSet.Bind(btnApply.gameObject).For((GameObject v) => v.activeSelf).ToExpression((HeroSkinGetViewModel vm) => !vm.SkinApplied);
		bindingSet.Bind(skinApplied).For((GameObject v) => v.activeSelf).To((HeroSkinGetViewModel vm) => vm.SkinApplied);
		bindingSet.Bind<TextMeshProUGUI>(skinName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSkinGetViewModel vm) => vm.SkinName);
		bindingSet.Bind<TextMeshProUGUI>(heroName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSkinGetViewModel vm) => vm.HeroName);
		bindingSet.Bind(qualityIcon).For((Image v) => v.sprite).To((HeroSkinGetViewModel vm) => vm.QualityIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(qualityLargeIcon).For((Image v) => v.sprite).To((HeroSkinGetViewModel vm) => vm.QualityLargeIcon)
			.WithConversion("ItemIcon");
		if (skinTagIcon != null)
		{
			bindingSet.Bind(skinTagIcon).For((Image v) => v.sprite).To((HeroSkinGetViewModel vm) => vm.SkinTagIcon)
				.WithConversion("ItemIcon");
			bindingSet.Bind(skinTagIcon.gameObject).For((GameObject v) => v.activeSelf).ToExpression((HeroSkinGetViewModel vm) => !string.IsNullOrEmpty(vm.SkinTagIcon));
		}
		bindingSet.Bind<TextMeshProUGUI>(voiceText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSkinGetViewModel vm) => vm.VoiceText);
		bindingSet.Build();
		LoadSkinSpine();
		_viewModel.PlayGetVoice();
	}

	private async void LoadSkinSpine()
	{
		if (string.IsNullOrEmpty(_viewModel.SkinSpinePath))
		{
			return;
		}
		_skinSpinePath = _viewModel.SkinSpinePath;
		GameObject gameObject = await InstantiateAsync(AssetUtility.GetUIItemAsset(_skinSpinePath), skinSpineRoot);
		if (!(gameObject == null))
		{
			_skinSpine = gameObject;
			SkeletonGraphic component = _skinSpine.transform.GetChild(0).GetComponent<SkeletonGraphic>();
			if ((UnityEngine.Object)(object)component != null)
			{
				component.freeze = false;
			}
			StreamerMode.ApplySpineSkin(gameObject);
		}
	}

	protected override void OnDestroy()
	{
		if (_skinSpine != null)
		{
			UnityEngine.Object.DestroyImmediate(_skinSpine);
			_skinSpine = null;
		}
		_viewModel.StopVoice();
		base.OnDestroy();
	}
}
