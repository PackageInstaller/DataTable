using System;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.Battle;

public class BigWorldRunningPointTrigger : MonoBehaviour
{
	public Action<Collider> onTriggerEnter;

	public Action<Collider> onTriggerExit;

	private async void OnTriggerEnter(Collider other)
	{
		MonoEntity component = other.gameObject.GetComponent<MonoEntity>();
		if (!(component != null) || !MonoECS.instance.IsMainEntity(component.entity))
		{
			return;
		}
		if (!MonoECS.instance.isStartWorld)
		{
			await UniTask.WaitUntil(() => MonoECS.instance.isStartWorld);
		}
		if (onTriggerEnter != null)
		{
			onTriggerEnter(other);
		}
	}

	private async void OnTriggerExit(Collider other)
	{
		MonoEntity component = other.gameObject.GetComponent<MonoEntity>();
		if (!(component != null) || !MonoECS.instance.IsMainEntity(component.entity))
		{
			return;
		}
		if (!MonoECS.instance.isStartWorld)
		{
			await UniTask.WaitUntil(() => MonoECS.instance.isStartWorld);
		}
		if (onTriggerExit != null)
		{
			onTriggerExit(other);
		}
	}
}
