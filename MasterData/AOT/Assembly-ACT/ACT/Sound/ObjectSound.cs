using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Battle;
using Cysharp.Threading.Tasks;
using FMODUnity;
using Fundamental;
using UnityEngine;
using UnityEngine.Serialization;

namespace ACT.Sound;

public class ObjectSound : MonoBehaviour
{
	public static uint id;

	public List<EventReference> references;

	public List<AudioEventReference> audioReferences;

	[Tooltip("音效事件所需的Bank，编辑器下填入事件时自动烘焙，运行时异步加载")]
	public List<YooAssetReference> banks = new List<YooAssetReference>();

	[Tooltip("是否使用特效发射")]
	public bool useParticleSystemLoop;

	public ParticleSystem particleSystem;

	[Tooltip("延迟时间")]
	public float delayTime;

	[Tooltip("使用随机音效，默认顺序播放")]
	public bool useRandomSound;

	[Tooltip("音量大小")]
	[Range(0f, 1f)]
	public float volume = 1f;

	[Tooltip("FMOD SpatialMode parameter")]
	public AudioSpatialMode spatialMode;

	[FormerlySerializedAs("useXAxisAttenuationProxy")]
	[Tooltip("使用一个 ObjectSound 本地代理，这样衰减只会基于各轴超出已配置自由范围的部分来计算")]
	public bool useAxisAttenuationProxy;

	[Tooltip("用于局部衰减代理的 X 轴自由距离。负值表示忽略 X 轴，0 表示使用正常的 X 轴衰减，正值表示只保留超出 X 轴范围的部分")]
	public float attenuationFreeXDistance;

	[Tooltip("用于局部衰减代理的 Y 轴自由距离。负值表示忽略 Y 轴，0 表示使用正常的 Y 轴衰减，正值表示只保留超出 Y 轴范围的部分。")]
	public float attenuationFreeYDistance;

	[Tooltip("是否是循环音效")]
	public bool isLoopSound;

	protected int m_curIndex;

	protected uint m_uid;

	protected uint m_instance;

	protected Transform m_AttenuationProxy;

	private bool _banksLoaded;

	private void Awake()
	{
		TryLoadBanks();
	}

	private async void OnEnable()
	{
		CancellationToken cancellationToken = destroyCancellationToken;
		try
		{
			await UniTask.WaitUntil(() => this == null || (MonoECS.instance != null && MonoECS.instance.isStartWorld), PlayerLoopTiming.Update, cancellationToken);
		}
		catch (OperationCanceledException) when (cancellationToken.IsCancellationRequested)
		{
			return;
		}
		if (this == null || !gameObject.activeInHierarchy)
		{
			return;
		}
		if (MonoECS.instance == null)
		{
			Debug.LogError("ObjectSound.OnEnable failed: MonoECS.instance is null.", this);
			return;
		}
		m_curIndex = 0;
		if (audioReferences == null)
		{
			Debug.LogError("ObjectSound.OnEnable failed: audioReferences is null.", this);
			return;
		}
		for (int num = audioReferences.Count - 1; num >= 0; num--)
		{
			_ = audioReferences[num];
			if (audioReferences[num].IsNull())
			{
				audioReferences.RemoveAt(num);
			}
		}
		TryLoadBanks();
		UpdateAttenuationProxyPosition();
		ParticalSystemSound();
	}

	private void TryLoadBanks()
	{
		if (_banksLoaded || banks == null || banks.Count == 0 || Singleton<GameManager>.instance == null || Singleton<GameManager>.instance.audioManager == null)
		{
			return;
		}
		AudioManager audioManager = Singleton<GameManager>.instance.audioManager;
		int num = 0;
		for (int i = 0; i < banks.Count; i++)
		{
			YooAssetReference yooAssetReference = banks[i];
			if (!(yooAssetReference == null) && yooAssetReference.IsValid())
			{
				audioManager.LoadBankAsync(yooAssetReference);
				num++;
			}
		}
		_banksLoaded = num > 0;
	}

