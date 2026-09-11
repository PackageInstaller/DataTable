using Dorm.Character;
using Dorm.Furniture;
using UnityEngine;
using UnityEngine.EventSystems;

namespace P08.SimBusiness.Input;

public class ShelfTrigger : FurnitureEventTrigger
{
	protected override bool CheckCanPlace()
	{
		return SimBusinessMgr.instance.navSurface.ShelfCheckCanPlace(goodsEntity);
	}

	protected override Vector3 SnapPos(Vector3 inputPos)
	{
		return SimBusinessMgr.instance.navSurface.ShelfSnapPos(goodsEntity, inputPos);
	}

	protected override void OnStartEdit()
	{
		SimBusinessMgr.instance.OnStartEditShelf();
	}

	protected override void OnStopEdit()
	{
		SimBusinessMgr.instance.OnStopEditShelf();
	}

	protected override void UpdateCanPlaceVisualEffect(bool canPlace)
	{
		SimBusinessMgr.instance.EnableWarningMode(!canPlace);
	}

	protected override bool ShouldConsumeDrag(PointerEventData eventData)
	{
		if (goodsEntity.furnitureStatus == FurnitureEntity.FurnitureStatus.mEditing)
		{
			if (eventData.dragging)
			{
				return !isPassingDragEvent;
			}
			return false;
		}
		return false;
	}

	protected override bool CheckCanEdit()
	{
		return true;
	}

	public override void OnPointerClick(PointerEventData eventData)
	{
		DormEntityAction.Notify("ON_FURNITURE_CLICKED", goodsEntity.entityId);
	}
}
