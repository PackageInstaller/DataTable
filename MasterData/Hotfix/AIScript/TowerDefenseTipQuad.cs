using UnityEngine;

namespace AIScript;

internal class TowerDefenseTipQuad
{
	private GameObject tipQuad;

	private int index;

	private readonly string[] CHILDS = new string[6] { "pass", "select", "set", "lock", "self", "target" };

	public int Index => index;

	public void Init(GameObject tipQuad)
	{
		this.tipQuad = tipQuad;
		index = -1;
	}

	public void UpdateIndex(int index)
	{
		this.index = index;
	}

	public void UpdatePosition(Vector3 position)
	{
		tipQuad.transform.position = position;
	}

	public void UpdateState(string openChild)
	{
		for (int i = 0; i < CHILDS.Length; i++)
		{
			Transform transform = tipQuad.transform.Find(CHILDS[i]);
			if (null == transform)
			{
				Debug.LogWarning(tipQuad.name + "没有找到子节点" + CHILDS[i]);
			}
			else
			{
				transform.gameObject.SetActive(value: false);
			}
		}
		if (string.IsNullOrEmpty(openChild))
		{
			index = -1;
			return;
		}
		Transform transform2 = tipQuad.transform.Find(openChild);
		if (null != transform2)
		{
			transform2.gameObject.SetActive(value: true);
		}
	}

	public void Clear()
	{
		Object.Destroy(tipQuad);
		tipQuad = null;
		index = -1;
	}
}
