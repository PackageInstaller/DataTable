using System;

namespace UnityEngine;

[Serializable]
public struct LazyLoadReference<T> where T : Object
{
	[SerializeField]
	private int m_InstanceID;
}
