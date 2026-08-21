using System;
using UnityEngine.Scripting;

namespace UnityEngine;

[Serializable]
[UsedByNativeCode]
internal struct BlendShape
{
	[SerializeField]
	private uint m_FirstVertex;

	[SerializeField]
	private uint m_VertexCount;

	[SerializeField]
	private bool m_HasNormals;

	[SerializeField]
	private bool m_HasTangents;

	public uint firstVertex => m_FirstVertex;

	public uint vertexCount => m_VertexCount;
}
