using System;
using UnityEngine;

namespace BilliardGame.Runtime;

public class BilliardGameEffect : MonoBehaviour
{
	private ParticleSystem ps;

	private float playTime;

	public GameObject parent;

	private Action dieCallBack;

	public float scale;

	private Quaternion effectRotation = Quaternion.identity;

	public void Init(string conf)
	{
		base.name = conf;
		ps = base.transform.GetComponentInChildren<ParticleSystem>();
		base.gameObject.SetActive(value: false);
	}

	public void Play(float scale)
	{
		playTime = 0f;
		base.gameObject.SetActive(value: true);
		ps.Play();
		SetScale(base.transform, scale);
		base.transform.rotation = effectRotation;
	}

	public void SetScale(Transform t, float scale)
	{
		t.localScale = new Vector3(scale, scale, scale);
		this.scale = scale;
	}

	public void AddScale(float scale)
	{
		this.scale += scale;
		SetScale(base.transform, this.scale);
	}

	private void Update()
	{
		playTime += Time.deltaTime;
		if (parent != null)
		{
			if (parent.activeSelf)
			{
				base.transform.position = parent.transform.position;
			}
			else
			{
				Die();
			}
		}
		if (playTime > ps.main.duration && ps.main.ringBufferMode != ParticleSystemRingBufferMode.PauseUntilReplaced && !ps.main.loop)
		{
			Die();
		}
	}

	public void SetParent(GameObject obj)
	{
		parent = obj;
	}

	public void SetRotation(Quaternion rotation)
	{
		effectRotation = rotation;
	}

	public void Die()
	{
		if (dieCallBack != null)
		{
			dieCallBack();
			dieCallBack = null;
		}
		base.gameObject.SetActive(value: false);
	}

	public void SetDieCallBack(Action callBack)
	{
		dieCallBack = callBack;
	}

	private void OnDestroy()
	{
	}
}
