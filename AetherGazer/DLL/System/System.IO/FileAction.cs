namespace System.IO;

internal enum FileAction
{
	Added = 1,
	Removed,
	Modified,
	RenamedOldName,
	RenamedNewName
}
