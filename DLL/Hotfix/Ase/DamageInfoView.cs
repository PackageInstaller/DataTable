using System;
using System.Linq.Expressions;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class DamageInfoView : UGuiView
{
	public Text nameText;

	public TextMeshProUGUI damageText;

	public Image damageProgress;

	public TextMeshProUGUI tanecityText;

	public Image tanecityProgress;

	public TextMeshProUGUI cureText;

	public Image cureProgress;

	public TextMeshProUGUI indexText;

	[SerializeField]
	private GameObject icon1;

	[SerializeField]
	private GameObject icon2;

	[SerializeField]
	private GameObject icon3;

	[SerializeField]
	private Image skinFrame;

	private DamageInfoViewModel _viewModel;

	public void Init(DamageInfoViewModel viewModel)
	{
		_viewModel = viewModel;
		BindingSet<DamageInfoView, DamageInfoViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(nameText).For((Text v) => v.text).To((DamageInfoViewModel vm) => vm.Name);
		bindingSet.Bind<TextMeshProUGUI>(damageText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DamageInfoViewModel vm) => vm.DamageText);
		bindingSet.Bind(damageProgress).For((Image v) => v.fillAmount).ToExpression((DamageInfoViewModel vm) => (vm.MaxDamage == 0f) ? 0f : (vm.Damage / vm.MaxDamage));
		bindingSet.Bind<TextMeshProUGUI>(tanecityText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((DamageInfoViewModel vm) => $"{vm.TenacityText}");
		bindingSet.Bind(tanecityProgress).For((Image v) => v.fillAmount).ToExpression((DamageInfoViewModel vm) => (vm.MaxTenacity == 0f) ? 0f : (vm.Tenacity / vm.MaxTenacity));
		bindingSet.Bind<TextMeshProUGUI>(cureText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((DamageInfoViewModel vm) => $"{vm.CureText}");
		bindingSet.Bind(cureProgress).For((Image v) => v.fillAmount).ToExpression((DamageInfoViewModel vm) => (vm.MaxCure == 0f) ? 0f : (vm.Cure / vm.MaxCure));
		bindingSet.Bind<TextMeshProUGUI>(indexText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DamageInfoViewModel vm) => vm.ShowIndex);
		bindingSet.Bind(icon1).For((GameObject v) => v.activeSelf).ToExpression((DamageInfoViewModel vm) => vm.ShowIndex == 1);
		bindingSet.Bind(icon2).For((GameObject v) => v.activeSelf).ToExpression((DamageInfoViewModel vm) => vm.ShowIndex == 2);
		bindingSet.Bind(icon3).For((GameObject v) => v.activeSelf).ToExpression((DamageInfoViewModel vm) => vm.ShowIndex == 3);
		bindingSet.Build();
		SetBattleDsFrame();
	}

	public void UpdateData(DamageInfoViewModel viewModel)
	{
		this.SetDataContext(viewModel);
	}

	private async UniTask SetBattleDsFrame()
	{
		if (skinFrame == null)
		{
			return;
		}
		if (_viewModel.SkinId <= 0)
		{
			skinFrame.gameObject.SetActive(value: false);
			return;
		}
		DRHeroSkin dataRow = GameEntry.DataTable.GetDataRow<DRHeroSkin>(_viewModel.SkinId);
		if (dataRow != null && dataRow.SkinBattleFrame)
		{
			Sprite sprite = await LoadSpriteAsync(SkinAssetUtility.GetSkinBattleDSFrame(_viewModel.SkinId));
			if (!(sprite == null))
			{
				skinFrame.sprite = sprite;
				skinFrame.gameObject.SetActive(value: true);
			}
		}
	}
}
