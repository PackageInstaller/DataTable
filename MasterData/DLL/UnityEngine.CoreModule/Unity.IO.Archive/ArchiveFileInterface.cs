using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace Unity.IO.Archive;

[RequiredByNativeCode]
[NativeHeader("Runtime/VirtualFileSystem/ArchiveFileSystem/ArchiveFileHandle.h")]
[StaticAccessor("GetManagedArchiveSystem()", StaticAccessorType.Dot)]
public static class ArchiveFileInterface
{
}
