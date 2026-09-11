using System.Collections.Generic;
using UnityEngine;

public class CMonoBehaviour : MonoBehaviour, IBehavior
{
	[HideInInspector]
	public NAgent mAgent;

	public I GetInterfaceComponent<I>() where I : class
	{
		return GetComponent(typeof(I)) as I;
	}

	public static List<I> FindObjectsOfInterface<I>() where I : class
	{
		MonoBehaviour[] array = Object.FindObjectsOfType<MonoBehaviour>();
		List<I> list = new List<I>();
		MonoBehaviour[] array2 = array;
		for (int i = 0; i < array2.Length; i++)
		{
			if (array2[i].GetComponent(typeof(I)) is I item)
			{
				list.Add(item);
			}
		}
		return list;
	}

	public virtual void Initialize()
	{
		if (mAgent == null)
		{
			mAgent = base.gameObject.GetComponent<NAgent>();
			XLogger.Assert(mAgent != null, "this gameobject don't have NAgent!");
		}
	}

	public virtual void ActiveBehavior()
	{
	}

	public virtual void FixedUpdateBehavior()
	{
	}

	public virtual void UpdateBehavior()
	{
	}

	public virtual void LateUpdateBehavior()
	{
	}

	public virtual void ResetBehavior()
	{
	}

	public virtual void DestroyBehavior()
	{
	}
}
