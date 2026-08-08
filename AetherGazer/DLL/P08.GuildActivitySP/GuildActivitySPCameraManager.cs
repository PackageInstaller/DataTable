using System;
using UnityEngine;
using UnityEngine.EventSystems;

public class GuildActivitySPCameraManager : MonoBehaviour
{
	private float _cameraMaxSize;

	private float _cameraMinSize;

	private GuildActivitySPInputManager _spInputManager;

	private Action<float> _onZoomByFingerHandler;

	private float _beginZoomSize;

	private Rect _boundary;

	private Vector3 _lastCameraPosition;

	private Vector3 _lastCameraEulerAngles;

	private GuildActivitySPWarFieldNode _tweeningTarget;

	public float PercentX
	{
		get
		{
			return (Camera.main.transform.position.x - _tweeningTarget.transform.position.x) / (Camera.main.orthographicSize * Camera.main.aspect);
		}
		set
		{
			Vector3 position = Camera.main.transform.position;
			position.x = value * Camera.main.orthographicSize * Camera.main.aspect + _tweeningTarget.transform.position.x;
			Camera.main.transform.position = position;
		}
	}

	public float PercentY
	{
		get
		{
			return (Camera.main.transform.position.y - _tweeningTarget.transform.position.y) / Camera.main.orthographicSize;
		}
		set
		{
			Vector3 position = Camera.main.transform.position;
			position.y = value * Camera.main.orthographicSize + _tweeningTarget.transform.position.y;
			Camera.main.transform.position = position;
		}
	}

	private void Awake()
	{
		if (Camera.main.gameObject.GetComponent<Physics2DRaycaster>() == null)
		{
			Camera.main.gameObject.AddComponent<Physics2DRaycaster>();
		}
		_spInputManager = GetComponent<GuildActivitySPInputManager>();
		GuildActivitySPInputManager spInputManager = _spInputManager;
		spInputManager.onZoomChange = (Action<int, float>)Delegate.Combine(spInputManager.onZoomChange, new Action<int, float>(OnZoomChange));
		GuildActivitySPInputManager spInputManager2 = _spInputManager;
		spInputManager2.onSingleFingerMove = (Action<Vector2>)Delegate.Combine(spInputManager2.onSingleFingerMove, new Action<Vector2>(OnSingleFingerMove));
	}

	public void SetBoundary(Rect boundary)
	{
		_boundary = boundary;
	}

	public void SetOnZoomByFingerHandler(Action<float> handler)
	{
		_onZoomByFingerHandler = handler;
	}

	private void OnZoomChange(int status, float delta)
	{
		if (status == GuildActivitySPInputManager.ZOOM_BEGIN)
		{
			_beginZoomSize = Camera.main.orthographicSize;
		}
		float v = _beginZoomSize - delta;
		v = v.clamp(_cameraMinSize, _cameraMaxSize);
		SetZoomOnMap(v);
		FixBoundary();
	}

	private void SetZoomOnMap(float size)
	{
		Camera.main.orthographicSize = size;
		float v = (_cameraMaxSize - size) / (_cameraMaxSize - _cameraMinSize);
		v = v.clamp01();
		_onZoomByFingerHandler?.Invoke(v);
	}

	private void OnSingleFingerMove(Vector2 deltaPos)
	{
		Vector3 position = Camera.main.transform.position;
		position.x -= deltaPos.x;
		position.y += deltaPos.y;
		Camera.main.transform.position = position;
		FixBoundary();
	}

	public void SetZoom(float value)
	{
		Camera.main.orthographicSize = _cameraMaxSize - (_cameraMaxSize - _cameraMinSize) * value;
		FixBoundary();
	}

	public void StartGame()
	{
		Camera.main.transform.position = new Vector3(0f, 0f, -10f);
		Camera.main.transform.eulerAngles = Vector3.zero;
		Camera.main.transform.localScale = Vector3.one;
		Camera.main.orthographic = true;
		Camera.main.orthographicSize = _cameraMaxSize;
	}

	public void OnNodeClick(GuildActivitySPWarFieldNode node)
	{
		MoveCameraToNode(node, _cameraMinSize);
	}

