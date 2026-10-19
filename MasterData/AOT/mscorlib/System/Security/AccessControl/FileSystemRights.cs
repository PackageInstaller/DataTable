namespace System.Security.AccessControl;

[Flags]
public enum FileSystemRights
{
	ListDirectory = 1,
	ReadData = ListDirectory,
	CreateFiles = 2,
	WriteData = CreateFiles,
	AppendData = 4,
	CreateDirectories = AppendData,
	ReadExtendedAttributes = 8,
	WriteExtendedAttributes = 0x10,
	ExecuteFile = 0x20,
	Traverse = ExecuteFile,
	DeleteSubdirectoriesAndFiles = 0x40,
	ReadAttributes = 0x80,
	WriteAttributes = 0x100,
	Write = CreateFiles | AppendData | WriteExtendedAttributes | WriteAttributes,
	Delete = 0x10000,
	ReadPermissions = 0x20000,
	Read = ListDirectory | ReadExtendedAttributes | ReadAttributes | ReadPermissions,
	ReadAndExecute = Read | ExecuteFile,
	Modify = ReadAndExecute | Write | Delete,
	ChangePermissions = 0x40000,
	TakeOwnership = 0x80000,
	Synchronize = 0x100000,
	FullControl = Modify | DeleteSubdirectoriesAndFiles | ChangePermissions | TakeOwnership | Synchronize
}
