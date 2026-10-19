using System;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine.Animations;

[Serializable]
[UsedByNativeCode]
[NativeHeader("Modules/Animation/Constraints/Constraint.bindings.h")]
[NativeType(CodegenOptions = CodegenOptions.Custom, Header = "Modules/Animation/Constraints/ConstraintSource.h", IntermediateScriptingStructName = "MonoConstraintSource")]
public struct ConstraintSource
{
	[NativeName("sourceTransform")]
	private Transform m_SourceTransform;

	[NativeName("weight")]
	private float m_Weight;

	public Transform sourceTransform
	{
		get
		{
			return m_SourceTransform;
		}
		set
		{
			m_SourceTransform = value;
		}
	}

	public float weight
	{
		get
		{
			return m_Weight;
		}
		set
		{
			m_Weight = value;
		}
	}
}
