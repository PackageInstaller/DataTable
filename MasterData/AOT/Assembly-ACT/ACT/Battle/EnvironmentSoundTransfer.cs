using System;
using System.Diagnostics;
using ACT.Sound;
using Bamboo.ECS;
using FMODUnity;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

[RequireComponent(typeof(BoxCollider))]
public class EnvironmentSoundTransfer : MonoBehaviour
{
	public EventReference ambName;

	public AudioEventReference audioAmbName;

	[Range(0f, 10f)]
	public float paramValue;

	[NonSerialized]
	public Collider[] colliders;

	private bool m_isInInteract;

	private void linkThoughts()
	{
		Process.Start("https://thoughts.teambition.com/workspaces/5fa92928dbaa030046a23c32/docs/6349421704d0f200018b9a24");
	}

	private void Awake()
	{
		colliders = GetComponents<Collider>();
	}

	private void OnTriggerEnter(Collider other)
	{
		MonoEntity component = other.GetComponent<MonoEntity>();
		if (!(component == null) && component.entity.GetEntityType() == EntityType.Character && !m_isInInteract)
		{
			m_isInInteract = true;
			Singleton<EnvironmentSoundManager>.instance.AddListener(this);
		}
	}

	private void OnTriggerExit(Collider other)
	{
		MonoEntity component = other.GetComponent<MonoEntity>();
		if (!(component == null) && component.entity.GetEntityType() == EntityType.Character && m_isInInteract)
		{
			m_isInInteract = false;
			Singleton<EnvironmentSoundManager>.instance.RemoveListener(this);
		}
	}

	private void OnDestroy()
	{
		if (m_isInInteract)
		{
			Singleton<EnvironmentSoundManager>.instance.RemoveListener(this);
		}
	}
}
