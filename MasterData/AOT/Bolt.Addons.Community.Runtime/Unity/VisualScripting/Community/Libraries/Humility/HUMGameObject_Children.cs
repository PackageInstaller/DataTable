using UnityEngine;

namespace Unity.VisualScripting.Community.Libraries.Humility;

public static class HUMGameObject_Children
{
	public static GameObject Clone(this HUMGameObject.Data.Remove remove)
	{
		remove.target.name = remove.target.name.Replace("(Clone)", string.Empty);
		return remove.target;
	}
}
