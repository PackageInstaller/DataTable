using System;
using UnityEngine.Bindings;
using UnityEngine.Scripting;
using UnityEngine.Scripting.APIUpdating;

namespace UnityEngine.Animations;

[NativeHeader("Modules/Animation/ScriptBindings/AnimationStream.bindings.h")]
[RequiredByNativeCode]
[MovedFrom("UnityEngine.Experimental.Animations")]
[NativeHeader("Modules/Animation/Director/AnimationStream.h")]
public struct AnimationStream
{
	private uint m_AnimatorBindingsVersion;

	private IntPtr constant;

	private IntPtr input;

	private IntPtr output;

	private IntPtr workspace;

	private IntPtr inputStreamAccessor;

	private IntPtr animationHandleBinder;

	internal uint animatorBindingsVersion => m_AnimatorBindingsVersion;

	public bool isValid => m_AnimatorBindingsVersion >= 2 && constant != IntPtr.Zero && input != IntPtr.Zero && output != IntPtr.Zero && workspace != IntPtr.Zero && animationHandleBinder != IntPtr.Zero;

	internal void CheckIsValid()
	{
		if (!isValid)
		{
			throw new InvalidOperationException("The AnimationStream is invalid.");
		}
	}
}
