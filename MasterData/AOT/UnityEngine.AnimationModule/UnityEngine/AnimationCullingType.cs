using System;

namespace UnityEngine;

public enum AnimationCullingType
{
	AlwaysAnimate,
	BasedOnRenderers,
	[Obsolete("Enum member AnimatorCullingMode.BasedOnClipBounds has been deprecated. Use AnimationCullingType.AlwaysAnimate or AnimationCullingType.BasedOnRenderers instead")]
	BasedOnClipBounds,
	[Obsolete("Enum member AnimatorCullingMode.BasedOnUserBounds has been deprecated. Use AnimationCullingType.AlwaysAnimate or AnimationCullingType.BasedOnRenderers instead")]
	BasedOnUserBounds
}
