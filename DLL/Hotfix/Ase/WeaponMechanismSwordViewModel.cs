using System.Collections.Generic;
using Ase.ECS;
using GameFramework.Runtime;

namespace Ase;

public class WeaponMechanismSwordViewModel : WeaponMechanismViewModel
{
	private float maxLayer;

	private bool playEffect;

	private float keennessRatio;

	private float protectTimeFill;

	private List<float> everyLayer;

	public float MaxLayer => maxLayer;

	public float ProtectTimeFill => protectTimeFill;

	public float KeennessRatio
	{
		get
		{
			return keennessRatio;
		}
		set
		{
			Set(ref keennessRatio, value, "KeennessRatio");
		}
	}

	public List<float> EveryLayer => everyLayer;

	public WeaponMechanismSwordViewModel(WeaponEnum weaponEnum, ObservableDictionary<string, Ase.ECS.PropertyData> propertyList)
		: base(weaponEnum, propertyList)
	{
	}

	public override void OnUpdate(float delta)
	{
		base.OnUpdate(delta);
	}

	public void SetLayerFillAmountData(List<float> everyLayer, float maxLayer)
	{
		this.maxLayer = maxLayer;
		this.everyLayer = everyLayer;
	}

	public void SetProtectTimeFill(float fill)
	{
		protectTimeFill = fill;
	}
}
