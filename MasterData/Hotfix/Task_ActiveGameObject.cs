using System.Collections.Generic;
using UnityEngine;

[AddComponentMenu("触发器结果/物件事件/开启或关闭物件", 0)]
public class Task_ActiveGameObject : TaskCellBase
{
	public List<GameObject> entityObects;

	public string entityTile;

	public bool active = true;

	private readonly bool toggle;

	protected override void OnExecute()
	{
		if ((entityObects == null || entityObects.Count == 0) && string.IsNullOrEmpty(entityTile))
		{
			LogWarning("未配置");
			EndAction(success: false);
			return;
		}
		if (toggle)
		{
			if (entityObects.get_Item(0).activeSelf)
			{
				DeactiveEntityObjects();
			}
			else
			{
				ActiveEntityObjects();
			}
		}
		else if (active)
		{
			ActiveEntityObjects();
		}
		else
		{
			DeactiveEntityObjects();
		}
		EndAction();
	}

	private void ActiveEntityObjects()
	{
		List<GameObject> list = entityObects;
		if (list != null && list.Count > 0)
		{
			for (int i = 0; i < entityObects.Count; i++)
			{
				entityObects.get_Item(i)?.SetActive(value: true);
			}
		}
		if (string.IsNullOrEmpty(entityTile))
		{
			return;
		}
		GameObject[] array = Resources.FindObjectsOfTypeAll<GameObject>();
		if (array == null || array.Length <= 0)
		{
			return;
		}
		for (int j = 0; j < array.Length; j++)
		{
			if (array[j].CompareTag(entityTile))
			{
				array[j].SetActive(value: true);
			}
		}
	}

	protected void DeactiveEntityObjects()
	{
		List<GameObject> list = entityObects;
		if (list != null && list.Count > 0)
		{
			for (int i = 0; i < entityObects.Count; i++)
			{
				entityObects.get_Item(i)?.SetActive(value: false);
			}
		}
		if (string.IsNullOrEmpty(entityTile))
		{
			return;
		}
		GameObject[] array = GameObject.FindGameObjectsWithTag(entityTile);
		if (array != null && array.Length > 0)
		{
			for (int j = 0; j < array.Length; j++)
			{
				array[j]?.SetActive(value: false);
			}
		}
	}
}
