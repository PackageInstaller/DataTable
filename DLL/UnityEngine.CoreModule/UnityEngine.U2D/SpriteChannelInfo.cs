using System;
using UnityEngine.Bindings;

namespace UnityEngine.U2D;

[VisibleToOtherModules]
internal struct SpriteChannelInfo
{
	[NativeName("buffer")]
	private IntPtr m_Buffer;

	[NativeName("count")]
	private int m_Count;

	[NativeName("offset")]
	private int m_Offset;

	[NativeName("stride")]
	private int m_Stride;

	public unsafe void* buffer => (void*)m_Buffer;

	public int count => m_Count;

	public int offset => m_Offset;

	public int stride => m_Stride;
}
