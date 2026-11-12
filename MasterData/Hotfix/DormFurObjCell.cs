using UnityEngine;

public class DormFurObjCell
{
	public float x;

	public float y;

	public float z;

	public GameObject Cube;

	public void Clear()
	{
		x = (y = (z = 0f));
		if (Cube != null)
		{
			Object.DestroyImmediate(Cube);
		}
		Cube = null;
	}
}
