namespace System.IO;

internal static class PathInternal
{
	private static readonly bool s_isCaseSensitive = GetIsCaseSensitive();

	internal static StringComparison StringComparison
	{
		get
		{
			if (!s_isCaseSensitive)
			{
				return StringComparison.OrdinalIgnoreCase;
			}
			return StringComparison.Ordinal;
		}
	}

	private static bool GetIsCaseSensitive()
	{
		try
		{
			string text = Path.Combine(Path.GetTempPath(), "CASESENSITIVETEST" + Guid.NewGuid().ToString("N"));
			using (new FileStream(text, FileMode.CreateNew, FileAccess.ReadWrite, FileShare.None, 4096, FileOptions.DeleteOnClose))
			{
				return !File.Exists(text.ToLowerInvariant());
			}
		}
		catch (Exception)
		{
			return false;
		}
	}
}
