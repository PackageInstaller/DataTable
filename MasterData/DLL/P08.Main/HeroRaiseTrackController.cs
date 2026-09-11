using System.Collections.Generic;
using Cinemachine;
using UnityEngine;

public class HeroRaiseTrackController : MonoBehaviour
{
	public CinemachineVirtualCamera virtualCamera;

	private GameObject _cameraGo;

	private CinemachineTrackedDolly _trackDolly;

	private CinemachineComposer _composer;

	private CinemachinePathBase _path;

	public HeroRaiseTrackData cameraData;

	private float normalized_PreviousPosition;

	private float normalized_TargetPosition;

	private float _previousPosition;

	private float _targetPosition;

	public float positionTime = 1f;

	public float bodyTime = 1f;

	private float _previousFOV;

	private float _previousDutch;

	private Vector3 _previousPathOffset;

	private Vector3 _previousTrackedObjectOffset;

	public AnimationCurve Speed;

	public AnimationCurve XDamping;

	public AnimationCurve YDamping;

	public AnimationCurve ZDamping;

	[Header("子界面配置")]
	public List<HeroRaiseSubNode> heroRaiseSubLists;

	private void Awake()
	{
		_trackDolly = virtualCamera.GetCinemachineComponent<CinemachineTrackedDolly>();
		_composer = virtualCamera.GetCinemachineComponent<CinemachineComposer>();
		_path = _trackDolly.m_Path;
		_previousPosition = _trackDolly.m_PathPosition;
		_targetPosition = _previousPosition;
		normalized_PreviousPosition = _Normalize(_previousPosition, _trackDolly.m_PositionUnits);
		normalized_TargetPosition = normalized_PreviousPosition;
		_cameraGo = virtualCamera.gameObject;
	}

	private void OnDestroy()
	{
		LeanTween.cancel(_cameraGo);
	}

	public bool LoadTrackData(string path)
	{
		HeroRaiseTrackData heroRaiseTrackData = Asset.Load<HeroRaiseTrackData>(path);
		if (heroRaiseTrackData != null)
		{
			cameraData = heroRaiseTrackData;
			return true;
		}
		return false;
	}

	public void ChangePathPosition(int target, bool isForce)
	{
		_targetPosition = target;
		_previousPosition = _trackDolly.m_PathPosition;
		normalized_PreviousPosition = _Normalize(_previousPosition, _trackDolly.m_PositionUnits);
		_targetPosition = _path.StandardizeUnit(target, _trackDolly.m_PositionUnits);
		normalized_TargetPosition = _Normalize(target, _trackDolly.m_PositionUnits);
		float targetFov = ((target < cameraData.nodes.Count) ? cameraData.nodes[target].fov : _previousFOV);
		float targetDutch = ((target < cameraData.nodes.Count) ? ((float)cameraData.nodes[target].dutch) : _previousDutch);
		Vector3 targetOffset = ((target < cameraData.nodes.Count) ? cameraData.nodes[target].pathOffset : _previousPathOffset);
		Vector3 targetTrackedOffset = ((target < cameraData.nodes.Count) ? cameraData.nodes[target].TrackedObjectOffset : _previousTrackedObjectOffset);
		_ChangeNodeData(targetFov, targetDutch, targetOffset, targetTrackedOffset, isForce);
		if (!isForce)
		{
			LeanTween.value(_cameraGo, normalized_PreviousPosition, normalized_TargetPosition, positionTime).setEase(Speed).setOnUpdate(delegate(float pos)
			{
				float pathPosition = _UnNormalize(pos, _trackDolly.m_PositionUnits);
				_trackDolly.m_PathPosition = pathPosition;
			});
		}
		else
		{
			_trackDolly.m_PathPosition = target;
		}
	}

