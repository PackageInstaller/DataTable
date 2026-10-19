using System;
using System.Runtime.InteropServices;

namespace UnityEngine;

[Serializable]
[StructLayout(LayoutKind.Sequential)]
[Obsolete("This class is not used anymore. See AnimatorOverrideController.GetOverrides() and AnimatorOverrideController.ApplyOverrides()")]
public class AnimationClipPair
{
	public AnimationClip originalClip;

	public AnimationClip overrideClip;
}
