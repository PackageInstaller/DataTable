using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine.Rendering;

[UsedByNativeCode]
[NativeHeader("Runtime/Shaders/Keywords/KeywordSpaceScriptBindings.h")]
[NativeHeader("Runtime/Graphics/ShaderScriptBindings.h")]
public readonly struct GlobalKeyword
{
	internal readonly string m_Name;

	internal readonly uint m_Index;

	public override string ToString()
	{
		return m_Name;
	}
}
