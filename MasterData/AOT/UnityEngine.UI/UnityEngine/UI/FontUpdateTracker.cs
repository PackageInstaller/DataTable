using System.Collections.Generic;

namespace UnityEngine.UI;

public static class FontUpdateTracker
{
	private static Dictionary<Font, HashSet<Text>> m_Tracked = new Dictionary<Font, HashSet<Text>>();

	public static void TrackText(Text t)
	{
		if (t.font == null)
		{
			return;
		}
		m_Tracked.TryGetValue(t.font, out var value);
		if (value == null)
		{
			if (m_Tracked.Count == 0)
			{
				Font.textureRebuilt += RebuildForFont;
			}
			value = new HashSet<Text>();
			m_Tracked.Add(t.font, value);
		}
		value.Add(t);
	}

	private static void RebuildForFont(Font f)
	{
		m_Tracked.TryGetValue(f, out var value);
		if (value == null)
		{
			return;
		}
		foreach (Text item in value)
		{
			item.FontTextureChanged();
		}
	}

	public static void UntrackText(Text t)
	{
		if (t.font == null)
		{
			return;
		}
		m_Tracked.TryGetValue(t.font, out var value);
		if (value == null)
		{
			return;
		}
		value.Remove(t);
		if (value.Count == 0)
		{
			m_Tracked.Remove(t.font);
			if (m_Tracked.Count == 0)
			{
				Font.textureRebuilt -= RebuildForFont;
			}
		}
	}
}
