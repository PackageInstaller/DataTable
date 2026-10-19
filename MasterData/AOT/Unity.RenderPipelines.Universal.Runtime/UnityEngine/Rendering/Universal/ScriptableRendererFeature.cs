using System;

namespace UnityEngine.Rendering.Universal;

[ExcludeFromPreset]
public abstract class ScriptableRendererFeature : ScriptableObject, IDisposable
{
	[HideInInspector]
	[SerializeField]
	private bool m_Active = true;

	public bool isActive => m_Active;

	public abstract void Create();

	public virtual void OnCameraPreCull(ScriptableRenderer renderer, in CameraData cameraData)
	{
	}

	public abstract void AddRenderPasses(ScriptableRenderer renderer, ref ScriptableRenderContext context, ref RenderingData renderingData);

	internal virtual void ReconcilePersistentRenderResources(CommandBuffer cmd, ref RenderingData renderingData)
	{
	}

	internal virtual void OnActiveStateChanged()
	{
	}

	public virtual void ApplyRuntimeSettings()
	{
	}

	private void OnEnable()
	{
		Create();
	}

	private void OnValidate()
	{
		Create();
	}

	public void SetActive(bool active)
	{
		if (m_Active != active)
		{
			m_Active = active;
			OnActiveStateChanged();
		}
	}

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	protected virtual void Dispose(bool disposing)
	{
	}

	public virtual void EnableFeatureKeyWords(CommandBuffer cmd)
	{
	}

	public virtual void DisableFeatureKeyWords(CommandBuffer cmd)
	{
	}

	public static void DisableAllFeatureKeyWords(CommandBuffer cmd)
	{
	}
}
