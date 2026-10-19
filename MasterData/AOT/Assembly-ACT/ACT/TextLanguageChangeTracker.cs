namespace ACT;

public static class TextLanguageChangeTracker
{
	private static bool s_PendingCloseAllOnSettingsClose;

	public static void NotifyLanguageChanged()
	{
		s_PendingCloseAllOnSettingsClose = true;
	}

	public static bool ConsumePendingCloseAllOnSettingsClose()
	{
		if (!s_PendingCloseAllOnSettingsClose)
		{
			return false;
		}
		s_PendingCloseAllOnSettingsClose = false;
		return true;
	}
}
