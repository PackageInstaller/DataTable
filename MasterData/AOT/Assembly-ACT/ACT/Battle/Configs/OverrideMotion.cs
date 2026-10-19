using System;

namespace ACT.Battle.Configs;

[Serializable]
public struct OverrideMotion
{
	public bool IsForbidden;

	public ConfigMotion motion;

	private bool m_IsForbidden
	{
		get
		{
			if (!IsForbidden)
			{
				return motion != null;
			}
			return true;
		}
	}
}
