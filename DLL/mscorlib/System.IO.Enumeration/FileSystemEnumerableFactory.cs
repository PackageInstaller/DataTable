using System.Collections.Generic;

namespace System.IO.Enumeration;

internal static class FileSystemEnumerableFactory
{
	private static readonly char[] s_unixEscapeChars = new char[4] { '\\', '"', '<', '>' };

	internal static void NormalizeInputs(ref string directory, ref string expression, EnumerationOptions options)
	{
		if (Path.IsPathRooted(expression))
		{
			throw new ArgumentException("Second path fragment must not be a drive or UNC name.", "expression");
		}
		ReadOnlySpan<char> directoryName = Path.GetDirectoryName(expression.AsSpan());
		if (directoryName.Length != 0)
		{
			directory = Path.Join(directory, directoryName);
			expression = expression.Substring(directoryName.Length + 1);
		}
		switch (options.MatchType)
		{
		case MatchType.Win32:
			if (string.IsNullOrEmpty(expression) || expression == "." || expression == "*.*")
			{
				expression = "*";
				break;
			}
			if (Path.DirectorySeparatorChar != '\\' && expression.IndexOfAny(s_unixEscapeChars) != -1)
			{
				expression = expression.Replace("\\", "\\\\");
				expression = expression.Replace("\"", "\\\"");
				expression = expression.Replace(">", "\\>");
				expression = expression.Replace("<", "\\<");
			}
			expression = FileSystemName.TranslateWin32Expression(expression);
			break;
		default:
			throw new ArgumentOutOfRangeException("options");
		case MatchType.Simple:
			break;
		}
	}

	private static bool MatchesPattern(string expression, ReadOnlySpan<char> name, EnumerationOptions options)
	{
		bool ignoreCase = (options.MatchCasing == MatchCasing.PlatformDefault && !PathInternal.IsCaseSensitive) || options.MatchCasing == MatchCasing.CaseInsensitive;
		return options.MatchType switch
		{
			MatchType.Simple => FileSystemName.MatchesSimpleExpression(expression, name, ignoreCase), 
			MatchType.Win32 => FileSystemName.MatchesWin32Expression(expression, name, ignoreCase), 
			_ => throw new ArgumentOutOfRangeException("options"), 
		};
	}

	internal static IEnumerable<string> UserFiles(string directory, string expression, EnumerationOptions options)
	{
		return new FileSystemEnumerable<string>(directory, delegate(ref FileSystemEntry entry)
		{
			return entry.ToSpecifiedFullPath();
		}, options)
		{
			ShouldIncludePredicate = delegate(ref FileSystemEntry entry)
			{
				return !entry.IsDirectory && MatchesPattern(expression, entry.FileName, options);
			}
		};
	}

	internal static IEnumerable<string> UserDirectories(string directory, string expression, EnumerationOptions options)
	{
		return new FileSystemEnumerable<string>(directory, delegate(ref FileSystemEntry entry)
		{
			return entry.ToSpecifiedFullPath();
		}, options)
		{
			ShouldIncludePredicate = delegate(ref FileSystemEntry entry)
			{
				return entry.IsDirectory && MatchesPattern(expression, entry.FileName, options);
			}
		};
	}

	internal static IEnumerable<string> UserEntries(string directory, string expression, EnumerationOptions options)
	{
		return new FileSystemEnumerable<string>(directory, delegate(ref FileSystemEntry entry)
		{
			return entry.ToSpecifiedFullPath();
		}, options)
		{
			ShouldIncludePredicate = delegate(ref FileSystemEntry entry)
			{
				return MatchesPattern(expression, entry.FileName, options);
			}
		};
	}

	internal static IEnumerable<FileInfo> FileInfos(string directory, string expression, EnumerationOptions options)
	{
		return new FileSystemEnumerable<FileInfo>(directory, delegate(ref FileSystemEntry entry)
		{
			return (FileInfo)entry.ToFileSystemInfo();
		}, options)
		{
			ShouldIncludePredicate = delegate(ref FileSystemEntry entry)
			{
				return !entry.IsDirectory && MatchesPattern(expression, entry.FileName, options);
			}
		};
	}

	internal static IEnumerable<DirectoryInfo> DirectoryInfos(string directory, string expression, EnumerationOptions options)
	{
		return new FileSystemEnumerable<DirectoryInfo>(directory, delegate(ref FileSystemEntry entry)
		{
			return (DirectoryInfo)entry.ToFileSystemInfo();
		}, options)
		{
			ShouldIncludePredicate = delegate(ref FileSystemEntry entry)
			{
				return entry.IsDirectory && MatchesPattern(expression, entry.FileName, options);
			}
		};
	}

	internal static IEnumerable<FileSystemInfo> FileSystemInfos(string directory, string expression, EnumerationOptions options)
	{
		return new FileSystemEnumerable<FileSystemInfo>(directory, delegate(ref FileSystemEntry entry)
		{
			return entry.ToFileSystemInfo();
		}, options)
		{
			ShouldIncludePredicate = delegate(ref FileSystemEntry entry)
			{
				return MatchesPattern(expression, entry.FileName, options);
			}
		};
	}
}
