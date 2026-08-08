using System.Collections.Generic;
using Cinemachine;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Pipelines.SimPipeline;

public class CameraCtrl : MonoBehaviour
{
	private CameraParamComponent cameraParam;

	private LockTargetCinemachine lockTargetCinemachine;

	private SimStickController stickController;

	private int PressFinger = -1;

	public float rotSpeed = 2f;

	private RectTransform areaRect;

	private Camera mainCamera;

	private BattleScene battleScene;

	public RectTransform buttonsArea;

	public bool isEnable = true;

	private PointerEventData eventData;

	private List<RaycastResult> listRaycastResult = new List<RaycastResult>();

	private void Start()
	{
		areaRect = base.transform as RectTransform;
		mainCamera = CanvasManager.Instance.uiCamera;
		eventData = new PointerEventData(EventSystem.current);
	}

	public void Update()
	{
		if (cameraParam == null)
		{
			battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene != null)
			{
				cameraParam = battleScene.virtualCameraParam;
				return;
			}
			CinemachineBrain component = Camera.main.gameObject.GetComponent<CinemachineBrain>();
			if (!(component == null) && component.ActiveVirtualCamera != null && component.ActiveVirtualCamera != null)
			{
				ICinemachineCamera cinemachineCamera = ((component.ActiveVirtualCamera.Name == "FollowCamera") ? component.ActiveVirtualCamera : null);
				cameraParam = (cinemachineCamera as CinemachineVirtualCamera).GetComponent<CameraParamComponent>();
			}
			return;
		}
		if (cameraParam != null && lockTargetCinemachine == null)
		{
			lockTargetCinemachine = cameraParam.lockTargetCinemachine;
		}
		if (stickController == null)
		{
			battleScene = NScene.GetCurrentScene() as BattleScene;
			if (!(battleScene != null))
			{
				return;
			}
			stickController = battleScene.battlePanelGameObject.transform.Find("Stick").GetComponent<SimStickController>();
		}
		if (!(buttonsArea == null) && !BattleScene.isPause && isEnable)
		{
			TouchRotate();
		}
	}

	public void TouchRotate()
	{
		Touch[] touches = Input.touches;
		if (PressFinger < 0)
		{
			for (int i = 0; i < touches.Length; i++)
			{
				Touch touch = touches[i];
				if (touch.phase == TouchPhase.Began && (stickController.validPosFunc == null || !stickController.validPosFunc(touch.position)) && !InButtonsArea(touch.position) && touch.fingerId != stickController.PressFinger && InArea(touch.position))
				{
					UpdateFunc(touch, touch.fingerId);
					break;
				}
			}
			return;
		}
		for (int j = 0; j < touches.Length; j++)
		{
			Touch touch2 = touches[j];
			if (PressFinger == touch2.fingerId && stickController.PressFinger != PressFinger)
			{
				if (!InArea(touch2.position))
				{
					UpdateFunc(touch2, -1);
				}
				else
				{
					UpdateFunc(touch2, PressFinger);
				}
				return;
			}
		}
		UpdateFunc(default(Touch), -1);
	}

	public void UpdateFunc(Touch touch, int fingerId)
	{
		PressFinger = fingerId;
		if (PressFinger != -1)
		{
			float num = touch.deltaPosition.x * rotSpeed / 5f;
			if (Mathf.Abs(num) > 0.0001f)
			{
				cameraParam.transposer.m_XAxis.m_InputAxisValue = num;
				lockTargetCinemachine.SetLoseTarget();
			}
			else
			{
				cameraParam.transposer.m_XAxis.m_InputAxisValue = 0f;
			}
		}
		else
		{
			cameraParam.transposer.m_XAxis.m_InputAxisValue = 0f;
		}
	}

	private void OnDisable()
	{
		if (cameraParam != null)
		{
			cameraParam.transposer.m_XAxis.m_InputAxisValue = 0f;
		}
	}

	private void OnEnable()
	{
	}

	private bool InButtonsArea(Vector3 pos)
	{
		if (null == areaRect)
		{
			return false;
		}
		return RectTransformUtility.RectangleContainsScreenPoint(buttonsArea, pos, mainCamera);
	}

	private bool InArea(Vector3 pos)
	{
		if (null == areaRect)
		{
			return false;
		}
		listRaycastResult.Clear();
		eventData.pressPosition = pos;
		eventData.position = pos;
		EventSystem current = EventSystem.current;
		if (current == null)
		{
			return false;
		}
		current.RaycastAll(eventData, listRaycastResult);
		if (listRaycastResult.Count > 0)
		{
			return false;
		}
		return RectTransformUtility.RectangleContainsScreenPoint(areaRect, pos, mainCamera);
	}
}
