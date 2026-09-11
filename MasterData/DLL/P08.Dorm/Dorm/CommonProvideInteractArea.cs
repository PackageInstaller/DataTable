using System.Collections.Generic;
using Dorm.Character;
using Sirenix.OdinInspector;
using UnityEngine;

namespace Dorm;

[RequireComponent(typeof(BoxCollider))]
public class CommonProvideInteractArea : SerializedMonoBehaviour, IProvideInteractArea, IInteractProvider
{
	public bool overrideInteractAction;

	[SerializeField]
	private List<InteractAction> interactActions;

	public IProvideInteractEntity Provider { get; set; }

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

	public int WaitInteractCount => Provider.WaitInteractCount;

	public bool OccupyInteractArea => false;

	public BoxCollider Area { get; private set; }

	private void Awake()
	{
		base.gameObject.layer = LayerMask.NameToLayer("Ignore Raycast");
	}

	private void Start()
	{
		Area = GetComponent<BoxCollider>();
		Area.isTrigger = true;
		base.gameObject.layer = LayerMask.NameToLayer("Ignore Raycast");
	}

	internal InteractAction? RndPickAction(DormEntity entity)
	{
		return IProvideInteractEntity.RndPickAction(Provider, Actions, entity);
	}

	public int? ProvideAction(DormEntity entity, out Transform interactPos, out Transform exitPos)
	{
		InteractAction? interactAction = ((WaitInteractCount < InteractEntityCountLimit) ? RndPickAction(entity) : ((InteractAction?)null));
		interactPos = interactAction?.interactPos;
		exitPos = interactAction?.exitPos;
		return interactAction?.id;
	}
}
