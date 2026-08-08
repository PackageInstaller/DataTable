using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;

public class GPUParticleNodeBehaviour : PlayableBehaviour
{
	private List<GPUParticleRenderer> m_v2ParticleSystems = new List<GPUParticleRenderer>();

	private List<MeshRenderer> m_gpuparticleSystems = new List<MeshRenderer>();

	private GameObject m_effect;

	private MaterialPropertyBlock _mpb;

	public GameObject effect
	{
		get
		{
			return m_effect;
		}
		set
		{
			m_effect = value;
			m_gpuparticleSystems.Clear();
			m_v2ParticleSystems.Clear();
			if (!m_effect)
			{
				return;
			}
			MeshRenderer[] componentsInChildren = m_effect.GetComponentsInChildren<MeshRenderer>();
			foreach (MeshRenderer meshRenderer in componentsInChildren)
			{
				if (meshRenderer.sharedMaterial != null && meshRenderer.sharedMaterial.shader.name.Contains("GPU_Particles"))
				{
					m_gpuparticleSystems.Add(meshRenderer);
				}
			}
			GPUParticleRenderer[] componentsInChildren2 = m_effect.GetComponentsInChildren<GPUParticleRenderer>();
			m_v2ParticleSystems.AddRange(componentsInChildren2.toList<GPUParticleRenderer>());
		}
	}

	private MaterialPropertyBlock mpb
	{
		get
		{
			if (_mpb == null)
			{
				_mpb = new MaterialPropertyBlock();
			}
			return _mpb;
		}
		set
		{
			_mpb = value;
		}
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		double time = playable.GetTime();
		for (int i = 0; i < m_gpuparticleSystems.Count; i++)
		{
			mpb.SetFloat("_GPUDATA_GPUParticleStartTime", -1f);
			mpb.SetFloat("_GPUDATA_GPUParticleTime", (float)time);
			m_gpuparticleSystems[i].SetPropertyBlock(mpb);
		}
		for (int j = 0; j < m_v2ParticleSystems.Count; j++)
		{
			m_v2ParticleSystems[j].Play(1f, (float)time);
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		for (int i = 0; i < m_gpuparticleSystems.Count; i++)
		{
			if ((bool)m_gpuparticleSystems[i])
			{
				mpb.SetFloat("_GPUDATA_GPUParticleStartTime", -1f);
				mpb.SetFloat("_GPUDATA_GPUParticleTime", 0f);
				m_gpuparticleSystems[i].SetPropertyBlock(mpb);
			}
		}
		for (int j = 0; j < m_v2ParticleSystems.Count; j++)
		{
			m_v2ParticleSystems[j].SetTimeScale(0f);
		}
	}
}
