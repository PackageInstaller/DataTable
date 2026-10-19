using ACT;
using UnityEngine;

namespace Runtime.World;

public class BattleGateEffect : MonoBehaviour
{
	[SerializeField]
	private YooAssetReference _effectReference;

	[SerializeField]
	[Header("特效生成CD")]
	private float _cd = 2f;

	private BoxCollider _collider;

	private float _lastFireTime = float.NegativeInfinity;

	private void Awake()
	{
		_collider = GetComponent<BoxCollider>();
	}

	public void FireEffect(Vector3 contactsPos)
	{
		if (!(Time.time - _lastFireTime < _cd))
		{
			_lastFireTime = Time.time;
			Transform transform = _collider.transform;
			Vector3 vector = transform.rotation * _collider.center;
			contactsPos.x = transform.position.x + vector.x;
			Quaternion rotate = Quaternion.Euler(0f, 90f, 0f);
			GameManager.effectSystem.FireEffect(_effectReference, contactsPos, rotate);
		}
	}
}
