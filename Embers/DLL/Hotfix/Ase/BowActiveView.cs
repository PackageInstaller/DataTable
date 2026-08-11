using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BowActiveView : WeaponActiveView
{
	[SerializeField]
	private Color color1;

	[SerializeField]
	private Color color2;

	[SerializeField]
	private Color color3;

	private float colorState;

	[SerializeField]
	private Animation awakeAni;

	[SerializeField]
	private Image fillNormal;

	[SerializeField]
	private Image fillAwaken;

	[SerializeField]
	private Image fillAwaken1;

	[SerializeField]
	private Image fillAwaken2;

	[SerializeField]
	private GameObject normalEffect;

	[SerializeField]
	private GameObject awakeEffect;

	private WeaponMechanismBow.BowState bowState;

	protected WeaponMechanismBowViewModel bowViewModel;

	protected BowViewBindData bowBindData;

	public Image FillNormal => fillNormal;

	public Image FillAwaken => fillAwaken;

	public Image FillAwaken1 => fillAwaken1;

	public Image FillAwaken2 => fillAwaken2;

	public WeaponMechanismBow.BowState BowState
	{
		get
		{
			return bowState;
		}
		set
		{
			SetBowImage(value);
			bowState = value;
		}
	}

	public float ColorState
	{
		get
		{
			return colorState;
		}
		set
		{
			colorState = value;
			if (BowState == WeaponMechanismBow.BowState.Normal)
			{
				if (colorState <= 0.5f)
				{
					fillNormal.color = color1;
				}
				else if (colorState > 0.5f && colorState <= 0.75f)
				{
					fillNormal.color = color2;
				}
				else if (colorState > 0.75f)
				{
					fillNormal.color = color3;
				}
			}
		}
	}

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		bowBindData = new BowViewBindData(this);
	}

	protected override void OnInitWeaponMechanism()
	{
		base.OnInitWeaponMechanism();
		bowViewModel = viewModel.HeroData.WeaponMechanismData as WeaponMechanismBowViewModel;
		BindingSet<BowActiveView, WeaponMechanismBowViewModel> bindingSet = this.CreateBindingSet(bowViewModel);
		bindingSet.Bind(bowBindData).For((BowViewBindData v) => v.ColorState).ToExpression((WeaponMechanismBowViewModel vm) => vm.FillLeft);
		bindingSet.Bind(bowBindData).For((BowViewBindData v) => v.FillNormal).ToExpression((WeaponMechanismBowViewModel vm) => vm.FillLeft);
		bindingSet.Bind(bowBindData).For((BowViewBindData v) => v.FillAwaken).ToExpression((WeaponMechanismBowViewModel vm) => vm.FillLeft);
		bindingSet.Bind(bowBindData).For((BowViewBindData v) => v.BowState).ToExpression((WeaponMechanismBowViewModel vm) => vm.BowState);
		bindingSet.Build();
		normalEffect.gameObject.SetActive(value: false);
		awakeEffect.gameObject.SetActive(value: false);
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		bowViewModel = viewModel.HeroData.WeaponMechanismData as WeaponMechanismBowViewModel;
		this.SetDataContext(viewModel.HeroData.WeaponMechanismData);
	}

	private async void SetBowImage(WeaponMechanismBow.BowState state)
	{
		switch (state)
		{
		case WeaponMechanismBow.BowState.Normal:
			fillNormal.color = color1;
			fillNormal.gameObject.SetActive(value: true);
			fillAwaken.gameObject.SetActive(value: false);
			awakeEffect.gameObject.SetActive(value: false);
			if (bowState != WeaponMechanismBow.BowState.None)
			{
				normalEffect.gameObject.SetActive(value: true);
				awakeAni.Play("AwakeEffect_out_1");
			}
			break;
		case WeaponMechanismBow.BowState.Awaken:
			normalEffect.gameObject.SetActive(value: false);
			fillNormal.gameObject.SetActive(value: false);
			awakeEffect.gameObject.SetActive(value: true);
			WeaponAudio();
			fillAwaken.gameObject.SetActive(value: true);
			awakeAni.Play("AwakeEffect_enter_2");
			break;
		}
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
	}
}
