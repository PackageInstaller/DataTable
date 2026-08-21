using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class SwordActiveView : WeaponActiveView
{
	public Image outline;

	[SerializeField]
	private List<SwordSlider> _swordSlider;

	private bool playEffect;

	private int curLayerIndex = -1;

	private float protectTimeFill;

	protected SwordViewBindData swordBindData;

	protected WeaponMechanismSwordViewModel swordViewModel;

	protected void LateUpdate()
	{
		if (swordViewModel == null || !swordViewModel.Property.ContainsKey("KeennessLayer"))
		{
			return;
		}
		int num = (int)swordViewModel.Property["KeennessLayer"].CurValue;
		if (num != swordBindData.CurLayer)
		{
			swordBindData.CurLayer = num;
		}
		if (swordViewModel.ProtectTimeFill != protectTimeFill)
		{
			protectTimeFill = swordViewModel.ProtectTimeFill;
			for (int i = 0; i < _swordSlider.Count; i++)
			{
				_swordSlider[i].layerProtectTimeFill.fillAmount = swordViewModel.ProtectTimeFill;
			}
		}
	}

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		swordBindData = new SwordViewBindData(this);
		if (_swordSlider != null && _swordSlider.Count > 0)
		{
			_swordSlider[0].root.SetActive(value: true);
			_swordSlider[0].layer1.fillAmount = 0f;
			_swordSlider[0].layer2.fillAmount = 0f;
			_swordSlider[0].layerProtectTimeFill.fillAmount = 1f;
			_swordSlider[0].downLayer.SetActive(value: false);
			_swordSlider[0].upLayer.SetActive(value: false);
		}
	}

	protected override void OnInitWeaponMechanism()
	{
		base.OnInitWeaponMechanism();
		swordViewModel = viewModel.HeroData.WeaponMechanismData as WeaponMechanismSwordViewModel;
		BindingSet<SwordActiveView, WeaponMechanismSwordViewModel> bindingSet = this.CreateBindingSet(swordViewModel);
		bindingSet.Bind(swordBindData).For((SwordViewBindData v) => v.OutLine).To((WeaponMechanismSwordViewModel vm) => vm.KeennessRatio);
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		swordViewModel = viewModel.HeroData.WeaponMechanismData as WeaponMechanismSwordViewModel;
		this.SetDataContext(viewModel.HeroData.WeaponMechanismData);
	}

	protected override void OnLayerChange()
	{
		float curValue = viewModel.HeroData.Property["KeennessLayer"].CurValue;
		if (swordViewModel.EveryLayer == null || _swordSlider == null || swordViewModel.EveryLayer.Count != _swordSlider.Count)
		{
			return;
		}
		int num = 0;
		for (int i = 0; i < swordViewModel.EveryLayer.Count; i++)
		{
			num = i;
			if (curValue <= swordViewModel.EveryLayer[i])
			{
				break;
			}
		}
		float fill = GetFill(num);
		if (curLayerIndex == num)
		{
			_swordSlider[curLayerIndex].layer1.fillAmount = fill;
			_swordSlider[curLayerIndex].layer2.fillAmount = fill;
			return;
		}
		_swordSlider[num].root.SetActive(value: true);
		_swordSlider[num].upLayer.SetActive(value: false);
		_swordSlider[num].downLayer.SetActive(value: false);
		if (curLayerIndex >= 0)
		{
			_swordSlider[curLayerIndex].root.SetActive(value: false);
		}
		if (num > curLayerIndex)
		{
			_swordSlider[num].upLayer.SetActive(value: true);
			if (num > 0)
			{
				WeaponAudio();
			}
		}
		else
		{
			_swordSlider[num].downLayer.SetActive(value: true);
		}
		_swordSlider[num].layer1.gameObject.SetActive(value: true);
		_swordSlider[num].layer2.gameObject.SetActive(value: true);
		_swordSlider[num].layer1.fillAmount = fill;
		_swordSlider[num].layer2.fillAmount = fill;
		curLayerIndex = num;
	}

	private float GetFill(int index)
	{
		if (index < 0)
		{
			return 0f;
		}
		float curValue = viewModel.HeroData.Property["KeennessLayer"].CurValue;
		float num = swordViewModel.EveryLayer[index];
		if (index == 0)
		{
			return curValue / num;
		}
		float num2 = swordViewModel.EveryLayer[index - 1];
		return (curValue - num2 - 1f) / (num - num2 - 1f);
	}

	public void SetOutLine(float outline)
	{
		if (this.outline != null)
		{
			this.outline.fillAmount = outline;
			this.outline.transform.parent.gameObject.SetActive(outline > 0f);
		}
	}
}
