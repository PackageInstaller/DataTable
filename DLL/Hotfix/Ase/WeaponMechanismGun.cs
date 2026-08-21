#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using Ase.ECS;
using GameFramework;
using UnityEngine;

namespace Ase;

public class WeaponMechanismGun : WeaponMechanismBase, IPropertyChanged
{
	public enum GunState
	{
		Normal,
		FullHeat,
		OverHear
	}

	protected WeaponMechanismGunViewModel gunViewModel;

	protected List<WeaponGunBulletData> bulletList;

	protected Dictionary<WeaponGunBulletOperationType, IWeaponMechanismGunOperation> operationDic;

	protected Ase.ECS.PropertyData heroHeatProperty;

	protected Ase.ECS.PropertyData heroHeatThresholdProperty;

	protected Ase.ECS.PropertyData fullHeatProperty;

	protected Ase.ECS.PropertyData overHeatProperty;

	protected Ase.ECS.PropertyData overHeatableProperty;

	protected Ase.ECS.PropertyData bulletNumProperty;

	protected float heroHeatCD;

	protected bool isHeroHeatCD;

	protected float heroHeatCDTimer;

	protected float heroHeatMax;

	public WeaponMechanismGun(BaseEntity entity, DRHero heroCfg, WeaponMechanismViewModel viewModel)
		: base(entity, heroCfg, viewModel)
	{
		gunViewModel = viewModel as WeaponMechanismGunViewModel;
		ownerEntity = entity;
		bulletList = new List<WeaponGunBulletData>();
		InitOperationDic();
	}

	public override void OnStart()
	{
		if (heroCfg.GunInit.Count != 5)
		{
			Log.Error("双枪武器参数错误,请检查Hero表");
			return;
		}
		heroHeatMax = heroCfg.GunInit[0];
		gunViewModel.ThresholdFill = Mathf.Clamp01(heroCfg.GunInit[1] / heroHeatMax);
		heroHeatCD = heroCfg.GunInit[2];
		gunViewModel.ShowBullet = heroCfg.GunInit[3] == 0f;
		isHeroHeatCD = false;
		heroHeatCDTimer = 0f;
		if (!viewModel.Property.TryGetValue("FullHeat", out fullHeatProperty))
		{
			Log.Error("属性获取错误:FullHeat");
			return;
		}
		if (!viewModel.Property.TryGetValue("OverHeat", out overHeatProperty))
		{
			Log.Error("属性获取错误:OverHeat");
			return;
		}
		if (!viewModel.Property.TryGetValue("OverHeatable", out overHeatableProperty))
		{
			Log.Error("属性获取错误:OverHeatable");
			return;
		}
		if (!viewModel.Property.TryGetValue("HeroHeat", out heroHeatProperty))
		{
			Log.Error("属性获取错误:HeroHeat");
			return;
		}
		heroHeatProperty.ResetMax(heroHeatMax, isExecuteValueChanged: false);
		heroHeatProperty.RegisterOnChangedCallback(this);
		gunViewModel.HeroHeatFill = 0f;
		if (!viewModel.Property.TryGetValue("HeroHeatThreshold", out heroHeatThresholdProperty))
		{
			Log.Error("属性获取错误:HeroHeatThreshold");
			return;
		}
		heroHeatThresholdProperty.ResetInit(heroCfg.GunInit[1]);
		heroHeatThresholdProperty.Set(heroCfg.GunInit[1], isIgnoreMax: false, isExecuteValueChanged: false);
		heroHeatThresholdProperty.RegisterOnChangedCallback(this);
		overHeatableProperty.ResetInit(heroCfg.GunInit[4]);
		overHeatableProperty.Set(heroCfg.GunInit[4], isIgnoreMax: false, isExecuteValueChanged: false);
		if (!viewModel.Property.TryGetValue("BulletNumber", out bulletNumProperty))
		{
			Log.Error("属性获取错误:BulletNumber");
			return;
		}
		bulletNumProperty.RegisterOnChangedCallback(this);
		OnBulletNumMaxChanged();
	}

	protected virtual void InitOperationDic()
	{
		operationDic = new Dictionary<WeaponGunBulletOperationType, IWeaponMechanismGunOperation>
		{
			{
				WeaponGunBulletOperationType.Add,
				new WeaponMechanismGunOperationRam()
			},
			{
				WeaponGunBulletOperationType.Sub,
				new WeaponMechanismGunOperationConsume()
			},
			{
				WeaponGunBulletOperationType.Clear,
				new WeaponMechanismGunOperationClear()
			},
			{
				WeaponGunBulletOperationType.Set,
				new WeaponMechanismGunOperationSet()
			},
			{
				WeaponGunBulletOperationType.Get,
				new WeaponMechanismGunOperationGet()
			},
			{
				WeaponGunBulletOperationType.Disrupted,
				new WeaponMechanismGunOperationRandom()
			},
			{
				WeaponGunBulletOperationType.SetHeroHeatMax,
				new WeaponMechanismGunOperationHeroHeatMax()
			}
		};
	}

