using System;
using UnityEngine;

internal class HexBullet : MonoBehaviour
{
	public string explodeEffectPath = "Effect/Hero/6071/fx_6071_skill_hit";

	public float explodeFxTime = 1.2f;

	public float speed = 5f;

	[HideInInspector]
	public bool isMoving;

	private Vector3 endPoint;

	private Action callBack;

	public void Fire(Vector3 endPoint, Action callBack)
	{
		this.endPoint = endPoint;
		this.callBack = callBack;
		base.transform.forward = (endPoint - base.transform.position).normalized;
		isMoving = true;
	}

	private void Start()
	{
		Asset.Cache(explodeEffectPath);
	}

	private void Update()
	{
		if (!isMoving)
		{
			return;
		}
		float maxDistanceDelta = speed * Time.deltaTime;
		base.transform.position = Vector3.MoveTowards(base.transform.position, endPoint, maxDistanceDelta);
		if (0.5f > Vector3.Distance(base.transform.position, endPoint))
		{
			isMoving = false;
			if (callBack != null)
			{
				callBack();
				callBack = null;
			}
			PooledAsset.DestroyOrReturn(base.gameObject);
			PlayExplodeEffect();
		}
	}

	private void PlayExplodeEffect()
	{
		GameObject obj = Asset.Instantiate(explodeEffectPath);
		obj.transform.position = base.transform.position;
		EffectController effectController = U3DUtil.Get<EffectController>(obj);
		effectController.Initialize(isLoop: false, explodeFxTime, 1f, EEffectQuality.Medium, null);
		effectController.Simulator(0f);
	}
}
