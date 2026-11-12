using System;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;

public class AmmoInfo : LogicComponent
{
	public delegate void AmmoChangedHandle(int ammo, int ammoMax);

	private readonly AmmoEntry[] ammoEnties = new AmmoEntry[3];

	public HotfixEnum.AmmoType ammoType;

	public HotfixEnum.bulletType bulletT;

	public static readonly bool useValued = false;

	public static int countUpper = int.MaxValue;

	public static int maxUpper = int.MaxValue;

	public int originAmmoCountMax;

	public FP originAmmoRatio;

	[Space]
	public bool forceReloadAmmo;

	[Space]
	public bool isNoCostAmmo;

	public int ammoCountMax => GetAmmoMax(ammoType);

	public int ammoCount
	{
		get
		{
			return GetAmmoCount(ammoType);
		}
		set
		{
			ChangeValue(ammoType, HotfixEnum.ammoParameterType.SET_ABSOLUTE_VALUE, value);
		}
	}

	public FP ammoCountPercentage
	{
		get
		{
			if (ammoCountMax == 0)
			{
				return 0f;
			}
			return (FP)ammoCount / (FP)ammoCountMax;
		}
	}

	public event AmmoChangedHandle AmmoChangedEvent;

	public int GetAmmoCount(HotfixEnum.AmmoType type)
	{
		if (type == HotfixEnum.AmmoType.Max)
		{
			return 0;
		}
		return Math.Clamp(ammoEnties[(int)type].Value, 0, countUpper);
	}

	public int GetAmmoMax(HotfixEnum.AmmoType type)
	{
		if (type == HotfixEnum.AmmoType.Max)
		{
			return 0;
		}
		ref AmmoEntry reference = ref ammoEnties[(int)type];
		return Math.Clamp(useValued ? reference.Max : reference.AmendMax, 0, maxUpper);
	}

	public void ChangeValue(HotfixEnum.AmmoType type, HotfixEnum.ammoParameterType subType, FP val)
	{
		if (type != HotfixEnum.AmmoType.Max)
		{
			ammoEnties[(int)type].ChangeValue(subType, val);
			AmmoChangedEvent?.Invoke(ammoCount, ammoCountMax);
		}
	}

	public void RefreshAmmoCost(int adjustNum)
	{
		if (!isNoCostAmmo)
		{
			ammoCount += adjustNum;
			AdeventrueShootCost adeventrueShootCost = AdeventrueShootCost.Generate();
			adeventrueShootCost.sender = Entity;
			adeventrueShootCost.cost = Math.Abs(adjustNum);
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adeventrueShootCost);
		}
		else
		{
			AdeventrueShootCostAmmo adeventrueShootCostAmmo = AdeventrueShootCostAmmo.Generate();
			adeventrueShootCostAmmo.sender = this;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adeventrueShootCostAmmo);
		}
	}

	public void Reset()
	{
		ammoType = HotfixEnum.AmmoType.Main;
		SetOriginIntValue(HotfixEnum.AmmoType.Main, originAmmoCountMax, originAmmoRatio);
		ammoCount = ammoCountMax;
	}

	public void SetOriginIntValue(HotfixEnum.AmmoType type, int val, FP ratio)
	{
		if (type != HotfixEnum.AmmoType.Max)
		{
			ammoEnties[(int)type].SetOrigin((int)(long)(val * ratio));
		}
	}

	public void SetOriginAttributeData(Character attributeConfig, FP ratio)
	{
		originAmmoCountMax = attributeConfig.Ammo;
		originAmmoRatio = ratio;
		SetOriginIntValue(HotfixEnum.AmmoType.Main, attributeConfig.Ammo, ratio);
		ammoCount = ammoCountMax;
	}
}
