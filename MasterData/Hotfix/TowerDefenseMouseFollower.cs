using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.InputSystem;
using UnityEngine.Rendering.Universal;
using UnityEngine.UI;

public class TowerDefenseMouseFollower : MonoBehaviour
{
	public LayerMask followLayer;

	public float heightOffset = 0.1f;

	public float maxDistance = 100f;

	public float smoothness = 0.2f;

	private Camera camera;

	private Vector3 targetPosition;

	private bool isFollowing;

	private Ray ray;

	private RaycastHit[] hits;

	public Action<Vector3> callback;

	private Vector2 screenPosition;

	private DefaultInputActions controls;

	public Action<Vector2> onPressDown;

	public Action<Vector2> onPress;

	public Action<Vector3> onPressUp;

	public Action<Vector2, Vector3> onHold;

	public Action<Vector3> onMove;

	public Action<Vector3, bool> onHoldChange;

	private InputAction clickAction;

	private InputAction pointAction;

	private Vector3 callbackPosition = Vector3.zero;

	private const string FollowLayerObjName = "MouseFollowLayerObject";

	private GameObject mouseFollowLayerObject;

	private float pressTime;

	[SerializeField]
	private float longPressTime = 0.2f;

	private bool isPointCard;

	private bool isHoldCard;

	private PointerEventData uiPointerEventData;

	private EventSystem uiPointerEventDataOwner;

	private readonly List<RaycastResult> uiRaycastResults = new List<RaycastResult>();

	private float startAngle = 50f;

	private Vector2 prePosition;

	private Vector2 curPosition;

	private void Awake()
	{
		if (controls == null)
		{
			controls = new DefaultInputActions();
		}
	}

	public static TowerDefenseMouseFollower Create()
	{
		GameObject gameObject = GameObject.CreatePrimitive(PrimitiveType.Plane);
		gameObject.name = "MouseFollowLayerObject";
		gameObject.transform.localScale = new Vector3(999f, 1f, 999f);
		if (gameObject.TryGetComponent<MeshRenderer>(out var component))
		{
			component.enabled = false;
		}
		gameObject.layer = 0;
		TowerDefenseMouseFollower towerDefenseMouseFollower = gameObject.AddComponent<TowerDefenseMouseFollower>();
		towerDefenseMouseFollower.mouseFollowLayerObject = gameObject;
		return towerDefenseMouseFollower;
	}

	private void OnEnable()
	{
		clickAction = controls.TouchEffect.Click;
		pointAction = controls.TouchEffect.Point;
		controls.TouchEffect.Enable();
	}

	private void OnDisable()
	{
		controls.TouchEffect.Disable();
		clickAction = null;
		pointAction = null;
	}

	public void InitConfig(Camera camera, LayerMask layerMask, float heightOffset, float maxDistance, float smoothness)
	{
		this.camera = camera;
		followLayer = layerMask;
		this.heightOffset = heightOffset;
		this.maxDistance = maxDistance;
		this.smoothness = smoothness;
	}

	private void OnPress(Vector2 screenPosition)
	{
		if (isPointCard)
		{
			pressTime += Time.unscaledDeltaTime;
		}
		this.screenPosition = screenPosition;
		onPress?.Invoke(screenPosition);
		if (isFollowing)
		{
			Ray();
		}
	}

	private void OnPressDown(Vector2 screenPosition)
	{
		pressTime = 0f;
		isHoldCard = false;
		ray = camera.ScreenPointToRayAsHFOV(screenPosition);
		hits = Physics.RaycastAll(ray, maxDistance, followLayer);
		if (hits != null && hits.Length != 0)
		{
			for (int i = 0; i < hits.Length; i++)
			{
				RaycastHit raycastHit = hits[i];
				if (raycastHit.transform.name.Equals("MouseFollowLayerObject"))
				{
					targetPosition = raycastHit.point + Vector3.up * heightOffset;
					onHoldChange?.Invoke(targetPosition, isHoldCard);
					break;
				}
			}
		}
		this.screenPosition = screenPosition;
		onPressDown?.Invoke(screenPosition);
	}

	private void OnPressUp(Vector2 screenPositieon)
	{
		bool flag = clickAction.activeControl.device is Touchscreen;
		if (isPointCard && pressTime <= longPressTime && !isHoldCard && !flag)
		{
			isHoldCard = true;
			onHoldChange?.Invoke(Vector3.zero, isHoldCard);
		}
		pressTime = 0f;
		screenPosition = screenPosition;
		if (isHoldCard)
		{
			return;
		}
		StopFollow();
		ray = camera.ScreenPointToRayAsHFOV(screenPosition);
		hits = Physics.RaycastAll(ray, maxDistance, followLayer);
		if (hits == null || hits.Length == 0)
		{
			return;
		}
		for (int i = 0; i < hits.Length; i++)
		{
			RaycastHit raycastHit = hits[i];
			if (raycastHit.transform.name.Equals("MouseFollowLayerObject"))
			{
				targetPosition = raycastHit.point + Vector3.up * heightOffset;
				onPressUp?.Invoke(targetPosition);
				break;
			}
		}
	}

