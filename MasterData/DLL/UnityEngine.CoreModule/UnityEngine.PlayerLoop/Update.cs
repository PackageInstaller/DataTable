using System.Runtime.InteropServices;
using UnityEngine.Scripting;
using UnityEngine.Scripting.APIUpdating;

namespace UnityEngine.PlayerLoop;

[StructLayout(LayoutKind.Sequential, Size = 1)]
[MovedFrom("UnityEngine.Experimental.PlayerLoop")]
[RequiredByNativeCode]
public struct Update
{
	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct ScriptRunBehaviourUpdate
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct DirectorUpdate
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct ScriptRunDelayedDynamicFrameRate
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct ScriptRunDelayedTasks
	{
	}
}
