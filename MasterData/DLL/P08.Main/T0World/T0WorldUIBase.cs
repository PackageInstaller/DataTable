using ControllerExSpace;
using P08.Gamepad;
using Sirenix.OdinInspector;
using UnityEngine;

namespace T0World;

public class T0WorldUIBase : SerializedMonoBehaviour
{
	public QWJoystickController joystickController;

	public T0WorldUICamera uiCamera;

	protected CanvasGroup joystickCanvasGroup;

	public T0WorldBubblePool bubblePool;

	public RectTransform bubbleCanvas;

	public RectTransform bubbleFollowUINode;

	public RectTransform effectNode;

	public ControllerExCollection controller;

	protected TransparentGraphic graphic;

	protected T0ControlerStateEnum nowState;

	protected T0CaptureModeStateEnum nowCaptureModeState = T0CaptureModeStateEnum.normal;

	private ControllerEx playerControlStateController;

	private ControllerEx captureModeController;

	private ControllerEx lookStateController;

	private string normalViewStateName = "normalView_{0}";

	public T0ControlerStateEnum NowState
	{
		get
		{
			return nowState;
		}
		set
		{
			nowState = value;
		}
	}

	public T0CaptureModeStateEnum NowCaptureModeState => nowCaptureModeState;

	public bool IsHideUI
	{
		get
		{
			if (nowCaptureModeState != T0CaptureModeStateEnum.mainUIHide)
			{
				return nowCaptureModeState == T0CaptureModeStateEnum.empty;
			}
			return true;
		}
	}

	private string GetCaptureModeMainStateControllerName()
	{
		int t0SceneID = T0WorldScene.Scene.t0SceneID;
		if (t0SceneID > 1)
		{
			return string.Format(normalViewStateName, t0SceneID);
		}
		return "normalView";
	}

	protected virtual void InitController()
	{
		playerControlStateController = controller.GetController("playerControl");
		captureModeController = controller.GetController("captureMode");
		lookStateController = controller.GetController("lookBtnState");
	}

	public virtual void ChangeState(T0ControlerStateEnum state)
	{
		if (nowState != state)
		{
			if (nowState == T0ControlerStateEnum.half_lock)
			{
				T0WorldScene.Scene.player.SetHalfCamerShow(isShow: false);
			}
			nowState = state;
			switch (state)
			{
			case T0ControlerStateEnum.normal:
				playerControlStateController.SetSelectedState("free");
				break;
			case T0ControlerStateEnum.locked:
				playerControlStateController.SetSelectedState("lock");
				break;
			case T0ControlerStateEnum.half_lock:
				playerControlStateController.SetSelectedState("half_lock");
				break;
			case T0ControlerStateEnum.photo:
				playerControlStateController.SetSelectedState("photo");
				break;
			}
			T0WorldFreeLookCamera.Instance.enabled = state == T0ControlerStateEnum.free_look;
		}
	}

	public virtual void ChangePhotoViewMode(T0CaptureModeStateEnum state)
	{
		nowCaptureModeState = state;
		switch (state)
		{
		case T0CaptureModeStateEnum.photo:
			captureModeController.SetSelectedState("photoView");
			break;
		case T0CaptureModeStateEnum.empty:
			captureModeController.SetSelectedState("emptyView");
			break;
		case T0CaptureModeStateEnum.filter:
			captureModeController.SetSelectedState("filterView");
			break;
		case T0CaptureModeStateEnum.normal:
		{
			SetjoyStickShow(isShow: true);
			string captureModeMainStateControllerName = GetCaptureModeMainStateControllerName();
			captureModeController.SetSelectedState(captureModeMainStateControllerName);
			break;
		}
		case T0CaptureModeStateEnum.mainUIHide:
			SetjoyStickShow(isShow: false);
			captureModeController.SetSelectedState("hideMainView");
			break;
		}
		LuaHelper.CallFunction("T0WorldViewControllerModeChange", (int)state);
	}

	public virtual void ChangeLookState(bool isLook)
	{
		if (isLook)
		{
			lookStateController.SetSelectedState("on");
		}
		else
		{
			lookStateController.SetSelectedState("off");
		}
	}

	protected virtual void AddListener()
	{
	}

	protected virtual void RemoveListener()
	{
	}

	public virtual void SetSliderValue(float value)
	{
	}

	private void Awake()
	{
		InitController();
		graphic = base.transform.GetComponent<TransparentGraphic>();
		if (joystickController != null)
		{
			joystickController.Init(Vector3.zero, 0f, new T0StickControllerGameLogic());
		}
		if (uiCamera != null)
		{
			uiCamera.Init();
		}
		T0WorldScene t0WorldScene = NScene.GetCurrentScene() as T0WorldScene;
		if (t0WorldScene != null)
		{
			t0WorldScene.RegisterWorldUI(this);
		}
		joystickCanvasGroup = joystickController.GetComponent<CanvasGroup>();
		bubblePool = new T0WorldBubblePool();
		bubblePool.Init(bubbleCanvas, bubbleFollowUINode);
		InitData();
		ChangePhotoViewMode(T0CaptureModeStateEnum.normal);
		ChangeState(T0ControlerStateEnum.normal);
		AddListener();
	}

	private void InitData()
	{
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
	}

	protected void SetjoyStickShow(bool isShow)
	{
		if (isShow)
		{
			bool flag = GamepadManager.Instance.IsUsingJoystick();
			joystickCanvasGroup.alpha = ((!flag) ? 1 : 0);
		}
		else
		{
			joystickCanvasGroup.alpha = 0f;
		}
	}

	public bool IsLockRotate()
	{
		if (nowState == T0ControlerStateEnum.locked)
		{
			return false;
		}
		return true;
	}

	public void Dispose()
	{
		bubblePool.Dispose();
		bubblePool = null;
		RemoveListener();
	}
}