	public override void AddLayer(int layer)
	{
		if (!isHeroHeatCD && layer != 0)
		{
			ownerEntity.SetProperty("HeroHeat", layer);
		}
	}

	public override void AddWeaponValueByDamageProgress(DamageProgressBase damageProgress, string property, float value)
	{
		if (property == "HeroHeat")
		{
			AddLayer((int)value);
		}
	}

	public override void SetLayer(int layer)
	{
		ownerEntity.SetProperty("HeroAnger", layer);
	}

	protected override void OnUpdate(float deltaTime, float timeScaleDeltaTime)
	{
		if (isHeroHeatCD)
		{
			heroHeatCDTimer += deltaTime;
			if (heroHeatCDTimer >= heroHeatCD)
			{
				isHeroHeatCD = false;
				heroHeatCDTimer = 0f;
				heroHeatProperty.ResetMax(heroHeatMax, isExecuteValueChanged: false);
				overHeatProperty.ResetValue(toMax: false, isExecuteValueChanged: false);
				gunViewModel.GunState = GunState.Normal;
			}
			gunViewModel.OverHearFill = (heroHeatCD - heroHeatCDTimer) / heroHeatCD;
		}
	}

	public void OnPropertyChanged(string propertyName, PropertyChangedEnum changedEnum, float delta)
	{
		if (propertyName == "HeroHeat" && (changedEnum == PropertyChangedEnum.CurValue || changedEnum == PropertyChangedEnum.BuffValue))
		{
			OnHeroHeatChanged();
		}
		else if (propertyName == "BulletNumber")
		{
			if (changedEnum == PropertyChangedEnum.MaxValue)
			{
				OnBulletNumMaxChanged();
			}
		}
		else if (propertyName == "HeroHeatThreshold")
		{
			OnHeroHeatThresholdChanged();
		}
	}

	private void OnHeroHeatChanged()
	{
		if (!isHeroHeatCD)
		{
			int num = ((heroHeatProperty.CurValue >= heroHeatThresholdProperty.CurValue) ? 1 : 0);
			if ((float)num != fullHeatProperty.CurValue)
			{
				fullHeatProperty.Set(num);
			}
			if (heroHeatProperty.IsMax && overHeatableProperty.CurValue == 1f)
			{
				isHeroHeatCD = true;
				overHeatProperty.Set(1f);
				heroHeatProperty.ResetValue(toMax: false, isExecuteValueChanged: false);
				heroHeatProperty.ResetMax(0f, isExecuteValueChanged: false);
				fullHeatProperty.ResetValue(toMax: false, isExecuteValueChanged: false);
			}
			if (isHeroHeatCD)
			{
				gunViewModel.GunState = GunState.OverHear;
				gunViewModel.OverHearFill = 1f;
			}
			else
			{
				gunViewModel.GunState = ((num == 1) ? GunState.FullHeat : GunState.Normal);
			}
			gunViewModel.HeroHeatFill = heroHeatProperty.ScaleValue;
		}
	}

	private void OnBulletNumMaxChanged()
	{
		gunViewModel.GunBulletCountMax = (int)bulletNumProperty.MaxValue;
	}

	private void OnHeroHeatThresholdChanged()
	{
		gunViewModel.ThresholdFill = Mathf.Clamp01(heroHeatThresholdProperty.CurValue / heroHeatMax);
	}

	protected virtual void UpdateBulletNumber()
	{
		int num = ((bulletList != null) ? bulletList.Count : 0);
		bulletNumProperty.Set(num);
		gunViewModel.GunBulletCountCur = num;
	}

	protected virtual void UpdateBulletListToViewModel()
	{
		gunViewModel.UpdateBullet(bulletList);
	}

	public override void OnDispose()
	{
		base.OnDispose();
		heroHeatProperty?.RemoveOnChangedCallback(this);
		heroHeatThresholdProperty?.RemoveOnChangedCallback(this);
		bulletNumProperty?.RemoveOnChangedCallback(this);
	}

	public IWeaponGunBulletCallback WeaponGunBulletOperation(IWeaponGunBulletOperaDataBase dataBase)
	{
		if (dataBase.OperType == WeaponGunBulletOperationType.None)
		{
			Log.Error("双枪子弹操作类型错误");
			return null;
		}
		if (operationDic != null && operationDic.TryGetValue(dataBase.OperType, out var value))
		{
			return value.WeaponBulletOperationFunc(this, dataBase);
		}
		return null;
	}

	public virtual IWeaponGunBulletCallback RamBullet(IWeaponGunBulletOperaDataBase dataBase)
	{
		GunBulletRamData gunBulletRamData = (GunBulletRamData)(object)dataBase;
		int num = (int)bulletNumProperty.MaxValue;
		gunBulletRamData.index = Mathf.Max(Mathf.Min(num - 1, gunBulletRamData.index), 0);
		WeaponGunBulletData item = CreateWeaponGunBulletData(gunBulletRamData.bulletType);
		for (int i = 0; i < gunBulletRamData.count; i++)
		{
			bulletList.Insert(gunBulletRamData.index, item);
			gunBulletRamData.index++;
		}
		if (bulletList.Count > num)
		{
			int index = Mathf.Clamp(num, 0, num);
			bulletList.RemoveRange(index, bulletList.Count - num);
		}
		UpdateBulletNumber();
		UpdateBulletListToViewModel();
		return default(GunBulletRamCallback);
	}

