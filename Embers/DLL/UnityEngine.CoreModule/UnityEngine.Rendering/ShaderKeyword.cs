using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine.Rendering;

[NativeHeader("Runtime/Graphics/ShaderScriptBindings.h")]
[UsedByNativeCode]
[NativeHeader("Runtime/Shaders/Keywords/KeywordSpaceScriptBindings.h")]
public struct ShaderKeyword
{
	internal string m_Name;

	internal uint m_Index;

	internal bool m_IsLocal;

	internal bool m_IsCompute;

	internal bool m_IsValid;

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("ShaderScripting::GetGlobalKeywordCount")]
	internal static extern uint GetGlobalKeywordCount();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("ShaderScripting::GetGlobalKeywordIndex")]
	internal static extern uint GetGlobalKeywordIndex(string keyword);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("ShaderScripting::CreateGlobalKeyword")]
	internal static extern void CreateGlobalKeyword(string keyword);

	public ShaderKeyword(string keywordName)
	{
		m_Name = keywordName;
		m_Index = GetGlobalKeywordIndex(keywordName);
		if (m_Index >= GetGlobalKeywordCount())
		{
			CreateGlobalKeyword(keywordName);
			m_Index = GetGlobalKeywordIndex(keywordName);
		}
		m_IsValid = true;
		m_IsLocal = false;
		m_IsCompute = false;
	}

	public override string ToString()
	{
		return m_Name;
	}
}
