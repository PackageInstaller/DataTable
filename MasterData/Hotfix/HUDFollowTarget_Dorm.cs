using UnityEngine;

public class HUDFollowTarget_Dorm : MonoBehaviour
{
	private Transform _target;

	private RectTransform _transform;

	private Vector3 _positionOffset;

	private RectTransform _canvasRect;

	private bool _bUpdateHudPos = true;

	public void SetFollowTarget(Transform target, Vector3 positionOffset)
	{
		_target = target;
		_positionOffset = positionOffset;
		if (_transform == null)
		{
			_transform = GetComponent<RectTransform>();
		}
		if (_canvasRect == null)
		{
			_canvasRect = _transform.parent.GetComponent<RectTransform>();
		}
		UpdateHudPos();
	}

	public void EnableUpdateHudPos(bool bVisible, bool bEnable)
	{
		_bUpdateHudPos = bEnable;
		if (bVisible)
		{
			UpdateHudPos();
		}
	}

	public void LateUpdate()
	{
		if (_bUpdateHudPos)
		{
			UpdateHudPos();
		}
	}

	public void UpdateHudPos()
	{
		if (!(null == _target) && !(_transform == null) && !(_canvasRect == null))
		{
			Vector3 vector = MonoSingleton<GameCameraStackManager>.Instance.mainCamera.WorldToScreenPoint(_target.position + _positionOffset);
			if (RectTransformUtility.ScreenPointToLocalPointInRectangle(_canvasRect, new Vector2(vector.x, vector.y), MonoSingleton<GameCameraStackManager>.Instance.uiCamera, out var localPoint))
			{
				_transform.anchoredPosition = localPoint;
			}
		}
	}
}
