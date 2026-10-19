using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Playables;

namespace UnityEngine.Animations;

[NativeHeader("Modules/Animation/Animator.h")]
[NativeHeader("Runtime/Director/Core/HPlayable.h")]
[NativeHeader("Modules/Animation/ScriptBindings/AnimationPlayableGraphExtensions.bindings.h")]
[NativeHeader("Runtime/Director/Core/HPlayableOutput.h")]
[StaticAccessor("AnimationPlayableGraphExtensionsBindings", StaticAccessorType.DoubleColon)]
internal static class AnimationPlayableGraphExtensions
{
	[MethodImpl((MethodImplOptions)4096)]
	[NativeThrows]
	internal static extern bool InternalCreateAnimationOutput(ref PlayableGraph graph, string name, out PlayableOutputHandle handle);
}
