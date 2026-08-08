using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;

public class CameraDepthOfField : MonoBehaviour
{
	private CameraExtension _cameraExtension;

	[SerializeField]
	private DepthOfFieldType _dofType;

	[SerializeField]
	[Range(0f, 1f)]
	private float _dofScale;

	[SerializeField]
	private float _dofNear = 5f;

	[SerializeField]
	private float _dofFar = 10f;

	private bool _isDirty;

	public CameraExtension cameraExtension
	{
		get
		{
			if (_cameraExtension == null)
			{
				_cameraExtension = Camera.main.transform.GetComponent<CameraExtension>();
			}
			return _cameraExtension;
		}
		set
		{
			_cameraExtension = value;
			_isDirty = true;
		}
	}

	public DepthOfFieldType dofType
	{
		get
		{
			return _dofType;
		}
		set
		{
			_dofType = value;
			_isDirty = true;
		}
	}

	public float dofScale
	{
		get
		{
			return _dofScale;
		}
		set
		{
			_dofScale = value;
			_isDirty = true;
		}
	}

	public float dofNear
	{
		get
		{
			return _dofNear;
		}
		set
		{
			_dofNear = value;
			_isDirty = true;
		}
	}

	public float dofFar
	{
		get
		{
			return _dofFar;
		}
		set
		{
			_dofFar = value;
			_isDirty = true;
		}
	}

	private void Start()
	{
		_isDirty = true;
	}

	private void OnEnable()
	{
		_isDirty = true;
	}

	private void Update()
	{
		if (_isDirty)
		{
			cameraExtension.dofType = _dofType;
			cameraExtension.dofScale = _dofScale;
			cameraExtension.dofNear = _dofNear;
			cameraExtension.dofFar = _dofFar;
			_isDirty = false;
		}
	}
}
