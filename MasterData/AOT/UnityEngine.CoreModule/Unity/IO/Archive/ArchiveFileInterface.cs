using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace Unity.IO.Archive;

[StaticAccessor("GetManagedArchiveSystem()", StaticAccessorType.Dot)]
[RequiredByNativeCode]
[NativeHeader("Runtime/VirtualFileSystem/ArchiveFileSystem/ArchiveFileHandle.h")]
public static class ArchiveFileInterface
{
}
