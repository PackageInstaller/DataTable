using System;
using System.Collections.Generic;
using System.Linq;
using Dorm;
using Dorm.Character;
using Dorm.Furniture;
using Sirenix.OdinInspector;
using UnityEngine;

[ExecuteAlways]
public class FurnitureTag : SerializedMonoBehaviour, IProvideInteractEntity, IEidProvider, IInteractProvider
{
	[NonSerialized]
	public int id;

	[NonSerialized]
	public uint state;

	[NonSerialized]
	public TileType tileType;

	[NonSerialized]
	public bool forceLayOnGrount;

	[NonSerialized]
	private Vector3Int size;

	[HideInInspector]
	public bool autoAdjustCollider;

	[Tooltip("如果需要使用专门制作的碰撞体而不是在游戏中根据占地尺寸自动生成，则将专门制作的碰撞体的Transform设置于此")]
	public Transform colliderTrs;

	public MeshRenderer occupationRender;

	private FurnitureFootprint footprint;

	private DormEntity interactProvider;

	private FurnitureEntity furnitureEntity;

	public InteractAction[] interactActions;

	[SerializeField]
	public bool hasInteract;

	[Range(1f, 5f)]
	public int interactLimit = 1;

	public Vector3Int Size
	{
		get
		{
			return size;
		}
		set
		{
			size = value;
			Footprint.OnFootprintSizeChange(size);
			if ((bool)MainColliderTrs)
			{
				AdjustMainColliderSize(0.25f * (Vector3)size);
			}
		}
	}

	public FurnitureFootprint Footprint
	{
		get
		{
			if (Application.isPlaying && footprint == null)
			{
				footprint = U3DUtil.Get<FurnitureFootprint>(base.gameObject);
			}
			return footprint;
		}
	}

	public FurnitureEntity FurnitureEntity
	{
		get
		{
			return furnitureEntity;
		}
		set
		{
			furnitureEntity = value;
			Bind(value.entity);
			OnSetFootprintState(value?.renderType ?? FurnitureRenderType.mHide);
		}
	}

	public int EntityID => furnitureEntity.entityId;

	public int InteractEntityCountLimit => interactLimit;

	public int WaitInteractCount => interactProvider.WaitInteractCount;

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

	public bool OccupyInteractArea
	{
		get
		{
			if (furnitureEntity != null && furnitureEntity.child.Count > 0)
			{
				return furnitureEntity.parent == null;
			}
			return false;
		}
	}

	public Transform MainColliderTrs
	{
		get
		{
			if (colliderTrs == null)
			{
				GameObject gameObject = new GameObject("main collider");
				gameObject.transform.SetParent(base.transform);
				gameObject.transform.localPosition = Vector3.zero;
				gameObject.transform.localRotation = Quaternion.identity;
				AdjustMainColliderSize(gameObject.AddComponent<BoxCollider>(), 0.25f * (Vector3)Size);
				autoAdjustCollider = true;
				colliderTrs = gameObject.transform;
			}
			return colliderTrs;
		}
	}

	public InteractAction? RndPickAction(DormEntity entity)
	{
		return IProvideInteractEntity.RndPickAction(this, Actions, entity);
	}

	public void OnInteractBeingCanceled()
	{
		DormEntity dormEntity = interactProvider;
		if ((dormEntity?.WaitInteractCount ?? 0) == InteractEntityCountLimit)
		{
			dormEntity.RestoreAnimeScheme();
			dormEntity.Play(DormEntity.DormEntityAnime.Stand, 0f);
		}
	}

	public int? ProvideAction(DormEntity entity, out Transform interactPos, out Transform exitPos)
	{
		InteractAction? interactAction = ((WaitInteractCount < InteractEntityCountLimit) ? RndPickAction(entity) : ((InteractAction?)null));
		interactPos = interactAction?.interactPos;
		exitPos = interactAction?.exitPos;
		return interactAction?.id;
	}

	public void Bind(DormEntity providerEntity)
	{
		interactProvider = providerEntity;
	}

	public void OnSetTileType(TileType tileType)
	{
		if (tileType == TileType.FLOOR)
		{
			Footprint.OnFootprintTypeChange(FurnitureFootprint.FootprintType.Floor);
		}
		else if (forceLayOnGrount)
		{
			Footprint.OnFootprintTypeChange(FurnitureFootprint.FootprintType.WallMountAttachGround);
		}
		else
		{
			Footprint.OnFootprintTypeChange(FurnitureFootprint.FootprintType.WallMount);
		}
		AdjustMainColliderSize(0.25f * (Vector3)Size);
	}

	public void OnSetFootprintState(FurnitureRenderType renderType)
	{
		if ((bool)occupationRender)
		{
			Footprint.UseCustomFootprint(occupationRender);
		}
		Footprint.OnSetVisible(renderType != FurnitureRenderType.mHide);
		Footprint.SetColor((renderType == FurnitureRenderType.mDisabled) ? DormConst.COLOR_RED : DormConst.COLOR_BLUE);
	}

	private void AdjustMainColliderSize(Vector3 size)
	{
		BoxCollider component = MainColliderTrs.GetComponent<BoxCollider>();
		AdjustMainColliderSize(component, size);
	}

	private void AdjustMainColliderSize(BoxCollider box, Vector3 size)
	{
		if (autoAdjustCollider)
		{
			if (tileType == TileType.FLOOR)
			{
				box.center = new Vector3(0f, size.z * 0.5f, 0f);
				box.size = new Vector3(size.x, size.z, size.y);
			}
			else
			{
				box.center = new Vector3(0f, 0f, size.z * 0.5f);
				box.size = size;
			}
		}
	}
}
