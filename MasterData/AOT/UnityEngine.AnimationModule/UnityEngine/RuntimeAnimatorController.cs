using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[UsedByNativeCode]
[ExcludeFromObjectFactory]
[NativeHeader("Modules/Animation/RuntimeAnimatorController.h")]
public class RuntimeAnimatorController : Object
{
	public extern AnimationClip[] animationClips
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	protected RuntimeAnimatorController()
	{
	}
}
