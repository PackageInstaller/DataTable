using System.Collections;
using CriMana;
using UnityEngine;

public abstract class CriManaMovieMaterialBase : CriMonoBehaviour
{
	public enum MaxFrameDrop
	{
		Disabled,
		One,
		Two,
		Three,
		Four,
		Five,
		Six,
		Seven,
		Eight,
		Nine,
		Ten
	}

	public enum RenderMode
	{
		Always,
		OnVisibility,
		Never
	}

	public delegate void OnApplicationPauseCallback(CriManaMovieMaterialBase manaMovieMaterial, bool appPause);

	public bool playOnStart;

	public bool restartOnEnable;

	public RenderMode renderMode;

	public OnApplicationPauseCallback onApplicationPauseCallback;

	private Player.TimerType _timerType = Player.TimerType.Audio;

	[SerializeField]
	private Material _material;

	[SerializeField]
	private MaxFrameDrop _maxFrameDrop;

	private bool materialOwn;

	protected bool isMonoBehaviourStartCalled;

	private bool wasDisabled;

	private bool wasPausedOnDisable;

	private bool previousOnApplicationPauseStatus;

	private WaitForEndOfFrame frameEnd = new WaitForEndOfFrame();

	private bool unpauseOnApplicationUnpause;

	private CriManaMoviePlayerHolder playerHolder;

	public MaxFrameDrop maxFrameDrop
	{
		get
		{
			return _maxFrameDrop;
		}
		set
		{
			_maxFrameDrop = value;
			if (player != null)
			{
				player.maxFrameDrop = (int)_maxFrameDrop;
			}
		}
	}

	protected abstract bool initializeWithAdvancedAudio { get; }

	protected abstract bool initializeWithAmbisonics { get; }

	public bool isMaterialAvailable { get; private set; }

	public Player player { get; private set; }

	public Material material
	{
		get
		{
			return _material;
		}
		set
		{
			if (value != _material)
			{
				DestroyOwnMaterial();
				_material = value;
				isMaterialAvailable = false;
			}
		}
	}

	public Player.TimerType timerType
	{
		get
		{
			return _timerType;
		}
		set
		{
			_timerType = value;
			if (player != null)
			{
				player.SetMasterTimerType(timerType);
			}
		}
	}

	protected abstract uint FilePathLength { get; }

	protected bool HaveRendererOwner { get; private set; }

	private void DestroyOwnMaterial()
	{
		if (materialOwn && _material != null)
		{
			Object.Destroy(_material);
			_material = null;
		}
		materialOwn = false;
	}

	protected abstract void SetDataToPlayer();

	public void Play()
	{
		player.Start();
		CriInternalUpdate();
	}

	public void Stop()
	{
		player.Stop();
		if (isMaterialAvailable)
		{
			isMaterialAvailable = false;
			OnMaterialAvailableChanged();
		}
	}

	public void Pause(bool sw)
	{
		if (wasDisabled)
		{
			wasPausedOnDisable = sw;
		}
		else
		{
			player.Pause(sw);
		}
	}

	protected virtual void OnMaterialAvailableChanged()
	{
	}

	protected virtual void OnMaterialUpdated()
	{
	}

	public void PlayerManualInitialize()
	{
		if (player != null)
		{
			Debug.LogError("[CRIWARE][Error] CriManaMovieMaterial is already initialized. There is no need to call this function multiple times.");
			return;
		}
		player = new Player(initializeWithAdvancedAudio, initializeWithAmbisonics, FilePathLength);
		player.SetMasterTimerType(timerType);
		isMaterialAvailable = false;
	}

	public void PlayerManualFinalize()
	{
		if (player != null)
		{
			player.Dispose();
			player = null;
			DestroyOwnMaterial();
		}
	}

	public void PlayerManualSetup()
	{
		HaveRendererOwner = GetComponent<Renderer>() != null;
		if (_material == null)
		{
			CreateMaterial();
		}
		SetDataToPlayer();
		if (playOnStart)
		{
			player.Start();
		}
	}

	public virtual bool RenderTargetManualSetup()
	{
		return true;
	}

	public virtual void RenderTargetManualFinalize()
	{
	}

	public void PlayerManualUpdate()
	{
		if (player == null)
		{
			return;
		}
		if (player.timerType == Player.TimerType.User)
		{
			player.UpdateWithUserTime(0uL, 1000uL);
		}
		else
		{
			player.Update();
		}
		bool flag;
		if (player.isFrameAvailable)
		{
			flag = player.UpdateMaterial(material);
			if (flag)
			{
				OnMaterialUpdated();
			}
		}
		else
		{
			flag = false;
		}
		if (isMaterialAvailable != flag)
		{
			isMaterialAvailable = flag;
			OnMaterialAvailableChanged();
		}
	}

	protected virtual void Awake()
	{
		PlayerManualInitialize();
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		if (wasDisabled && player != null && player.isAlive)
		{
			player.Pause(wasPausedOnDisable);
			if (restartOnEnable)
			{
				StartCoroutine(RestartPlayerRoutine());
			}
		}
		wasDisabled = false;
	}

	private IEnumerator RestartPlayerRoutine()
	{
		if (player.status != Player.Status.Playing && player.status != Player.Status.PlayEnd)
		{
			yield break;
		}
		Stop();
		while (player.status != Player.Status.Stop)
		{
			if (player.status != Player.Status.StopProcessing)
			{
				yield break;
			}
			yield return frameEnd;
		}
		Play();
		player.Pause(wasPausedOnDisable);
	}

	protected override void OnDisable()
	{
		base.OnDisable();
		if (player != null && player.isAlive)
		{
			wasPausedOnDisable = player.IsPaused();
			player.Pause(sw: true);
		}
		wasDisabled = true;
	}

	protected virtual void OnDestroy()
	{
		RenderTargetManualFinalize();
		PlayerManualFinalize();
	}

	protected virtual void Start()
	{
		PlayerManualSetup();
		isMonoBehaviourStartCalled = true;
		if (!RenderTargetManualSetup())
		{
			Object.Destroy(this);
		}
	}

	public override void CriInternalUpdate()
	{
		PlayerManualUpdate();
	}

	public virtual void RenderMovie()
	{
		player.OnWillRenderObject(this);
	}

	public override void CriInternalLateUpdate()
	{
		if (renderMode == RenderMode.Always)
		{
			player.OnWillRenderObject(this);
		}
	}

	protected virtual void OnWillRenderObject()
	{
		if (renderMode == RenderMode.OnVisibility)
		{
			player.OnWillRenderObject(this);
		}
	}

	private void OnApplicationPause(bool appPause)
	{
		ProcessApplicationPause(appPause);
	}

	private void ProcessApplicationPause(bool appPause)
	{
		if (previousOnApplicationPauseStatus == appPause)
		{
			return;
		}
		previousOnApplicationPauseStatus = appPause;
		if (onApplicationPauseCallback != null)
		{
			onApplicationPauseCallback(this, appPause);
		}
		else
		{
			if (player == null)
			{
				return;
			}
			if (appPause)
			{
				unpauseOnApplicationUnpause = !player.IsPaused();
				if (unpauseOnApplicationUnpause)
				{
					player.PauseOnApplicationPause(sw: true);
				}
			}
			else
			{
				if (unpauseOnApplicationUnpause)
				{
					player.PauseOnApplicationPause(sw: false);
				}
				unpauseOnApplicationUnpause = false;
			}
		}
	}

	private void CreateMaterial()
	{
		_material = new Material(Shader.Find("CriMana/SofdecPrimeYuv"));
		_material.name = "CriMana-MovieMaterial";
		materialOwn = true;
	}
}
