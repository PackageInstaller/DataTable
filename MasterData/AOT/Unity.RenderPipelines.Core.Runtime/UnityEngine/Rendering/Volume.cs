using System.Collections.Generic;
using UnityEngine.Serialization;

namespace UnityEngine.Rendering;

[AddComponentMenu("Miscellaneous/Volume")]
[ExecuteAlways]
public class Volume : MonoBehaviour, IVolume
{
	[FormerlySerializedAs("isGlobal")]
	[SerializeField]
	private bool m_IsGlobal = true;

	[Tooltip("A value which determines which Volume is being used when Volumes have an equal amount of influence on the Scene. Volumes with a higher priority will override lower ones.")]
	[Delayed]
	public float priority;

	[Tooltip("Sets the outer distance to start blending from. A value of 0 means no blending and Unity applies the Volume overrides immediately upon entry.")]
	public float blendDistance;

	[Range(0f, 1f)]
	[Tooltip("Sets the total weight of this Volume in the Scene. 0 means no effect and 1 means full effect.")]
	public float weight = 1f;

	public VolumeProfile sharedProfile;

	internal List<Collider> m_Colliders = new List<Collider>();

	private int m_PreviousLayer;

	private float m_PreviousPriority;

	private VolumeProfile m_InternalProfile;

	[Tooltip("When enabled, the Volume is applied to the entire Scene.")]
	public bool isGlobal
	{
		get
		{
			return m_IsGlobal;
		}
		set
		{
			m_IsGlobal = value;
		}
	}

	public VolumeProfile profile
	{
		get
		{
			if (m_InternalProfile == null)
			{
				m_InternalProfile = ScriptableObject.CreateInstance<VolumeProfile>();
				if (sharedProfile != null)
				{
					m_InternalProfile.name = sharedProfile.name;
					foreach (VolumeComponent component in sharedProfile.components)
					{
						VolumeComponent item = Object.Instantiate(component);
						m_InternalProfile.components.Add(item);
					}
				}
			}
			return m_InternalProfile;
		}
		set
		{
			m_InternalProfile = value;
		}
	}

	public List<Collider> colliders => m_Colliders;

	internal VolumeProfile profileRef
	{
		get
		{
			if (!(m_InternalProfile == null))
			{
				return m_InternalProfile;
			}
			return sharedProfile;
		}
	}

	public bool HasInstantiatedProfile()
	{
		return m_InternalProfile != null;
	}

	private void OnEnable()
	{
		m_PreviousLayer = gameObject.layer;
		VolumeManager.instance.Register(this, m_PreviousLayer);
		GetComponents(m_Colliders);
	}

	private void OnDisable()
	{
		VolumeManager.instance.Unregister(this, gameObject.layer);
	}

	private void Update()
	{
		UpdateLayer();
		if (priority != m_PreviousPriority)
		{
			VolumeManager.instance.SetLayerDirty(gameObject.layer);
			m_PreviousPriority = priority;
		}
	}

	internal void UpdateLayer()
	{
		int layer = gameObject.layer;
		if (layer != m_PreviousLayer)
		{
			VolumeManager.instance.UpdateVolumeLayer(this, m_PreviousLayer, layer);
			m_PreviousLayer = layer;
		}
	}
}
