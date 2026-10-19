using System;
using UnityEngine;

namespace ACT.Battle;

public class TriggerProxy : MonoBehaviour
{
	public Action<Collider> triggerEnter;

	public Action<Collider> triggerExit;

	private void OnTriggerEnter(Collider other)
	{
		triggerEnter?.Invoke(other);
	}

	private void OnTriggerExit(Collider other)
	{
		triggerExit?.Invoke(other);
	}
}
