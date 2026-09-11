using System.Runtime.InteropServices;
using UnityEngine.Scripting;
using UnityEngine.Scripting.APIUpdating;

namespace UnityEngine.PlayerLoop;

[StructLayout(LayoutKind.Sequential, Size = 1)]
[RequiredByNativeCode]
[MovedFrom("UnityEngine.Experimental.PlayerLoop")]
public struct FixedUpdate
{
	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct ClearLines
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct DirectorFixedSampleTime
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct AudioFixedUpdate
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct ScriptRunBehaviourFixedUpdate
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct DirectorFixedUpdate
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct LegacyFixedAnimationUpdate
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct XRFixedUpdate
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct PhysicsFixedUpdate
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct Physics2DFixedUpdate
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	private struct PhysicsClothFixedUpdate
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct DirectorFixedUpdatePostPhysics
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct ScriptRunDelayedFixedFrameRate
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct NewInputFixedUpdate
	{
	}
}
