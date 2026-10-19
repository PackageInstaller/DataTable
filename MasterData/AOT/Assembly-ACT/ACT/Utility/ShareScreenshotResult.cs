using System;
using UnityEngine;

namespace ACT.Utility;

public sealed class ShareScreenshotResult : IDisposable
{
	public string FilePath { get; }

	public RenderTexture Texture { get; private set; }

	public Vector2Int Size { get; }

	public bool IsDisposed { get; private set; }

	public bool IsOwnedByView { get; private set; }

	internal ShareScreenshotResult(string filePath, RenderTexture texture)
	{
		FilePath = filePath;
		Texture = texture;
		Size = new Vector2Int(texture.width, texture.height);
	}

	public void TakeOwnership()
	{
		if (IsDisposed)
		{
			throw new ObjectDisposedException("ShareScreenshotResult");
		}
		if (IsOwnedByView)
		{
			throw new InvalidOperationException("The screenshot is already owned by a share view.");
		}
		IsOwnedByView = true;
	}

	public void Dispose()
	{
		if (!IsDisposed)
		{
			IsDisposed = true;
			ShareScreenshotUtilities.Release(this);
			Texture = null;
		}
	}
}
