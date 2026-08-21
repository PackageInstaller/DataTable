using System;

namespace UnityEngine;

[Serializable]
public struct BlendShapeBufferRange
{
	[SerializeField]
	private uint m_StartIndex;

	[SerializeField]
	private uint m_EndIndex;

	internal uint startIndex
	{
		set
		{
			m_StartIndex = value;
		}
	}

	internal uint endIndex
	{
		set
		{
			m_EndIndex = value;
		}
	}
}
