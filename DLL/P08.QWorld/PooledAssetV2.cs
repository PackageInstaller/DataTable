using System.Collections;
using UnityEngine;

public class PooledAssetV2 : MonoBehaviour, IPoolActive
{
	public IPool mLinkCache;

	public bool mIsRunning { get; set; }

	public bool mReuseOldestGameobject { get; set; }

	public float mSimulatorTime { get; set; }

	public void SetActive(bool active)
	{
		base.gameObject.SetActive(active);
	}

	public void Stop()
	{
		base.gameObject.SetActive(value: false);
	}

	public bool Return()
	{
		if (mLinkCache != null)
		{
			if (mLinkCache.HasReturn(base.gameObject))
			{
				return false;
			}
			mLinkCache.ReturnPool(base.gameObject);
			return true;
		}
		return false;
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
			mLinkCache = null;
		}
	}

	public static void DestroyOrReturn(GameObject go)
	{
		if (!(go == null))
		{
			PooledAssetV2 component = go.GetComponent<PooledAssetV2>();
			if (!(component != null) || !component.Return())
			{
				Object.Destroy(go);
			}
		}
	}

	public static void DestroyOrReturn(GameObject go, float time)
	{
		PooledAssetV2 component = go.GetComponent<PooledAssetV2>();
		if (component != null)
		{
			component.Return(time);
		}
		else
		{
			Object.Destroy(go, time);
		}
	}
}
