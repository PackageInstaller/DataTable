using UnityEngine;

namespace XPostProcessing;

public class FullscreenMaterialPostProcessController : MonoBehaviour, IPostProcessWeightTarget
{
	[SerializeField]
	private Material material;

	[SerializeField]
	private int passIndex;

	[SerializeField]
	private int priority;

	[SerializeField]
	private bool setWeightProperty = true;

	[SerializeField]
	private string weightProperty = "_Intensity";

	[SerializeField]
	[Range(0f, 1f)]
	private float weight;

	private int m_WeightPropertyId;

	private string m_CachedWeightProperty;

	public Material Material => material;

	public int PassIndex => passIndex;

	public int Priority => priority;

	public float Weight
	{
		get
		{
			return weight;
		}
		set
		{
			weight = Mathf.Clamp01(value);
			ApplyWeightProperty();
		}
	}

	private void OnEnable()
	{
		ApplyWeightProperty();
		FullscreenMaterialPostProcessRuntime.Register(this);
	}

	private void OnDisable()
	{
		FullscreenMaterialPostProcessRuntime.Unregister(this);
	}

	private void OnValidate()
	{
		weight = Mathf.Clamp01(weight);
	}

	internal void ApplyWeightProperty()
	{
		if (setWeightProperty && !(material == null) && !string.IsNullOrEmpty(weightProperty))
		{
			if (m_CachedWeightProperty != weightProperty)
			{
				m_WeightPropertyId = Shader.PropertyToID(weightProperty);
				m_CachedWeightProperty = weightProperty;
			}
			if (material.HasProperty(m_WeightPropertyId))
			{
				material.SetFloat(m_WeightPropertyId, weight);
			}
		}
	}
}
