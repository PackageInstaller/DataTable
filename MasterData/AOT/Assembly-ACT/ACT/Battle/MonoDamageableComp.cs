using System;
using ACT.Battle.Configs;
using ACT.Sound;
using FMODUnity;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class MonoDamageableComp : LuminSerializedMonoBehaviour, IDamageable
{
	[Serializable]
	public class CameraNoise
	{
		[Tooltip("震屏效果类型")]
		public CameraNoiseType cameraNoiseType = CameraNoiseType.LevelTrigger;

		[Tooltip("震屏效果预制体")]
		public YooAssetReference noiseReferenceAssetID;

		[Tooltip("震屏效果相对于播放点的偏移量，一般只有Y轴才有用")]
		public Vector3 velocity;
	}

	public struct Animators
	{
		[Tooltip("动画")]
		public Animator animator;

		[Tooltip("动画机状态名")]
		public string parameterName;

		public ConfigAnimParameterType type;

		public float defaultFloat;

		public int defaultInt;

		public bool defaultBool;
	}

	public MeshRenderer meshRenderer;

	public GameObject model;

	[Tooltip("特效预制体")]
	public YooAssetReference effectReferenceAssetID;

	[Tooltip("音效名字")]
	public EventReference soundEvent;

	public AudioEventReference audioSoundEvent;

	[Tooltip("动画")]
	public Animators animators;

	[Tooltip("震屏")]
	public CameraNoise cameraNoise;

	private bool m_Start;

	private float m_Time = 1f;

	public void Do(ActionMemory memory)
	{
		m_Start = true;
		if (effectReferenceAssetID != null)
		{
			GameManager.effectSystem.FireEffect(effectReferenceAssetID, model.transform.position, Quaternion.identity);
		}
		if (!soundEvent.IsNull)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound(audioSoundEvent, new AudioPlayOptions
			{
				attachTarget = model.transform
			});
		}
		switch (animators.type)
		{
		case ConfigAnimParameterType.Float:
			animators.animator.SetFloat(animators.parameterName, animators.defaultFloat);
			break;
		case ConfigAnimParameterType.Int:
			animators.animator.SetInteger(animators.parameterName, animators.defaultInt);
			break;
		case ConfigAnimParameterType.Bool:
			animators.animator.SetBool(animators.parameterName, animators.defaultBool);
			break;
		case ConfigAnimParameterType.Trigger:
			animators.animator.SetTrigger(animators.parameterName);
			break;
		}
		Singleton<CameraNoiseManager>.instance.TriggerCameraNoise(cameraNoise.cameraNoiseType, model.transform.position, cameraNoise.noiseReferenceAssetID, cameraNoise.velocity, 0f, 0f, changeVelocityXZ: false, overLay: true, unloadAfterPlaying: true);
	}

	public void Update()
	{
		if (m_Start)
		{
			m_Time -= Time.deltaTime;
			meshRenderer.material.SetFloat(BattleConsts.SUB_EFFECT_SHADER_DITHER, m_Time);
			if (m_Time < 0f)
			{
				m_Time = 0f;
				m_Start = false;
			}
		}
	}
}