	public bool IsPointerOverClickableUI()
	{
		EventSystem current = EventSystem.current;
		if (null == current)
		{
			return false;
		}
		if (uiPointerEventData == null || uiPointerEventDataOwner != current)
		{
			uiPointerEventData = new PointerEventData(current);
			uiPointerEventDataOwner = current;
		}
		uiPointerEventData.position = screenPosition;
		current.RaycastAll(uiPointerEventData, uiRaycastResults);
		for (int i = 0; i < uiRaycastResults.Count; i++)
		{
			GameObject gameObject = uiRaycastResults.get_Item(i).gameObject;
			if (!(null == gameObject))
			{
				if (null != gameObject.GetComponentInParent<Selectable>())
				{
					return true;
				}
				if (gameObject.GetComponentInParent<IPointerClickHandler>() != null)
				{
					return true;
				}
			}
		}
		return false;
	}

	private void OnHold(Vector2 screenPosition)
	{
		this.screenPosition = screenPosition;
		ray = camera.ScreenPointToRayAsHFOV(screenPosition);
		hits = Physics.RaycastAll(ray, maxDistance, followLayer);
		if (hits == null || hits.Length == 0)
		{
			return;
		}
		for (int i = 0; i < hits.Length; i++)
		{
			RaycastHit raycastHit = hits[i];
			if (raycastHit.transform.name.Equals("MouseFollowLayerObject"))
			{
				targetPosition = raycastHit.point + Vector3.up * heightOffset;
				onHold?.Invoke(this.screenPosition, targetPosition);
				break;
			}
		}
	}

	private void OnMove(Vector2 screenPosition)
	{
		this.screenPosition = screenPosition;
		ray = camera.ScreenPointToRayAsHFOV(screenPosition);
		hits = Physics.RaycastAll(ray, maxDistance, followLayer);
		if (hits == null || hits.Length == 0)
		{
			return;
		}
		for (int i = 0; i < hits.Length; i++)
		{
			RaycastHit raycastHit = hits[i];
			if (raycastHit.transform.name.Equals("MouseFollowLayerObject"))
			{
				targetPosition = raycastHit.point + Vector3.up * heightOffset;
				onMove?.Invoke(targetPosition);
				break;
			}
		}
	}

	public void StartFollow()
	{
		if (Ray())
		{
			isFollowing = true;
		}
	}

	public void StopFollow()
	{
		isFollowing = false;
	}

	public void PointCard(bool enter)
	{
		if (Ray() & enter)
		{
			isPointCard = true;
			return;
		}
		isPointCard = false;
		pressTime = 0f;
	}

	private void Update()
	{
		curPosition = pointAction.ReadValue<Vector2>();
		if (clickAction.WasPressedThisFrame())
		{
			OnPressDown(curPosition);
		}
		if (clickAction.IsPressed())
		{
			OnPress(curPosition);
		}
		if (isHoldCard)
		{
			OnHold(curPosition);
		}
		if (clickAction.WasReleasedThisFrame())
		{
			OnPressUp(curPosition);
		}
		if (!prePosition.Equals(curPosition))
		{
			OnMove(curPosition);
			prePosition = curPosition;
		}
	}

	private bool Ray()
	{
		ray = camera.ScreenPointToRayAsHFOV(screenPosition);
		hits = Physics.RaycastAll(ray, maxDistance, followLayer);
		if (hits != null && hits.Length != 0)
		{
			for (int i = 0; i < hits.Length; i++)
			{
				RaycastHit raycastHit = hits[i];
				if (raycastHit.transform.name.Equals("MouseFollowLayerObject"))
				{
					targetPosition = raycastHit.point + Vector3.up * heightOffset;
					transform.position = callbackPosition;
					return true;
				}
			}
		}
		return false;
	}

	public void PlayRoleLevelUpEffect(GameObject asset, Vector2 fromScreenPosition, Vector3 toPosition, float speed, Action callback = null)
	{
		ray = camera.ScreenPointToRayAsHFOV(fromScreenPosition);
		hits = Physics.RaycastAll(ray, maxDistance, followLayer);
		if (hits == null || hits.Length == 0)
		{
			return;
		}
		for (int i = 0; i < hits.Length; i++)
		{
			RaycastHit raycastHit = hits[i];
			if (raycastHit.transform.name.Equals("MouseFollowLayerObject"))
			{
				Vector3 point = raycastHit.point;
				GameObject effect = AdventureFXPlayer.PlayFX(asset, 1f, point, Quaternion.identity).gameObject;
				StartCoroutine(DoLevelUpEffect(effect, point, toPosition, callback));
				break;
			}
		}
	}

	private IEnumerator DoLevelUpEffect(GameObject effect, Vector3 effFromPosition, Vector3 effTargetPosition, Action effectCompleteCallback)
	{
		float totalMoveTime = 0.5f;
		float moveTime = 0f;
		float normalizedTime = 0f;
		Vector3 controlHandler = new Vector3(2f, 5f, 4f);
		while (normalizedTime < 1f)
		{
			moveTime += Time.unscaledDeltaTime;
			normalizedTime = moveTime / totalMoveTime;
			Vector3 bezierPointByT = CommonHelper.GetBezierPointByT(effFromPosition, controlHandler, effTargetPosition, normalizedTime);
			effect.transform.position = bezierPointByT;
			yield return new WaitForEndOfFrame();
		}
		effect = null;
		effectCompleteCallback?.Invoke();
		effectCompleteCallback = null;
	}

	public void CancelHoldState()
	{
		isHoldCard = false;
		onHoldChange?.Invoke(Vector3.zero, isHoldCard);
	}

	public void Clear()
	{
		onPress = null;
		onPressUp = null;
		onPressDown = null;
		onHold = null;
		onMove = null;
		onHoldChange = null;
		callback = null;
		UnityEngine.Object.Destroy(mouseFollowLayerObject);
		mouseFollowLayerObject = null;
	}
}
