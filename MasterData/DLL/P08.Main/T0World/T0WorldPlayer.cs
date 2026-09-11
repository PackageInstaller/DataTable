using System;
using Cinemachine;
using UnityEngine;

namespace T0World;

public class T0WorldPlayer : MonoBehaviour
{
	private CharacterController mCharacterController;

	private CinemachineVirtualCamera playerLook;

	public Vector3 inputDirection;

	public Vector2 dragDelta;

	[SerializeField]
	public float speed = 2f;

	public Transform slowFollowNode;

	private PlayerSlowFollow slowScript;

	private float ybeginPosValue;

	private Transform cameraNode;

	[SerializeField]
	public T0SpringArmComponent springArm = new T0SpringArmComponent();

	public T0WorldPlayerCollision playerCollision;

	public bool enableCollisionTest;

	private float baseXEulerAngle;

	private float baseYEulerAngle;

	private float nowHalfLockAngleX;

	private float nowHalfLockAngleY;

	public CinemachineVirtualCamera halfLockCamera;

	private float halfSinValue;

	private float halfCosValue;

	public void UpdateCollisionTest()
	{
		if (enableCollisionTest)
		{
			float buttomOffset = 0f;
			float topOffset = 0f;
			playerCollision?.ComputePenetrationIter(5, buttomOffset, topOffset);
		}
	}

	private void Awake()
	{
		InitFollowCamera();
		InitFollowNode();
		InitBlackBoard();
		if (mCharacterController == null)
		{
			mCharacterController = GetComponent<CharacterController>();
		}
		halfLockCamera.transform.SetParent(T0WorldScene.Scene.T0EntityContent);
	}

	public void ExitHalfLockMode()
	{
		Vector3 pos = new Vector3(halfLockCamera.transform.position.x, base.transform.position.y, halfLockCamera.transform.position.z);
		SetPosAndRot(pos, halfLockCamera.transform.eulerAngles);
	}

	public void SetHalfCamerShow(bool isShow)
	{
		if (halfLockCamera != null)
		{
			halfLockCamera.gameObject.SetActive(isShow);
		}
	}

	public void SetHalfLockData(CinemachineVirtualCamera halfLockCamerData)
	{
		if (!halfLockCamera.gameObject.activeSelf)
		{
			halfLockCamera.transform.position = halfLockCamerData.transform.position;
			halfLockCamera.transform.rotation = halfLockCamerData.transform.rotation;
			halfLockCamera.m_Lens.FieldOfView = halfLockCamerData.m_Lens.FieldOfView;
			halfLockCamera.m_Lens.Dutch = halfLockCamerData.m_Lens.Dutch;
			baseXEulerAngle = NormalizeAngle(halfLockCamera.transform.eulerAngles.x);
			baseYEulerAngle = NormalizeAngle(halfLockCamera.transform.eulerAngles.y);
			halfSinValue = Mathf.Sin(halfLockCamera.m_Lens.Dutch * (MathF.PI / 180f));
			halfCosValue = Mathf.Cos(halfLockCamera.m_Lens.Dutch * (MathF.PI / 180f));
			nowHalfLockAngleX = baseXEulerAngle;
			nowHalfLockAngleY = baseYEulerAngle;
			SetHalfCamerShow(isShow: true);
		}
	}

	public void SetPosAndRot(Vector3 pos, Vector3 rot)
	{
		base.transform.position = pos;
		base.transform.rotation = Quaternion.Euler(new Vector3(0f, rot.y, 0f));
		playerLook.transform.rotation = Quaternion.Euler(rot);
		ybeginPosValue = base.transform.position.y;
		springArm.ForceResetHandlePos(cameraNode.position, cameraNode.rotation);
	}

	private void Update()
	{
		if (!(T0WorldScene.Scene != null) || !(T0WorldScene.Scene.mWorldUI != null) || T0WorldScene.Scene.mWorldUI.NowState == T0ControlerStateEnum.normal)
		{
			Vector2 vector = new Vector2(inputDirection.x, inputDirection.z);
			vector.Normalize();
			Vector3 vector2 = base.transform.forward * vector.y + base.transform.right * vector.x;
			mCharacterController.Move(vector2 * Time.deltaTime * speed);
			if (Mathf.Abs(base.transform.position.y - ybeginPosValue) > 0.01f)
			{
				base.transform.position = new Vector3(base.transform.position.x, ybeginPosValue, base.transform.position.z);
			}
			springArm?.Tick();
		}
	}

