using UnityEngine.Bindings;
using UnityEngine.Scripting.APIUpdating;

namespace UnityEngine.Animations;

[MovedFrom("UnityEngine.Experimental.Animations")]
[NativeHeader("Modules/Animation/Director/AnimationSceneHandles.h")]
public struct PropertySceneHandle
{
	private uint valid;

	private int handleIndex;
}
