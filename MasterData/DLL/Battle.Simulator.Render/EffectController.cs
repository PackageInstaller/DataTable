using System;
using System.Collections.Generic;
using Cinemachine;
using UnityEngine;
using UnityEngine.Playables;

[ExecuteInEditMode]
[RequireComponent(typeof(EffectQualityManager))]
public class EffectController : PooledAsset
{
	private enum ParticleState
	{
		Initialized,
		BeforeLifeTime,
		DuringLifeTime,
		AfterLifeTime
	}

	public bool mReuseOldestGameobjectVar;

	public float TotalTime;

	public bool IsLoop;

	private bool _isPause;

	private float _timeScale = 1f;

	private float _runtimeTimeScale = 1f;

	private Action<EffectController> _onStop;

	private float mSimulatorUnScaledTime;

	private float mPauseTime;

	private bool mPauseTimeCalculate;

	private bool FirstInitialized;

	private float recordStartTime;

	private static readonly int GPUDATA_GPUParticleStartTime = Shader.PropertyToID("_GPUDATA_GPUParticleStartTime");

	private static readonly int GPUDATA_StartTimeEndTimeParticleNumberSortingOrder = Shader.PropertyToID("_GPUDATA_StartTimeEndTimeParticleNumberSortingOrder");

	public bool IgnoreTimeScale;

	private EEffectQuality _quality = EEffectQuality.Fantastic;

	private EffectQualityManager _qualityManager;

	public bool _testInEditor;

	public float _particleProgressToTestInEditor;

	[HideInInspector]
	public bool _timelineControl;

	private bool _testInEditorNew;

	private bool _timelineControlNew;

	public PositionAttachIsNotChild mPositionAttachIsNotChild;

	[SerializeField]
	public List<CinemachineVirtualCamera> m_virtualCameras = new List<CinemachineVirtualCamera>();

	public CameraEffectController m_CameraEffectController;

	[SerializeField]
	public List<CameraEffectController> m_CameraEffectControllers = new List<CameraEffectController>();

	public EarlyWarningEffectController m_EarlyWarningEffectController;

	[SerializeField]
	public List<PlayableDirector> m_PlayableDirectors = new List<PlayableDirector>();

	public UVChainLightning m_UVChainLightning;

	public EffectAudio m_effectAudio;

	public List<Collider> colliders = new List<Collider>();

	private ParticleState[] GPUParticleStates;

	public EffectRenderEnableHelper m_effectRenderEnableHelper;

	private EEffectQuality prevQuality;

	private List<Vector3> GPUParticlesIndexStartTimeEndTime;

	private MaterialPropertyBlock _mpb;

	private ParticleState[] CPUParticleStates;

	private List<int> CPUParticleIndex;

	private MaterialPropertyBlock _mpbForCPUParticle;

	private bool stopping;

	private bool needReturn = true;

	public override bool mReuseOldestGameobject
	{
		get
		{
			return mReuseOldestGameobjectVar;
		}
		set
		{
			mReuseOldestGameobjectVar = value;
		}
	}

	public bool testInEditorNew
	{
		get
		{
			return _testInEditorNew;
		}
		set
		{
			_testInEditorNew = value;
		}
	}

