using UnityEngine;

public interface IPool
{
	bool HasReturn(GameObject inObject);

	void ReturnPool(GameObject inObject);

	void Remove(GameObject inObject);
}
