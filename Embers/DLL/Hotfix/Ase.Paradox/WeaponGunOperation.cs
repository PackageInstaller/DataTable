using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("双枪武器操作", 0)]
[Category("✫ DragonLost/Weapon")]
[Description("双枪武器操作")]
public class WeaponGunOperation : ActionTaskBase
{
	[Name("操作类型", 0)]
	[Description("操作类型")]
	public WeaponGunBulletOperationType bulletOperType;

	[ShowIf("bulletOperType", new int[] { 1, 2, 3, 4, 5 })]
	[Name("子弹类型", 0)]
	[Tooltip("当前参数不得为None!")]
	[Description("子弹类型")]
	public BBParameter<WeaponGunBulletType> bulletType;

	[ShowIf("bulletOperType", new int[] { 1, 5 })]
	[Name("子弹索引", 0)]
	[Description("子弹索引")]
	public BBParameter<int> bulletIndex;

	[ShowIf("bulletOperType", new int[] { 1, 2 })]
	[Name("子弹数量", 0)]
	[Description("子弹数量")]
	public BBParameter<int> bulletCount;

	[ShowIf("bulletOperType", 6)]
	[Name("是否随机子弹数据", 0)]
	[Description("是否随机子弹数据")]
	public BBParameter<bool> isRandomData;

	[ShowIf("bulletOperType", 7)]
	[Name("设置灵能最大值", 0)]
	public BBParameter<int> heroHeatMax;

	[ParadoxNotion.Design.Space(10, "———————————————————————————")]
	[ShowIf("bulletOperType", new int[] { 4, 6, 2 })]
	[Name("返回子弹列表", 0)]
	[Tooltip("如果操作类型为 <Sub> 则\n返回列表索引为子弹类型\n返回值为子弹消耗数量")]
	[Description("返回子弹列表")]
	public BBParameter<List<int>> bulletList;

	[ShowIf("bulletOperType", new int[] { 4, 2 })]
	[Name("返回子弹数量", 0)]
	[Description("返回子弹数量")]
	public BBParameter<int> consumeCount;

	private WeaponMechanismGun wepaonGun;

	private Dictionary<WeaponGunBulletOperationType, IWeaponGunOperationAction> operDic;

