using UnityEngine;

namespace ACT.World.Asset;

public abstract class MonoDataBaker : MonoBehaviour
{
	public virtual bool BakeSystemVisibility
	{
		get
		{
			if (enabled)
			{
				return gameObject.activeInHierarchy;
			}
			return false;
		}
	}

	public abstract IDataBaker Baker { get; }
}
