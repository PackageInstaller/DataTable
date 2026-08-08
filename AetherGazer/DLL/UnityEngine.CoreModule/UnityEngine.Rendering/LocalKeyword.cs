using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine.Rendering;

[UsedByNativeCode]
[NativeHeader("Runtime/Graphics/ShaderScriptBindings.h")]
[NativeHeader("Runtime/Shaders/Keywords/KeywordSpaceScriptBindings.h")]
public readonly struct LocalKeyword : IEquatable<LocalKeyword>
{
	internal readonly LocalKeywordSpace m_SpaceInfo;

	internal readonly string m_Name;

	internal readonly uint m_Index;

	public string name => m_Name;

	public bool isDynamic => IsDynamic(this);

	public bool isOverridable => IsOverridable(this);

	public bool isValid => IsValid(m_SpaceInfo, m_Index);

	public ShaderKeywordType type => GetKeywordType(m_SpaceInfo, m_Index);

	[FreeFunction("keywords::IsKeywordDynamic")]
	private static bool IsDynamic(LocalKeyword kw)
	{
		return IsDynamic_Injected(ref kw);
	}

	[FreeFunction("keywords::IsKeywordOverridable")]
	private static bool IsOverridable(LocalKeyword kw)
	{
		return IsOverridable_Injected(ref kw);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("ShaderScripting::GetKeywordCount")]
	private static extern uint GetShaderKeywordCount(Shader shader);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("ShaderScripting::GetKeywordIndex")]
	private static extern uint GetShaderKeywordIndex(Shader shader, string keyword);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("ShaderScripting::GetKeywordCount")]
	private static extern uint GetComputeShaderKeywordCount(ComputeShader shader);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("ShaderScripting::GetKeywordIndex")]
	private static extern uint GetComputeShaderKeywordIndex(ComputeShader shader, string keyword);

	[FreeFunction("keywords::GetKeywordType")]
	private static ShaderKeywordType GetKeywordType(LocalKeywordSpace spaceInfo, uint keyword)
	{
		return GetKeywordType_Injected(ref spaceInfo, keyword);
	}

	[FreeFunction("keywords::IsKeywordValid")]
	private static bool IsValid(LocalKeywordSpace spaceInfo, uint keyword)
	{
		return IsValid_Injected(ref spaceInfo, keyword);
	}

	public LocalKeyword(Shader shader, string name)
	{
		if (shader == null)
		{
			Debug.LogError("Cannot initialize a LocalKeyword with a null Shader.");
		}
		m_SpaceInfo = shader.keywordSpace;
		m_Name = name;
		m_Index = GetShaderKeywordIndex(shader, name);
		if (m_Index >= GetShaderKeywordCount(shader))
		{
			Debug.LogErrorFormat("Local keyword {0} doesn't exist in the shader.", name);
		}
	}

	public LocalKeyword(ComputeShader shader, string name)
	{
		if (shader == null)
		{
			Debug.LogError("Cannot initialize a LocalKeyword with a null ComputeShader.");
		}
		m_SpaceInfo = shader.keywordSpace;
		m_Name = name;
		m_Index = GetComputeShaderKeywordIndex(shader, name);
		if (m_Index >= GetComputeShaderKeywordCount(shader))
		{
			Debug.LogErrorFormat("Local keyword {0} doesn't exist in the compute shader.", name);
		}
	}

	public override string ToString()
	{
		return m_Name;
	}

	public override bool Equals(object o)
	{
		return o is LocalKeyword rhs && Equals(rhs);
	}

	public bool Equals(LocalKeyword rhs)
	{
		return m_SpaceInfo == rhs.m_SpaceInfo && m_Index == rhs.m_Index;
	}

	public static bool operator ==(LocalKeyword lhs, LocalKeyword rhs)
	{
		return lhs.Equals(rhs);
	}

	public static bool operator !=(LocalKeyword lhs, LocalKeyword rhs)
	{
		return !(lhs == rhs);
	}

	public override int GetHashCode()
	{
		return m_Index.GetHashCode() ^ m_SpaceInfo.GetHashCode();
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool IsDynamic_Injected(ref LocalKeyword kw);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool IsOverridable_Injected(ref LocalKeyword kw);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern ShaderKeywordType GetKeywordType_Injected(ref LocalKeywordSpace spaceInfo, uint keyword);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool IsValid_Injected(ref LocalKeywordSpace spaceInfo, uint keyword);
}
