using System.Collections.Generic;
using UnityEngine;

public class EffectRenderEnableHelper : MonoBehaviour
{
	public List<Renderer> m_renderers = new List<Renderer>();

	private bool _hide;

	public void Hide(bool v)
	{
		_hide = v;
	}

	private void LateUpdate()
	{
		if (_hide)
		{
			for (int i = 0; i < m_renderers.Count; i++)
			{
				m_renderers[i].enabled = false;
			}
		}
	}
}
