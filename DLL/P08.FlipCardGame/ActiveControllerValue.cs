using System;
using UnityEngine;

[Serializable]
public class ActiveControllerValue
{
	[SerializeField]
	public bool isActive;

	public static bool CopyFromComponent(NewControllerValue value, Component target)
	{
		value.controllerProperty = ControllerProperty.Active;
		value.intValues = new int[1] { target.transform.gameObject.activeSelf ? 1 : 0 };
		return true;
	}

	public static bool PasteTo(NewControllerValue value, Component target, bool isTween, float during, LeanTweenType ease)
	{
		bool flag = value.intValues[0] == 1;
		try
		{
			UIPanel component = target.GetComponent<UIPanel>();
			if (((null == component) ? target.transform.gameObject.activeSelf : component.GetActive()) != flag)
			{
				if (Application.isPlaying)
				{
					if (component != null)
					{
						component.SetActive(flag);
					}
					else
					{
						target.transform.gameObject.SetActive(flag);
					}
				}
				else
				{
					target.transform.gameObject.SetActive(flag);
				}
			}
		}
		catch (Exception value2)
		{
			Console.WriteLine(value2);
			throw;
		}
		return true;
	}

	public static bool IsEqualTo(NewControllerValue value, Component target)
	{
		if (target.GetComponent<UIPanel>() != null)
		{
			return true;
		}
		return value.intValues[0] == 1 == target.transform.gameObject.activeSelf;
	}
}
