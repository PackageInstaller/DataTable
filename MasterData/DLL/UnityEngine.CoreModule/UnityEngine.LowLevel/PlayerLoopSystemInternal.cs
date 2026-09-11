using System;
using UnityEngine.Bindings;
using UnityEngine.Scripting;
using UnityEngine.Scripting.APIUpdating;

namespace UnityEngine.LowLevel;

[NativeType(Header = "Runtime/Misc/PlayerLoop.h")]
[RequiredByNativeCode]
[MovedFrom("UnityEngine.Experimental.LowLevel")]
internal struct PlayerLoopSystemInternal
{
	public Type type;

	public PlayerLoopSystem.UpdateFunction updateDelegate;

	public IntPtr updateFunction;

	public IntPtr loopConditionFunction;

	public int numSubSystems;
}
