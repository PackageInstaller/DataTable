namespace System.IO;

public class EnumerationOptions
{
	internal static EnumerationOptions Compatible { get; } = new EnumerationOptions
	{
		MatchType = MatchType.Win32,
		AttributesToSkip = (FileAttributes)0,
		IgnoreInaccessible = false
	};

	private static EnumerationOptions CompatibleRecursive { get; } = new EnumerationOptions
	{
		RecurseSubdirectories = true,
		MatchType = MatchType.Win32,
		AttributesToSkip = (FileAttributes)0,
		IgnoreInaccessible = false
	};

	internal static EnumerationOptions Default { get; } = new EnumerationOptions();

	public bool RecurseSubdirectories { get; set; }

	public bool IgnoreInaccessible { get; set; }

	public FileAttributes AttributesToSkip { get; set; }

	public MatchType MatchType { get; set; }

	public MatchCasing MatchCasing { get; }

	public bool ReturnSpecialDirectories { get; }

	public EnumerationOptions()
	{
		IgnoreInaccessible = true;
		AttributesToSkip = FileAttributes.Hidden | FileAttributes.System;
	}

	internal static EnumerationOptions FromSearchOption(SearchOption searchOption)
	{
		if (searchOption != SearchOption.TopDirectoryOnly && searchOption != SearchOption.AllDirectories)
		{
			throw new ArgumentOutOfRangeException("searchOption", "Enum value was out of legal range.");
		}
		if (searchOption != SearchOption.AllDirectories)
		{
			return Compatible;
		}
		return CompatibleRecursive;
	}
}
