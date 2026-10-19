using System.Diagnostics;
using ACT.Sound;
using ACT.Sound.Management;
using Bamboo.ECS;
using FMODUnity;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

[RequireComponent(typeof(BoxCollider))]
public class SnapshotSoundTransfer : MonoBehaviour
{
	public EventReference ambName;

	public AudioEventReference audioAmbName;

	private bool m_isInInteract;

	private int m_index;

	private void linkThoughts()
	{
		Process.Start("https://thoughts.teambition.com/workspaces/5fa92928dbaa030046a23c32/docs/6349421704d0f200018b9a24");
	}

	private void OnTriggerEnter(Collider other)
	{
		MonoEntity component = other.GetComponent<MonoEntity>();
		if (!(component == null) && component.entity.GetEntityType() == EntityType.Character && !m_isInInteract)
		{
			m_isInInteract = true;
			m_index = Singleton<SnapshotReverbManager>.instance.SetSnapshotReverb(audioAmbName);
		}
	}

	private void OnTriggerExit(Collider other)
	{
		MonoEntity component = other.GetComponent<MonoEntity>();
		if (!(component == null) && component.entity.GetEntityType() == EntityType.Character && m_isInInteract)
		{
			m_isInInteract = false;
			Singleton<SnapshotReverbManager>.instance.StopSnapshotReverb(m_index);
		}
	}

	private void OnDestroy()
	{
		if (m_isInInteract)
		{
			Singleton<SnapshotReverbManager>.instance.StopSnapshotReverb(m_index);
		}
	}
}
