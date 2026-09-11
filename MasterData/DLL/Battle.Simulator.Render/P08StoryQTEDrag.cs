using System;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Pipelines.SimPipeline;

public class P08StoryQTEDrag : P08StoryQTEUI, IBeginDragHandler, IEventSystemHandler, IDragHandler, IEndDragHandler
{
	private float _currentTime;

	private float _timeLimit;

	private Vector2 _targetDir;

	private Action _successAction;

	private Action _failedAction;

	private bool _inited;

	private bool _isPress;

	private bool _finished;

	private Vector2 _pressStartPoint;

	private Vector2 _originalPoint;

	private RectTransform _root_rect;

	private Camera _ui_cam;

	private RectTransform _btn_rect;

	private GameObject _daiji_go;

	private GameObject _huadong_go;

	private GameObject _dianji_go;

	private Animation _close_anim;

	private Animation _daiji_anim;

	public void Init(float timelimit, Vector2 targetDir, Action successAction, Action failedAction)
	{
		_currentTime = 0f;
		_timeLimit = timelimit;
		_successAction = successAction;
		_failedAction = failedAction;
		_targetDir = targetDir;
		_inited = true;
		_isPress = false;
		_finished = false;
		GameObject goFromCfg = GetGoFromCfg("_text");
		if (goFromCfg != null)
		{
			goFromCfg.transform.rotation = Quaternion.identity;
		}
		_daiji_go = GetGoFromCfg("_daiji");
		_huadong_go = GetGoFromCfg("_huadong");
		_dianji_go = GetGoFromCfg("_dianji");
		_btn_rect = GetGoFromCfg("_btn").transform as RectTransform;
		_close_anim = base.gameObject.GetComponent<Animation>();
		_daiji_anim = GetGoFromCfg("_daiji_anim").GetComponent<Animation>();
		_root_rect = GetGoFromCfg("_root").transform as RectTransform;
		_ui_cam = CanvasManager.Instance.uiCamera;
		_daiji_go.SetActive(value: true);
		_huadong_go.SetActive(value: false);
		_dianji_go.SetActive(value: false);
		_daiji_anim.enabled = true;
		float angle = UnityUtils.AngleAroundAxis(Vector3.left, targetDir, Vector3.forward);
		_root_rect.rotation = Quaternion.AngleAxis(angle, Vector3.forward);
		_btn_rect.rotation = Quaternion.AngleAxis(angle, Vector3.forward);
	}

	private void Update()
	{
		if (_inited && !_finished)
		{
			_currentTime += Time.deltaTime;
			if (_currentTime > _timeLimit)
			{
				FailedCall();
			}
		}
	}

	public void SuccessCall()
	{
		if (_successAction != null)
		{
			_successAction();
		}
		_successAction = null;
		_failedAction = null;
		_inited = false;
		_finished = true;
	}

	public void FailedCall()
	{
		if (_failedAction != null)
		{
			_failedAction();
		}
		_finished = true;
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		if (_inited)
		{
			_daiji_go.SetActive(value: false);
			_huadong_go.SetActive(value: true);
			_dianji_go.SetActive(value: false);
			_daiji_anim.enabled = false;
			_pressStartPoint = eventData.position;
			_isPress = true;
			_originalPoint = _ui_cam.WorldToScreenPoint(_btn_rect.position);
			_daiji_go.SetActive(value: false);
		}
	}

	public void OnDrag(PointerEventData eventData)
	{
		Vector2 vector = Vector3.Project(eventData.position - _pressStartPoint, _targetDir);
		if (Vector2.Dot(vector, _targetDir) < 0f)
		{
			vector = Vector2.zero;
		}
		Vector2 screenPoint = _originalPoint + Vector2.ClampMagnitude(vector, _targetDir.magnitude);
		Vector2 localPoint = Vector2.zero;
		RectTransformUtility.ScreenPointToLocalPointInRectangle(base.transform as RectTransform, screenPoint, _ui_cam, out localPoint);
		_btn_rect.anchoredPosition = localPoint;
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		if (_inited)
		{
			_daiji_go.SetActive(value: false);
			_huadong_go.SetActive(value: false);
			_dianji_go.SetActive(value: true);
			_daiji_anim.enabled = true;
			_isPress = false;
			Vector2 lhs = Vector3.Project(eventData.position - _pressStartPoint, _targetDir);
			if (Vector2.Dot(lhs, _targetDir) < 0f)
			{
				lhs = Vector2.zero;
			}
			if (lhs.magnitude >= _targetDir.magnitude * 0.85f)
			{
				SuccessCall();
			}
			else
			{
				Vector2 localPoint = Vector2.zero;
				RectTransformUtility.ScreenPointToLocalPointInRectangle(base.transform as RectTransform, _originalPoint, _ui_cam, out localPoint);
				_btn_rect.anchoredPosition = localPoint;
			}
			_daiji_go.SetActive(value: true);
		}
	}

	public override void Dispose(float delay)
	{
		base.Dispose(delay);
		_close_anim?.Play();
		_successAction = null;
		_failedAction = null;
	}
}
