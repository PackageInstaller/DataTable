using UnityEngine;

namespace Ase.ECS;

public class BulletViewComponent : BaseComponent
{
	private BulletData _bulletData;

	private EntityView _entityView;

	private Vector3 _offset;

	private Transform _vTsm;

	private int _battleLayer;

	private bool _existVTsm;

	private bool _existEntityView;

	private const float KLogNegligibleResidual = -4.6051702f;

	public override void OnAwake(object data = null)
	{
		base.OnAwake(data);
		_bulletData = GetData<BulletData>("bulletData");
		_offset = _bulletData.cfg.SelfSfxOffset.ToVector3();
		_battleLayer = LayerMask.NameToLayer("Battle");
		GenerateEntityView();
	}

	private void GenerateEntityView()
	{
		GameObject entityObject = mBaseEntity.GetEntityObject();
		if (entityObject == null)
		{
			return;
		}
		_vTsm = entityObject.transform;
		_vTsm.position = base.transform.position + base.transform.rotation * _offset;
		_vTsm.rotation = base.transform.rotation;
		_existVTsm = true;
		if (mBaseEntity.GetEntityView() != null)
		{
			_entityView = (EntityView)entityObject.GetOrAddComponent(mBaseEntity.GetEntityView());
			_entityView.OnInit(mBaseEntity);
			_existEntityView = true;
			bool flag = false;
			flag = mBaseEntity.Parent != null && (mBaseEntity.GetSystem<EntitySystem>()?.GetEntityIsTeam(mBaseEntity.Parent) ?? false);
			(_entityView as BulletView)?.SetEffectData(_bulletData.cfg.SelfSfx, flag);
			ChangeEntityLayer();
			_entityView.OnAwake();
			mBaseEntity.RegisterEntityViewComponent(_entityView);
			if (_bulletData.extraData != null && _bulletData.extraData.viewData != null)
			{
				entityObject.SetActive(_bulletData.extraData.viewData.isActive);
			}
			else
			{
				entityObject.SetActive(value: true);
			}
		}
	}

	private void ChangeEntityLayer()
	{
		if (_vTsm.gameObject.layer == LayerMask.NameToLayer("Default") || _vTsm.gameObject.layer == LayerMask.NameToLayer("Hide"))
		{
			_vTsm.gameObject.SetLayerRecursively(_battleLayer);
		}
	}

	public override void OnStart(object data = null)
	{
		if (_existEntityView)
		{
			_entityView.OnStart(data);
		}
	}

	public override void OnUpdate(float deltaTime)
	{
		if (_existEntityView)
		{
			_entityView.OnUpdate(deltaTime);
		}
		if (_bulletData != null && _existVTsm)
		{
			Vector3 vector = mBaseEntity.transform.rotation * _offset;
			if (mBaseEntity.ViewNeedLerp)
			{
				float num = 4.6051702f / mBaseEntity.ViewMovementSharpness;
				Vector3 vector2 = (mBaseEntity.transform.position + vector - (_vTsm.position + vector)) * (1f - Mathf.Exp((0f - num) * deltaTime));
				_vTsm.position += vector2;
				_vTsm.rotation = Quaternion.Slerp(_vTsm.rotation, mBaseEntity.transform.rotation, deltaTime / mBaseEntity.ViewRotationSharpness);
			}
			else
			{
				_vTsm.position = mBaseEntity.transform.position + vector;
				_vTsm.rotation = mBaseEntity.transform.rotation;
			}
		}
	}

	public override void OnFixedUpdateBefore(WorldUpdateType updateType)
	{
		base.OnFixedUpdateBefore(updateType);
		if (_existEntityView)
		{
			_entityView.OnFixedUpdateBefore(updateType);
		}
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		if (_existEntityView)
		{
			_entityView.OnFixedUpdate(updateType, deltaTime);
		}
	}

	public virtual void OnRefreshViewSize(HitVolume hitVolume)
	{
		if (hitVolume != null && hitVolume.PrimitiveInfo.Type == PrimitiveEnum.BoxPrimitive)
		{
			SetEntityScale(hitVolume.PrimitiveInfo.BoxSize);
		}
	}

	public virtual void SetPosition(Vector3 position)
	{
		if (_existEntityView)
		{
			_entityView.transform.position = position;
		}
	}

	public virtual void SetRotation(Quaternion rotation)
	{
		if (_existEntityView)
		{
			_entityView.transform.rotation = rotation;
		}
	}

	public virtual void SetLocalScale(Vector3 localScale)
	{
		if (_existEntityView)
		{
			_entityView.transform.localScale = localScale;
		}
	}

	public override void OnEntityRelease()
	{
		if (_existEntityView)
		{
			_entityView.GetComponent<IPooledObject>()?.Free();
		}
		if (_vTsm != null)
		{
			_vTsm = null;
		}
		_existVTsm = false;
	}

	public void ShowEntityView()
	{
		if (_existEntityView)
		{
			_entityView.gameObject.SetActive(value: true);
		}
	}

	public void SetEntityScale(Vector3 vector3)
	{
		if (_existEntityView)
		{
			_entityView.transform.localScale = vector3;
		}
	}

	public void HideEntityView()
	{
		if (_existEntityView)
		{
			_entityView.gameObject.SetActive(value: false);
		}
	}

	public override void OnDispose()
	{
		if (_entityView != null)
		{
			_entityView.OnDispose();
			_entityView = null;
		}
		_existEntityView = false;
		_bulletData = null;
	}
}
