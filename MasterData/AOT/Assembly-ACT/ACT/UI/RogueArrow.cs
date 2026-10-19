using Bamboo.NumberString;
using TMPro;
using UnityEngine;

namespace ACT.UI;

[DisallowMultipleComponent]
[RequireComponent(typeof(CanvasGroup))]
public class RogueArrow : MonoBehaviour
{
	[Header("箭头显示")]
	[SerializeField]
	private RectTransform arrowTransform;

	[Tooltip("箭头旋转时需要保持正向的节点，例如距离文本根节点。")]
	[SerializeField]
	private Transform steadyTransform;

	[SerializeField]
	private CanvasGroup canvasGroup;

	[Header("距离显示")]
	[SerializeField]
	private RectTransform distanceRoot;

	[SerializeField]
	private TMP_Text distanceText;

	private Transform target;

	private Vector3 targetWorldPosition;

	private bool tracksTransform;

	private bool initialized;

	private bool showDistance;

	private int lastDistance = -1;

	public bool Initialized => initialized;

	private void Awake()
	{
		if (arrowTransform == null)
		{
			arrowTransform = transform as RectTransform;
		}
		if (canvasGroup == null)
		{
			canvasGroup = GetComponent<CanvasGroup>();
		}
		SetVisible(visible: false);
	}

	public void Initialize(Transform targetTransform, bool distanceVisible)
	{
		target = targetTransform;
		tracksTransform = true;
		initialized = target != null;
		showDistance = distanceVisible;
		lastDistance = -1;
		if (!initialized)
		{
			SetVisible(visible: false);
		}
	}

	public void Initialize(Vector3 worldPosition, bool distanceVisible)
	{
		target = null;
		targetWorldPosition = worldPosition;
		tracksTransform = false;
		initialized = true;
		showDistance = distanceVisible;
		lastDistance = -1;
	}

	public void UpdateTarget(Transform targetTransform, bool distanceVisible)
	{
		if (!initialized || !tracksTransform || !(target == targetTransform) || showDistance != distanceVisible)
		{
			Initialize(targetTransform, distanceVisible);
		}
	}

	public void UpdateTarget(Vector3 worldPosition, bool distanceVisible)
	{
		if (!initialized || tracksTransform || !(targetWorldPosition == worldPosition) || showDistance != distanceVisible)
		{
			Initialize(worldPosition, distanceVisible);
		}
	}

	public bool TryGetTargetWorldPosition(out Vector3 worldPosition)
	{
		worldPosition = targetWorldPosition;
		if (!initialized)
		{
			return false;
		}
		if (tracksTransform)
		{
			if (target == null)
			{
				UnInitialize();
				return false;
			}
			targetWorldPosition = target.position;
			worldPosition = targetWorldPosition;
		}
		return true;
	}

	public void ApplyView(Vector3 arrowWorldPosition, Vector2 direction, Vector3 playerPosition, bool hasPlayerPosition)
	{
		SetVisible(visible: true);
		arrowTransform.position = arrowWorldPosition;
		arrowTransform.rotation = Quaternion.FromToRotation(Vector2.up, direction);
		if (steadyTransform != null)
		{
			steadyTransform.rotation = Quaternion.identity;
		}
		if (showDistance && !(distanceText == null) && hasPlayerPosition)
		{
			int num = Mathf.Max(0, (int)Vector3.Distance(targetWorldPosition, playerPosition));
			if (num != lastDistance)
			{
				distanceText.SetText(num.FastToString());
				lastDistance = num;
			}
		}
	}

	public void SetVisible(bool visible)
	{
		if (canvasGroup != null)
		{
			canvasGroup.alpha = (visible ? 1f : 0f);
		}
		if (distanceRoot != null)
		{
			distanceRoot.gameObject.SetActive(visible && showDistance);
		}
	}

	public void UnInitialize()
	{
		target = null;
		tracksTransform = false;
		initialized = false;
		lastDistance = -1;
		SetVisible(visible: false);
	}
}
