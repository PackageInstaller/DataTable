using System;
using System.Collections.Generic;
using UnityEngine;

namespace CriMana.Detail;

public abstract class RendererResourceFactory : IDisposable
{
	private static SortedList<int, RendererResourceFactory> factoryList = new SortedList<int, RendererResourceFactory>();

	private bool disposed;

	public static void RegisterFactory(RendererResourceFactory factory, int priority)
	{
		factoryList.Add(priority, factory);
	}

	public static void DisposeAllFactories()
	{
		foreach (KeyValuePair<int, RendererResourceFactory> factory in factoryList)
		{
			factory.Value.Dispose();
		}
		factoryList.Clear();
	}

	public static RendererResource DispatchAndCreate(int playerId, MovieInfo movieInfo, bool additive, Shader userShader)
	{
		RendererResource rendererResource = null;
		foreach (KeyValuePair<int, RendererResourceFactory> factory in factoryList)
		{
			rendererResource = factory.Value.CreateRendererResource(playerId, movieInfo, additive, userShader);
			if (rendererResource != null)
			{
				return rendererResource;
			}
		}
		Debug.LogError("[CRIWARE] unsupported movie.");
		return null;
	}

	~RendererResourceFactory()
	{
		Dispose(disposing: false);
	}

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	private void Dispose(bool disposing)
	{
		if (!disposed)
		{
			if (disposing)
			{
				OnDisposeManaged();
			}
			OnDisposeUnmanaged();
			disposed = true;
		}
	}

	protected abstract void OnDisposeManaged();

	protected abstract void OnDisposeUnmanaged();

	public abstract RendererResource CreateRendererResource(int playerId, MovieInfo movieInfo, bool additive, Shader userShader);
}
