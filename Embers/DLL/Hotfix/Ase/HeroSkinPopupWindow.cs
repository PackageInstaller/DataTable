using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using Spine.Unity;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HeroSkinPopupWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private RectTransform skinSpineRoot;

	private string _skinSpinePath;

	private GameObject _skinSpine;

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

	private HeroSkinPopupViewModel _viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<HeroSkinPopupViewModel>();
		BindingSet<HeroSkinPopupWindow, HeroSkinPopupViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((HeroSkinPopupWindow v) => v.OpenUguiWindow).To((HeroSkinPopupViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((HeroSkinPopupWindow v) => v.OnDismissRequest).To((HeroSkinPopupViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((HeroSkinPopupViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind<TextMeshProUGUI>(skinName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSkinPopupViewModel vm) => vm.SkinName);
		bindingSet.Bind<TextMeshProUGUI>(heroName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSkinPopupViewModel vm) => vm.HeroName);
		bindingSet.Bind(qualityIcon).For((Image v) => v.sprite).To((HeroSkinPopupViewModel vm) => vm.QualityIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(qualityLargeIcon).For((Image v) => v.sprite).To((HeroSkinPopupViewModel vm) => vm.QualityLargeIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(voiceText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSkinPopupViewModel vm) => vm.VoiceText);
		bindingSet.Build();
		LoadSkinSpine();
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
		base.OnDestroy();
	}
}
