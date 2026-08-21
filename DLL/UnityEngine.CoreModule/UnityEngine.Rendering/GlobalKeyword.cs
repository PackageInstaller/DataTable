using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine.Rendering;

[UsedByNativeCode]
[NativeHeader("Runtime/Graphics/ShaderScriptBindings.h")]
[NativeHeader("Runtime/Shaders/Keywords/KeywordSpaceScriptBindings.h")]
public readonly struct GlobalKeyword
{
	internal readonly string m_Name;

	internal readonly uint m_Index;

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("ShaderScripting::GetGlobalKeywordCount")]
	private static extern uint GetGlobalKeywordCount();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("ShaderScripting::GetGlobalKeywordIndex")]
	private static extern uint GetGlobalKeywordIndex(string keyword);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("ShaderScripting::CreateGlobalKeyword")]
	private static extern void CreateGlobalKeyword(string keyword);

	public static GlobalKeyword Create(string name)
	{
		CreateGlobalKeyword(name);
		return new GlobalKeyword(name);
	}

	public GlobalKeyword(string name)
	{
		m_Name = name;
		m_Index = GetGlobalKeywordIndex(name);
		if (m_Index >= GetGlobalKeywordCount())
		{
			Debug.LogErrorFormat("Global keyword {0} doesn't exist.", name);
		}
	}

	public override string ToString()
	{
		return m_Name;
	}
}
