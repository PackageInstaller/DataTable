using System;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[StructLayout(LayoutKind.Sequential)]
[NativeHeader("Runtime/Export/Graphics/Graphics.bindings.h")]
public sealed class LightProbes : Object
{
	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private static Action lightProbesUpdated;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private static Action tetrahedralizationCompleted;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private static Action needsRetetrahedralization;

	[RequiredByNativeCode]
	private static void Internal_CallLightProbesUpdatedFunction()
	{
		if (lightProbesUpdated != null)
		{
			lightProbesUpdated();
		}
	}

	[RequiredByNativeCode]
	private static void Internal_CallTetrahedralizationCompletedFunction()
	{
		if (tetrahedralizationCompleted != null)
		{
			tetrahedralizationCompleted();
		}
	}

	[RequiredByNativeCode]
	private static void Internal_CallNeedsRetetrahedralizationFunction()
	{
		if (needsRetetrahedralization != null)
		{
			needsRetetrahedralization();
		}
	}
}
