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

	internal static bool IsCaseSensitive => s_isCaseSensitive;

	internal static int GetRootLength(ReadOnlySpan<char> path)
	{
		if (path.Length <= 0 || !IsDirectorySeparator(path[0]))
		{
			return 0;
		}
		return 1;
	}

	internal static bool IsDirectorySeparator(char c)
	{
		return c == '/';
	}

	internal static bool IsPartiallyQualified(ReadOnlySpan<char> path)
	{
		return !Path.IsPathRooted(path);
	}

	internal static bool IsEffectivelyEmpty(string path)
	{
		return string.IsNullOrEmpty(path);
	}

	internal static bool IsEffectivelyEmpty(ReadOnlySpan<char> path)
	{
		return path.IsEmpty;
	}

	internal static bool EndsInDirectorySeparator(ReadOnlySpan<char> path)
	{
		if (path.Length > 0)
		{
			return IsDirectorySeparator(path[path.Length - 1]);
		}
		return false;
	}

	internal static bool StartsWithDirectorySeparator(ReadOnlySpan<char> path)
	{
		if (path.Length > 0)
		{
			return IsDirectorySeparator(path[0]);
		}
		return false;
	}

	internal static string EnsureTrailingSeparator(string path)
	{
		if (!EndsInDirectorySeparator(path))
		{
			return path + "/";
		}
		return path;
	}

	internal static string TrimEndingDirectorySeparator(string path)
	{
		if (!EndsInDirectorySeparator(path) || IsRoot(path))
		{
			return path;
		}
		return path.Substring(0, path.Length - 1);
	}

	internal static ReadOnlySpan<char> TrimEndingDirectorySeparator(ReadOnlySpan<char> path)
	{
		if (!EndsInDirectorySeparator(path) || IsRoot(path))
		{
			return path;
		}
		return path.Slice(0, path.Length - 1);
	}

	internal static bool IsRoot(ReadOnlySpan<char> path)
	{
		return path.Length == GetRootLength(path);
	}

	internal static int GetCommonPathLength(string first, string second, bool ignoreCase)
	{
		int num = EqualStartingCharacterCount(first, second, ignoreCase);
		if (num == 0)
		{
			return num;
		}
		if (num == first.Length && (num == second.Length || IsDirectorySeparator(second[num])))
		{
			return num;
		}
		if (num == second.Length && IsDirectorySeparator(first[num]))
		{
			return num;
		}
		while (num > 0 && !IsDirectorySeparator(first[num - 1]))
		{
			num--;
		}
		return num;
	}

	internal unsafe static int EqualStartingCharacterCount(string first, string second, bool ignoreCase)
	{
		if (string.IsNullOrEmpty(first) || string.IsNullOrEmpty(second))
		{
			return 0;
		}
		int num = 0;
		fixed (char* ptr = first)
		{
			fixed (char* ptr2 = second)
			{
				char* ptr3 = ptr;
				char* ptr4 = ptr2;
				char* ptr5 = ptr3 + first.Length;
				char* ptr6 = ptr4 + second.Length;
				while (ptr3 != ptr5 && ptr4 != ptr6 && (*ptr3 == *ptr4 || (ignoreCase && char.ToUpperInvariant(*ptr3) == char.ToUpperInvariant(*ptr4))))
				{
					num++;
					ptr3++;
					ptr4++;
				}
			}
		}
		return num;
	}

	internal static bool AreRootsEqual(string first, string second, StringComparison comparisonType)
	{
		int rootLength = GetRootLength(first);
		int rootLength2 = GetRootLength(second);
		if (rootLength == rootLength2)
		{
			return string.Compare(first, 0, second, 0, rootLength, comparisonType) == 0;
		}
		return false;
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

	public static bool IsPartiallyQualified(string path)
	{
		return false;
	}

	public static bool HasIllegalCharacters(string path, bool checkAdditional)
	{
		return path.IndexOfAny(Path.InvalidPathChars) != -1;
	}
}
