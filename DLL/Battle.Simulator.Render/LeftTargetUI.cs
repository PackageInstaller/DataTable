using System.Collections.Generic;
using UnityEngine;

public class LeftTargetUI : MonoBehaviour
{
	public LeftSpDescUI tpl;

	private Dictionary<int, LeftSpDescUI> dict = new Dictionary<int, LeftSpDescUI>();

	public void Add(int id, string imagePath, string title, string content)
	{
		if (tpl == null || dict == null)
		{
			return;
		}
		if (!dict.TryGetValue(id, out var value))
		{
			GameObject gameObject = Object.Instantiate(tpl.gameObject, tpl.transform.parent);
			if (gameObject == null)
			{
				return;
			}
			value = gameObject.GetComponent<LeftSpDescUI>();
			if (value == null)
			{
				return;
			}
			dict[id] = value;
		}
		if (!(value == null))
		{
			value.Init(imagePath, title, content);
			value.gameObject.SetActive(value: true);
		}
	}

	public void Remove(int id)
	{
		if (dict != null && dict.TryGetValue(id, out var value) && value != null)
		{
			value.gameObject.SetActive(value: false);
		}
	}
}