	public void ChangeSubCamera(int pageIndex, int target)
	{
		if (target == 0)
		{
			float targetFov = ((pageIndex < cameraData.nodes.Count) ? cameraData.nodes[pageIndex].fov : _previousFOV);
			float targetDutch = ((pageIndex < cameraData.nodes.Count) ? ((float)cameraData.nodes[pageIndex].dutch) : _previousDutch);
			Vector3 targetOffset = ((pageIndex < cameraData.nodes.Count) ? cameraData.nodes[pageIndex].pathOffset : _previousPathOffset);
			Vector3 targetTrackedOffset = ((pageIndex < cameraData.nodes.Count) ? cameraData.nodes[pageIndex].TrackedObjectOffset : _previousTrackedObjectOffset);
			_ChangeNodeData(targetFov, targetDutch, targetOffset, targetTrackedOffset, isForce: false);
			return;
		}
		foreach (HeroRaiseSubNode heroRaiseSubList in heroRaiseSubLists)
		{
			if (heroRaiseSubList.pageIndex == pageIndex && heroRaiseSubList.subCameraId == target)
			{
				float fov = heroRaiseSubList.fov;
				float targetDutch2 = heroRaiseSubList.dutch;
				Vector3 targetOffset2 = heroRaiseSubList.pathOffset + cameraData.nodes[target].pathOffset;
				Vector3 targetTrackedOffset2 = heroRaiseSubList.TrackedObjectOffset + cameraData.nodes[target].TrackedObjectOffset;
				_ChangeNodeData(fov, targetDutch2, targetOffset2, targetTrackedOffset2, isForce: false);
			}
			else
			{
				Debug.LogWarning("缺少子界面数据");
			}
		}
	}

	private void _ChangeNodeData(float targetFov, float targetDutch, Vector3 targetOffset, Vector3 targetTrackedOffset, bool isForce)
	{
		_previousFOV = virtualCamera.m_Lens.FieldOfView;
		_previousDutch = virtualCamera.m_Lens.Dutch;
		_previousPathOffset = _trackDolly.m_PathOffset;
		_previousTrackedObjectOffset = _composer.m_TrackedObjectOffset;
		if (!isForce)
		{
			LeanTween.value(_cameraGo, _previousFOV, targetFov, bodyTime).setEase(Speed).setOnUpdate(delegate(float fov)
			{
				virtualCamera.m_Lens.FieldOfView = fov;
			});
			LeanTween.value(_cameraGo, _previousDutch, targetDutch, bodyTime).setEase(Speed).setOnUpdate(delegate(float dutch)
			{
				virtualCamera.m_Lens.Dutch = dutch;
			});
			LeanTween.value(_cameraGo, _previousPathOffset, targetOffset, bodyTime).setEase(Speed).setOnUpdate(delegate(Vector3 offset)
			{
				_trackDolly.m_PathOffset = offset;
			});
			LeanTween.value(_cameraGo, _previousTrackedObjectOffset, targetTrackedOffset, bodyTime).setEase(Speed).setOnUpdate(delegate(Vector3 offset)
			{
				_composer.m_TrackedObjectOffset = offset;
			});
		}
		else
		{
			virtualCamera.m_Lens.FieldOfView = targetFov;
			virtualCamera.m_Lens.Dutch = targetDutch;
			_trackDolly.m_PathOffset = targetOffset;
			_composer.m_TrackedObjectOffset = targetTrackedOffset;
		}
	}

	private float _Normalize(float pos, CinemachinePathBase.PositionUnits unit)
	{
		pos = _path.StandardizeUnit(pos, unit);
		switch (unit)
		{
		case CinemachinePathBase.PositionUnits.PathUnits:
			pos = _path.FromPathNativeUnits(pos, CinemachinePathBase.PositionUnits.Normalized);
			break;
		case CinemachinePathBase.PositionUnits.Distance:
			pos /= _path.PathLength;
			break;
		}
		return pos;
	}

	private float _UnNormalize(float pos, CinemachinePathBase.PositionUnits unit)
	{
		pos = _path.StandardizeUnit(pos, unit);
		switch (unit)
		{
		case CinemachinePathBase.PositionUnits.PathUnits:
			pos = _path.ToNativePathUnits(pos, CinemachinePathBase.PositionUnits.Normalized);
			break;
		case CinemachinePathBase.PositionUnits.Distance:
			pos *= _path.PathLength;
			break;
		}
		return pos;
	}

	private float _GetPathLength(float startPos, float endPos)
	{
		if (startPos > _path.MaxUnit(CinemachinePathBase.PositionUnits.PathUnits))
		{
			return -1f;
		}
		float num = _UnNormalize(_Normalize(startPos, CinemachinePathBase.PositionUnits.PathUnits), CinemachinePathBase.PositionUnits.Distance);
		float num2 = _UnNormalize(_Normalize(endPos, CinemachinePathBase.PositionUnits.PathUnits), CinemachinePathBase.PositionUnits.Distance);
		return Mathf.Abs(num - num2);
	}
}
