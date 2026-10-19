using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine;

[NativeHeader("Modules/Animation/HumanTrait.h")]
public class HumanTrait
{
	public static extern int MuscleCount
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public static extern string[] MuscleName
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("GetMuscleNames")]
		get;
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern int GetBoneIndexFromMono(int humanId);
}
