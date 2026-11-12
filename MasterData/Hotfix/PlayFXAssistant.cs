using System.Collections;
using TrueSync;
using UnityEngine;

[AddComponentMenu("Game/FX/Play FX Assistant")]
public class PlayFXAssistant : MonoBehaviour
{
	public GameObject fxPrefab;

	[Space]
	[Min(0.01f)]
	public float playSpeed = 1f;

	[Min(0.01f)]
	public float fxScale = 1f;

	[Space]
	[Min(0f)]
	public float playInterval;

	[Space]
	public Transform targetPoint;

	private AdventureFXPlayer _fxPlayer;

	private long _fxToken;

	private Coroutine _updateCoroutine;

	[HideInInspector]
	private FP _fxScaleMutli = 1;

	public FP FxScaleMutli
	{
		get
		{
			return _fxScaleMutli;
		}
		set
		{
			if (!(_fxScaleMutli == value))
			{
				_fxScaleMutli = value;
				if (_fxPlayer != null)
				{
					_fxPlayer.sizeScale = FxScale;
				}
			}
		}
	}

	private float FxScale => (fxScale * FxScaleMutli).AsFloat();

	private void OnEnable()
	{
		FxScaleMutli = 1;
		if (!(fxPrefab == null))
		{
			if (playInterval <= float.Epsilon)
			{
				GameObject gameObject = fxPrefab;
				float playbackSpeed = playSpeed;
				Vector3 position = transform.position;
				Quaternion rotation = transform.rotation;
				float spawnSize = FxScale;
				Transform source = transform;
				Transform target = targetPoint;
				_fxPlayer = AdventureFXPlayer.PlayFX(gameObject, playbackSpeed, position, rotation, spawnSize, source, default, target);
				_fxToken = _fxPlayer.token;
				_fxPlayer.size = 1f;
				_fxPlayer.sizeScale = 1f;
				_fxPlayer.Bind(base.gameObject);
			}
			else
			{
				_updateCoroutine = StartCoroutine(UpdateCoroutine());
			}
		}
	}

	private void OnDisable()
	{
		if (_fxPlayer != null && _fxPlayer.token == _fxToken)
		{
			_fxPlayer.Stop();
			_fxPlayer = null;
			_fxToken = 0L;
		}
		if (_updateCoroutine != null)
		{
			StopCoroutine(_updateCoroutine);
			_updateCoroutine = null;
		}
	}

	private IEnumerator UpdateCoroutine()
	{
		float interval = 0f;
		AdventureFXPlayer fx = null;
		while (true)
		{
			if (interval > 0f)
			{
				interval -= Time.deltaTime;
				if (fx != null)
				{
					fx.sizeScale = FxScale;
				}
			}
			else
			{
				GameObject gameObject = fxPrefab;
				float playbackSpeed = playSpeed;
				Vector3 position = transform.position;
				Quaternion rotation = transform.rotation;
				float spawnSize = FxScale;
				Transform source = transform;
				Transform target = targetPoint;
				fx = AdventureFXPlayer.PlayFX(gameObject, playbackSpeed, position, rotation, spawnSize, source, default, target);
				interval = playInterval;
			}
			yield return null;
		}
	}
}
