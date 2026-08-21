using System.Runtime.InteropServices;
using UnityEngine.Scripting;

namespace UnityEngine.PlayerLoop;

[StructLayout(LayoutKind.Sequential, Size = 1)]
[RequiredByNativeCode]
public struct TimeUpdate
{
	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct WaitForLastPresentationAndUpdateTime
	{
	}
}
