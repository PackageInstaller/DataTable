using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine.Rendering;

[NativeHeader("Runtime/Shaders/Keywords/KeywordSpaceScriptBindings.h")]
public readonly struct LocalKeywordSpace : IEquatable<LocalKeywordSpace>
{
	private readonly IntPtr m_KeywordSpace;

	[FreeFunction("keywords::GetKeyword", HasExplicitThis = true)]
	private LocalKeyword GetKeyword(string name)
	{
		GetKeyword_Injected(ref this, name, out var ret);
		return ret;
	}

	public LocalKeyword FindKeyword(string name)
	{
		return GetKeyword(name);
	}

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
		return m_KeywordSpace.GetHashCode();
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetKeyword_Injected(ref LocalKeywordSpace _unity_self, string name, out LocalKeyword ret);
}
