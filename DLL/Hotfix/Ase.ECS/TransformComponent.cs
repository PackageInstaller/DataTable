using UnityEngine;

namespace Ase.ECS;

public class TransformComponent : BaseComponent
{
	private int _battleLayer;

	private bool _syncPosition;

	private Transform _vTsm;

	private bool _existVTsm;

	private CapsuleCollider bodyCollider;

	private EntityCollisionLayer collisionLayer;

	private Rigidbody rigidbody;

	public GameObject VGameObject => _vTsm?.gameObject;

	public override void OnInit(object data)
	{
		base.OnInit(data);
		_battleLayer = LayerMask.NameToLayer("Battle");
	}

	public override void OnAwake(object data = null)
	{
		CreateDeterministicPhysics();
	}

	private void CreateDeterministicPhysics()
	{
		if (mBaseEntity.IsSyncPhysicsEntity)
		{
			GameObject gameObject = new GameObject();
			gameObject.transform.SetParent(mBaseEntity.GetWorld().EntityRoot);
			gameObject.hideFlags = HideFlags.HideInHierarchy;
			bodyCollider = gameObject.GetOrAddComponent<CapsuleCollider>();
			collisionLayer = gameObject.GetOrAddComponent<EntityCollisionLayer>();
			if (mBaseEntity.GetEntityType() == EntityType.HERO)
			{
				gameObject.GetOrAddComponent<MathTriggerableMonoBehaviour>();
			}
			((Collider)bodyCollider).enabled = false;
			_vTsm = gameObject.transform;
			_vTsm.position = mBaseEntity.transform.position;
			_vTsm.rotation = mBaseEntity.transform.rotation;
			_vTsm.localScale = mBaseEntity.transform.localScale;
			_existVTsm = true;
			ChangeEntityLayer();
			AddEntityView();
		}
	}

	private void AddEntityView()
	{
		if (mBaseEntity.GetEntityView() != null)
		{
			((EntityView)_vTsm.gameObject.GetOrAddComponent(mBaseEntity.GetEntityView())).OnInit(mBaseEntity);
		}
	}

	private void ChangeEntityLayer()
	{
		if (_vTsm.gameObject.layer == LayerMask.NameToLayer("Default") || _vTsm.gameObject.layer == LayerMask.NameToLayer("Hide"))
		{
			_vTsm.gameObject.SetLayerRecursively(_battleLayer);
			_vTsm.gameObject.SetLayerRecursively(_battleLayer);
		}
	}

	public void SetPosition(Vector3 position)
	{
		base.transform.position = position;
		if (_existVTsm && !(_vTsm.position == position))
		{
			_vTsm.position = position;
		}
	}

	public float SetRotation(Vector3 rotation, bool immediately)
	{
		base.transform.rotation = Quaternion.Euler(rotation);
		if (immediately)
		{
			_vTsm.rotation = base.transform.rotation;
			return 0f;
		}
		return 0f;
	}

	public void SetPositionAndRotation(Vector3 position, Vector3 rotation, bool immediately)
	{
		SetPosition(position);
		SetRotation(rotation, immediately);
	}

	public void SetRotation(Vector3 rotation)
	{
		base.transform.eulerAngles = rotation;
		if (_existVTsm)
		{
			Quaternion quaternion = Quaternion.Euler(rotation);
			if (!(_vTsm.rotation == quaternion))
			{
				_vTsm.rotation = quaternion;
			}
		}
	}

	public override void OnFixedUpdateAfter(WorldUpdateType updateType)
	{
		base.OnFixedUpdateAfter(updateType);
		if (mBaseEntity.SyncPosition && _existVTsm)
		{
			Vector3 position = mBaseEntity.transform.position;
			Quaternion rotation = mBaseEntity.transform.rotation;
			if (_vTsm.position != position)
			{
				_vTsm.position = position;
			}
			if (_vTsm.rotation != rotation)
			{
				_vTsm.rotation = rotation;
			}
		}
		if ((mBaseEntity is HeroEntity || mBaseEntity is MonsterEntity) && LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"TransformComponent  Position ：{mBaseEntity.transform.position}  Rotation ：{mBaseEntity.transform.rotation}", mBaseEntity);
		}
	}

	public override void OnEntityDead()
	{
		if (mBaseEntity.GetEntityType() == EntityType.MONSTER)
		{
			SetBodyColliderEnable(enable: false);
		}
	}

	public override void OnEntityRelease()
	{
		if (_vTsm != null)
		{
			Object.DestroyImmediate(_vTsm.gameObject);
			_vTsm = null;
		}
		_existVTsm = false;
	}

	public void HideEntityView()
	{
		if (_existVTsm)
		{
			_vTsm.gameObject.SetActive(value: false);
		}
	}

	public void ShowEntityView()
	{
		if (_existVTsm)
		{
			_vTsm.gameObject.SetActive(value: true);
		}
	}

	public CapsuleCollider GetBodyCollider()
	{
		return bodyCollider;
	}

	public void SetColliderEnable(int index, bool enable)
	{
		if (!(collisionLayer == null) && collisionLayer.others != null && collisionLayer.others.Count > index)
		{
			collisionLayer.others[index].enabled = enable;
		}
	}

	public void SetBodyColliderEnable(bool enable)
	{
		if ((Object)(object)bodyCollider != null)
		{
			((Collider)bodyCollider).enabled = enable;
		}
	}

	public void SetColliderEnable(int[] indexs, bool enable)
	{
		if (collisionLayer == null || collisionLayer.others == null || indexs.IsNullOrEmpty())
		{
			return;
		}
		for (int i = 0; i < indexs.Length; i++)
		{
			if (collisionLayer.others.Count > indexs[i])
			{
				collisionLayer.others[indexs[i]].enabled = enable;
			}
		}
	}
}
