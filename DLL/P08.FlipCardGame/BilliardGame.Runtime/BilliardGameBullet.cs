using UnityEngine;

namespace BilliardGame.Runtime;

public class BilliardGameBullet : BilliardGameBehaviorBase
{
	private Rigidbody2D rb;

	public void Awake()
	{
		Init();
	}

	public override void Init()
	{
		rb = GetComponent<Rigidbody2D>();
		if (rb == null)
		{
			Debug.Log("no rb");
		}
	}

	public void ClearVelocity()
	{
		rb.velocity = Vector3.zero;
	}

	public void Shoot(Vector3 dir, float speed)
	{
		base.transform.GetChild(0).localEulerAngles = new Vector3(0f, 0f, 0f);
		dir = new Vector3(dir.x, dir.y, 0f);
		dir = Vector3.Normalize(dir);
		float z = Vector3.SignedAngle(Vector3.left, -dir, Vector3.forward);
		base.transform.GetChild(0).localEulerAngles = new Vector3(0f, 0f, z);
		rb.velocity = base.transform.TransformDirection(dir) * speed;
	}

	public void ChangeRandomRot()
	{
		Transform[] componentsInChildren = base.transform.GetChild(0).GetChild(0).GetComponentsInChildren<Transform>();
		foreach (Transform transform in componentsInChildren)
		{
			int num = Random.Range(0, 181);
			transform.rotation = Quaternion.Euler(num, transform.rotation.eulerAngles.y, transform.rotation.eulerAngles.z);
		}
	}

	private void OnTriggerEnter2D(Collider2D collision)
	{
		if (collision == null || collision.gameObject.name == "ShootTrigger")
		{
			return;
		}
		if (collision.transform.TryGetComponent<BilliardGameBehaviorBase>(out var component))
		{
			if (component is BilliardGameBall && !(component is BilliardGamePhysicalBullet))
			{
				BilliardGameLogicManager.Instance.BulletCollisionPlayer(base.entityID, component.entityID);
			}
			if (component is BilliardGameEnemy)
			{
				BilliardGameLogicManager.Instance.BulletCollisionEnemy(base.entityID, component.entityID);
			}
			if (component is BilliardGameMechanism)
			{
				BilliardGameLogicManager.Instance.BulletCollisionMech(base.entityID, component.entityID);
			}
		}
		else if (collision.gameObject.name == "billiardBound")
		{
			BilliardGameLogicManager.Instance.BulletCollisionBound(base.entityID);
		}
		else
		{
			BilliardGameLogicManager.Instance.BulletCollisionWall(base.entityID);
		}
	}
}
