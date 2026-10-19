using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Playables;

namespace UnityEngine.Animations;

[NativeHeader("Modules/Animation/AnimationClip.h")]
[NativeHeader("Runtime/Director/Core/HPlayable.h")]
[NativeHeader("Modules/Animation/Director/AnimationPlayableExtensions.h")]
public static class AnimationPlayableExtensions
{
	public static void SetAnimatedProperties<U>(this U playable, AnimationClip clip) where U : struct, IPlayable
	{
		PlayableHandle playable2 = playable.GetHandle();
		SetAnimatedPropertiesInternal(ref playable2, clip);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeThrows]
	internal static extern void SetAnimatedPropertiesInternal(ref PlayableHandle playable, AnimationClip animatedProperties);
}
