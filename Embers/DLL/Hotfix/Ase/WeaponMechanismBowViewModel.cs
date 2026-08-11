using System;
using Ase.ECS;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class WeaponMechanismBowViewModel(WeaponEnum weaponEnum, ObservableDictionary<string, Ase.ECS.PropertyData> propertyList) : WeaponMechanismViewModel(weaponEnum, propertyList)
{
	private Action<Ase.ECS.PropertyData> onBaseAwakenDataChanged;

	private Action<WeaponMechanismBow.BowState> onBowStateChanged;

	private BaseEntity hitEntity;

	[Obsolete]
	private int hitLevel;

	[Obsolete]
	private float fill;

	[Obsolete]
	private bool isFull;

	[Obsolete]
	private int hitUpdate = 1;

	[Obsolete]
	private Buff leftBuff;

	[Obsolete]
	private Buff rightBuff;

	private float fillLeft;

	[Obsolete]
	private float fillRight;

	private WeaponMechanismBow.BowState bowState;

	public int HitLevel
	{
		get
		{
			return hitLevel;
		}
		set
		{
			Set(ref hitLevel, value, "HitLevel");
		}
	}

	public float Fill
	{
		get
		{
			return fill;
		}
		set
		{
			Set(ref fill, value, "Fill");
		}
	}

	public bool IsFull
	{
		get
		{
			return isFull;
		}
		set
		{
			Set(ref isFull, value, "IsFull");
		}
	}

	public int HitUpdate
	{
		get
		{
			return hitUpdate;
		}
		set
		{
			Set(ref hitUpdate, value, "HitUpdate");
		}
	}

	public float FillLeft
	{
		get
		{
			return fillLeft;
		}
		set
		{
			Set(ref fillLeft, value, "FillLeft");
		}
	}

	public float FillRight
	{
		get
		{
			return fillRight;
		}
		set
		{
			Set(ref fillRight, value, "FillRight");
		}
	}

	public WeaponMechanismBow.BowState BowState
	{
		get
		{
			return bowState;
		}
		set
		{
			Set(ref bowState, value, "BowState");
		}
	}

	public void AddBowStateChaned(Action<WeaponMechanismBow.BowState> call)
	{
		onBowStateChanged = (Action<WeaponMechanismBow.BowState>)Delegate.Combine(onBowStateChanged, call);
	}

	public void AddBaseAwakenDataChanged(Action<Ase.ECS.PropertyData> call)
	{
		onBaseAwakenDataChanged = (Action<Ase.ECS.PropertyData>)Delegate.Combine(onBaseAwakenDataChanged, call);
	}

	public void HitDataChanged(int level, Ase.ECS.PropertyData data)
	{
		if (data != null)
		{
			FillLeft = data.CurValue / data.MaxValue;
		}
	}

	public void BowStateChanged(WeaponMechanismBow.BowState state)
	{
		BowState = state;
		onBowStateChanged?.Invoke(state);
	}

	public void BaseAwakenDataChanged(Ase.ECS.PropertyData data)
	{
		FillLeft = data.CurValue / data.MaxValue;
		FillRight = data.CurValue / data.MaxValue;
		onBaseAwakenDataChanged?.Invoke(data);
	}

	public Vector3 GetMonsterScreenPos()
	{
		if (hitEntity != null)
		{
			return hitEntity.GetSystem<CameraSystem>().BattleCamera.WorldToScreenPoint(hitEntity.GetComponent<EntityBoneComponent>().GetBonePosition("BowPoint"));
		}
		return Vector3.zero;
	}
}
