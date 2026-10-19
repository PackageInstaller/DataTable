using UnityEngine.Bindings;
using UnityEngine.Scripting.APIUpdating;

namespace UnityEngine.Animations;

[NativeHeader("Modules/Animation/Director/AnimationStreamHandles.h")]
[MovedFrom("UnityEngine.Experimental.Animations")]
public struct PropertyStreamHandle
{
	private uint m_AnimatorBindingsVersion;

	private int handleIndex;

	private int valueArrayIndex;

	private int bindType;
}
