using UnityEngine.Bindings;
using UnityEngine.Scripting.APIUpdating;

namespace UnityEngine.Animations;

[NativeHeader("Modules/Animation/ScriptBindings/AnimationStreamHandles.bindings.h")]
[NativeHeader("Modules/Animation/Director/AnimationSceneHandles.h")]
[MovedFrom("UnityEngine.Experimental.Animations")]
public struct TransformSceneHandle
{
	private uint valid;

	private int transformSceneHandleDefinitionIndex;
}
