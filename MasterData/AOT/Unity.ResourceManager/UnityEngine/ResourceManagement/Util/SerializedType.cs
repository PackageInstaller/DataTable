using System;
using System.IO;
using System.Reflection;
using UnityEngine.Serialization;

namespace UnityEngine.ResourceManagement.Util;

[Serializable]
public struct SerializedType
{
	[FormerlySerializedAs("m_assemblyName")]
	[SerializeField]
	private string m_AssemblyName;

	[FormerlySerializedAs("m_className")]
	[SerializeField]
	private string m_ClassName;

	private Type m_CachedType;

	public string AssemblyName => m_AssemblyName;

	public string ClassName => m_ClassName;

	public Type Value
	{
		get
		{
			try
			{
				if (string.IsNullOrEmpty(m_AssemblyName) || string.IsNullOrEmpty(m_ClassName))
				{
					return null;
				}
				if (m_CachedType == null)
				{
					Assembly assembly = Assembly.Load(m_AssemblyName);
					if (assembly != null)
					{
						m_CachedType = assembly.GetType(m_ClassName);
					}
				}
				return m_CachedType;
			}
			catch (Exception ex)
			{
				if (ex.GetType() != typeof(FileNotFoundException))
				{
					Debug.LogException(ex);
				}
				return null;
			}
		}
		set
		{
			if (value != null)
			{
				m_AssemblyName = value.Assembly.FullName;
				m_ClassName = value.FullName;
			}
			else
			{
				m_AssemblyName = (m_ClassName = null);
			}
		}
	}

	public bool ValueChanged { get; set; }

	public override string ToString()
	{
		if (!(Value == null))
		{
			return Value.Name;
		}
		return "<none>";
	}
}
