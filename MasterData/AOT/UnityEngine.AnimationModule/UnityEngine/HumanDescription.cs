using UnityEngine.Bindings;

namespace UnityEngine;

[NativeHeader("Modules/Animation/HumanDescription.h")]
[NativeHeader("Modules/Animation/ScriptBindings/AvatarBuilder.bindings.h")]
public struct HumanDescription
{
	[NativeName("m_Human")]
	public HumanBone[] human;

	[NativeName("m_Skeleton")]
	public SkeletonBone[] skeleton;

	internal float m_ArmTwist;

	internal float m_ForeArmTwist;

	internal float m_UpperLegTwist;

	internal float m_LegTwist;

	internal float m_ArmStretch;

	internal float m_LegStretch;

	internal float m_FeetSpacing;

	internal float m_GlobalScale;

	internal string m_RootMotionBoneName;

	internal bool m_HasTranslationDoF;

	internal bool m_HasExtraRoot;

	internal bool m_SkeletonHasParents;
}
