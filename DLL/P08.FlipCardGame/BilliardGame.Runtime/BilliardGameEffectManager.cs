using System;
using System.Collections.Generic;
using UnityEngine;

namespace BilliardGame.Runtime;

public class BilliardGameEffectManager
{
	private const string EFFECT_PATH = "BilliardGame/Effect/{0}";

	private Dictionary<string, List<BilliardGameEffect>> effectPool = new Dictionary<string, List<BilliardGameEffect>>();

	private Transform effectRootTrs;

	public BilliardGameEffectManager(Transform effectRootTrs)
	{
		this.effectRootTrs = effectRootTrs;
	}

	public BilliardGameEffect AddWorldEffect(string effectKey, Vector3 pos, float scale, Quaternion rotation = default(Quaternion), Action callBack = null)
	{
		BilliardGameEffect effect = GetEffect(effectKey, pos);
		if (effect == null)
		{
			return null;
		}
		effect.transform.position = pos;
		effect.SetRotation(rotation);
		effect.SetDieCallBack(callBack);
		effect.Play(scale);
		return effect;
	}

	public BilliardGameEffect AddEffect(string effectKey, GameObject obj, Vector3 pos, float scale, Action callBack = null)
	{
		if (obj == null)
		{
			return AddWorldEffect(effectKey, pos, scale, Quaternion.identity, callBack);
		}
		BilliardGameEffect effect = GetEffect(effectKey, obj.transform.position + pos);
		if (effect == null)
		{
			return null;
		}
		effect.SetParent(obj);
		effect.SetDieCallBack(callBack);
		effect.Play(scale);
		return effect;
	}

	private BilliardGameEffect GetEffect(string effectKey, Vector3 worldPos)
	{
		if (!effectPool.ContainsKey(effectKey))
		{
			effectPool.Add(effectKey, new List<BilliardGameEffect>());
		}
		List<BilliardGameEffect> list = effectPool[effectKey];
		BilliardGameEffect billiardGameEffect = null;
		for (int i = 0; i < list.Count; i++)
		{
			BilliardGameEffect billiardGameEffect2 = list[i];
			if (!billiardGameEffect2.gameObject.activeSelf)
			{
				billiardGameEffect = billiardGameEffect2;
				break;
			}
		}
		if (billiardGameEffect == null)
		{
			billiardGameEffect = CreateEffect(effectKey);
		}
		return billiardGameEffect;
	}

	private BilliardGameEffect CreateEffect(string effectKey)
	{
		GameObject gameObject = Asset.Instantiate($"BilliardGame/Effect/{effectKey}");
		gameObject.transform.SetParent(effectRootTrs);
		if (gameObject == null)
		{
			Debug.LogError("cant find file ! : " + effectKey);
		}
		BilliardGameEffect billiardGameEffect = gameObject.AddComponent<BilliardGameEffect>();
		billiardGameEffect.Init(effectKey);
		if (!effectPool.ContainsKey(effectKey))
		{
			effectPool.Add(effectKey, new List<BilliardGameEffect>());
		}
		effectPool[effectKey].Add(billiardGameEffect);
		return billiardGameEffect;
	}
}
