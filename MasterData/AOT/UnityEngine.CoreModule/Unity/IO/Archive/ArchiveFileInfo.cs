using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace Unity.IO.Archive;

[RequiredByNativeCode]
[NativeHeader("Runtime/VirtualFileSystem/ArchiveFileSystem/ArchiveFileHandle.h")]
public struct ArchiveFileInfo
{
	public string Filename;

	public ulong FileSize;
}
