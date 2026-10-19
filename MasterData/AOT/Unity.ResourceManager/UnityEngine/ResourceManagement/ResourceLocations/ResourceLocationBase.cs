using System;
using System.Collections.Generic;

namespace UnityEngine.ResourceManagement.ResourceLocations;

public class ResourceLocationBase : IResourceLocation
{
	private string m_Name;

	private string m_Id;

	private string m_ProviderId;

	private object m_Data;

	private int m_DependencyHashCode;

	private int m_HashCode;

	private Type m_Type;

	private List<IResourceLocation> m_Dependencies;

	private string m_PrimaryKey;

	public string InternalId => m_Id;

	public string ProviderId => m_ProviderId;

	public IList<IResourceLocation> Dependencies => m_Dependencies;

	public bool HasDependencies
	{
		get
		{
			if (m_Dependencies != null)
			{
				return m_Dependencies.Count > 0;
			}
			return false;
		}
	}

	public object Data
	{
		get
		{
			return m_Data;
		}
		set
		{
			m_Data = value;
		}
	}

	public string PrimaryKey
	{
		get
		{
			return m_PrimaryKey;
		}
		set
		{
			m_PrimaryKey = value;
		}
	}

	public int DependencyHashCode => m_DependencyHashCode;

	public Type ResourceType => m_Type;

	public int Hash(Type t)
	{
		return (m_HashCode * 31 + t.GetHashCode()) * 31 + DependencyHashCode;
	}

	public override string ToString()
	{
		return m_Id;
	}

	public ResourceLocationBase(string name, string id, string providerId, Type t, params IResourceLocation[] dependencies)
	{
		if (string.IsNullOrEmpty(id))
		{
			throw new ArgumentNullException("id");
		}
		if (string.IsNullOrEmpty(providerId))
		{
			throw new ArgumentNullException("providerId");
		}
		m_PrimaryKey = name;
		m_HashCode = (name.GetHashCode() * 31 + id.GetHashCode()) * 31 + providerId.GetHashCode();
		m_Name = name;
		m_Id = id;
		m_ProviderId = providerId;
		m_Dependencies = new List<IResourceLocation>(dependencies);
		m_Type = ((t == null) ? typeof(object) : t);
		ComputeDependencyHash();
	}

	public void ComputeDependencyHash()
	{
		m_DependencyHashCode = ((m_Dependencies.Count > 0) ? 17 : 0);
		foreach (IResourceLocation dependency in m_Dependencies)
		{
			m_DependencyHashCode = m_DependencyHashCode * 31 + dependency.Hash(typeof(object));
		}
	}
}
