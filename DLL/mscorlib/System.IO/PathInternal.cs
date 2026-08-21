using System.Runtime.CompilerServices;

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

	internal static bool IsValidDriveChar(char value)
	{
		if (value < 'A' || value > 'Z')
		{
			if (value >= 'a')
			{
				return value <= 'z';
			}
			return false;
		}
		return true;
	}

	internal static bool EndsWithPeriodOrSpace(string path)
	{
		if (string.IsNullOrEmpty(path))
		{
			return false;
		}
		char c = path[path.Length - 1];
		if (c != ' ')
		{
			return c == '.';
		}
		return true;
	}

	internal static string EnsureExtendedPrefixIfNeeded(string path)
	{
		if (path != null && (path.Length >= 260 || EndsWithPeriodOrSpace(path)))
		{
			return EnsureExtendedPrefix(path);
		}
		return path;
	}

	internal static string EnsureExtendedPrefix(string path)
	{
		if (IsPartiallyQualified(path) || IsDevice(path))
		{
			return path;
		}
		if (path.StartsWith("\\\\", StringComparison.OrdinalIgnoreCase))
		{
			return path.Insert(2, "?\\UNC\\");
		}
		return "\\\\?\\" + path;
	}

	internal static bool IsDevice(ReadOnlySpan<char> path)
	{
		if (!IsExtended(path))
		{
			if (path.Length >= 4 && IsDirectorySeparator(path[0]) && IsDirectorySeparator(path[1]) && (path[2] == '.' || path[2] == '?'))
			{
				return IsDirectorySeparator(path[3]);
			}
			return false;
		}
		return true;
	}

	internal static bool IsDeviceUNC(ReadOnlySpan<char> path)
	{
		if (path.Length >= 8 && IsDevice(path) && IsDirectorySeparator(path[7]) && path[4] == 'U' && path[5] == 'N')
		{
			return path[6] == 'C';
		}
		return false;
	}

	internal static bool IsExtended(ReadOnlySpan<char> path)
	{
		if (path.Length >= 4 && path[0] == '\\' && (path[1] == '\\' || path[1] == '?') && path[2] == '?')
		{
			return path[3] == '\\';
		}
		return false;
	}

	internal static int GetRootLength(ReadOnlySpan<char> path)
	{
		int length = path.Length;
		int i = 0;
		bool flag = IsDevice(path);
		bool flag2 = flag && IsDeviceUNC(path);
		if ((!flag | flag2) && length > 0 && IsDirectorySeparator(path[0]))
		{
			if (flag2 || (length > 1 && IsDirectorySeparator(path[1])))
			{
				i = (flag2 ? 8 : 2);
				int num = 2;
				for (; i < length; i++)
				{
					if (IsDirectorySeparator(path[i]) && --num <= 0)
					{
						break;
					}
				}
			}
			else
			{
				i = 1;
			}
		}
		else if (flag)
		{
			for (i = 4; i < length && !IsDirectorySeparator(path[i]); i++)
			{
			}
			if (i < length && i > 4 && IsDirectorySeparator(path[i]))
			{
				i++;
			}
		}
		else if (length >= 2 && path[1] == ':' && IsValidDriveChar(path[0]))
		{
			i = 2;
			if (length > 2 && IsDirectorySeparator(path[2]))
			{
				i++;
			}
		}
		return i;
	}

	internal static bool IsPartiallyQualified(ReadOnlySpan<char> path)
	{
		if (path.Length < 2)
		{
			return true;
		}
		if (IsDirectorySeparator(path[0]))
		{
			if (path[1] != '?')
			{
				return !IsDirectorySeparator(path[1]);
			}
			return false;
		}
		if (path.Length >= 3 && path[1] == ':' && IsDirectorySeparator(path[2]))
		{
			return !IsValidDriveChar(path[0]);
		}
		return true;
	}

	[MethodImpl((MethodImplOptions)256)]
	internal static bool IsDirectorySeparator(char c)
	{
		if (c != '\\')
		{
			return c == '/';
		}
		return true;
	}

	internal static bool IsEffectivelyEmpty(ReadOnlySpan<char> path)
	{
		if (path.IsEmpty)
		{
			return true;
		}
		ReadOnlySpan<char> readOnlySpan = path;
		for (int i = 0; i < readOnlySpan.Length; i++)
		{
			if (readOnlySpan[i] != ' ')
			{
				return false;
			}
		}
		return true;
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
			return path + "\\";
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
