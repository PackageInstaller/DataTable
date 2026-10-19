using ACT.Battle;
using Fundamental;
using UnityEngine;

namespace ACT.World.Function;

[RequireComponent(typeof(Collider))]
public class EnvironmentInfoCollider : MonoTriggerEvent, EnvironmentInfoBase, ITrigger
{
	public EnvironmentState environmentState;

	private bool _isAlreadyIn;

	public EnvironmentState states => environmentState;

	private void OnTriggerEnter(Collider other)
	{
		MonoEntity component = other.GetComponent<MonoEntity>();
		if (component != null && component.entity == MonoECS.instance.mainEntity && !_isAlreadyIn)
		{
			Singleton<EnvironmentInfoManager>.instance.AddEnvironmentInfoCollider(this);
			_isAlreadyIn = true;
			OnEnterEvt(component.entity, this);
		}
	}

	private void OnTriggerExit(Collider other)
	{
		MonoEntity component = other.GetComponent<MonoEntity>();
		if (component != null && component.entity == MonoECS.instance.mainEntity)
		{
			Singleton<EnvironmentInfoManager>.instance.RemoveEnvironmentInfoCollider(this);
			_isAlreadyIn = false;
			OnExitEvt(component.entity, this);
		}
	}

	public void TriggerExit()
	{
		if (MonoECS.instance.localPlayer.battleEntity.IsValid)
		{
			_isAlreadyIn = false;
			Singleton<EnvironmentInfoManager>.instance.RemoveEnvironmentInfoCollider(this);
		}
	}

	public void OnDisable()
	{
		Singleton<EnvironmentInfoManager>.instance.RemoveEnvironmentInfoCollider(this);
	}

	public void OnDestroy()
	{
		Singleton<EnvironmentInfoManager>.instance.RemoveEnvironmentInfoCollider(this);
	}
}
