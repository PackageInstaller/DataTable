using UnityEngine;

public class FollowOf1044 : MonoBehaviour
{
	public Transform Root;

	public Transform Bip001;

	public float Length = 1.48f;

	public float MaxValue = 1f;

	public float MinValue = 0.01f;

	public bool UseRootPosition;

	private bool changeY;

	private void Update()
	{
		if (Root == null || Bip001 == null)
		{
			return;
		}
		if (UseRootPosition)
		{
			base.transform.position = Root.position;
			return;
		}
		if (!changeY && Mathf.Abs(base.transform.position.y + Length - Bip001.position.y) > MaxValue)
		{
			changeY = true;
		}
		if (changeY)
		{
			Vector3 b = new Vector3(Root.position.x, Bip001.position.y - Length, Root.position.z);
			base.transform.position = Vector3.Lerp(base.transform.position, b, ((double)Time.deltaTime > 0.1) ? 1f : (Time.deltaTime / 0.1f));
		}
		else
		{
			base.transform.position = new Vector3(Root.position.x, base.transform.position.y, Root.position.z);
		}
		if (changeY && Mathf.Abs(base.transform.position.y + Length - Bip001.position.y) < MinValue)
		{
			changeY = false;
		}
		if (base.transform.position.y < Root.position.y)
		{
			base.transform.position = Root.position;
		}
	}
}
