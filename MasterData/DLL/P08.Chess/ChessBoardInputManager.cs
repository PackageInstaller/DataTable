using ChessBoard;
using UnityEngine;

public class ChessBoardInputManager : MonoBehaviour
{
	public float keyboardSpeed = 4f;

	public float mouseSpeed = 20f;

	public float touchMouseRate = 0.02f;

	public float scaleRate = -0.001f;

	public UIPassEvent uIPassEvent;

	public static ChessBoardInputManager _instance;

	private Camera mainCamera;

	public bool IsEnableInput = true;

	private float lastTouchDis = -1f;

	public static ChessBoardInputManager Instance => _instance;

	private void Awake()
	{
		_instance = this;
		if (mainCamera == null)
		{
			mainCamera = Camera.main;
		}
	}

	private void Update()
	{
		if (!IsEnableInput)
		{
			return;
		}
		if (Input.GetAxis("Mouse ScrollWheel") != 0f)
		{
			LuaHelper.CallFunction("OnChessBoardCameraZoomScale");
		}
		if (Input.touchCount == 2)
		{
			float num = Vector2.Distance(Input.touches[0].position, Input.touches[1].position);
			if (-1f == lastTouchDis)
			{
				lastTouchDis = num;
			}
			float num2 = num - lastTouchDis;
			lastTouchDis = num;
			num2 *= scaleRate;
			if (num2 != 0f)
			{
				ChessBoardCameraManager.Instance.AddYAxis(num2);
				LuaHelper.CallFunction("OnChessBoardCameraZoomScale");
			}
			if (uIPassEvent != null)
			{
				uIPassEvent.isPassClick = false;
			}
		}
		else
		{
			lastTouchDis = -1f;
			if (uIPassEvent != null)
			{
				uIPassEvent.isPassClick = true;
			}
		}
	}
}
