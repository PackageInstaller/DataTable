#define UNITY_ASSERTIONS
using System;
using System.Runtime.CompilerServices;
using UnityEngine.Assertions;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine.Rendering;

[NativeHeader("Editor/Src/Graphics/ShaderCompilerData.h")]
[UsedByNativeCode]
public struct ShaderKeywordSet
{
	private IntPtr m_KeywordState;

	private IntPtr m_Shader;

	private IntPtr m_ComputeShader;

	private ulong m_StateIndex;

	[FreeFunction("keywords::IsKeywordEnabled")]
	private static bool IsKeywordNameEnabled(ShaderKeywordSet state, string name)
	{
		return IsKeywordNameEnabled_Injected(ref state, name);
	}

	private void CheckKeywordCompatible(ShaderKeyword keyword)
	{
		if (keyword.m_IsLocal)
		{
			if (m_Shader != IntPtr.Zero)
			{
				Assert.IsTrue(!keyword.m_IsCompute, "Trying to use a keyword that comes from a different shader.");
			}
			else
			{
				Assert.IsTrue(keyword.m_IsCompute, "Trying to use a keyword that comes from a different shader.");
			}
		}
	}

	public bool IsEnabled(ShaderKeyword keyword)
	{
		CheckKeywordCompatible(keyword);
		return IsKeywordNameEnabled(this, keyword.m_Name);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool IsKeywordNameEnabled_Injected(ref ShaderKeywordSet state, string name);
}
