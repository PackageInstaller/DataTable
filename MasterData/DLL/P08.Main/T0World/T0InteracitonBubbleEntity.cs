using ControllerExSpace;
using UnityEngine;

namespace T0World;

public class T0InteracitonBubbleEntity : MonoBehaviour
{
	public bool isShowBubble;

	public ControllerExCollection controllerEx;

	private ControllerEx showController;

	public float InSceneCenterTriggerRange = 200f;

	public float InSceneCenterScale = 1.1f;

	public float baseBubbleScale = 1f;

	private int _effectLayerMask;

	[SerializeField]
	private T0InterationBubbleData bubbleData;

	public void Awake()
	{
		_effectLayerMask = LayerMask.GetMask("Effect");
		if (controllerEx == null)
		{
			controllerEx = GetComponent<ControllerExCollection>();
		}
		if ((bool)controllerEx)
		{
			showController = controllerEx.GetController("showState");
		}
		base.gameObject.layer = LayerMask.NameToLayer("Effect");
	}

	public void Init(T0InterationBubbleData bubbleData)
	{
		this.bubbleData = bubbleData;
		baseBubbleScale = bubbleData.bubbleScale;
		base.transform.localScale = Vector3.one * baseBubbleScale;
		if (bubbleData.trigger_type == TriggerType.Click)
		{
			CapsuleCollider capsuleCollider = base.transform.GetComponent<CapsuleCollider>();
			if (capsuleCollider == null)
			{
				capsuleCollider = base.gameObject.AddComponent<CapsuleCollider>();
			}
			capsuleCollider.center = bubbleData.click_center;
			capsuleCollider.radius = bubbleData.click_radius;
			capsuleCollider.height = bubbleData.click_height;
			capsuleCollider.isTrigger = true;
		}
		isShowBubble = false;
		if ((bool)controllerEx)
		{
			base.gameObject.SetActive(value: true);
		}
		else
		{
			base.gameObject.SetActive(isShowBubble);
		}
		Tick();
	}

	public void Tick(bool isProcess = true)
	{
		UpdatePosition();
		UpdateBubbleShow(isProcess);
		UpdateClickSceneTrigger();
	}

	private bool CheckIsInCameraCenter(Vector3 screenPos)
	{
		if (screenPos.z < 0f)
		{
			return false;
		}
		float num = Screen.width;
		float num2 = Screen.height;
		if (screenPos.x < 0f || screenPos.x > num || screenPos.y < 0f || screenPos.y > num2)
		{
			return false;
		}
		float num3 = screenPos.x - num * 0.5f;
		float num4 = screenPos.y - num2 * 0.5f;
		if (num3 * num3 + num4 * num4 > InSceneCenterTriggerRange * InSceneCenterTriggerRange)
		{
			return false;
		}
		return true;
	}

	private void UpdateClickSceneTrigger()
	{
		if (!PlatformHelper.IsPC() || Cursor.visible || !isShowBubble)
		{
			return;
		}
		Vector3 screenPos = Camera.main.WorldToScreenPoint(base.transform.position);
		base.gameObject.transform.localScale = Vector3.one * baseBubbleScale;
		if (!CheckIsInCameraCenter(screenPos))
		{
			base.transform.localScale = Vector3.one * baseBubbleScale;
			return;
		}
		base.transform.localScale = Vector3.one * InSceneCenterScale * baseBubbleScale;
		if (CheckIsMeetClick())
		{
			TriggerClick();
		}
	}

	private bool IsHaveOtherEffectCol()
	{
		Vector3 position = Camera.main.transform.position;
		Vector3 position2 = base.transform.position;
		Vector3 normalized = (position2 - position).normalized;
		float maxDistance = Vector3.Distance(position, position2);
		RaycastHit[] array = Physics.RaycastAll(position, normalized, maxDistance, _effectLayerMask);
		foreach (RaycastHit raycastHit in array)
		{
			if (!(raycastHit.collider.gameObject == base.gameObject))
			{
				return true;
			}
		}
		return false;
	}

	public bool CheckIsMeetClick()
	{
		if (!Input.GetMouseButtonDown(0))
		{
			return false;
		}
		_ = (Vector2)Input.mousePosition;
		if (IsHaveOtherEffectCol())
		{
			return false;
		}
		return true;
	}

	public void Dispose()
	{
		if (base.gameObject != null)
		{
			Object.DestroyImmediate(base.gameObject);
		}
	}

	public void TriggerClick()
	{
		if (bubbleData.trigger_type == TriggerType.Click && isShowBubble)
		{
			bubbleData.IsFinish = true;
		}
	}

	private void UpdateBubbleShow(bool isProcess = true)
	{
		bool num = isShowBubble;
		if (isProcess && Vector3.Distance(T0WorldScene.Scene.player.transform.position, base.transform.parent.position) <= bubbleData.show_range)
		{
			isShowBubble = true;
		}
		else
		{
			isShowBubble = false;
		}
		if (isShowBubble)
		{
			isShowBubble = CheckIsMeetAngle();
		}
		if (num == isShowBubble)
		{
			return;
		}
		if (showController != null)
		{
			base.gameObject.SetActive(value: true);
			if (isShowBubble)
			{
				showController.SetSelectedState("normal");
			}
			else
			{
				showController.SetSelectedState("hide");
			}
		}
		else
		{
			base.gameObject.SetActive(isShowBubble);
		}
	}

	public bool CheckIsMeetAngle()
	{
		bool result = false;
		Transform transform = T0WorldScene.Scene.player.transform;
		float num = Vector3.SignedAngle(to: new Vector3(transform.position.x - base.transform.position.x, 0f, transform.position.z - base.transform.position.z), from: base.transform.parent.forward, axis: Vector3.up);
		if (bubbleData.showAngleValueMin < bubbleData.showAngleValueMax)
		{
			if (num > bubbleData.showAngleValueMin && num < bubbleData.showAngleValueMax)
			{
				result = true;
			}
		}
		else if (num > bubbleData.showAngleValueMin || num < bubbleData.showAngleValueMax)
		{
			result = true;
		}
		return result;
	}

	private void UpdatePosition()
	{
		if (bubbleData.isFollowParentRotation)
		{
			base.transform.localPosition = bubbleData.pos;
		}
		else
		{
			base.transform.position = base.transform.parent.position + bubbleData.pos;
		}
		base.transform.forward = Camera.main.transform.forward;
	}
}
