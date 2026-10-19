using UnityEngine.Bindings;

namespace UnityEngine;

[NativeType(CodegenOptions.Custom, "MonoHumanLimit")]
[NativeHeader("Modules/Animation/HumanDescription.h")]
[NativeHeader("Modules/Animation/ScriptBindings/AvatarBuilder.bindings.h")]
public struct HumanLimit
{
	private Vector3 m_Min;

	private Vector3 m_Max;

	private Vector3 m_Center;

	private float m_AxisLength;

	private int m_UseDefaultValues;
}
