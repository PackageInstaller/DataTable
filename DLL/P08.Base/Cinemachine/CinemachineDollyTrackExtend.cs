using UnityEngine;

namespace Cinemachine;

[ExecuteAlways]
[AddComponentMenu("")]
[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
public class CinemachineDollyTrackExtend : CinemachineExtension
{
	public bool HandToRoot;

	public E_LookAtType LookAtType = E_LookAtType.ROOT;

	public Vector3 DollTrackExtendRotation = Vector3.zero;

	public Vector3 DollTrackExtendPosition = Vector3.zero;

	public AnimationCurve PositionX;

	public AnimationCurve PositionY;

	public AnimationCurve PositionZ;

	public AnimationCurve RotationX;

	public AnimationCurve RotationY;

	public AnimationCurve RotationZ;

	public AnimationCurve Fov;

	public AnimationCurve Dutch;

	public AnimationCurve PathOffsetX;

	public AnimationCurve PathOffsetY;

	public AnimationCurve PathOffsetZ;

	public AnimationCurve TrackedObjectOffsetX;

	public AnimationCurve TrackedObjectOffsetY;

	public AnimationCurve TrackedObjectOffsetZ;

	public CinemachineBlendDefinition blendDefinition = new CinemachineBlendDefinition(CinemachineBlendDefinition.Style.EaseInOut, 1.5f);

	private bool _isUpdate;

	private float _normalize;

	private Vector3 _pathOffset = Vector3.zero;

	private Vector3 _aimOffset = Vector3.zero;

	private CinemachineComposer _composer;

	private CinemachineTrackedDolly _trackDolly;

	private CinemachineVirtualCamera _virtualCamera;

	private E_DollyTrackExtendMode _mode = E_DollyTrackExtendMode.Preview;

	public Vector3 Amendment = Vector3.zero;

	public void OnFinish(CinemachineBrain _cameraBrain)
	{
		_normalize = 0f;
		_isUpdate = false;
		Amendment = Vector3.zero;
		if (_composer != null)
		{
			_composer.VirtualCamera.LookAt = null;
		}
		_cameraBrain.m_DefaultBlend = blendDefinition;
	}

	private CinemachineTrackedDolly GetTrackDolly()
	{
		if (null == _trackDolly)
		{
			if (null == _virtualCamera)
			{
				_virtualCamera = base.gameObject.GetComponent<CinemachineVirtualCamera>();
			}
			_trackDolly = _virtualCamera.GetCinemachineComponent<CinemachineTrackedDolly>();
		}
		return _trackDolly;
	}

	public void Tick(float pathPosition, float normalize)
	{
		_isUpdate = true;
		_mode = E_DollyTrackExtendMode.Runtime;
		if (null == _trackDolly)
		{
			if (null == _virtualCamera)
			{
				_virtualCamera = base.gameObject.GetComponent<CinemachineVirtualCamera>();
			}
			_trackDolly = _virtualCamera.GetCinemachineComponent<CinemachineTrackedDolly>();
			_composer = _virtualCamera.GetCinemachineComponent<CinemachineComposer>();
		}
		_normalize = normalize;
		_trackDolly.m_PathPosition = pathPosition;
		_trackDolly.m_PathOffset = new Vector3(PathOffsetX.Evaluate(normalize), PathOffsetY.Evaluate(normalize), PathOffsetZ.Evaluate(normalize));
		_composer.m_TrackedObjectOffset = new Vector3(TrackedObjectOffsetX.Evaluate(normalize), TrackedObjectOffsetY.Evaluate(normalize), TrackedObjectOffsetZ.Evaluate(normalize));
		_virtualCamera.m_Lens.FieldOfView = Fov.Evaluate(normalize);
		if (Dutch != null)
		{
			_virtualCamera.m_Lens.Dutch = Dutch.Evaluate(normalize);
		}
	}

	protected override void PostPipelineStageCallback(CinemachineVirtualCameraBase vcam, CinemachineCore.Stage stage, ref CameraState state, float deltaTime)
	{
		if (stage == CinemachineCore.Stage.Body && ((_isUpdate && _mode == E_DollyTrackExtendMode.Runtime) || E_DollyTrackExtendMode.Preview == _mode))
		{
			Vector3 dollTrackExtendPosition = DollTrackExtendPosition;
			if (_mode == E_DollyTrackExtendMode.Runtime)
			{
				if (PositionX != null)
				{
					dollTrackExtendPosition.x = PositionX.Evaluate(_normalize);
				}
				if (PositionY != null)
				{
					dollTrackExtendPosition.y = PositionY.Evaluate(_normalize);
				}
				if (PositionZ != null)
				{
					dollTrackExtendPosition.z = PositionZ.Evaluate(_normalize);
				}
			}
			state.RawPosition += dollTrackExtendPosition - Amendment;
		}
		if (stage != CinemachineCore.Stage.Aim || ((!_isUpdate || _mode != E_DollyTrackExtendMode.Runtime) && E_DollyTrackExtendMode.Preview != _mode))
		{
			return;
		}
		Vector3 dollTrackExtendRotation = DollTrackExtendRotation;
		if (_mode == E_DollyTrackExtendMode.Runtime)
		{
			if (RotationX != null)
			{
				dollTrackExtendRotation.x = RotationX.Evaluate(_normalize);
			}
			if (RotationY != null)
			{
				dollTrackExtendRotation.y = RotationY.Evaluate(_normalize);
			}
			if (RotationZ != null)
			{
				dollTrackExtendRotation.z = RotationZ.Evaluate(_normalize);
			}
		}
		Vector3 euler = state.OrientationCorrection.eulerAngles + dollTrackExtendRotation;
		state.OrientationCorrection = Quaternion.Euler(euler);
	}
}
