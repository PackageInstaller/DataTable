using System;
using System.Diagnostics;
using ACT.Sound;
using ACT.World;
using Bamboo.ECS;
using FMODUnity;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

[RequireComponent(typeof(BoxCollider))]
public class BGMSoundTransfer : MonoTriggerEvent, ITrigger
{
	public EventReference bgmName;

	public AudioEventReference audioBgmName;

	[Range(0f, 1f)]
	public float bgmVolume = 1f;

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
			Singleton<BGMSoundManager>.instance.AddListener(this);
			OnEnterEvt(component.entity, this);
		}
	}

	private void OnTriggerExit(Collider other)
	{
		MonoEntity component = other.GetComponent<MonoEntity>();
		if (!(component == null) && component.entity.GetEntityType() == EntityType.Character && m_isInInteract)
		{
			m_isInInteract = false;
			Singleton<BGMSoundManager>.instance.RemoveListener(this);
			OnExitEvt(component.entity, this);
		}
	}

	private void OnDestroy()
	{
		if (m_isInInteract)
		{
			Singleton<BGMSoundManager>.instance.RemoveListener(this);
		}
	}

	public void TriggerExit()
	{
		m_isInInteract = false;
		Singleton<BGMSoundManager>.instance.RemoveListener(this);
	}
}