	private void InitFollowNode()
	{
		GameObject gameObject = Asset.InstantiateWithoutCache("T0World/Common/T0PlayerSlowFllow");
		slowFollowNode = gameObject.transform;
		slowFollowNode.gameObject.name = "playerSlowFollowNode";
		slowFollowNode.SetParent(T0WorldScene.Scene.T0EntityContent);
		slowScript = slowFollowNode.GetComponent<PlayerSlowFollow>();
		SetDefaultSlowFlowTarget();
	}

	public void SetSlowFlowTarget(Transform targetNode)
	{
		slowScript.SetFollowTarget(targetNode);
	}

	public void SetDefaultSlowFlowTarget()
	{
		slowScript.SetFollowTarget(playerLook.Follow);
	}

	private void InitFollowCamera()
	{
		GameObject gameObject = Asset.InstantiateWithoutCache(T0WorldTools.PlayerCameraAssetPath);
		gameObject.transform.rotation = base.transform.rotation;
		gameObject.name = "T0WorldPlayerCamera";
		gameObject.transform.SetParent(T0WorldScene.Scene.T0EntityContent);
		cameraNode = base.transform.Find("CameraNode");
		playerLook = gameObject.GetComponent<CinemachineVirtualCamera>();
		playerLook.LookAt = base.transform;
		springArm.Init(cameraNode, cameraNode);
		playerLook.Follow = springArm.handle;
		springArm.handle.SetParent(T0WorldScene.Scene.T0EntityContent);
	}

	private void InitBlackBoard()
	{
		if (!base.gameObject.TryGetComponent<T0WorldBlackboard>(out var component))
		{
			component = base.gameObject.AddComponent<T0WorldBlackboard>();
		}
		component.InitBlackboard();
		component.EntityID = -1;
	}

	private float NormalizeAngle(float angle)
	{
		angle %= 360f;
		if (angle > 180f)
		{
			angle -= 360f;
		}
		if (angle < -180f)
		{
			angle += 360f;
		}
		return angle;
	}

	private float ClampAngle(float angle, float min, float max)
	{
		if (angle < -180f)
		{
			angle += 360f;
		}
		if (angle > 180f)
		{
			angle -= 360f;
		}
		return Mathf.Clamp(angle, min, max);
	}

	public void SetRotation(float x, float y)
	{
		dragDelta = new Vector2(x, y);
		if (T0WorldScene.Scene.mWorldUI.NowState == T0ControlerStateEnum.half_lock)
		{
			nowHalfLockAngleY = nowHalfLockAngleY + x * halfCosValue + y * 30f * halfSinValue;
			nowHalfLockAngleX = nowHalfLockAngleX + y * 30f * halfCosValue - x * halfSinValue;
			nowHalfLockAngleY = Mathf.Clamp(nowHalfLockAngleY, baseYEulerAngle - 60f, baseYEulerAngle + 60f);
			nowHalfLockAngleX = Mathf.Clamp(nowHalfLockAngleX, baseXEulerAngle - 45f, baseXEulerAngle + 45f);
			halfLockCamera.transform.rotation = Quaternion.Euler(new Vector3(nowHalfLockAngleX, nowHalfLockAngleY, 0f));
		}
		else if (T0WorldScene.Scene.mWorldUI.NowState != T0ControlerStateEnum.locked)
		{
			base.transform.Rotate(Vector3.up, x);
			Vector3 eulerAngles = playerLook.transform.eulerAngles;
			float y2 = eulerAngles.y + x;
			float num = eulerAngles.x + y * 30f;
			if (num > 180f)
			{
				num -= 360f;
			}
			num = Mathf.Clamp(num, -60f, 60f);
			playerLook.transform.eulerAngles = new Vector3(num, y2, 0f);
		}
	}

	internal void SetDir(Vector3 dir)
	{
		playerLook.transform.forward = dir;
	}

	public void SetScroll(float scroll)
	{
		if (Mathf.Abs(scroll) > 1E-05f)
		{
			SetRadius(scroll);
		}
		inputDirection.y = ((Mathf.Abs(scroll) > 1E-05f) ? Mathf.Sign(scroll) : 0f);
	}

	private void SetRadius(float mRadius)
	{
	}
}
