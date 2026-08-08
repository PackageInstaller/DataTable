namespace UnityEngine.UI;

public interface LoopScrollPrefabSource
{
	GameObject GetObject(int index);

	void ReturnObject(Transform trans);
}
