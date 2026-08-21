using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.EventSystems;

namespace NodeCanvas.Tasks.Conditions;

[Category("UGUI")]
[Description("Returns true when the selected event is triggered on the selected agent.\nYou can use this for both GUI and 3D objects.\nPlease make sure that Unity Event Systems are setup correctly")]
public class InterceptEvent : ConditionTask<Transform>
{
	public EventTriggerType eventType;

	protected override string info => $"{eventType.ToString()} on {base.agentInfo}";

	protected override void OnEnable()
	{
		switch (eventType)
		{
		case EventTriggerType.PointerEnter:
			base.router.onPointerEnter += OnPointerEnter;
			break;
		case EventTriggerType.PointerExit:
			base.router.onPointerExit += OnPointerExit;
			break;
		case EventTriggerType.PointerDown:
			base.router.onPointerDown += OnPointerDown;
			break;
		case EventTriggerType.PointerUp:
			base.router.onPointerUp += OnPointerUp;
			break;
		case EventTriggerType.PointerClick:
			base.router.onPointerClick += OnPointerClick;
			break;
		case EventTriggerType.Drag:
			base.router.onDrag += OnDrag;
			break;
		case EventTriggerType.Drop:
			base.router.onDrop += OnDrop;
			break;
		case EventTriggerType.Scroll:
			base.router.onScroll += OnScroll;
			break;
		case EventTriggerType.UpdateSelected:
			base.router.onUpdateSelected += OnUpdateSelected;
			break;
		case EventTriggerType.Select:
			base.router.onSelect += OnSelect;
			break;
		case EventTriggerType.Deselect:
			base.router.onDeselect += OnDeselect;
			break;
		case EventTriggerType.Move:
			base.router.onMove += OnMove;
			break;
		case EventTriggerType.Submit:
			base.router.onSubmit += OnSubmit;
			break;
		case EventTriggerType.InitializePotentialDrag:
		case EventTriggerType.BeginDrag:
		case EventTriggerType.EndDrag:
			break;
		}
	}

	protected override void OnDisable()
	{
		switch (eventType)
		{
		case EventTriggerType.PointerEnter:
			base.router.onPointerEnter -= OnPointerEnter;
			break;
		case EventTriggerType.PointerExit:
			base.router.onPointerExit -= OnPointerExit;
			break;
		case EventTriggerType.PointerDown:
			base.router.onPointerDown -= OnPointerDown;
			break;
		case EventTriggerType.PointerUp:
			base.router.onPointerUp -= OnPointerUp;
			break;
		case EventTriggerType.PointerClick:
			base.router.onPointerClick -= OnPointerClick;
			break;
		case EventTriggerType.Drag:
			base.router.onDrag -= OnDrag;
			break;
		case EventTriggerType.Drop:
			base.router.onDrop -= OnDrop;
			break;
		case EventTriggerType.Scroll:
			base.router.onScroll -= OnScroll;
			break;
		case EventTriggerType.UpdateSelected:
			base.router.onUpdateSelected -= OnUpdateSelected;
			break;
		case EventTriggerType.Select:
			base.router.onSelect -= OnSelect;
			break;
		case EventTriggerType.Deselect:
			base.router.onDeselect -= OnDeselect;
			break;
		case EventTriggerType.Move:
			base.router.onMove -= OnMove;
			break;
		case EventTriggerType.Submit:
			base.router.onSubmit -= OnSubmit;
			break;
		case EventTriggerType.InitializePotentialDrag:
		case EventTriggerType.BeginDrag:
		case EventTriggerType.EndDrag:
			break;
		}
	}

	protected override bool OnCheck()
	{
		return false;
	}

	private void OnPointerEnter(EventData<PointerEventData> data)
	{
		YieldReturn(value: true);
	}

	private void OnPointerExit(EventData<PointerEventData> data)
	{
		YieldReturn(value: true);
	}

	private void OnPointerDown(EventData<PointerEventData> data)
	{
		YieldReturn(value: true);
	}

	private void OnPointerUp(EventData<PointerEventData> data)
	{
		YieldReturn(value: true);
	}

	private void OnPointerClick(EventData<PointerEventData> data)
	{
		YieldReturn(value: true);
	}

	private void OnDrag(EventData<PointerEventData> data)
	{
		YieldReturn(value: true);
	}

	private void OnDrop(EventData<PointerEventData> eventData)
	{
		YieldReturn(value: true);
	}

	private void OnScroll(EventData<PointerEventData> data)
	{
		YieldReturn(value: true);
	}

	private void OnUpdateSelected(EventData<BaseEventData> eventData)
	{
		YieldReturn(value: true);
	}

	private void OnSelect(EventData<BaseEventData> eventData)
	{
		YieldReturn(value: true);
	}

	private void OnDeselect(EventData<BaseEventData> eventData)
	{
		YieldReturn(value: true);
	}

	private void OnMove(EventData<AxisEventData> eventData)
	{
		YieldReturn(value: true);
	}

	private void OnSubmit(EventData<BaseEventData> eventData)
	{
		YieldReturn(value: true);
	}
}
