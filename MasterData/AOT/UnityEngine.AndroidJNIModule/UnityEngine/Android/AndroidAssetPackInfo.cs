using System.Diagnostics;
using System.Runtime.CompilerServices;

namespace UnityEngine.Android;

public class AndroidAssetPackInfo
{
	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private readonly string name__BackingField;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private readonly AndroidAssetPackStatus status__BackingField;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private readonly ulong size__BackingField;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private readonly ulong bytesDownloaded__BackingField;

	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private readonly float transferProgress__BackingField;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private readonly AndroidAssetPackError error__BackingField;

	internal AndroidAssetPackInfo(string name, AndroidAssetPackStatus status, ulong size, ulong bytesDownloaded, float transferProgress, AndroidAssetPackError error)
	{
		name__BackingField = name;
		status__BackingField = status;
		size__BackingField = size;
		bytesDownloaded__BackingField = bytesDownloaded;
		transferProgress__BackingField = transferProgress;
		error__BackingField = error;
	}
}
