using Cinemachine;
using T0World;
using UnityEngine;

public class T0WorldFreeLookCamera : MonoBehaviour
{
	public float sensitive = 0.1f;

	public float speed = 2f;

	private CharacterController freeMoveController;

	private CinemachineVirtualCamera freeLook;

	private CinemachinePOV currentPOV;

	private const float FREE_LOOK_CAM_RADIUS = 0.15f;

	public const string FREE_CAM_NAME = "T0WorldFreeCamera";

	private static readonly RaycastHit[] hitResultCache = new RaycastHit[4];

	public T0WorldPlayer Player
	{
		get
		{
			if (!T0WorldScene.Scene)
			{
				return null;
			}
			return T0WorldScene.Scene.player;
		}
	}

	public Vector3 inputDirection => Player?.inputDirection ?? Vector3.zero;

	private Vector2 DragSensitiveFactor => new Vector2(sensitive / 5f, (0f - sensitive) / 0.06f);

	public Vector2 dragDelta
	{
		get
		{
			if (!Player)
			{
				return Vector3.zero;
			}
			return Vector2.Scale(Player.dragDelta, DragSensitiveFactor);
		}
	}

	public CinemachinePOV CurrentPOV
	{
		get
		{
			if (currentPOV == null)
			{
				if (freeLook == null)
				{
					return null;
				}
				currentPOV = freeLook.GetCinemachineComponent<CinemachinePOV>();
			}
			return currentPOV;
		}
	}

	public static T0WorldFreeLookCamera Instance { get; private set; }

	public float FreeLookHeightCeil { get; private set; }

	public float FreeLookHeightFloor { get; private set; }

	private CinemachineVirtualCamera PrepareInitCamera(string name, out GameObject camera)
	{
		camera = Asset.InstantiateWithoutCache(T0WorldTools.PlayerCameraAssetPath);
		camera.transform.rotation = base.transform.rotation;
		camera.name = name;
		camera.transform.SetParent(T0WorldScene.Scene.T0EntityContent);
		CinemachineVirtualCamera component = camera.GetComponent<CinemachineVirtualCamera>();
		camera.SetActive(value: false);
		return component;
	}

	private void InitFreeLookCamera()
	{
		freeMoveController = base.gameObject.AddComponent<CharacterController>();
		freeMoveController.radius = 0.15f;
		freeMoveController.height = 0f;
		freeLook = PrepareInitCamera("T0WorldFreeCamera", out var _);
		freeLook.Follow = freeMoveController.transform;
		if (freeLook.GetCinemachineComponent<CinemachinePOV>() == null)
		{
			CinemachinePOV cinemachinePOV = freeLook.AddCinemachineComponent<CinemachinePOV>();
			cinemachinePOV.m_HorizontalAxis.m_InputAxisName = null;
			cinemachinePOV.m_VerticalAxis.m_InputAxisName = null;
		}
		if (freeLook.GetCinemachineComponent<CinemachineTransposer>() == null)
		{
			freeLook.AddCinemachineComponent<CinemachineTransposer>().m_FollowOffset = Vector3.zero;
		}
	}

	internal static void MoveController_Internal(CharacterController move, Vector3 inputDirection, bool fly, bool useGravity, float dt, float speed)
	{
		Vector3 motion = Vector3.zero;
		if (!fly)
		{
			inputDirection.y = 0f;
		}
		if (useGravity && !move.isGrounded)
		{
			motion = Vector3.Project(move.velocity, Physics.gravity) + dt * Physics.gravity;
		}
		motion += inputDirection * Time.deltaTime * speed;
		move.Move(motion);
	}

	private void CheckFreeLookCamYArea()
	{
		Ray ray = new Ray(freeMoveController.transform.position, Vector3.up);
		Ray ray2 = new Ray(freeMoveController.transform.position, Vector3.down);
		FreeLookHeightFloor = float.MinValue;
		FreeLookHeightCeil = float.MaxValue;
		int num = Physics.SphereCastNonAlloc(ray, 0.15f, hitResultCache);
		for (int i = 0; i < num; i++)
		{
			ref RaycastHit reference = ref hitResultCache[i];
			if (!(reference.collider == freeMoveController))
			{
				FreeLookHeightCeil = Mathf.Min(FreeLookHeightCeil, reference.point.y);
			}
		}
		num = Physics.SphereCastNonAlloc(ray2, 0.15f, hitResultCache);
		for (int j = 0; j < num; j++)
		{
			ref RaycastHit reference2 = ref hitResultCache[j];
			if (!(reference2.collider == freeMoveController))
			{
				FreeLookHeightFloor = Mathf.Max(FreeLookHeightFloor, reference2.point.y);
			}
		}
	}

	private static void GetForward(Transform trs, out Vector3 localFwd, out Vector3 localRight)
	{
		localRight = Vector3.Cross(Vector3.up, trs.forward);
		if (localRight == Vector3.zero)
		{
			localRight = Vector3.Cross(Vector3.up, trs.up);
		}
		localFwd = Vector3.Cross(localRight, Vector3.up);
	}

	private void MoveUpdate(float dt)
	{
		if (!(T0WorldScene.Scene == null) && !(T0WorldScene.Scene.mWorldUI == null))
		{
			GetForward(Camera.main.transform, out var localFwd, out var _);
			Vector3 normalized = inputDirection.normalized;
			Vector3 vector = Quaternion.LookRotation(localFwd, Vector3.up) * normalized;
			MoveController_Internal(freeMoveController, vector, fly: true, useGravity: false, dt, speed);
		}
	}

	private void ResetFreeLookCamPos()
	{
		Transform transform = Camera.main.transform;
		Transform obj = freeMoveController.transform;
		Vector3 position = (freeLook.transform.position = transform.position);
		obj.position = position;
		Transform obj2 = freeMoveController.transform;
		Quaternion rotation = (freeLook.transform.rotation = transform.rotation);
		obj2.rotation = rotation;
		Vector3 eulerAngles = transform.rotation.eulerAngles;
		CurrentPOV.m_HorizontalAxis.Value = eulerAngles.y;
		CurrentPOV.m_VerticalAxis.Value = eulerAngles.x;
	}

	public static T0WorldFreeLookCamera Create()
	{
		GameObject obj = new GameObject("freeLookNode");
		obj.transform.SetParent(T0WorldScene.Scene.T0EntityContent, worldPositionStays: false);
		return obj.AddComponent<T0WorldFreeLookCamera>();
	}

	private void Awake()
	{
		InitFreeLookCamera();
		Instance = this;
	}

	private void OnEnable()
	{
		ResetFreeLookCamPos();
		freeLook.gameObject.SetActive(value: true);
	}

	private void OnDisable()
	{
		freeLook.gameObject.SetActive(value: false);
	}

	private void Update()
	{
		CurrentPOV.m_HorizontalAxis.m_InputAxisValue = dragDelta.x;
		CurrentPOV.m_VerticalAxis.m_InputAxisValue = dragDelta.y;
		MoveUpdate(Time.deltaTime);
		CheckFreeLookCamYArea();
	}

	private void OnDestroy()
	{
		if (Instance == this)
		{
			Instance = null;
		}
	}
}
