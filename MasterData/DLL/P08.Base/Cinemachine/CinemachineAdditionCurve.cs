using UnityEngine;

namespace Cinemachine;

[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
[AddComponentMenu("")]
[SaveDuringPlay]
[ExecuteAlways]
public class CinemachineAdditionCurve : CinemachineExtension
{
	public AnimationCurve XCurve;

	public AnimationCurve YCurve;

	public AnimationCurve ZCurve;

	public AnimationCurve YAngleOfViewCurve;

	private E_AdditionForwardType ForwardType = E_AdditionForwardType.Follow;

	private float _normalize;

	private bool _isUpdate;

	public void OnFinish()
	{
		_normalize = 0f;
		_isUpdate = false;
		XCurve = null;
		YCurve = null;
		ZCurve = null;
		YAngleOfViewCurve = null;
	}

	public void Tick(float value)
	{
		_normalize = value;
	}

	public void SetCurvesFromOtherAddictionCurve(CinemachineAdditionCurve curve, E_AdditionForwardType forwardType)
	{
		XCurve = curve.XCurve;
		YCurve = curve.YCurve;
		ZCurve = curve.ZCurve;
		YAngleOfViewCurve = curve.YAngleOfViewCurve;
		ForwardType = forwardType;
		_isUpdate = true;
	}

	protected override void PostPipelineStageCallback(CinemachineVirtualCameraBase vcam, CinemachineCore.Stage stage, ref CameraState state, float deltaTime)
	{
		if (_isUpdate && stage == CinemachineCore.Stage.Finalize)
		{
			float num = 0f;
			float num2 = 0f;
			float num3 = 0f;
			float num4 = 0f;
			if (XCurve != null)
			{
				num = XCurve.Evaluate(_normalize);
			}
			if (YCurve != null)
			{
				num2 = YCurve.Evaluate(_normalize);
			}
			if (ZCurve != null)
			{
				num3 = ZCurve.Evaluate(_normalize);
			}
			if (YAngleOfViewCurve != null)
			{
				num4 = YAngleOfViewCurve.Evaluate(_normalize);
			}
			Transform transform = vcam.Follow;
			switch (ForwardType)
			{
			case E_AdditionForwardType.Look:
				transform = vcam.LookAt;
				break;
			case E_AdditionForwardType.Follow:
				transform = vcam.Follow;
				break;
			case E_AdditionForwardType.Camera:
				transform = Camera.main.transform;
				break;
			}
			Vector3 vector = num * transform.right + num2 * transform.up + num3 * transform.forward;
			state.PositionCorrection += vector;
			Vector3 eulerAngles = state.OrientationCorrection.eulerAngles;
			state.OrientationCorrection = Quaternion.Euler(eulerAngles.x + num4, eulerAngles.y, eulerAngles.z);
		}
		if (stage == CinemachineCore.Stage.Finalize)
		{
			if (float.IsNaN(state.FinalPosition.x) || float.IsNaN(state.FinalPosition.y) || float.IsNaN(state.FinalPosition.z))
			{
				state.RawPosition = base.transform.position;
				state.PositionCorrection = Vector3.zero;
			}
			if (float.IsNaN(state.FinalOrientation.x) || float.IsNaN(state.FinalOrientation.y) || float.IsNaN(state.FinalOrientation.z) || float.IsNaN(state.FinalOrientation.w))
			{
				state.RawOrientation = base.transform.rotation;
				state.OrientationCorrection = Quaternion.identity;
			}
		}
	}
}