	public bool timelineControlNew
	{
		get
		{
			return _timelineControlNew;
		}
		set
		{
			_timelineControlNew = value;
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

	private bool testInEditor
	{
		get
		{
			return testInEditorNew;
		}
		set
		{
			testInEditorNew = value;
		}
	}

	private EffectQualityManager GetQualityManager()
	{
		if (null == _qualityManager)
		{
			_qualityManager = U3DUtil.Get<EffectQualityManager>(base.gameObject);
		}
		return _qualityManager;
	}

	private void Awake()
	{
		_qualityManager = GetQualityManager();
	}

	public void LoadEffectComponents(bool force = false)
	{
	}

	public void Initialize(bool isLoop, float keepTime, float timeScale, EEffectQuality quality, Action<EffectController> onStop, bool isMainPlayer = true, bool isFriend = false)
	{
		if (!base.enabled)
		{
			Debug.LogError("尝试初始化已经被回收的特效");
			return;
		}
		IsLoop = isLoop;
		_onStop = onStop;
		_timeScale = timeScale;
		_runtimeTimeScale = 1f;
		TotalTime = keepTime;
		mSimulatorTime = 0f;
		mSimulatorUnScaledTime = 0f;
		mPauseTime = 0f;
		mPauseTimeCalculate = false;
		FirstInitialized = false;
		_quality = quality;
		GetQualityManager().SetActive(EEffectQuality.Low, active: false);
		GetQualityManager().SetActive(quality, active: true, isMainPlayer, isFriend, m_virtualCameras.Count > 0);
		mIsRunning = true;
		Pause(isPause: false);
		ParticleInitialize(quality);
	}

	private void ParticleInitialize(EEffectQuality quality)
	{
		bool flag = false;
		if (GPUParticlesIndexStartTimeEndTime == null)
		{
			prevQuality = quality;
			GPUParticlesIndexStartTimeEndTime = new List<Vector3>();
			flag = true;
		}
		if (CPUParticleIndex == null)
		{
			prevQuality = quality;
			CPUParticleIndex = new List<int>();
			flag = true;
		}
		if (prevQuality != quality)
		{
			CPUParticleIndex.Clear();
			GPUParticlesIndexStartTimeEndTime.Clear();
			prevQuality = quality;
			flag = true;
		}
		if (flag)
		{
			List<Component> list = GetQualityManager().Get(quality);
			if (list == null)
			{
				Debug.LogError(base.gameObject.name + " :  " + quality);
			}
			int count = list.Count;
			for (int i = 0; i < count; i++)
			{
				int num = i;
				if (!(list[i] is Renderer))
				{
					continue;
				}
				Renderer renderer = (Renderer)list[i];
				if (renderer.sharedMaterial != null)
				{
					if (renderer.sharedMaterial.shader.name.Contains("GPU_Particles/"))
					{
						Vector4 vector = renderer.sharedMaterial.GetVector(GPUDATA_StartTimeEndTimeParticleNumberSortingOrder);
						GPUParticlesIndexStartTimeEndTime.Add(new Vector3(num, vector.x, vector.y));
					}
					else if (renderer.sharedMaterial != null)
					{
						CPUParticleIndex.Add(num);
					}
				}
			}
			CPUParticleStates = new ParticleState[CPUParticleIndex.Count];
			GPUParticleStates = new ParticleState[GPUParticlesIndexStartTimeEndTime.Count];
		}
		for (int j = 0; j < GPUParticleStates.Length; j++)
		{
			GPUParticleStates[j] = ParticleState.Initialized;
		}
		for (int k = 0; k < CPUParticleStates.Length; k++)
		{
			CPUParticleStates[k] = ParticleState.Initialized;
		}
		if (GPUParticlesIndexStartTimeEndTime != null)
		{
			for (int l = 0; l < GPUParticlesIndexStartTimeEndTime.Count; l++)
			{
				int index = Mathf.RoundToInt(GPUParticlesIndexStartTimeEndTime[l].x);
				(GetQualityManager().Get(_quality)[index] as Renderer).enabled = false;
			}
		}
	}

	public void SetTimeScale(float timeScale)
	{
		if (!IgnoreTimeScale)
		{
			_runtimeTimeScale = timeScale;
			SetPlaySpeed(_timeScale * _runtimeTimeScale);
		}
	}

	public void Simulator(float startTime, bool isMainPlayer = true, bool isFriend = false)
	{
		GetQualityManager().Simulator(_quality, startTime, _timeScale * _runtimeTimeScale, isMainPlayer, isFriend, m_virtualCameras.Count > 0);
	}

	private void SetPlaySpeed(float speed)
	{
		GetQualityManager().SetPlaySpeed(_quality, speed);
	}

	public void Pause(bool isPause)
	{
		SetPlaySpeed(isPause ? 0f : (_timeScale * _runtimeTimeScale));
		_isPause = isPause;
	}

	public void Clean()
	{
		if (!mIsRunning)
		{
			return;
		}
		_onStop = null;
		mSimulatorTime = 0f;
		mSimulatorUnScaledTime = 0f;
		mPauseTime = 0f;
		mPauseTimeCalculate = false;
		FirstInitialized = false;
		mIsRunning = false;
		Pause(isPause: true);
		if (Application.isPlaying && needReturn)
		{
			PooledAsset.DestroyOrReturn(base.gameObject);
		}
		if (m_virtualCameras != null && m_virtualCameras.Count > 0)
		{
			for (int i = 0; i < m_virtualCameras.Count; i++)
			{
				m_virtualCameras[i].enabled = false;
			}
		}
	}

	private void OnEnable()
	{
	}

	public void Update()
	{
		if (_isPause)
		{
			mPauseTime += Time.deltaTime;
			mPauseTimeCalculate = true;
		}
		if (_isPause || !mIsRunning || IsLoop)
		{
			return;
		}
		float deltaTime = Time.deltaTime;
		float num = deltaTime * _timeScale * _runtimeTimeScale;
		bool flag = false;
		float num2 = 0f;
		if (mSimulatorTime <= 0f && num > 0f && !FirstInitialized)
		{
			FirstInitialized = true;
			flag = true;
			recordStartTime = Time.timeSinceLevelLoad;
		}
		mSimulatorTime += num;
		mSimulatorUnScaledTime += deltaTime;
		if (mSimulatorTime < TotalTime)
		{
			if (GPUParticlesIndexStartTimeEndTime != null)
			{
				for (int i = 0; i < GPUParticlesIndexStartTimeEndTime.Count; i++)
				{
					Vector3 vector = GPUParticlesIndexStartTimeEndTime[i];
					float z = vector.z;
					float y = vector.y;
					int index = Mathf.RoundToInt(vector.x);
					if (z < mSimulatorTime)
					{
						if (GPUParticleStates[i] == ParticleState.DuringLifeTime)
						{
							(GetQualityManager().Get(_quality)[index] as Renderer).enabled = false;
							GPUParticleStates[i] = ParticleState.AfterLifeTime;
						}
					}
					else if (y < mSimulatorTime)
					{
						if (GPUParticleStates[i] <= ParticleState.BeforeLifeTime)
						{
							Renderer renderer = GetQualityManager().Get(_quality)[index] as Renderer;
							if (!GetQualityManager().IsInHideDictionaryAndNoMainPlayer(GetQualityManager().Get(_quality)[index]))
							{
								renderer.enabled = true;
							}
							GPUParticleStates[i] = ParticleState.DuringLifeTime;
						}
					}
					else if (GPUParticleStates[i] == ParticleState.Initialized)
					{
						(GetQualityManager().Get(_quality)[index] as Renderer).enabled = false;
						GPUParticleStates[i] = ParticleState.BeforeLifeTime;
					}
				}
			}
			if (_timeScale * _runtimeTimeScale < 1f)
			{
				float num3 = mSimulatorUnScaledTime - mSimulatorTime;
				num2 = recordStartTime + num3;
				flag = true;
			}
			else
			{
				num2 = recordStartTime;
			}
			float value = num2 + mPauseTime;
			if (mPauseTimeCalculate)
			{
				flag = true;
				mPauseTimeCalculate = false;
			}
			if (!flag)
			{
				return;
			}
			if (GPUParticlesIndexStartTimeEndTime != null)
			{
				mpb.SetFloat(GPUDATA_GPUParticleStartTime, value);
				for (int j = 0; j < GPUParticlesIndexStartTimeEndTime.Count; j++)
				{
					Vector3 vector2 = GPUParticlesIndexStartTimeEndTime[j];
					int index2 = Mathf.RoundToInt(vector2.x);
					if (vector2.z >= mSimulatorTime)
					{
						((Renderer)GetQualityManager().Get(_quality)[index2]).SetPropertyBlock(mpb);
					}
				}
			}
			if (CPUParticleIndex != null)
			{
				for (int k = 0; k < CPUParticleIndex.Count; k++)
				{
					int index3 = CPUParticleIndex[k];
					if (_mpbForCPUParticle == null)
					{
						_mpbForCPUParticle = new MaterialPropertyBlock();
					}
					Renderer obj = (Renderer)GetQualityManager().Get(_quality)[index3];
					obj.GetPropertyBlock(_mpbForCPUParticle);
					_mpbForCPUParticle.SetFloat(GPUDATA_GPUParticleStartTime, value);
					obj.SetPropertyBlock(_mpbForCPUParticle);
				}
			}
			GetQualityManager().SetParticleSystemRendererMPB(GPUDATA_GPUParticleStartTime, value);
		}
		else
		{
			Stop();
		}
	}

	public override void Stop()
	{
		if (!stopping)
		{
			stopping = true;
			if (_onStop != null)
			{
				_onStop(this);
			}
			Clean();
			stopping = false;
		}
	}

	private void OnDestroy()
	{
		if (mLinkCache != null)
		{
			mLinkCache.Remove(base.gameObject);
			mLinkCache = null;
		}
		PooledAsset.mPoolTable.Remove(base.gameObject);
		needReturn = false;
		Stop();
		needReturn = true;
	}

	public override void SetActive(bool active)
	{
		GetQualityManager().SetActive(EEffectQuality.Low, active);
		if (mPositionAttachIsNotChild != null)
		{
			mPositionAttachIsNotChild.enabled = false;
		}
		SetCameraEffectControllers(active);
		if (!active && m_virtualCameras.Count > 0)
		{
			SetVirtualCameras(active: false);
		}
		if (m_EarlyWarningEffectController != null)
		{
			m_EarlyWarningEffectController.enabled = active;
		}
		if (m_PlayableDirectors.Count > 0)
		{
			SetPlayableDirectors(active);
		}
		if (m_UVChainLightning != null)
		{
			m_UVChainLightning.Reset();
			m_UVChainLightning.enabled = active;
		}
		if (m_effectAudio != null)
		{
			SetEffectAudioControllers(active);
		}
		if (m_effectRenderEnableHelper != null)
		{
			m_effectRenderEnableHelper.Hide(v: false);
			m_effectRenderEnableHelper.enabled = active;
		}
		base.enabled = active;
		if (colliders == null)
		{
			return;
		}
		foreach (Collider collider in colliders)
		{
			if (collider != null)
			{
				collider.enabled = active;
			}
		}
	}

	public void EnableVirtualCameras()
	{
		SetVirtualCameras(active: true);
	}

	private void SetVirtualCameras(bool active)
	{
		if (m_virtualCameras != null && m_virtualCameras.Count > 0)
		{
			for (int i = 0; i < m_virtualCameras.Count; i++)
			{
				m_virtualCameras[i].enabled = active;
			}
		}
	}

	public void UpdateVirtualCameras()
	{
		m_virtualCameras.Clear();
		CinemachineVirtualCamera[] componentsInChildren = base.gameObject.GetComponentsInChildren<CinemachineVirtualCamera>(includeInactive: true);
		m_virtualCameras.AddRange(componentsInChildren);
	}

	private void SetCameraEffectControllers(bool active)
	{
		if (m_CameraEffectController != null)
		{
			m_CameraEffectController.enabled = active;
		}
		if (m_CameraEffectControllers != null && m_CameraEffectControllers.Count > 0)
		{
			for (int i = 0; i < m_CameraEffectControllers.Count; i++)
			{
				m_CameraEffectControllers[i].enabled = active;
			}
		}
	}

	public void UpdateCameraEffectControllers()
	{
		m_CameraEffectControllers.Clear();
		CameraEffectController[] componentsInChildren = base.gameObject.GetComponentsInChildren<CameraEffectController>(includeInactive: true);
		m_CameraEffectControllers.AddRange(componentsInChildren);
	}

	public void SetPlayableDirectors(bool active)
	{
		if (active)
		{
			List<PlayableDirector>.Enumerator enumerator = m_PlayableDirectors.GetEnumerator();
			while (enumerator.MoveNext())
			{
				PlayableDirector current = enumerator.Current;
				current.time = 0.0;
				current.Play();
			}
		}
		else
		{
			List<PlayableDirector>.Enumerator enumerator2 = m_PlayableDirectors.GetEnumerator();
			while (enumerator2.MoveNext())
			{
				PlayableDirector current2 = enumerator2.Current;
				current2.Stop();
				current2.time = 0.0;
			}
		}
	}

	public void UpdatePlayableDirectors()
	{
		m_PlayableDirectors.Clear();
		m_PlayableDirectors.AddRange(base.gameObject.GetComponentsInChildren<PlayableDirector>(includeInactive: true));
	}

	public void UpdateEarlyWarningEffectController()
	{
		m_EarlyWarningEffectController = base.gameObject.GetComponentInChildren<EarlyWarningEffectController>(includeInactive: true);
	}

	public static EffectController GetEffectController(GameObject currentEffect)
	{
		if (PooledAsset.mPoolTable.TryGetValue(currentEffect, out var value))
		{
			return value as EffectController;
		}
		return currentEffect.GetComponent<EffectController>();
	}

	public void UpdateUVChainLighting()
	{
		m_UVChainLightning = base.gameObject.GetComponentInChildren<UVChainLightning>(includeInactive: true);
	}

	internal void Hide(bool v)
	{
		if (base.enabled)
		{
			GetQualityManager().HideRenderer(_quality, v);
			if (m_EarlyWarningEffectController != null)
			{
				m_EarlyWarningEffectController.HideRenderer(v);
			}
			if (m_effectRenderEnableHelper != null)
			{
				m_effectRenderEnableHelper.Hide(v);
			}
		}
	}

	public void UpdateEffectRenderEnableHelper()
	{
		m_effectRenderEnableHelper = GetComponent<EffectRenderEnableHelper>();
	}

	public void UpdateEffectAudioControllers()
	{
		m_effectAudio = GetComponentInChildren<EffectAudio>();
	}

	private void SetEffectAudioControllers(bool enabled)
	{
		if (m_effectAudio != null)
		{
			if (enabled)
			{
				m_effectAudio.Play();
			}
			else
			{
				m_effectAudio.Stop();
			}
		}
	}

	public void UpdateCollider()
	{
		if (colliders == null)
		{
			colliders = new List<Collider>();
		}
		colliders.Clear();
		GetComponentsInChildren(includeInactive: true, colliders);
	}
}
