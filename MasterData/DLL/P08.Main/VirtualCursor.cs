using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Pipelines.SimPipeline;

public class VirtualCursor : MonoBehaviour
{
	[SerializeField]
	private string click = "Submit";

	private const string parent = "UICamera/Canvas/UIScreenTap";

	private const string prefab = "UISpace/Widget/System/UIScreenTap/ScreenTapUI.prefab";

	private const string instName = "ScreenTapUI";

	[SerializeField]
	private RectTransform virtualCursor;

	public float moveSpeed = 1000f;

	private ExStandaloneInputModule exStandaloneInput;

	private Camera mainCamera;

	private Vector2 curPos;

	private bool curState;

	private static VirtualCursor virtualCursorCom;

	private void OnEnable()
	{
		if (exStandaloneInput == null)
		{
			exStandaloneInput = EventSystem.current.currentInputModule as ExStandaloneInputModule;
		}
		if (mainCamera == null)
		{
			mainCamera = CanvasManager.Instance.uiCamera;
		}
		if (virtualCursorCom != null)
		{
			Debug.LogError("重复赋值");
		}
		virtualCursorCom = this;
	}

	private void OnDisable()
	{
		virtualCursorCom = null;
	}

	public static void StartVirtualCursor()
	{
		GameObject gameObject = GameObject.Find("UICamera/Canvas/UIScreenTap");
		if ((bool)gameObject)
		{
			Transform transform = gameObject.transform.Find("ScreenTapUI");
			if (transform == null)
			{
				Asset.InstantiateWithoutCache("UISpace/Widget/System/UIScreenTap/ScreenTapUI.prefab", gameObject.transform).name = "ScreenTapUI";
			}
			else
			{
				transform.gameObject.SetActive(value: true);
			}
		}
	}

	public static void StopVirtualCursor()
	{
		GameObject gameObject = GameObject.Find("UICamera/Canvas/UIScreenTap");
		if ((bool)gameObject)
		{
			Transform transform = gameObject.transform.Find("ScreenTapUI");
			if (transform != null)
			{
				transform.gameObject.SetActive(value: false);
			}
		}
	}

	private void Show(bool flag)
	{
		if (curState != flag)
		{
			if (virtualCursor.gameObject.activeSelf != flag)
			{
				virtualCursor.gameObject.SetActive(flag);
			}
			EventSystem.current.sendNavigationEvents = !flag;
			if (flag)
			{
				GamepadManager.Instance.DisableListenerEnable();
			}
			else
			{
				GamepadManager.Instance.GetLastInputValue();
			}
			virtualCursor.anchoredPosition = Vector2.zero;
			curState = flag;
			curPos = new Vector2(Screen.width / 2, Screen.height / 2);
		}
	}

	private void Update()
	{
		if (virtualCursor == null || exStandaloneInput == null || mainCamera == null)
		{
			if (exStandaloneInput == null)
			{
				exStandaloneInput = EventSystem.current.currentInputModule as ExStandaloneInputModule;
			}
			if (mainCamera == null)
			{
				mainCamera = CanvasManager.Instance.uiCamera;
			}
			return;
		}
		if (Input.touchCount > 0 || Input.GetMouseButton(0))
		{
			Show(flag: false);
			return;
		}
		float axis = Input.GetAxis("Horizontal");
		float axis2 = Input.GetAxis("Vertical");
		if (!Mathf.Approximately(axis, 0f) || !Mathf.Approximately(axis2, 0f))
		{
			Show(flag: true);
			curPos += new Vector2(axis * moveSpeed, axis2 * moveSpeed) * Time.deltaTime;
			curPos.x = Mathf.Clamp(curPos.x, 0f, Screen.width);
			curPos.y = Mathf.Clamp(curPos.y, 0f, Screen.height);
			RectTransformUtility.ScreenPointToLocalPointInRectangle(base.transform as RectTransform, curPos, mainCamera, out var localPoint);
			virtualCursor.anchoredPosition = localPoint;
			EventSystem.current.sendNavigationEvents = false;
		}
		if (Input.GetButtonDown(click))
		{
			exStandaloneInput.ClickAt(curPos, TouchPhase.Began);
		}
		else if (Input.GetButton(click))
		{
			exStandaloneInput.ClickAt(curPos, TouchPhase.Moved);
		}
		else if (Input.GetButtonUp(click))
		{
			exStandaloneInput.ClickAt(curPos, TouchPhase.Ended);
		}
	}

	public static bool IsActive()
	{
		if (virtualCursorCom == null || virtualCursorCom.exStandaloneInput == null || virtualCursorCom.mainCamera == null || virtualCursorCom.virtualCursor == null)
		{
			return false;
		}
		return virtualCursorCom.curState;
	}

	public static void ClickAt(RectTransform transform, TouchPhase press)
	{
		if (IsActive() && !(transform == null))
		{
			Vector2 vector = (virtualCursorCom.virtualCursor.pivot - transform.pivot) * transform.sizeDelta;
			Vector2 vector2 = RectTransformUtility.WorldToScreenPoint(virtualCursorCom.mainCamera, transform.position) + vector;
			if (vector2.x > 0f && vector2.x < (float)Screen.width && vector2.y > 0f && vector2.y < (float)Screen.height)
			{
				virtualCursorCom.curPos = vector2;
				virtualCursorCom.virtualCursor.position = transform.position;
				virtualCursorCom.virtualCursor.anchoredPosition += vector;
			}
			virtualCursorCom.exStandaloneInput.ClickAt(virtualCursorCom.curPos, press);
		}
	}
}
