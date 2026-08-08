using System;
using UnityEngine.Scripting;

namespace UnityEngine;

[AttributeUsage(AttributeTargets.Class)]
[UsedByNativeCode]
public class DefaultExecutionOrder : Attribute
{
	private int m_Order;

	public int order => m_Order;

	public DefaultExecutionOrder(int order)
	{
		m_Order = order;
	}
}
