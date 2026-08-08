using System;
using UnityEngine;

[Serializable]
public class ActiveController2DValue
{
	[SerializeField]
	public bool isActive;

	public bool CopyFromComponent(Component target)
	{
		isActive = target.transform.gameObject.activeSelf;
		return true;
	}

	public bool PasteToComponent(Component target, bool isTween, float during, LeanTweenType ease)
	{
		try
		{
			UIPanel component = target.GetComponent<UIPanel>();
			if (((null == component) ? target.transform.gameObject.activeSelf : component.GetActive()) != isActive)
			{
				if (Application.isPlaying)
				{
					if (component != null)
					{
						component.SetActive(isActive);
					}
					else
					{
						target.transform.gameObject.SetActive(isActive);
					}
				}
				else
				{
					target.transform.gameObject.SetActive(isActive);
				}
			}
		}
		catch (Exception value)
		{
			Console.WriteLine(value);
			throw;
		}
		return true;
	}

	public bool IsEqualTo(Component target)
	{
		if (target.GetComponent<UIPanel>() != null)
		{
			return true;
		}
		return isActive == target.transform.gameObject.activeSelf;
	}
}
