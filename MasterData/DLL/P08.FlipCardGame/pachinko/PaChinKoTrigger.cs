using System;
using UnityEngine;

namespace pachinko;

public class PaChinKoTrigger : MonoBehaviour
{
	public Action onTriggerFun;

	private void Start()
	{
	}

	private void Update()
	{
	}

	private void OnTriggerEnter2D(Collider2D other)
	{
		if (other.GetComponent<PaChinKoBaseCollider>().objectType == OBJECT_TYPE.BALL)
		{
			onTriggerFun?.Invoke();
		}
	}
}
