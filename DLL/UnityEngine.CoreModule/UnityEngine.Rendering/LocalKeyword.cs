using System;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine.Rendering;

[NativeHeader("Runtime/Graphics/ShaderScriptBindings.h")]
[NativeHeader("Runtime/Shaders/Keywords/KeywordSpaceScriptBindings.h")]
[UsedByNativeCode]
public readonly struct LocalKeyword : IEquatable<LocalKeyword>
{
	internal readonly LocalKeywordSpace m_SpaceInfo;

	internal readonly string m_Name;

	internal readonly uint m_Index;

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

	public override int GetHashCode()
	{
		uint index = m_Index;
		return index.GetHashCode() ^ m_SpaceInfo.GetHashCode();
	}
}
