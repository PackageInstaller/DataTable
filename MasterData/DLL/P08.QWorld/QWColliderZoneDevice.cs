using System;
using System.Linq;
using UnityEngine;

public abstract class QWColliderZoneDevice : QWZoneDevice
{
	[NonSerialized]
	public float updateRate = 0.05f;

	private float _time;

	private Collider[] _collider1 = new Collider[5];

	private Collider[] _collider2 = new Collider[5];

	private bool _index;

	protected abstract void GetOverlapCollider(Collider[] overlapColliders);

	private void _OnTriggerEnter(Collider other)
	{
		QWCharacterProxy component = other.GetComponent<QWCharacterProxy>();
		if ((bool)component)
		{
			OnEnterZone(component.agent);
		}
	}

	private void _OnTriggerExit(Collider other)
	{
		QWCharacterProxy component = other.GetComponent<QWCharacterProxy>();
		if ((bool)component)
		{
			OnExitZone(component.agent);
		}
	}

	private void Update()
	{
		if (updateRate < 0f)
		{
			return;
		}
		_time += Time.deltaTime;
		if (_time < updateRate)
		{
			return;
		}
		_time = 0f;
		Collider[] array = (_index ? _collider1 : _collider2);
		Collider[] array2 = (_index ? _collider2 : _collider1);
		for (int i = 0; i < array.Length; i++)
		{
			array[i] = null;
		}
		GetOverlapCollider(array);
		foreach (Collider collider in array)
		{
			if ((bool)collider && !array2.Contains(collider))
			{
				_OnTriggerEnter(collider);
			}
		}
		foreach (Collider collider2 in array2)
		{
			if ((bool)collider2 && !array.Contains(collider2))
			{
				_OnTriggerExit(collider2);
			}
		}
		array.CopyTo(array2, 0);
		_index = !_index;
	}
}
