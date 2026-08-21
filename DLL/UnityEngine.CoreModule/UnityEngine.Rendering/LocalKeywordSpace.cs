using System;
using UnityEngine.Bindings;

namespace UnityEngine.Rendering;

[NativeHeader("Runtime/Shaders/Keywords/KeywordSpaceScriptBindings.h")]
public readonly struct LocalKeywordSpace : IEquatable<LocalKeywordSpace>
{
	private readonly IntPtr m_KeywordSpace;

	public override bool Equals(object o)
	{
		return o is LocalKeywordSpace rhs && Equals(rhs);
	}

	public bool Equals(LocalKeywordSpace rhs)
	{
		return m_KeywordSpace == rhs.m_KeywordSpace;
	}

	public static bool operator ==(LocalKeywordSpace lhs, LocalKeywordSpace rhs)
	{
		return lhs.Equals(rhs);
	}

	public override int GetHashCode()
	{
		IntPtr keywordSpace = m_KeywordSpace;
		return keywordSpace.GetHashCode();
	}
}
