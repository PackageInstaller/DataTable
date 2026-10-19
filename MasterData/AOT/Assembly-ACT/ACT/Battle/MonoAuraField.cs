using System;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public class MonoAuraField : MonoBehaviour
{
	public Action<Entity> onEnter;

	public Action<Entity> onExit;

	private void OnTriggerEnter(Collider collider)
	{
		MonoEntity component = collider.gameObject.GetComponent<MonoEntity>();
		if (component != null)
		{
			onEnter?.Invoke(component.entity);
		}
	}

	private void OnTriggerExit(Collider collider)
	{
		MonoEntity component = collider.gameObject.GetComponent<MonoEntity>();
		if (component != null)
		{
			onExit?.Invoke(component.entity);
		}
	}
}
