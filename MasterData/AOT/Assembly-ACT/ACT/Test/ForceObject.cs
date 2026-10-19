using ACT.Battle;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Test;

public class ForceObject : MonoBehaviour
{
	private Rigidbody2D ForceObjects;

	private Vector2 hitPos;

	private Entity target;

	public Vector2 Objvelocity;

	private float acc = 3f;

	private Vector2 dis;

	private float speed = 6f;

	private bool ishit;

	private void OnEnable()
	{
		ForceObjects = transform.GetComponent<Rigidbody2D>();
		target = MonoECS.instance.mainEntity;
	}

	private void OnTriggerEnter2D(Collider2D other)
	{
		ishit = true;
		speed = 6f;
		hitPos = other.bounds.ClosestPoint(transform.position);
		dis = (Vector2)transform.position - hitPos;
		Objvelocity = target.GetCompPhysics().characterMovement.velocity;
	}

	private void Update()
	{
		if (speed > 0f && ishit)
		{
			speed -= acc * Time.deltaTime;
		}
		if (speed <= 0f)
		{
			speed = 0f;
		}
		transform.position = (Vector2)transform.position + dis.normalized * Time.deltaTime * speed;
	}
}
