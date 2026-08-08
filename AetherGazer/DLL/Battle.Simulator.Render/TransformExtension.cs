using UnityEngine;

public static class TransformExtension
{
	public static Transform FindChildInAllChild(this Transform self, string childName)
	{
		Transform transform = self.Find(childName);
		if (null == transform)
		{
			for (int i = 0; i < self.childCount; i++)
			{
				transform = self.GetChild(i).FindChildInAllChild(childName);
				if (transform != null)
				{
					break;
				}
			}
		}
		return transform;
	}

	public static string GetChildPath(this Transform self, Transform attchPoint)
	{
		if (self == attchPoint || null == attchPoint)
		{
			return string.Empty;
		}
		if (self.FindChildInAllChild(attchPoint.name) == null)
		{
			return string.Empty;
		}
		string text = attchPoint.name;
		Transform parent = attchPoint.transform.parent;
		while (null != parent && parent != self)
		{
			text = parent.name + "/" + text;
			parent = parent.parent;
		}
		return text;
	}
}
