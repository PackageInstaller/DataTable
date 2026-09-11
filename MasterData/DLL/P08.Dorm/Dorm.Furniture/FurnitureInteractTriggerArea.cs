using System.Collections.Generic;
using Dorm.Character;
using Sirenix.OdinInspector;
using UnityEngine;

namespace Dorm.Furniture;

[RequireComponent(typeof(BoxCollider))]
[ExecuteInEditMode]
public class FurnitureInteractTriggerArea : SerializedMonoBehaviour, IProvideInteractArea, IInteractProvider
{
	public FurnitureTag furnitrueTag;

	public bool overrideInteractAction;

	[SerializeField]
	private List<InteractAction> interactActions;

	public FurnitureEntity furnitureEntity => furnitrueTag.FurnitureEntity;

	public int EntityID => furnitureEntity.entityId;

	public IProvideInteractEntity Provider => furnitrueTag;

	public int WaitInteractCount => Provider.WaitInteractCount;

	public int InteractEntityCountLimit => Provider.InteractEntityCountLimit;

	public IEnumerable<InteractAction> Actions
	{
		get
		{
			if (!overrideInteractAction)
			{
				return Provider.Actions;
			}
			return interactActions;
		}
	}

	public bool OccupyInteractArea => false;

	public BoxCollider Area { get; private set; }

	public int? ProvideAction(DormEntity entity, out Transform interactPos, out Transform exitPos)
	{
		InteractAction? interactAction = ((WaitInteractCount < InteractEntityCountLimit) ? IProvideInteractEntity.RndPickAction(Provider, Actions, entity) : ((InteractAction?)null));
		interactPos = interactAction?.interactPos;
		exitPos = interactAction?.exitPos;
		return interactAction?.id;
	}

	private void Start()
	{
		Area = GetComponent<BoxCollider>();
		Area.isTrigger = true;
		base.gameObject.layer = LayerMask.NameToLayer("Ignore Raycast");
	}
}
