using Dorm.Character;
using Sirenix.OdinInspector;
using UnityEngine.EventSystems;

namespace Dorm;

public class EntityClickTrigger : SerializedMonoBehaviour, IPointerClickHandler, IEventSystemHandler, IPointerDownHandler, IPointerUpHandler
{
	public int eid;

	private void Awake()
	{
		if (eid == 0)
		{
			eid = GetComponent<IEidProvider>()?.EntityID ?? 0;
		}
	}

	private void OnEnable()
	{
	}

	public void OnPointerClick(PointerEventData eventData)
	{
		if (base.enabled && eid != 0)
		{
			DormEntityAction.Notify("DORM_CLICK_ENTITY", eid);
		}
	}

	public void OnPointerDown(PointerEventData eventData)
	{
	}

	public void OnPointerUp(PointerEventData eventData)
	{
	}
}
