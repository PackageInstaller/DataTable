using System.Collections.Generic;
using UnityEngine;

[ExecuteAlways]
public class InstancedIndirectGrassPosDefine : MonoBehaviour
{
	[Range(0f, 5f)]
	public int density = 1;

	[Range(0f, 5f)]
	public float spacing = 0.2f;

	private void Start()
	{
		UpdatePos();
	}

	[ContextMenu("UpdatePos")]
	private void UpdatePos()
	{
		InstancedIndirectGrassRenderer component = GetComponent<InstancedIndirectGrassRenderer>();
		if (!component.enabled)
		{
			SetActive();
			return;
		}
		Transform[] componentsInChildren = base.gameObject.GetComponentsInChildren<Transform>(includeInactive: true);
		List<Vector3> list = new List<Vector3>(componentsInChildren.Length - 1);
		for (int i = 1; i < componentsInChildren.Length; i++)
		{
			Transform transform = componentsInChildren[i];
			if (transform.transform.parent == base.gameObject.transform)
			{
				for (int j = 0; j <= density; j++)
				{
					int num = (j + 1) / 2;
					int num2 = j / 2;
					Random.InitState(1);
					float x = Random.Range(0f - spacing, spacing) * (float)num;
					Random.InitState(2);
					float z = Random.Range(0f - spacing, spacing) * (float)num2;
					list.Add(transform.transform.position + new Vector3(x, 0f, z));
				}
				transform.gameObject.SetActive(value: false);
			}
		}
		component.allGrassPos = list;
	}

	private void SetActive()
	{
		Transform[] componentsInChildren = base.gameObject.GetComponentsInChildren<Transform>(includeInactive: true);
		for (int i = 1; i < componentsInChildren.Length; i++)
		{
			Transform transform = componentsInChildren[i];
			if (transform.transform.parent == base.gameObject.transform)
			{
				transform.gameObject.SetActive(value: true);
			}
		}
	}
}
