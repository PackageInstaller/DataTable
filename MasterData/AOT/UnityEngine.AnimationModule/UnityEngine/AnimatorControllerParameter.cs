using System.Runtime.InteropServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[StructLayout(LayoutKind.Sequential)]
[NativeAsStruct]
[NativeHeader("Modules/Animation/ScriptBindings/AnimatorControllerParameter.bindings.h")]
[NativeHeader("Modules/Animation/AnimatorControllerParameter.h")]
[NativeType(CodegenOptions.Custom, "MonoAnimatorControllerParameter")]
[UsedByNativeCode]
public class AnimatorControllerParameter
{
	internal string m_Name = "";

	internal AnimatorControllerParameterType m_Type;

	internal float m_DefaultFloat;

	internal int m_DefaultInt;

	internal bool m_DefaultBool;

	public string name => m_Name;

	public int nameHash => Animator.StringToHash(m_Name);

	public AnimatorControllerParameterType type
	{
		get
		{
			return m_Type;
		}
		set
		{
			m_Type = value;
		}
	}

	public float defaultFloat
	{
		get
		{
			return m_DefaultFloat;
		}
		set
		{
			m_DefaultFloat = value;
		}
	}

	public int defaultInt
	{
		get
		{
			return m_DefaultInt;
		}
		set
		{
			m_DefaultInt = value;
		}
	}

	public bool defaultBool
	{
		get
		{
			return m_DefaultBool;
		}
		set
		{
			m_DefaultBool = value;
		}
	}

	public override bool Equals(object o)
	{
		return o is AnimatorControllerParameter animatorControllerParameter && m_Name == animatorControllerParameter.m_Name && m_Type == animatorControllerParameter.m_Type && m_DefaultFloat == animatorControllerParameter.m_DefaultFloat && m_DefaultInt == animatorControllerParameter.m_DefaultInt && m_DefaultBool == animatorControllerParameter.m_DefaultBool;
	}

	public override int GetHashCode()
	{
		return name.GetHashCode();
	}
}
