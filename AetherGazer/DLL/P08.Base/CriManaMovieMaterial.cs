using UnityEngine;

[AddComponentMenu("CRIWARE/CriManaMovieMaterial")]
public class CriManaMovieMaterial : CriManaMovieMaterialBase
{
	[SerializeField]
	private string _moviePath;

	[SerializeField]
	private bool _loop;

	[SerializeField]
	private bool _audioBaseConcatenation = true;

	[SerializeField]
	private bool _additiveMode;

	[SerializeField]
	private bool _advancedAudio = true;

	[SerializeField]
	private bool _ambisonics;

	[SerializeField]
	private bool _applyTargetAlpha;

	[SerializeField]
	private bool _uiRenderMode;

	private GameObject ambisonicSource;

	public string moviePath
	{
		get
		{
			return _moviePath;
		}
		set
		{
			if (isMonoBehaviourStartCalled)
			{
				Debug.LogError("[CRIWARE] moviePath can not be changed. Use CriMana::Player::SetFile method.");
			}
			else
			{
				_moviePath = value;
			}
		}
	}

	public bool loop
	{
		get
		{
			return _loop;
		}
		set
		{
			if (isMonoBehaviourStartCalled)
			{
				Debug.LogError("[CRIWARE] loop property can not be changed. Use CriMana::Player::Loop method.");
			}
			else
			{
				_loop = value;
			}
		}
	}

	public bool audioBaseConcatenation
	{
		get
		{
			return _audioBaseConcatenation;
		}
		set
		{
			if (isMonoBehaviourStartCalled)
			{
				Debug.LogError("[CRIWARE] audioBaseConcatenation property can not be changed in running.");
			}
			else
			{
				_audioBaseConcatenation = value;
			}
		}
	}

	public bool advancedAudio
	{
		get
		{
			return _advancedAudio;
		}
		set
		{
			if (isMonoBehaviourStartCalled)
			{
				Debug.LogError("[CRIWARE] advancedAudio property can not be changed in running.");
				return;
			}
			if (!value)
			{
				ambisonics = false;
			}
			_advancedAudio = value;
		}
	}

	public bool ambisonics
	{
		get
		{
			return _ambisonics;
		}
		set
		{
			if (isMonoBehaviourStartCalled)
			{
				Debug.LogError("[CRIWARE] ambisonics property can not be changed in running.");
				return;
			}
			if (!_advancedAudio)
			{
				Debug.LogError("[CRIWARE] ambisonics property needs for advancedAudio property to be true.");
				return;
			}
			if (!value)
			{
				GameObject gameObject = null;
				if (base.gameObject.transform.childCount > 0)
				{
					gameObject = ((ambisonicSource != null) ? ambisonicSource : base.gameObject.transform.Find("Ambisonic Source").gameObject);
					if (gameObject != null)
					{
						Object.DestroyImmediate(gameObject);
						gameObject = null;
					}
				}
			}
			else if (ambisonicSource == null)
			{
				ambisonicSource = new GameObject();
				ambisonicSource.name = "Ambisonic Source";
				ambisonicSource.transform.parent = base.gameObject.transform;
				ambisonicSource.transform.position = base.gameObject.transform.position;
				ambisonicSource.transform.rotation = base.gameObject.transform.rotation;
				ambisonicSource.transform.localScale = base.gameObject.transform.localScale;
				ambisonicSource.AddComponent<CriManaAmbisonicSource>();
			}
			_ambisonics = value;
		}
	}

	public bool additiveMode
	{
		get
		{
			return _additiveMode;
		}
		set
		{
			if (isMonoBehaviourStartCalled)
			{
				Debug.LogError("[CRIWARE] additiveMode can not be changed. Use CriMana::Player::additiveMode method.");
			}
			else
			{
				_additiveMode = value;
			}
		}
	}

	public bool applyTargetAlpha
	{
		get
		{
			return _applyTargetAlpha;
		}
		set
		{
			if (isMonoBehaviourStartCalled)
			{
				Debug.LogError("[CRIWARE] applyTargetAlpha property can not be changed in running.");
			}
			else
			{
				_applyTargetAlpha = value;
			}
		}
	}

	public bool uiRenderMode
	{
		get
		{
			return _uiRenderMode;
		}
		set
		{
			if (isMonoBehaviourStartCalled)
			{
				Debug.LogError("[CRIWARE] uiRenderMode property can not be changed in running.");
			}
			else
			{
				_uiRenderMode = value;
			}
		}
	}

	protected override uint FilePathLength
	{
		get
		{
			CriFs.GetMaxPathLength(out var length);
			return (uint)length;
		}
	}

	protected override bool initializeWithAdvancedAudio => advancedAudio;

	protected override bool initializeWithAmbisonics => ambisonics;

	protected override void SetDataToPlayer()
	{
		if (!string.IsNullOrEmpty(moviePath))
		{
			base.player.SetFile(null, moviePath);
		}
		base.player.Loop(loop);
		base.player.SetAudioBaseConcatenation(audioBaseConcatenation);
		base.player.additiveMode = additiveMode;
		base.player.maxFrameDrop = (int)base.maxFrameDrop;
		base.player.applyTargetAlpha = applyTargetAlpha;
		base.player.uiRenderMode = uiRenderMode;
	}
}