	private void UnloadBanks()
	{
		if (!_banksLoaded)
		{
			return;
		}
		_banksLoaded = false;
		if (banks == null || banks.Count == 0 || Singleton<GameManager>.instance == null || Singleton<GameManager>.instance.audioManager == null)
		{
			return;
		}
		AudioManager audioManager = Singleton<GameManager>.instance.audioManager;
		for (int i = 0; i < banks.Count; i++)
		{
			YooAssetReference yooAssetReference = banks[i];
			if (!(yooAssetReference == null) && yooAssetReference.IsValid())
			{
				audioManager.UnloadBank(yooAssetReference);
			}
		}
	}

	protected async void ParticalSystemSound()
	{
		if (useParticleSystemLoop)
		{
			if (!particleSystem)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogWarning("ObjectSound.ParticalSystemSound failed: particleSystem is null while useParticleSystemLoop is enabled.", this);
				}
				return;
			}
			ParticleSystem.EmissionModule emission = particleSystem.emission;
			float lastTime = 0f;
			while ((bool)particleSystem && particleSystem.main.loop)
			{
				for (int i = 0; i < emission.burstCount; i++)
				{
					ParticleSystem.Burst burst = emission.GetBurst(i);
					await UniTask.WaitUntil(() => particleSystem == null || particleSystem.time % particleSystem.main.duration >= burst.time);
					if (this == null || !gameObject.activeInHierarchy)
					{
						return;
					}
					if (!particleSystem)
					{
						if (LuminApplication.LogEnabled)
						{
							Debug.LogWarning("ObjectSound.ParticalSystemSound stopped: particleSystem became null before playing burst sound.", this);
						}
						return;
					}
					await UniTask.Delay((int)(delayTime * 1000f));
					if (this == null || !gameObject.activeInHierarchy)
					{
						return;
					}
					if (!particleSystem)
					{
						if (LuminApplication.LogEnabled)
						{
							Debug.LogWarning("ObjectSound.ParticalSystemSound stopped: particleSystem became null after delay.", this);
						}
						return;
					}
					lastTime = particleSystem.time;
					PlaySoundReference();
				}
				await UniTask.WaitUntil(() => particleSystem == null || lastTime >= particleSystem.time);
				if (this == null || !gameObject.activeInHierarchy)
				{
					break;
				}
				if (!particleSystem)
				{
					if (LuminApplication.LogEnabled)
					{
						Debug.LogWarning("ObjectSound.ParticalSystemSound stopped: particleSystem became null before loop restart.", this);
					}
					break;
				}
			}
			return;
		}
		await UniTask.Delay((int)(delayTime * 1000f));
		if (this == null || !gameObject.activeInHierarchy)
		{
			return;
		}
		if (isLoopSound)
		{
			if (ValidateAudioReferences("ParticalSystemSound") && TryGetAudioManager("ParticalSystemSound", out var audioManager))
			{
				m_uid = 1008611 + id++;
				if (m_instance != 0)
				{
					audioManager.Stop(m_instance);
				}
				UpdateAttenuationProxyPosition();
				m_instance = audioManager.PlaySound(audioReferences[0], new AudioPlayOptions
				{
					attachTarget = GetSoundAttachTarget(),
					IsLoop = true,
					spatialMode = spatialMode
				});
			}
		}
		else
		{
			PlaySoundReference();
		}
	}

	private void PlaySoundReference()
	{
		if (!(this == null) && gameObject.activeInHierarchy && ValidateAudioReferences("PlaySoundReference") && TryGetAudioManager("PlaySoundReference", out var audioManager) && audioManager.IsGameStateEnabled)
		{
			if (useRandomSound)
			{
				m_curIndex = UnityEngine.Random.Range(0, audioReferences.Count);
			}
			if (m_instance != 0)
			{
				audioManager.Stop(m_instance);
			}
			UpdateAttenuationProxyPosition();
			m_instance = audioManager.PlaySound(audioReferences[m_curIndex++], new AudioPlayOptions
			{
				attachTarget = GetSoundAttachTarget(),
				volume = volume,
				spatialMode = spatialMode
			});
			m_curIndex %= audioReferences.Count;
		}
	}

	public void SetSpatialMode(AudioSpatialMode spatialMode)
	{
		this.spatialMode = spatialMode;
		if (m_instance != 0 && TryGetAudioManager("SetSpatialMode", out var audioManager))
		{
			audioManager.SetSpatialMode(m_instance, spatialMode);
		}
	}

	private void LateUpdate()
	{
		UpdateAttenuationProxyPosition();
	}

	private Transform GetSoundAttachTarget()
	{
		if (!useAxisAttenuationProxy)
		{
			return transform;
		}
		if (m_AttenuationProxy == null)
		{
			GameObject gameObject = new GameObject("ObjectSound_XAxisAttenuationProxy");
			gameObject.transform.SetParent(transform, worldPositionStays: false);
			m_AttenuationProxy = gameObject.transform;
		}
		return m_AttenuationProxy;
	}

	private void UpdateAttenuationProxyPosition()
	{
		if (isActiveAndEnabled && (useAxisAttenuationProxy || !(m_AttenuationProxy == null)))
		{
			Transform transform = ((m_AttenuationProxy != null) ? m_AttenuationProxy : GetSoundAttachTarget());
			GameObject attenuationObject = StudioListener.GetAttenuationObject();
			Vector3 vector = ((attenuationObject != null) ? attenuationObject.transform.position : StudioListener.GetCameraPos());
			Vector3 position = base.transform.position;
			float attenuationOverflowOffset = GetAttenuationOverflowOffset(position.x, vector.x, attenuationFreeXDistance);
			float attenuationOverflowOffset2 = GetAttenuationOverflowOffset(position.y, vector.y, attenuationFreeYDistance);
			transform.position = new Vector3(vector.x + attenuationOverflowOffset, vector.y + attenuationOverflowOffset2, vector.z);
		}
	}

	private float GetAttenuationOverflowOffset(float sourceAxis, float listenerAxis, float freeDistance)
	{
		float num = sourceAxis - listenerAxis;
		if (freeDistance < 0f)
		{
			return 0f;
		}
		if (freeDistance == 0f)
		{
			return num;
		}
		float num2 = Mathf.Abs(num);
		if (num2 <= freeDistance)
		{
			return 0f;
		}
		return (num2 - freeDistance) * Mathf.Sign(num);
	}

	private void CleanupAttenuationProxy()
	{
		if (!(m_AttenuationProxy == null))
		{
			UnityEngine.Object.Destroy(m_AttenuationProxy.gameObject);
			m_AttenuationProxy = null;
		}
	}

	private bool ValidateAudioReferences(string callerName)
	{
		if (audioReferences == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning("ObjectSound." + callerName + " failed: audioReferences is null.", this);
			}
			return false;
		}
		if (audioReferences.Count == 0)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning("ObjectSound." + callerName + " failed: audioReferences is empty.", this);
			}
			return false;
		}
		return true;
	}

	private bool TryGetAudioManager(string callerName, out AudioManager audioManager)
	{
		audioManager = null;
		if (Singleton<GameManager>.instance == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning("ObjectSound." + callerName + " failed: GameManager.instance is null.", this);
			}
			return false;
		}
		audioManager = Singleton<GameManager>.instance.audioManager;
		if (audioManager == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning("ObjectSound." + callerName + " failed: audioManager is null.", this);
			}
			return false;
		}
		return true;
	}

	private void OnDisable()
	{
		OnDestroy();
	}

	protected void OnDestroy()
	{
		UnloadBanks();
		if (m_instance == 0)
		{
			CleanupAttenuationProxy();
			return;
		}
		if (!TryGetAudioManager("OnDestroy", out var audioManager))
		{
			CleanupAttenuationProxy();
			return;
		}
		audioManager.Stop(m_instance);
		CleanupAttenuationProxy();
	}
}
