using UnityEngine;

namespace ACT.VolumeControl;

public class ControlMeshRenderer : MonoBehaviour
{
	public bool needShow;

	public Renderer[] m_Renderers;

	public void Init()
	{
		m_Renderers = GetComponentsInChildren<Renderer>(includeInactive: true);
	}

	private void Awake()
	{
		if (m_Renderers == null)
		{
			return;
		}
		Renderer[] renderers = m_Renderers;
		foreach (Renderer renderer in renderers)
		{
			if ((bool)renderer)
			{
				renderer.enabled = false;
			}
		}
	}

	private void Update()
	{
		if (!needShow)
		{
			return;
		}
		needShow = true;
		Renderer[] renderers = m_Renderers;
		foreach (Renderer renderer in renderers)
		{
			if ((bool)renderer)
			{
				renderer.enabled = true;
			}
		}
	}
}
