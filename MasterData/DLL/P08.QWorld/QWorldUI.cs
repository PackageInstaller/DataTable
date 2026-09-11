using ControllerExSpace;
using LuaInterface;
using P08.Gamepad;
using UnityEngine;
using UnityEngine.EventSystems;

public class QWorldUI : MonoBehaviour
{
	[NoToLua]
	public QWJoystickController joystickController;

	[NoToLua]
	public QWUICamera uiCamera;

	public RectTransform bubbleCanvas;

	[NoToLua]
	public EventTriggerListener doggleBtn;

	[NoToLua]
	public ControllerExCollection doggleController;

	[NoToLua]
	private CanvasGroup joystickCanvasGroup;

	[NoToLua]
	private CanvasGroup dogeCanvasGroup;

	private void Awake()
	{
		if (joystickController != null)
		{
			joystickController.Init(Vector3.zero, 0f, new QWStickControllerGameLogic());
		}
		if (uiCamera != null)
		{
			uiCamera.Init();
		}
		QWorldScene qWorldScene = NScene.GetCurrentScene() as QWorldScene;
		if (qWorldScene != null)
		{
			qWorldScene.RegisterWorldUI(this);
		}
		doggleBtn.onPointerDown = OnPointerDown;
		joystickCanvasGroup = joystickController.GetComponent<CanvasGroup>();
		dogeCanvasGroup = doggleBtn.GetComponent<CanvasGroup>();
		ChangeDoggleState(isInRush: true, isInFastRush: false);
	}

	private void OnEnable()
	{
		GamepadManager.Instance.OnChangeInputDevice -= ShowCharactorCtrl;
		GamepadManager.Instance.OnChangeInputDevice += ShowCharactorCtrl;
	}

	private void OnDisable()
	{
		GamepadManager.Instance.OnChangeInputDevice -= ShowCharactorCtrl;
	}

	private void ShowCharactorCtrl(En_GamepadType inputGamedType)
	{
		bool flag = GamepadManager.Instance.IsUsingJoystick();
		joystickCanvasGroup.alpha = ((!flag) ? 1 : 0);
		dogeCanvasGroup.alpha = ((!flag) ? 1 : 0);
	}

	[NoToLua]
	public void ChangeDoggleState(bool isInRush, bool isInFastRush)
	{
		if (isInRush)
		{
			if (isInFastRush)
			{
				doggleController.GetController("dogebtn").SetSelectedState("fastRush");
			}
			else
			{
				doggleController.GetController("dogebtn").SetSelectedState("rush");
			}
		}
		else
		{
			doggleController.GetController("dogebtn").SetSelectedState("walk");
		}
	}

	private void OnPointerDown(GameObject go, PointerEventData e)
	{
		QWorldScene qWorldScene = NScene.GetCurrentScene() as QWorldScene;
		if ((bool)qWorldScene.Agent)
		{
			if (qWorldScene.Agent.GetIsUseGamePad())
			{
				qWorldScene.Agent.ChangeFastRush();
			}
			else if (qWorldScene.Agent.GetIsInRush())
			{
				qWorldScene.Agent.ChangeFastRush();
			}
		}
	}

	public void SetCameraControlActive(bool active)
	{
		uiCamera.gameObject.SetActive(active);
	}
}