	public void MoveCameraToNode(GuildActivitySPWarFieldNode node, float finalOrthographicSize = -1f, float time = 0.2f, float offset = 0.2f, Action onComplete = null)
	{
		_tweeningTarget = node;
		if (Math.Abs(finalOrthographicSize - -1f) < 1E-05f)
		{
			finalOrthographicSize = Camera.main.orthographicSize;
		}
		float orthographicSize = Camera.main.orthographicSize;
		LeanTween.cancel(Camera.main.gameObject);
		LeanTween.value(Camera.main.gameObject, delegate(float f)
		{
			PercentX = f;
		}, PercentX, offset, time);
		LeanTween.value(Camera.main.gameObject, delegate(float f)
		{
			PercentY = f;
		}, PercentY, 0f, time);
		LeanTween.value(Camera.main.gameObject, orthographicSize, finalOrthographicSize, time).setOnUpdate(delegate(float value)
		{
			SetZoomOnMap(value);
			FixBoundary();
		}).setOnComplete((Action)delegate
		{
			_tweeningTarget = null;
			FixBoundary();
			onComplete?.Invoke();
		});
	}

	private void FixBoundary()
	{
		Camera.main.transform.position = GetFixedPos(Camera.main.transform.position);
	}

	private Vector3 GetFixedPos(Vector3 pos, float orthographicSize = -1f)
	{
		float num = Camera.main.orthographicSize;
		if (Math.Abs(orthographicSize - -1f) > 1E-05f)
		{
			num = orthographicSize;
		}
		float num2 = num * Camera.main.aspect;
		if (pos.x - num2 < _boundary.xMin)
		{
			pos.x = num2 + _boundary.xMin;
		}
		else if (pos.x + num2 > _boundary.xMax)
		{
			pos.x = _boundary.xMax - num2;
		}
		if (pos.y - num < _boundary.yMin)
		{
			pos.y = num + _boundary.yMin;
		}
		else if (pos.y + num > _boundary.yMax)
		{
			pos.y = _boundary.yMax - num;
		}
		return pos;
	}

	public void InitCameraSetting(int mapId)
	{
		GuildActivitySPWarFieldLevel[] componentsInChildren = GetComponentsInChildren<GuildActivitySPWarFieldLevel>();
		GuildActivitySPWarFieldLevel guildActivitySPWarFieldLevel = null;
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			if (componentsInChildren[i].map_id == mapId)
			{
				guildActivitySPWarFieldLevel = componentsInChildren[i];
				break;
			}
		}
		SpriteRenderer component = guildActivitySPWarFieldLevel.GetComponent<SpriteRenderer>();
		Texture2D texture = component.sprite.texture;
		Vector2 vector = new Vector2(texture.width, texture.height) / component.sprite.pixelsPerUnit;
		double val = vector.y / 2f;
		double num = vector.x / 2f;
		_cameraMaxSize = (float)Math.Min(val, num / (double)Camera.main.aspect);
		_cameraMinSize = _cameraMaxSize / 3.5f;
		Rect boundary = new Rect((0f - vector.x) / 2f, (0f - vector.y) / 2f, vector.x, vector.y);
		SetBoundary(boundary);
	}

	public void SetOnWarField(bool onWarField)
	{
		if (onWarField)
		{
			Camera.main.orthographic = true;
			if (_lastCameraPosition != Vector3.zero)
			{
				Camera.main.transform.position = _lastCameraPosition;
				Camera.main.transform.eulerAngles = _lastCameraEulerAngles;
			}
		}
		else
		{
			_lastCameraPosition = Camera.main.transform.position;
			_lastCameraEulerAngles = Camera.main.transform.eulerAngles;
			Camera.main.orthographic = false;
		}
	}

	public float GetCameraMinSize()
	{
		return _cameraMinSize;
	}

	private void OnDestroy()
	{
		if (Camera.main != null && Camera.main.gameObject != null)
		{
			Physics2DRaycaster component = Camera.main.gameObject.GetComponent<Physics2DRaycaster>();
			if (component != null)
			{
				UnityEngine.Object.Destroy(component);
			}
		}
	}
}
