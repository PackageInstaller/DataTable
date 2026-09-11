using UnityEngine;

public class BlisterBullet : BlisterEntity
{
	public float speed = 0.1f;

	public SpriteRenderer bg;

	private int direction = 8;

	private BlisterNode belong;

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

	public BlisterNode Belong
	{
		get
		{
			return belong;
		}
		set
		{
			belong = value;
		}
	}

	public void Awake()
	{
		if (bg == null)
		{
			bg = base.transform.Find("bg").GetComponent<SpriteRenderer>();
		}
		AddEventListenner();
	}

	public void Move(int direction)
	{
		float num = ((Application.targetFrameRate < 30) ? 0.016f : Time.deltaTime);
		switch (direction)
		{
		case 0:
			base.transform.Translate(Vector3.right * speed * num);
			CheckOutOfBound();
			break;
		case 1:
			base.transform.Translate(new Vector3(1f, 1f, 0f) * speed * num);
			CheckOutOfBound();
			break;
		case 2:
			base.transform.Translate(Vector3.up * speed * num);
			CheckOutOfBound();
			break;
		case 3:
			base.transform.Translate(new Vector3(-1f, 1f, 0f) * speed * num);
			CheckOutOfBound();
			break;
		case 4:
			base.transform.Translate(Vector3.left * speed * num);
			CheckOutOfBound();
			break;
		case 5:
			base.transform.Translate(new Vector3(-1f, -1f, 0f) * speed * num);
			CheckOutOfBound();
			break;
		case 6:
			base.transform.Translate(Vector3.down * speed * num);
			CheckOutOfBound();
			break;
		case 7:
			base.transform.Translate(new Vector3(1f, -1f, 0f) * speed * num);
			CheckOutOfBound();
			break;
		}
		RefreshDirection(direction);
	}

	private void Update()
	{
		if (BlisterController.Instance.gameState != BlisterController.GameStatus.Paused)
		{
			Move(direction);
		}
	}

	private void CheckOutOfBound()
	{
		if (belong.blisterData.blisterNodeType == BlisterNodeType.boom)
		{
			if (BlisterController.Instance.CheckNodeOutOfBund1(this))
			{
				direction = 8;
				BlisterController.Instance.RemoveBlisterBullet(this);
			}
		}
		else if (BlisterController.Instance.CheckNodeOutOfBund(this))
		{
			direction = 8;
			BlisterController.Instance.RemoveBlisterBullet(this);
		}
	}

	public override void OnCollision(BlisterEntity otherObj)
	{
		direction = 8;
		BlisterController.Instance.RemoveBlisterBullet(this);
	}

	public void RefreshDirection(int direction)
	{
		bg.transform.rotation = Quaternion.Euler(base.transform.rotation.eulerAngles.x, base.transform.rotation.eulerAngles.y, 45 * direction);
	}
}
