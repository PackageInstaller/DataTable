using UnityEngine;
using UnityEngine.EventSystems;

namespace T0World;

public class T0BedInvokeHandleItem : MonoBehaviour, IPointerDownHandler, IEventSystemHandler, IBeginDragHandler, IEndDragHandler, IDragHandler
{
	public Transform dragControlNode;

	public Transform smallDragControlNode;

	public Transform smallDragLookAtNode;

	public PlayerSlowFollow smallNodeFollow;

	public float smallDragRatio = 0.5f;

	private Camera _mainCamera;

	private Vector3 _offset;

	private Vector3 _dragStartPos;

	private Vector3 _smallDragStartPos;

	public Vector3 dragStartOffset = Vector3.zero;

	public bool limitDragRange;

	public Vector2 dragLimitRange = new Vector2(1f, 1f);

	public bool limitY;

	private T0BedIceControl iceControl;

	private BedHandleEnum currentHandleType => T0BedGame.bedGame.context.currentHandleType;

	private BedPropEnum currentPropType => T0BedGame.bedGame.context.currentPropType;

	private BedPosEnum currentPosType => T0BedGame.bedGame.context.currentPosType;

	private bool IsClickHandle => currentHandleType == BedHandleEnum.click;

	private bool IsFoot => currentPosType == BedPosEnum.LEG;

	private bool IsIce => currentPropType == BedPropEnum.ice;

	private void PelvisDragBegin()
	{
		if (!IsClickHandle)
		{
			T0WorldScene.Scene.agentManager.CharacteraAgent.CharacterBoard.ikBehavior.bipedIk.solvers.pelvis.target = smallDragLookAtNode;
		}
	}

	private void PelvisDragEnd()
	{
		if (!IsClickHandle)
		{
			T0WorldScene.Scene.agentManager.CharacteraAgent.CharacterBoard.ikBehavior.bipedIk.solvers.pelvis.target = null;
		}
	}

	private void FootDragBegin()
	{
		if (IsFoot)
		{
			Transform slowFollowNode = T0WorldScene.Scene.player.slowFollowNode;
			T0CharacterIkBehavior ikBehavior = T0WorldScene.Scene.agentManager.CharacteraAgent.CharacterBoard.ikBehavior;
			ikBehavior.bipedIk.solvers.leftFoot.target = slowFollowNode;
			ikBehavior.bipedIk.solvers.rightFoot.target = slowFollowNode;
		}
	}

	private void FootDragEnd()
	{
		_ = IsFoot;
	}

	private void IceDragBegin()
	{
		if (!IsIce)
		{
			return;
		}
		if (iceControl == null || iceControl.applyBodyType != currentPosType)
		{
			T0BedIceControl[] componentsInChildren = T0WorldScene.Scene.agentManager.CharacteraAgent.transform.GetComponentsInChildren<T0BedIceControl>();
			if (componentsInChildren != null && componentsInChildren.Length != 0)
			{
				T0BedIceControl[] array = componentsInChildren;
				foreach (T0BedIceControl t0BedIceControl in array)
				{
					if (t0BedIceControl.applyBodyType == currentPosType)
					{
						iceControl = t0BedIceControl;
						break;
					}
				}
			}
		}
		iceControl.BeginDrag();
	}

	private void IceDragEnd()
	{
		if (IsIce && !(iceControl == null))
		{
			iceControl.EndDrag();
		}
	}

	private void IceOnDrag(Vector3 dragPos)
	{
		if (IsIce)
		{
			iceControl.OnDragMove(dragPos);
		}
	}

	private void Awake()
	{
		base.gameObject.layer = LayerMask.NameToLayer("Effect");
		_mainCamera = Camera.main;
		smallNodeFollow.SetFollowTarget(smallDragControlNode);
	}

	private Vector3 GetMouseWorldPos(Vector2 screenPos)
	{
		Vector3 position = new Vector3(screenPos.x, screenPos.y, _mainCamera.WorldToScreenPoint(base.transform.position).z);
		return _mainCamera.ScreenToWorldPoint(position);
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		if (IsClickHandle)
		{
			InvokeClick();
			return;
		}
		Vector3 mouseWorldPos = GetMouseWorldPos(eventData.position);
		_offset = base.transform.position - mouseWorldPos;
	}

	public void InvokeClick()
	{
		InvokeFinishHandle();
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		if (!IsClickHandle)
		{
			_dragStartPos = dragControlNode.position + dragStartOffset;
			if (smallDragControlNode != null)
			{
				_smallDragStartPos = smallDragControlNode.position;
			}
			InvokeFinishHandle();
			T0WorldScene.Scene.player.SetSlowFlowTarget(dragControlNode);
			T0WorldScene.Scene.agentManager.CharacteraAgent.CharacterBoard.ikBehavior.SetIkLookTarget(T0WorldScene.Scene.player.slowFollowNode);
			PelvisDragBegin();
			IceDragBegin();
			FootDragBegin();
		}
	}

	public void OnDrag(PointerEventData eventData)
	{
		if (!IsClickHandle)
		{
			Vector3 vector = GetMouseWorldPos(eventData.position) + _offset;
			if (limitDragRange)
			{
				vector.x = Mathf.Clamp(vector.x, _dragStartPos.x - dragLimitRange.x, _dragStartPos.x + dragLimitRange.x);
				vector.z = Mathf.Clamp(vector.z, _dragStartPos.z - dragLimitRange.y, _dragStartPos.z + dragLimitRange.y);
			}
			if (limitY)
			{
				vector.y = _dragStartPos.y;
			}
			dragControlNode.position = vector;
			if (smallDragControlNode != null)
			{
				Vector3 vector2 = vector - _dragStartPos;
				smallDragControlNode.position = _smallDragStartPos + vector2 * smallDragRatio;
			}
			IceOnDrag(eventData.position - eventData.pressPosition);
		}
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		if (!IsClickHandle)
		{
			InvokeDragEndHandle();
			PelvisDragEnd();
			IceDragEnd();
			FootDragEnd();
		}
	}

	private void InvokeFinishHandle()
	{
		T0BedGame.bedGame.context.IsCanClickUI = false;
		T0BedGame.bedGame.InvokeSelectCallback(T0BedClickType.INVOKE_HANDLE);
	}

	private void InvokeDragEndHandle()
	{
		T0BedGame.bedGame.context.IsCanClickUI = false;
		T0BedGame.bedGame.InvokeSelectCallback(T0BedClickType.INVOKE_DRAG_END);
	}
}
