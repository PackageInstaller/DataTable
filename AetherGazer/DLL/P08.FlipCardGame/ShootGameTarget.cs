using System;
using UnityEngine;

public class ShootGameTarget : MonoBehaviour
{
	public Action<GameObject> onPointerClick;

	public float speed = 1f;

	protected float collisionDis = 1.2f;

	protected int direction = 8;

	public float Speed
	{
		get
		{
			return speed;
		}
		set
		{
			if (value < 0f)
			{
				speed = 0f;
			}
			else
			{
				speed = value;
			}
		}
	}

	public int Direction
	{
		get
		{
			return direction;
		}
		set
		{
			if (value < 0)
			{
				direction = 0;
			}
			else
			{
				direction = value;
			}
		}
	}

	public bool IsCross(Vector3 targetPos, float dis)
	{
		return Vector3.Distance(base.transform.position, targetPos) <= dis;
	}

	public void Move(int direction)
	{
		float deltaTime = Time.deltaTime;
		switch (direction)
		{
		case 0:
			base.transform.Translate(Vector3.right * speed * deltaTime);
			break;
		case 1:
			base.transform.Translate(new Vector3(1f, 1f, 0f) * speed * deltaTime);
			break;
		case 2:
			base.transform.Translate(Vector3.up * speed * deltaTime);
			break;
		case 3:
			base.transform.Translate(new Vector3(-1f, 1f, 0f) * speed * deltaTime);
			break;
		case 4:
			base.transform.Translate(Vector3.left * speed * deltaTime);
			break;
		case 5:
			base.transform.Translate(new Vector3(-1f, -1f, 0f) * speed * deltaTime);
			break;
		case 6:
			base.transform.Translate(Vector3.down * speed * deltaTime);
			break;
		case 7:
			base.transform.Translate(new Vector3(1f, -1f, 0f) * speed * deltaTime);
			break;
		case 9:
			base.transform.Translate(new Vector3(0f, 0f, -1f) * speed * deltaTime);
			break;
		}
	}

	public bool IsCollision(ShootGameTarget otherObj)
	{
		return Vector3.Distance(base.transform.position, otherObj.transform.position) <= collisionDis;
	}

	public virtual void RefreshNodeState()
	{
	}

	public virtual bool OnCollision(ShootGameTarget otherObj)
	{
		return true;
	}
}
