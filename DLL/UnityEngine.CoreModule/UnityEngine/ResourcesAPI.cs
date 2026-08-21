using System;

namespace UnityEngine;

public class ResourcesAPI
{
	private static ResourcesAPI s_DefaultAPI = new ResourcesAPI();

	internal static ResourcesAPI ActiveAPI => overrideAPI ?? s_DefaultAPI;

	public static ResourcesAPI overrideAPI { get; }

	protected internal ResourcesAPI()
	{
	}

	protected internal virtual Object[] FindObjectsOfTypeAll(Type systemTypeInstance)
	{
		return ResourcesAPIInternal.FindObjectsOfTypeAll(systemTypeInstance);
	}

	protected internal virtual Shader FindShaderByName(string name)
	{
		return ResourcesAPIInternal.FindShaderByName(name);
	}

	protected internal virtual Object Load(string path, Type systemTypeInstance)
	{
		return ResourcesAPIInternal.Load(path, systemTypeInstance);
	}

	protected internal virtual Object[] LoadAll(string path, Type systemTypeInstance)
	{
		return ResourcesAPIInternal.LoadAll(path, systemTypeInstance);
	}

	protected internal virtual ResourceRequest LoadAsync(string path, Type systemTypeInstance)
	{
		ResourceRequest resourceRequest = ResourcesAPIInternal.LoadAsyncInternal(path, systemTypeInstance);
		resourceRequest.m_Path = path;
		resourceRequest.m_Type = systemTypeInstance;
		return resourceRequest;
	}

	protected internal virtual void UnloadAsset(Object assetToUnload)
	{
		ResourcesAPIInternal.UnloadAsset(assetToUnload);
	}
}
