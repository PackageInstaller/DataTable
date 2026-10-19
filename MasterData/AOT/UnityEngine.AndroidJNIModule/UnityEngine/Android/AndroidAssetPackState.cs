using System.Diagnostics;
using System.Runtime.CompilerServices;

namespace UnityEngine.Android;

public class AndroidAssetPackState
{
	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private readonly string name__BackingField;

	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private readonly AndroidAssetPackStatus status__BackingField;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private readonly AndroidAssetPackError error__BackingField;

	internal AndroidAssetPackState(string name, AndroidAssetPackStatus status, AndroidAssetPackError error)
	{
		name__BackingField = name;
		status__BackingField = status;
		error__BackingField = error;
	}
}
