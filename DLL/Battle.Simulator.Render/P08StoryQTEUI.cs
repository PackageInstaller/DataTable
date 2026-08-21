using System;
using System.Collections.Generic;
using UnityEngine;

public abstract class P08StoryQTEUI : MonoBehaviour
{
	[Serializable]
	public class UICfg
	{
		public string name;

		public GameObject go;
	}

	public List<UICfg> configs;

	public GameObject GetGoFromCfg(string str)
	{
		for (int i = 0; i < configs.Count; i++)
		{
			if (configs[i].name == str)
			{
				return configs[i].go;
			}
		}
		return null;
	}

	public virtual void Dispose(float delay)
	{
		PooledAsset.DestroyOrReturn(base.gameObject, delay);
	}
}