	private Dictionary<WeaponGunBulletOperationType, IWeaponGunCallbackAction> callbackDic;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (ownerEntity is HeroEntity heroEntity && heroEntity.BattleHeroData.WeaponEnum == WeaponEnum.Gun && bulletOperType != WeaponGunBulletOperationType.None)
		{
			wepaonGun = heroEntity.BattleHeroData.WeaponMechanismBase as WeaponMechanismGun;
			IWeaponGunBulletOperaDataBase operationData = GetOperationData();
			IWeaponGunBulletCallback callback = wepaonGun?.WeaponGunBulletOperation(operationData);
			WeaponGunBulletCallback(callback);
		}
		OnActionFinish();
	}

	protected override void OnGraphStop()
	{
	}

	protected virtual IWeaponGunBulletOperaDataBase GetOperationData()
	{
		InitOperationDic();
		if (operDic.TryGetValue(bulletOperType, out var value))
		{
			return value.GetOperationData(this);
		}
		return null;
	}

	protected virtual void WeaponGunBulletCallback(IWeaponGunBulletCallback callback)
	{
		if (callback != null)
		{
			InitCallbackDic();
			if (callbackDic.TryGetValue(callback.OperType, out var value))
			{
				value.GetWeaponGunBulletCallback(this, callback);
			}
		}
	}

	protected virtual void InitOperationDic()
	{
		if (operDic == null)
		{
			operDic = new Dictionary<WeaponGunBulletOperationType, IWeaponGunOperationAction>
			{
				{
					WeaponGunBulletOperationType.Add,
					new WeaponGunOperationAdd()
				},
				{
					WeaponGunBulletOperationType.Sub,
					new WeaponGunOperationSub()
				},
				{
					WeaponGunBulletOperationType.Clear,
					new WeaponGunOperationClear()
				},
				{
					WeaponGunBulletOperationType.Get,
					new WeaponGunOperationGet()
				},
				{
					WeaponGunBulletOperationType.Set,
					new WeaponGunOperationSet()
				},
				{
					WeaponGunBulletOperationType.Disrupted,
					new WeaponGunOperationDisrupted()
				},
				{
					WeaponGunBulletOperationType.SetHeroHeatMax,
					new WeaponGunOperationSetHeroHeatMax()
				}
			};
		}
	}

	protected virtual void InitCallbackDic()
	{
		if (callbackDic == null)
		{
			callbackDic = new Dictionary<WeaponGunBulletOperationType, IWeaponGunCallbackAction>
			{
				{
					WeaponGunBulletOperationType.Add,
					new WeaponGunCallbackActionAdd()
				},
				{
					WeaponGunBulletOperationType.Sub,
					new WeaponGunCallbackActionSub()
				},
				{
					WeaponGunBulletOperationType.Clear,
					new WeaponGunCallbackActionClear()
				},
				{
					WeaponGunBulletOperationType.Get,
					new WeaponGunCallbackActionGet()
				},
				{
					WeaponGunBulletOperationType.Set,
					new WeaponGunCallbackActionSet()
				},
				{
					WeaponGunBulletOperationType.Disrupted,
					new WeaponGunCallbackActionDisrupted()
				},
				{
					WeaponGunBulletOperationType.SetHeroHeatMax,
					new WeaponGunCallbackActionSetHeroHeatMax()
				}
			};
		}
	}

	public virtual IWeaponGunBulletOperaDataBase GetOperationAddData()
	{
		return new GunBulletRamData
		{
			bulletType = bulletType.value,
			index = bulletIndex.value,
			count = bulletCount.value
		};
	}

	public virtual IWeaponGunBulletOperaDataBase GetOperationSubData()
	{
		return new GunBulletConsumeData
		{
			bulletType = bulletType.value,
			count = bulletCount.value
		};
	}

	public virtual IWeaponGunBulletOperaDataBase GetOperationClearData()
	{
		return new GunBulletClearData
		{
			bulletType = bulletType.value
		};
	}

	public virtual IWeaponGunBulletOperaDataBase GetOperationGetData()
	{
		return new GunBulletGetData
		{
			bulletType = bulletType.value
		};
	}

	public virtual IWeaponGunBulletOperaDataBase GetOperationSetData()
	{
		return new GunBulletSetData
		{
			bulletTypeTo = bulletType.value,
			index = bulletIndex.value
		};
	}

	public virtual IWeaponGunBulletOperaDataBase GetOperationDisruptedData()
	{
		return new GunBulletRandomData
		{
			isRandomData = isRandomData.value
		};
	}

	public virtual IWeaponGunBulletOperaDataBase GetOperationSetHeroHeatMaxData()
	{
		return new GunBulletRandomData
		{
			isRandomData = isRandomData.value
		};
	}

	public virtual void GetAddCallback(IWeaponGunBulletCallback callback)
	{
	}

	public virtual void GetSubCallback(IWeaponGunBulletCallback callback)
	{
		GunBulletConsumeCallback gunBulletConsumeCallback = (GunBulletConsumeCallback)(object)callback;
		consumeCount.value = gunBulletConsumeCallback.list.Count;
		List<int> list = new List<int>(5) { 0, 0, 0, 0, 0 };
		for (int i = 0; i < gunBulletConsumeCallback.list.Count; i++)
		{
			list[(int)gunBulletConsumeCallback.list[i].BulletType]++;
		}
		bulletList.value = list;
	}

	public virtual void GetClearCallback(IWeaponGunBulletCallback callback)
	{
	}

	public virtual void GetGetCallback(IWeaponGunBulletCallback callback)
	{
		GunBulletGetCallback gunBulletGetCallback = (GunBulletGetCallback)(object)callback;
		List<int> list = new List<int>(gunBulletGetCallback.list.Count);
		for (int i = 0; i < gunBulletGetCallback.list.Count; i++)
		{
			list.Add((int)gunBulletGetCallback.list[i].BulletType);
		}
		bulletList.value = list;
		consumeCount.value = gunBulletGetCallback.bulletCount;
	}

	public virtual void GetSetCallback(IWeaponGunBulletCallback callback)
	{
	}

	public virtual void GetDisruptedCallback(IWeaponGunBulletCallback callback)
	{
		GunBulletRandomCallback gunBulletRandomCallback = (GunBulletRandomCallback)(object)callback;
		List<int> list = new List<int>(gunBulletRandomCallback.list.Count);
		for (int i = 0; i < gunBulletRandomCallback.list.Count; i++)
		{
			list.Add((int)gunBulletRandomCallback.list[i].BulletType);
		}
		bulletList.value = list;
	}

	public virtual void GetHeroHeatMaxCallback(IWeaponGunBulletCallback callback)
	{
	}
}
