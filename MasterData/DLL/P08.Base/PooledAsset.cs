using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[DisallowMultipleComponent]
public class PooledAsset : MonoBehaviour, IPoolActive
{
	public bool mDontDestroy;

	public ResourceCache mLinkCache;

	public static Dictionary<GameObject, PooledAsset> mPoolTable = new Dictionary<GameObject, PooledAsset>(200);

	public virtual float mSimulatorTime { get; set; }

	public virtual bool mIsRunning { get; set; }

	public virtual bool mReuseOldestGameobject { get; set; }

	public virtual void SetActive(bool active)
	{
		base.gameObject.SetActive(active);
	}

	public virtual void Stop()
	{
		base.gameObject.SetActive(value: false);
	}

	public void Return()
	{
		if (mLinkCache != null && !mLinkCache.HasReturn(base.gameObject))
		{
			mLinkCache.Return(base.gameObject);
		}
	}

	public void Return(float duringTime)
	{
		if (duringTime <= 0f || !base.gameObject.activeInHierarchy)
		{
			Return();
		}
		else
		{
			StartCoroutine(Delay(duringTime));
		}
	}

	private IEnumerator Delay(float delayTime)
	{
		while (delayTime >= 0f)
		{
			delayTime -= Time.deltaTime;
			yield return null;
		}
		Return();
	}

	private void OnDestroy()
	{
		if (mLinkCache != null)
		{
			mLinkCache.Remove(base.gameObject);
			mLinkCache.CheckEmpty();
			mLinkCache = null;
		}
		mPoolTable.Remove(base.gameObject);
	}

	public static void DestroyOrReturn(GameObject go)
	{
		if (go == null)
		{
			return;
		}
		PooledAsset pooledAsset = null;
		if (mPoolTable.ContainsKey(go))
		{
			pooledAsset = mPoolTable[go];
		}
		else
		{
			pooledAsset = go.GetComponent<PooledAsset>();
			if (pooledAsset != null && pooledAsset.mLinkCache != null)
			{
				mPoolTable[go] = pooledAsset;
			}
			else
			{
				Debug.LogWarning("!!!!!!" + go.name + "没有PooledAsset组件，直接移除!!!!!!");
			}
		}
		if (pooledAsset != null && pooledAsset.mLinkCache != null)
		{
			if (string.IsNullOrEmpty(pooledAsset.mLinkCache.assetPath))
			{
				pooledAsset.Return();
			}
			else
			{
				Object.Destroy(go);
			}
		}
		else
		{
			Object.Destroy(go);
		}
	}

	public static void DestroyOrReturn(GameObject go, float time)
	{
		PooledAsset pooledAsset = null;
		if (mPoolTable.ContainsKey(go))
		{
			pooledAsset = mPoolTable[go];
		}
		else
		{
			pooledAsset = go.GetComponent<PooledAsset>();
			if (pooledAsset != null)
			{
				mPoolTable[go] = pooledAsset;
			}
			else
			{
				Debug.LogWarning("!!!!!!" + go.name + "没有PooledAsset组件，直接移除!!!!!!");
			}
		}
		if (pooledAsset != null)
		{
			pooledAsset.Return(time);
		}
		else
		{
			Object.Destroy(go, time);
		}
	}
}
