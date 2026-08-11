using System;
using Ase.ECS;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class WeaponMechanismViewModel : ViewModelBase
{
	protected WeaponEnum weaponEnum;

	protected ObservableDictionary<string, Ase.ECS.PropertyData> propertyList;

	private InteractionRequest<Vector3> updateReloadingPosRequest = new InteractionRequest<Vector3>();

	private Action<BaseEntity, HitColliderVariableData, float> onDamageCumulativeChanged;

	public ObservableDictionary<string, Ase.ECS.PropertyData> Property => propertyList;

	public IInteractionRequest UpdateReloadingPosRequest => updateReloadingPosRequest;

	public WeaponEnum WeaponEnum
	{
		get
		{
			return weaponEnum;
		}
		set
		{
			Set(ref weaponEnum, value, "WeaponEnum");
		}
	}

	public WeaponMechanismViewModel(WeaponEnum weaponEnum, ObservableDictionary<string, Ase.ECS.PropertyData> propertyList)
	{
		this.propertyList = propertyList;
		this.weaponEnum = weaponEnum;
	}

	public void OnSkillCharge(int skillId)
	{
	}

	public void OnHammerSkillChargeRelease(int skillId)
	{
	}

	public void OnSkillEndCharge(int skillId)
	{
	}

	public virtual void OnUpdate(float delta)
	{
	}

	public void AddDamageCumulativeChanged(Action<BaseEntity, HitColliderVariableData, float> call)
	{
		onDamageCumulativeChanged = (Action<BaseEntity, HitColliderVariableData, float>)Delegate.Combine(onDamageCumulativeChanged, call);
	}

	public void DamageCumulativeChanged(BaseEntity hitEntity, HitColliderVariableData hitData, float value)
	{
		onDamageCumulativeChanged?.Invoke(hitEntity, hitData, value);
	}
}
