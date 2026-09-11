using System;
using Cinemachine;
using UnityEngine;

public class QWCharacterCamera : QWCharacterBehavior
{
	private Camera mainCamera;

	private CinemachineFreeLook freelook;

	private CinemachineFreeLook storyLook;

	private GameObject storyLookAt;

	private float radius;

	private float initRadius;

	private float initHeight;

	private float initTopHeight;

	private float initRadiusTop;

	private float initBottomRadius;

	private float initBottomHeight;

	private float initRadiusMiddle;

	private float heightRatio;

	private float radiusRatio;

	private float bottom_radiusRatio;

	private float bottom_heightRatio;

	public float minRadius;

	public float maxRadius;

	public float stroyCameraFov = 20f;

	public float restoreCoolDown;

	public float restoreSpeed;

	private float lastBreakRestoreTimer;

	private bool curFrameHasInput;

	public LayerMask storyLayerMask;

	public float storyLookBias;

	[SerializeField]
	public QWSpringArmComponent springArm = new QWSpringArmComponent();

	private CinemachineFreeLook.Orbit top;

	private CinemachineFreeLook.Orbit middle;

	private CinemachineFreeLook.Orbit down;

	private Transform defaultCamPos => base.mAgent.CharacterBlackboard.defaultCamPos;

	public CinemachineFreeLook FreeLook => freelook;

	public CinemachineFreeLook StoryLook => storyLook;

	public Transform LookAtPoint => base.mAgent.CharacterBlackboard.head;

	public void SwitchToStroyCamera(bool active, Transform target = null, bool needCopyStory = false)
	{
		if (active)
		{
			Transform head = base.mAgent.CharacterBlackboard.head;
			Vector3 vector = head.position;
			if (target != null)
			{
				vector = head.position + (target.position - head.position).normalized * (Vector3.Distance(target.position, head.position) / 2f);
			}
			storyLook.transform.position = freelook.transform.position;
			storyLook.transform.rotation = freelook.transform.rotation;
			storyLook.m_XAxis.Value = freelook.m_XAxis.Value;
			storyLook.m_YAxis.Value = freelook.m_YAxis.Value;
			storyLookAt.transform.position = vector;
			storyLook.SetActive(bActive: true);
			storyLook.Priority = 20;
			if (target != null)
			{
				Vector3 vector2 = vector - storyLook.transform.position;
				if (Physics.Raycast(storyLook.transform.position, vector2.normalized, out var hitInfo, Vector3.Distance(vector, storyLook.transform.position), storyLayerMask))
				{
					storyLookAt.transform.position = hitInfo.point + vector2.normalized * storyLookBias;
				}
			}
		}
		else
		{
			storyLook.Priority = 1;
			storyLook.SetActive(bActive: false);
		}
	}

	public override void Initialize()
	{
		base.Initialize();
		InitFollowCamera();
		top = freelook.m_Orbits[0];
		middle = freelook.m_Orbits[1];
		down = freelook.m_Orbits[2];
		initRadiusTop = top.m_Radius;
		initRadiusMiddle = middle.m_Radius;
		initBottomRadius = down.m_Radius;
		initBottomHeight = middle.m_Height - down.m_Height;
		radius = middle.m_Radius;
		initRadius = radius;
		initTopHeight = top.m_Height - middle.m_Height;
		initHeight = middle.m_Height;
		heightRatio = initTopHeight / initRadiusMiddle;
		radiusRatio = initRadiusTop / initRadiusMiddle;
		bottom_heightRatio = initBottomHeight / initRadiusMiddle;
		bottom_radiusRatio = initBottomRadius / initRadiusMiddle;
		QWBlackboard blackboard = base.mAgent.Blackboard;
		blackboard.ActionHandler = (QWBlackboard.AgentActionHandler)Delegate.Combine(blackboard.ActionHandler, new QWBlackboard.AgentActionHandler(OnCameraAction));
		QWorldScene.Scene.cameraManager.RegisterCharacterCamera(this);
	}