	public virtual IWeaponGunBulletCallback ConsumeBullet(IWeaponGunBulletOperaDataBase dataBase)
	{
		GunBulletConsumeData consumeData = (GunBulletConsumeData)(object)dataBase;
		List<WeaponGunBulletData> list = new List<WeaponGunBulletData>();
		int num = -1;
		for (int i = 0; i < consumeData.count; i++)
		{
			num = bulletList.FindLastIndex((WeaponGunBulletData b) => b.BulletType == consumeData.bulletType || consumeData.bulletType == WeaponGunBulletType.All);
			if (num < 0)
			{
				break;
			}
			list.Add(bulletList[num]);
			bulletList.RemoveAt(num);
		}
		UpdateBulletNumber();
		UpdateBulletListToViewModel();
		OnWeaponDataChangeStat(WeaponStatEnum.Bullet, list);
		return new GunBulletConsumeCallback
		{
			list = list
		};
	}

	public virtual IWeaponGunBulletCallback ClearBullet(IWeaponGunBulletOperaDataBase dataBase)
	{
		GunBulletClearData gunBulletClearData = (GunBulletClearData)(object)dataBase;
		if (gunBulletClearData.bulletType == WeaponGunBulletType.All)
		{
			bulletList.Clear();
		}
		else
		{
			for (int num = bulletList.Count - 1; num >= 0; num--)
			{
				if (bulletList[num].BulletType == gunBulletClearData.bulletType)
				{
					bulletList.RemoveAt(num);
				}
			}
		}
		UpdateBulletNumber();
		UpdateBulletListToViewModel();
		return default(GunBulletClearCallback);
	}

	public virtual IWeaponGunBulletCallback GetBullet(IWeaponGunBulletOperaDataBase dataBase)
	{
		GunBulletGetData gunBulletGetData = (GunBulletGetData)(object)dataBase;
		if (gunBulletGetData.bulletType == WeaponGunBulletType.None)
		{
			Log.Error("获取子弹节点：子弹类型错误:None");
			return null;
		}
		List<WeaponGunBulletData> list = new List<WeaponGunBulletData>();
		int num = 0;
		if (gunBulletGetData.bulletType == WeaponGunBulletType.All)
		{
			list = bulletList;
			num = bulletList.Count;
		}
		else
		{
			for (int i = 0; i < bulletList.Count; i++)
			{
				if (bulletList[i].BulletType == gunBulletGetData.bulletType)
				{
					list.Add(bulletList[i]);
					num++;
				}
			}
		}
		return new GunBulletGetCallback
		{
			list = list,
			bulletCount = num
		};
	}

	public virtual IWeaponGunBulletCallback SetBullet(IWeaponGunBulletOperaDataBase dataBase)
	{
		GunBulletSetData gunBulletSetData = (GunBulletSetData)(object)dataBase;
		if (gunBulletSetData.index >= bulletList.Count)
		{
			Log.Error($"当前子弹索引长度超出子弹总数量:(当前子弹索引 => {gunBulletSetData.index})(当前子弹总数 => {bulletList.Count})");
			return null;
		}
		WeaponGunBulletData value = bulletList[gunBulletSetData.index];
		value.SetBulletType(gunBulletSetData.bulletTypeTo);
		bulletList[gunBulletSetData.index] = value;
		UpdateBulletListToViewModel();
		return default(GunBulletSetCallback);
	}

	public virtual IWeaponGunBulletCallback RandomBullet(IWeaponGunBulletOperaDataBase dataBase)
	{
		if (!((GunBulletRandomData)(object)dataBase).isRandomData)
		{
			bulletList.Shuffle(ownerEntity);
		}
		else
		{
			int minValue = 0;
			int maxValue = 5;
			for (int i = 0; i < bulletList.Count; i++)
			{
				WeaponGunBulletData value = default(WeaponGunBulletData);
				value.SetBulletType((WeaponGunBulletType)ownerEntity.RandomInt(minValue, maxValue));
				bulletList[i] = value;
			}
		}
		UpdateBulletListToViewModel();
		return new GunBulletRandomCallback
		{
			list = bulletList
		};
	}

	public virtual IWeaponGunBulletCallback SetHeroHeatMax(IWeaponGunBulletOperaDataBase dataBase)
	{
		heroHeatMax = ((GunHeroHeatMaxData)(object)dataBase).value;
		heroHeatProperty.ResetMax(heroHeatMax);
		return default(GunHeroHeatMaxCallBack);
	}

	protected virtual WeaponGunBulletData CreateWeaponGunBulletData(WeaponGunBulletType bulletType)
	{
		WeaponGunBulletData result = default(WeaponGunBulletData);
		result.SetBulletType(bulletType);
		return result;
	}
}
