using System;
using UnityEngine.Scripting;

namespace UnityEngine;

[UsedByNativeCode]
[AttributeUsage(AttributeTargets.Class, AllowMultiple = false)]
public class HelpURLAttribute : Attribute
{
	internal readonly string m_Url;

	internal readonly bool m_Dispatcher;

	internal readonly string m_DispatchingFieldName;

	public string URL => m_Url;

	public HelpURLAttribute(string url)
	{
		m_Url = url;
		m_DispatchingFieldName = "";
		m_Dispatcher = false;
	}
}
