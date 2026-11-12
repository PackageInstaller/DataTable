using UnityEngine;

public class GroupSceneFlag : MonoBehaviour
{
	public int x;

	public int y;

	protected GameObject selChild;

	public bool IsTrue(int x, int y, int moveX, int moveY)
	{
		if (x - moveX == this.x)
		{
			return y - moveY == this.y;
		}
		return false;
	}

	public GameObject GetARdmChild()
	{
		if (null != selChild)
		{
			return selChild;
		}
		int childCount = transform.childCount;
		if (childCount == 0)
		{
			return null;
		}
		int index = MonoSingleton<GameController>.Instance.Random_Roguelike(0, childCount);
		selChild = transform.GetChild(index).gameObject;
		return selChild;
	}
}
