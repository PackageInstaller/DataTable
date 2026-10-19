using UnityEngine;

namespace Unity.VisualScripting.Community.Libraries.Humility;

public static class HUMGameObject
{
	public static class Data
	{
		public struct Remove(GameObject target)
		{
			public GameObject target = target;
		}
	}

	public static Data.Remove Remove(this GameObject target)
	{
		return new Data.Remove(target);
	}
}
