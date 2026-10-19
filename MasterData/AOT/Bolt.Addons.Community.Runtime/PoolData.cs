using UnityEngine;

public struct PoolData(CustomObjectPool Pool, GameObject args)
{
	public CustomObjectPool pool = Pool;

	public GameObject arg = args;
}
