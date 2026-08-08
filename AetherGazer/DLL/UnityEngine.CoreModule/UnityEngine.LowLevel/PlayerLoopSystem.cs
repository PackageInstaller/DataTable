using System;
using UnityEngine.Scripting.APIUpdating;

namespace UnityEngine.LowLevel;

[MovedFrom("UnityEngine.Experimental.LowLevel")]
public struct PlayerLoopSystem
{
	public delegate void UpdateFunction();

	public Type type;

	public PlayerLoopSystem[] subSystemList;

	public UpdateFunction updateDelegate;

	public IntPtr updateFunction;

	public IntPtr loopConditionFunction;

	public override string ToString()
	{
		return type.Name;
	}
}
