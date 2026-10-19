using System;
using ACT.World;
using UnityEngine;

namespace ACT.Battle;

public class MonoTrigger : MonoBehaviour, ITrigger
{
	public Action<Collider, ITrigger> triggerEnter;

	public Action<Collider, ITrigger> triggerExit;

	public Action triggerExitEvt;

	private void OnTriggerEnter(Collider other)
	{
		triggerEnter?.Invoke(other, this);
	}

	private void OnTriggerExit(Collider other)
	{
		triggerExit?.Invoke(other, this);
	}

	public void TriggerExit()
	{
		triggerExitEvt?.Invoke();
	}
}
