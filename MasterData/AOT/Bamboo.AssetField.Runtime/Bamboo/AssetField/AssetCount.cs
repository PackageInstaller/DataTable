using Bamboo.Pool;
using UnityEngine;

namespace Bamboo.AssetField;

public class AssetCount : IRecycle
{
	public object Asset;

	public int Count;

	public bool IsRecycled { get; set; }

	public T As<T>() where T : Object
	{
		if (Asset == null)
		{
			return null;
		}
		return Asset as T;
	}

	public void Recycle()
	{
		Asset = null;
		Count = 0;
	}
}
