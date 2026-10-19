using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[RequiredByNativeCode]
[NativeHeader("Modules/Animation/AnimatorInfo.h")]
public struct AnimatorTransitionInfo
{
	[NativeName("fullPathHash")]
	private int m_FullPath;

	[NativeName("userNameHash")]
	private int m_UserName;

	[NativeName("nameHash")]
	private int m_Name;

	[NativeName("hasFixedDuration")]
	private bool m_HasFixedDuration;

	[NativeName("duration")]
	private float m_Duration;

	[NativeName("normalizedTime")]
	private float m_NormalizedTime;

	[NativeName("anyState")]
	private bool m_AnyState;

	[NativeName("transitionType")]
	private int m_TransitionType;
}