	public void OnCameraAction(QWAgentAction a)
	{
		switch (a.Type)
		{
		case QWAgentAction.E_Type.TeleportCamera:
		{
			QWTeleportCameraAction qWTeleportCameraAction = a as QWTeleportCameraAction;
			springArm.ForceResetHandlePos(qWTeleportCameraAction.pos, qWTeleportCameraAction.rotation);
			freelook.ForceCameraPosition(defaultCamPos.position, defaultCamPos.rotation);
			freelook.m_XAxis.Value = -180f;
			freelook.m_YAxis.Value = 0.5f;
			freelook.transform.forward = defaultCamPos.forward;
			break;
		}
		case QWAgentAction.E_Type.Camera_LookAtTarget:
		{
			QWSetCameraLookAtTarget action = a as QWSetCameraLookAtTarget;
			ResetSpringArm(action);
			break;
		}
		case QWAgentAction.E_Type.Camera_Reset:
		{
			freelook.transform.forward = defaultCamPos.parent.forward;
			freelook.transform.position = defaultCamPos.position;
			QWorldCameraManager.Instance.MainCamera.transform.position = defaultCamPos.position;
			freelook.ForceCameraPosition(defaultCamPos.position, defaultCamPos.rotation);
			SetRadius(initRadius);
			Vector3 forward = base.transform.forward;
			Vector3 normalized = new Vector3(forward.x, 0f, forward.z).normalized;
			float value = Mathf.Atan2(normalized.x, normalized.z) * 57.29578f;
			freelook.m_XAxis.Value = value;
			break;
		}
		case QWAgentAction.E_Type.PostChangeCharacter:
			PostChangeCharacter();
			break;
		}
	}

	private void PostChangeCharacter()
	{
		springArm.Reset(LookAtPoint, LookAtPoint);
	}

	private void ResetSpringArm(QWSetCameraLookAtTarget action)
	{
		if (action.cameraFlag == QWCameraFlag.Furniture || action.cameraFlag == QWCameraFlag.Player)
		{
			if (action.lookAt == null)
			{
				freelook.Follow = springArm.handle;
				freelook.LookAt = springArm.handle;
			}
			else
			{
				freelook.Follow = action.lookAt;
				freelook.LookAt = action.lookAt;
			}
		}
	}

	protected void InitFollowCamera()
	{
		GameObject gameObject = Asset.InstantiateWithoutCache("QWWorld/Camera/QWCamera");
		GameObject gameObject2 = UnityEngine.Object.Instantiate(gameObject);
		gameObject.name = "FollowCamera";
		gameObject2.name = "StoryCamera";
		U3DUtil.Get<CinemachineBrain>(Camera.main.gameObject);
		freelook = gameObject.GetComponent<CinemachineFreeLook>();
		storyLook = gameObject2.GetComponent<CinemachineFreeLook>();
		storyLookAt = new GameObject("StroyLookAt");
		storyLook.Follow = storyLookAt.transform;
		storyLook.LookAt = storyLookAt.transform;
		storyLook.Priority = 1;
		storyLook.m_Lens.FieldOfView = stroyCameraFov;
		storyLook.m_Transitions.m_InheritPosition = true;
		springArm.Init(LookAtPoint, LookAtPoint, this);
		freelook.Follow = springArm.handle;
		freelook.LookAt = springArm.handle;
	}

	public override void UpdateBehavior()
	{
		base.UpdateBehavior();
		springArm?.Tick();
		UpdateDither();
		UpdateRestore();
	}

	private void UpdateRestore()
	{
		if (curFrameHasInput)
		{
			lastBreakRestoreTimer = Time.time;
			curFrameHasInput = false;
			return;
		}
		bool flag = (double)base.mAgent.CharacterBlackboard.inputMovement.Magnitude > 0.01;
		if (flag && !(Time.time - lastBreakRestoreTimer < restoreCoolDown) && !(radius >= maxRadius) && flag)
		{
			SetRadius(radius + restoreSpeed);
		}
	}

	public void UpdateDither()
	{
	}

	public void SetRotation(float x, float y, QWCameraFlag flag)
	{
		switch (flag)
		{
		case QWCameraFlag.Player:
		case QWCameraFlag.Furniture:
			freelook.m_YAxis.Value += y;
			freelook.m_XAxis.Value += x;
			break;
		case QWCameraFlag.Story:
			storyLook.m_YAxis.Value += y;
			storyLook.m_XAxis.Value += x;
			break;
		case QWCameraFlag.CustomCamera:
			break;
		}
	}

	public void SetScroll(float scroll, QWCameraFlag flag)
	{
		switch (flag)
		{
		case QWCameraFlag.Player:
		case QWCameraFlag.Furniture:
			if (Mathf.Abs(scroll) > 1E-05f)
			{
				curFrameHasInput = true;
				SetRadius(radius - scroll);
			}
			break;
		case QWCameraFlag.CustomCamera:
		case QWCameraFlag.Story:
			break;
		}
	}

	private void SetRadius(float mRadius)
	{
		mRadius = Mathf.Clamp(mRadius, minRadius, maxRadius);
		radius = mRadius;
		top.m_Height = initHeight + radius * heightRatio;
		top.m_Radius = radius * radiusRatio;
		middle.m_Radius = radius;
		down.m_Height = initHeight - radius * bottom_heightRatio;
		down.m_Radius = radius * bottom_radiusRatio;
		freelook.m_Orbits[0] = top;
		freelook.m_Orbits[1] = middle;
		freelook.m_Orbits[2] = down;
	}
}
