using System.Collections.Generic;
using Ase.ECS;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class WeaponMechanismGunViewModel : WeaponMechanismViewModel
{
	private float reloading;

	private float reloadingMax;

	private float heroHeatFill;

	private float thresholdFill;

	private WeaponMechanismGun.GunState gunState;

	public List<WeaponGunBulletData> GunBulletList = new List<WeaponGunBulletData>();

	public InteractionRequest updateBulletRequest = new InteractionRequest();

	private int gunBulletCountMax;

	private int gunBulletCountCur;

	public bool IsUpdateBullet;

	private bool showBullet;

	public bool ShowBullet
	{
		get
		{
			return showBullet;
		}
		set
		{
			Set(ref showBullet, value, "ShowBullet");
		}
	}

	public float Reloading
	{
		get
		{
			return reloading;
		}
		set
		{
			Set(ref reloading, value, "Reloading");
		}
	}

	public float ReloadingMax
	{
		get
		{
			return reloadingMax;
		}
		set
		{
			Set(ref reloadingMax, value, "ReloadingMax");
		}
	}

	public float HeroHeatFill
	{
		get
		{
			return heroHeatFill;
		}
		set
		{
			Set(ref heroHeatFill, value, "HeroHeatFill");
		}
	}

	public float ThresholdFill
	{
		get
		{
			return thresholdFill;
		}
		set
		{
			Set(ref thresholdFill, value, "ThresholdFill");
		}
	}

	public WeaponMechanismGun.GunState GunState
	{
		get
		{
			return gunState;
		}
		set
		{
			Set(ref gunState, value, "GunState");
		}
	}

	public int GunBulletCountCur
	{
		get
		{
			return gunBulletCountCur;
		}
		set
		{
			Set(ref gunBulletCountCur, value, "GunBulletCountCur");
		}
	}

	public int GunBulletCountMax
	{
		get
		{
			return gunBulletCountMax;
		}
		set
		{
			Set(ref gunBulletCountMax, value, "GunBulletCountMax");
		}
	}

	public IInteractionRequest UpdateBulletRequest => updateBulletRequest;

	public float OverHearFill { get; set; }

	public WeaponMechanismGunViewModel(WeaponEnum weaponEnum, ObservableDictionary<string, Ase.ECS.PropertyData> propertyList)
		: base(weaponEnum, propertyList)
	{
	}

	public void SetReloading(float reloadingFill, Vector3 pos)
	{
		Reloading = reloadingFill;
	}

	public void UpdateBullet(List<WeaponGunBulletData> list)
	{
		GunBulletList = list;
		GunBulletCountCur = list.Count;
		IsUpdateBullet = true;
	}
}
