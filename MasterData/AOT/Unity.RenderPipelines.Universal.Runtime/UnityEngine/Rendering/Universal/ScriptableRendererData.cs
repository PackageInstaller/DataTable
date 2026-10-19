using System.Collections.Generic;

namespace UnityEngine.Rendering.Universal;

public abstract class ScriptableRendererData : ScriptableObject
{
	[SerializeField]
	internal List<ScriptableRendererFeature> m_RendererFeatures = new List<ScriptableRendererFeature>(10);

	[SerializeField]
	internal List<long> m_RendererFeatureMap = new List<long>(10);

	internal bool isInvalidated { get; set; }

	public List<ScriptableRendererFeature> rendererFeatures => m_RendererFeatures;

	protected abstract ScriptableRenderer Create();

	protected virtual ScriptableRenderer Create(RenderPassScheduleMode renderPassScheduleMode)
	{
		return Create();
	}

	public new void SetDirty()
	{
		isInvalidated = true;
	}

	internal ScriptableRenderer InternalCreateRenderer(RenderPassScheduleMode renderPassScheduleMode)
	{
		isInvalidated = false;
		return Create(renderPassScheduleMode);
	}

	protected virtual void OnValidate()
	{
		SetDirty();
	}

	protected virtual void OnEnable()
	{
		SetDirty();
	}

	public bool TryGetRendererFeature<T>(out T rendererFeature) where T : ScriptableRendererFeature
	{
		foreach (ScriptableRendererFeature rendererFeature2 in rendererFeatures)
		{
			if (rendererFeature2.GetType() == typeof(T))
			{
				rendererFeature = rendererFeature2 as T;
				return true;
			}
		}
		rendererFeature = null;
		return false;
	}
}
