using UnityEngine;

public class ControllerUtil
{
	public static Controller GetController(Transform target, string conName)
	{
		Controller[] components = target.GetComponents<Controller>();
		if (components != null && components.Length != 0)
		{
			for (int i = 0; i < components.Length; i++)
			{
				if (components[i].name == conName)
				{
					return components[i];
				}
			}
		}
		return null;
	}

	public static Controller2D GetController2D(Transform target, string conName)
	{
		Controller2D[] components = target.GetComponents<Controller2D>();
		if (components != null && components.Length != 0)
		{
			for (int i = 0; i < components.Length; i++)
			{
				if (components[i].name == conName)
				{
					return components[i];
				}
			}
		}
		return null;
	}
}
