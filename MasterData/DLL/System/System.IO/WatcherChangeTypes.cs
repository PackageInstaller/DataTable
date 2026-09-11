namespace System.IO;

[Flags]
public enum WatcherChangeTypes
{
	All = 0xF,
	Changed = 4,
	Created = 1,
	Deleted = 2,
	Renamed = 8
}
