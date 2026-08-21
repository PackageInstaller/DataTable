using UnityEngine.UI.Collections;

namespace UnityEngine.UI;

public class ClipperRegistry
{
	private static ClipperRegistry s_Instance;

	private readonly IndexedSet<IClipper> m_Clippers = new IndexedSet<IClipper>();

	public static ClipperRegistry instance
	{
		get
		{
			if (s_Instance == null)
			{
				s_Instance = new ClipperRegistry();
			}
			return s_Instance;
		}
	}

	protected ClipperRegistry()
	{
	}

	public void Cull()
	{
		int count = m_Clippers.Count;
		for (int i = 0; i < count; i++)
		{
			m_Clippers[i].PerformClipping();
		}
	}

	public static void Register(IClipper c)
	{
		if (c != null)
		{
			instance.m_Clippers.AddUnique(c);
		}
	}

	public static void Unregister(IClipper c)
	{
		instance.m_Clippers.Remove(c);
	}

	public static void Disable(IClipper c)
	{
		instance.m_Clippers.DisableItem(c);
	}
}
