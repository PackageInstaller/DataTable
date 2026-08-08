using UnityEngine;

public class ShootTarget : ShootGameTarget
{
	public Transform starPos;

	public Transform endPos;

	private GameObject mis;

	private GameObject right;

	private GameObject tarShow1;

	private GameObject tarShow2;

	protected bool isSameCamp;

	protected bool isSuper;

	public bool IsSameCamp
	{
		get
		{
			return isSameCamp;
		}
		set
		{
			isSameCamp = value;
		}
	}

	public bool IsSuper
	{
		get
		{
			return isSuper;
		}
		set
		{
			isSuper = value;
		}
	}

	public void Awake()
	{
		mis = base.transform.Find("hitEffect/mistack").gameObject;
		right = base.transform.Find("hitEffect/right").gameObject;
		tarShow1 = base.transform.Find("tarShow1").gameObject;
		tarShow2 = base.transform.Find("tarShow2").gameObject;
		base.Speed = 0.5f;
	}

	private void Update()
	{
		if (ShootGameControl.Instance.state != ShootGameControl.GameStatus.Start && ShootGameControl.Instance.state != ShootGameControl.GameStatus.Paused && ShootGameControl.Instance.state != ShootGameControl.GameStatus.GameOver)
		{
			Move(base.Direction);
			CheckOutbound();
		}
	}

	private void CheckOutbound()
	{
		if (endPos != null && (IsCross(endPos.position, collisionDis) || base.transform.position.x < endPos.position.x))
		{
			ShootGameControl.Instance.RemoveShootGameTarget("target", this);
		}
	}

	public void SetModelShow(int randPos3)
	{
		for (int i = 1; i <= 4; i++)
		{
			base.transform.Find("tarShow1/show" + i).gameObject.SetActive(randPos3 == i);
		}
	}

	public override bool OnCollision(ShootGameTarget otherObj)
	{
		base.Direction = 8;
		ShootGameControl.Instance.RemoveShootGameTarget("target", this);
		return true;
	}

	public bool ShowEffect()
	{
		if (mis != null)
		{
			mis.SetActive(IsSameCamp);
		}
		if (right != null)
		{
			right.SetActive(!IsSameCamp);
		}
		if (tarShow1 != null)
		{
			tarShow1.SetActive(value: false);
		}
		if (tarShow2 != null)
		{
			tarShow2.SetActive(value: false);
		}
		return true;
	}

	public void ResetEffect()
	{
		if (mis != null)
		{
			mis.SetActive(value: false);
		}
		if (right != null)
		{
			right.SetActive(value: false);
		}
		if (tarShow1 != null)
		{
			tarShow1.SetActive(value: true);
		}
		if (tarShow2 != null)
		{
			tarShow2.SetActive(value: true);
		}
	}
}
