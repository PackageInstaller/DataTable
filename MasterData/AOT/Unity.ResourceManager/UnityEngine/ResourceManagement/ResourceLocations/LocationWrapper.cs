using System;
using System.Collections.Generic;

namespace UnityEngine.ResourceManagement.ResourceLocations;

internal class LocationWrapper : IResourceLocation
{
	private IResourceLocation m_InternalLocation;

	public string InternalId => m_InternalLocation.InternalId;

	public string ProviderId => m_InternalLocation.ProviderId;

	public IList<IResourceLocation> Dependencies => m_InternalLocation.Dependencies;

	public int DependencyHashCode => m_InternalLocation.DependencyHashCode;

	public bool HasDependencies => m_InternalLocation.HasDependencies;

	public object Data => m_InternalLocation.Data;

	public string PrimaryKey => m_InternalLocation.PrimaryKey;

	public Type ResourceType => m_InternalLocation.ResourceType;

	public LocationWrapper(IResourceLocation location)
	{
		m_InternalLocation = location;
	}

	public int Hash(Type resultType)
	{
		return m_InternalLocation.Hash(resultType);
	}
}
