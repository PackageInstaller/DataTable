using UnityEngine;
using UnityEngine.Serialization;

namespace Ase.Effect;

public class EffectMatLerp : MonoBehaviour
{
	[SerializeField]
	public float Duration;

	[FormerlySerializedAs("TargetRenderer")]
	[SerializeField]
	protected Renderer _targetRenderer;

	[FormerlySerializedAs("StartMaterial")]
	[SerializeField]
	private Material _startMaterial;

	[FormerlySerializedAs("TargetMaterial")]
	[SerializeField]
	private Material _targetMaterial;

	protected float _timer;

	protected bool _startLerpMat;

	protected Material _startMat;

	protected Material _toMat;

	protected Material _materialIns;

	protected virtual void Awake()
	{
		_materialIns = Object.Instantiate(_startMaterial);
		_targetRenderer.material = _materialIns;
	}

	private void OnDestroy()
	{
		_targetRenderer.material = null;
		Object.Destroy(_materialIns);
		_materialIns = null;
	}

	private void OnDisable()
	{
		EndMatLerp();
	}

	public virtual void StartMatLerp(bool isRevert)
	{
		_timer = 0f;
		_startLerpMat = true;
		_startMat = (isRevert ? _targetMaterial : _startMaterial);
		_toMat = (isRevert ? _startMaterial : _targetMaterial);
	}

	public virtual void EndMatLerp()
	{
		if (_startLerpMat)
		{
			_timer = Duration;
			_startLerpMat = false;
		}
	}

	protected virtual void Update()
	{
		if (_startLerpMat)
		{
			_timer += Time.deltaTime;
			_targetRenderer.material.Lerp(_startMat, _toMat, Mathf.Clamp(_timer / Duration, 0f, 1f));
			if (_timer >= Duration)
			{
				EndMatLerp();
			}
		}
	}
}
