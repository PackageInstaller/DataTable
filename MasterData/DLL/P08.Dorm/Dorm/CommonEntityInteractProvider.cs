using System.Collections.Generic;
using System.Linq;
using Dorm.Character;
using Sirenix.OdinInspector;
using UnityEngine;

namespace Dorm;

public class CommonEntityInteractProvider : SerializedMonoBehaviour, IProvideInteractEntity, IEidProvider, IInteractProvider
{
	public DormEntity entity;

	[SerializeField]
	public bool hasInteract;

	public List<InteractAction> interactActions;

	public int InteractEntityCountLimit => 1;

	public int EntityID => entity.id;

	public int WaitInteractCount => entity.WaitInteractCount;

	public IEnumerable<InteractAction> Actions
	{
		get
		{
			if (!hasInteract)
			{
				return Enumerable.Empty<InteractAction>();
			}
			return interactActions;
		}
	}

	public bool OccupyInteractArea => false;

	public Transform MainColliderTrs => null;

	public void Bind(DormEntity providerEntity)
	{
		entity = providerEntity;
	}

	public void OnInteractBeingCanceled()
	{
		if ((entity?.WaitInteractCount ?? 0) == InteractEntityCountLimit)
		{
			entity.RestoreAnimeScheme();
			entity.Play(DormEntity.DormEntityAnime.Stand);
		}
	}

	public int? ProvideAction(DormEntity entity, out Transform interactPos, out Transform exitPos)
	{
		InteractAction? interactAction = ((WaitInteractCount < InteractEntityCountLimit) ? IProvideInteractEntity.RndPickAction(this, Actions, entity) : ((InteractAction?)null));
		interactPos = interactAction?.interactPos;
		exitPos = interactAction?.exitPos;
		return interactAction?.id;
	}
}
