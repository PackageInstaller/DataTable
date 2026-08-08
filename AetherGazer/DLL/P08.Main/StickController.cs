using System;
using LuaInterface;
using UnityEngine;

public class StickController : MonoBehaviour
{
	private Camera uicamera;

	public int PressFinger = -1;

	public bool keyBoard = true;

	public Canvas canvas;

	public RectTransform thumbPosition;

	public RectTransform areaRect;

	public Vector3 lastVector = Vector3.zero;

	public int PreMoveDirection = int.MaxValue;

	public int ConfirmDirSndFrame;

	public int FixtimeDirSndFrame;

	private Action<Vector3, int> updateFunc;

	private Func<Vector3, bool> validPosFunc;

	private void Awake()
	{
		uicamera = GameObject.Find("UICamera").GetComponent<Camera>();
		canvas = GameObject.Find("Canvas").GetComponent<Canvas>();
	}

	private void Start()
	{
	}

	private void Update()
	{
		if (updateFunc != null)
		{
			UpdateTouchPos(updateFunc);
		}
	}

	private Vector3 TransformPos(Vector3 pressPos)
	{
		Vector2 localPoint = default(Vector2);
		RectTransformUtility.ScreenPointToLocalPointInRectangle(base.transform as RectTransform, new Vector2(pressPos.x, pressPos.y), null, out localPoint);
		return new Vector3(localPoint.x, localPoint.y);
	}

	private void UpdateTouchPos(Action<Vector3, int> updateFunc)
	{
		bool flag = false;
		float x = 0f;
		float y = 0f;
		if (keyBoard)
		{
			if (Input.GetKey(KeyCode.A))
			{
				flag = true;
				x = -1f;
			}
			else if (Input.GetKey(KeyCode.D))
			{
				flag = true;
				x = 1f;
			}
			if (Input.GetKey(KeyCode.W))
			{
				flag = true;
				y = 1f;
			}
			else if (Input.GetKey(KeyCode.S))
			{
				flag = true;
				y = -1f;
			}
			if (Input.GetAxis("LeftJoystickX") == -1f)
			{
				flag = true;
				x = -1f;
			}
			else if (Input.GetAxis("LeftJoystickX") == 1f)
			{
				flag = true;
				x = 1f;
			}
			if (Input.GetAxis("LeftJoystickY") == 1f)
			{
				flag = true;
				y = -1f;
			}
			else if (Input.GetAxis("LeftJoystickY") == -1f)
			{
				flag = true;
				y = 1f;
			}
		}
		if (flag)
		{
			Vector3 normalized = new Vector3(x, y, 0f).normalized;
			updateFunc(normalized, -2);
			return;
		}
		if (!Input.GetMouseButton(0))
		{
			updateFunc(Vector3.zero, -1);
			return;
		}
		Vector3 mousePosition = Input.mousePosition;
		if (PressFinger < 0 && !validPosFunc(mousePosition))
		{
			updateFunc(Vector3.zero, -1);
		}
		else
		{
			updateFunc(TransformPos(mousePosition), 1);
		}
	}

	public void SetStickFunc(LuaFunction updateFunc, LuaFunction validPosFunc)
	{
		this.updateFunc = delegate(Vector3 pressPos, int fingerId)
		{
			updateFunc.Call(pressPos, fingerId);
		};
		this.validPosFunc = (Vector3 pressPos) => (bool)validPosFunc.LazyCall(pressPos)[0];
	}

	public void SetStickModule(Action<Vector3, int> updateFunc, Func<Vector3, bool> validPosFunc)
	{
		this.updateFunc = updateFunc;
		this.validPosFunc = validPosFunc;
	}

	public void ClearStickFunc()
	{
		updateFunc = null;
		validPosFunc = null;
	}

	private void OnDestroy()
	{
		ClearStickFunc();
	}
}
