using System;
using UnityEngine;

namespace Ase.ECS;

public class EntityViewComponent : BaseComponent
{
	private const string EntityDisplayRoot = "root";

	private AnimatorComponent _animatorComponent;

	private int _battleLayer;

	private EntityBoneComponent _boneComponent;

	private string _curDisplayModelKey;

	private Transform _curDisplayModelTsm;

	private EntityView _entityView;

	private RPGCharacterAnimatorEvents _rpgCharacterAnimator;

	private GameObject _virtualObj;

	private Transform _vTsm;

	private bool _isOpenAnimatorMovement;

	private bool _existVTsm;

	private bool _existEntityView;

	private GameObject hideEntityViewGo;

	private const float KLogNegligibleResidual = -4.6051702f;

	public EntityView EntityView => _entityView;

	public Transform Transform => _vTsm;

	public override void OnAwake(object data = null)
	{
		_boneComponent = mBaseEntity.GetComponent<EntityBoneComponent>();
		_animatorComponent = mBaseEntity.GetComponent<AnimatorComponent>();
		_battleLayer = LayerMask.NameToLayer("Battle");
		GenerateEntityView();
		if (mBaseEntity.GetEntityType() != EntityType.EFFECT)
		{
			TargetEntityRegisterAnimator();
		}
		else
		{
			EffectEntityRegisterAnimator();
		}
		if (mBaseEntity.GetEntityType() == EntityType.MONSTER && !(_curDisplayModelTsm == null))
		{
			_rpgCharacterAnimator = _curDisplayModelTsm.GetComponent<RPGCharacterAnimatorEvents>();
			if (_rpgCharacterAnimator == null)
			{
				_rpgCharacterAnimator = _curDisplayModelTsm.gameObject.AddComponent<RPGCharacterAnimatorEvents>();
			}
			_rpgCharacterAnimator.Init(_animatorComponent.Animator, _vTsm);
		}
	}

	private void GenerateEntityView()
	{
		GameObject entityObject = mBaseEntity.GetEntityObject();
		if (entityObject == null)
		{
			return;
		}
		_vTsm = entityObject.transform;
		_vTsm.position = base.transform.position;
		_vTsm.rotation = base.transform.rotation;
		_vTsm.localScale = base.transform.localScale;
		_existVTsm = true;
		Type entityView = mBaseEntity.GetEntityView();
		if (entityView != null)
		{
			if (entityObject.TryGetComponent(entityView, out var component))
			{
				_entityView = (EntityView)component;
			}
			else
			{
				_entityView = (EntityView)entityObject.AddComponent(entityView);
			}
			_entityView.OnInit(mBaseEntity);
			ChangeEntityLayer();
			_entityView.OnAwake();
			_existEntityView = true;
			if (base.Entity.IsStandby)
			{
				entityObject.SetActive(value: false);
			}
			else
			{
				entityObject.SetActive(base.Entity.ViewInitIsActive);
			}
			mBaseEntity.RegisterEntityViewComponent(_entityView);
		}
	}

	public void GetHideEntityViewRoot()
	{
		EntityBoneComponent component = mBaseEntity.GetComponent<EntityBoneComponent>();
		if (component != null)
		{
			Transform boneRoot = component.GetBoneRoot("CanHide");
			if (!(boneRoot == null))
			{
				hideEntityViewGo = boneRoot.gameObject;
			}
		}
	}

	private void TargetEntityRegisterAnimator()
	{
		if (_animatorComponent != null)
		{
			ResetDisplayModel();
		}
	}

	private void EffectEntityRegisterAnimator()
	{
		if (_animatorComponent != null)
		{
			Animator component = _vTsm.GetComponent<Animator>();
			_animatorComponent.RegisterAnimator(component);
		}
	}

	public void ResetDisplayModel()
	{
		ClearDisplayModel();
		_curDisplayModelKey = "root";
		_curDisplayModelTsm = _boneComponent.GetBoneRoot("root");
		ResetAnimator();
	}

	private void ClearDisplayModel()
	{
		if (_curDisplayModelTsm != null)
		{
			_curDisplayModelTsm.gameObject.SetActive(value: false);
			_curDisplayModelTsm = null;
		}
	}

	public void ChangeDisplayModel(string displayKey)
	{
		if (!string.IsNullOrEmpty(displayKey) && (string.IsNullOrEmpty(_curDisplayModelKey) || !_curDisplayModelKey.Equals(displayKey)))
		{
			Transform boneRoot = _boneComponent.GetBoneRoot(displayKey);
			if (!(boneRoot == null))
			{
				ClearDisplayModel();
				_curDisplayModelKey = displayKey;
				_curDisplayModelTsm = boneRoot;
				ResetAnimator();
			}
		}
	}

	private void ResetAnimator()
	{
		if (!(_curDisplayModelTsm == null))
		{
			_curDisplayModelTsm.gameObject.SetActive(value: true);
			Animator component = _curDisplayModelTsm.GetComponent<Animator>();
			_animatorComponent.RegisterAnimator(component);
		}
	}

	private void ChangeEntityLayer()
	{
		if (_vTsm.gameObject.layer == LayerMask.NameToLayer("Default") || _vTsm.gameObject.layer == LayerMask.NameToLayer("Hide"))
		{
			SetEntityObjectLayer(_battleLayer);
		}
	}

	public void SetEntityObjectLayer(int layer)
	{
		if (_existVTsm)
		{
			_vTsm.gameObject.SetLayerRecursively(layer);
		}
	}

	public void ChangeParent(Transform parent, bool isStayWorldPosition = false)
	{
		if (!(parent == null) && _existVTsm)
		{
			_vTsm.SetParent(parent, isStayWorldPosition);
		}
	}

	public override void OnStart(object data = null)
	{
		if (_existEntityView)
		{
			_entityView.OnStart(data);
		}
	}

	public void IsOpenInterpolationMovement(bool openInterpolation)
	{
		mBaseEntity.SwitchEntityViewLerp(openInterpolation);
	}

	public void ChangeEntityMovementInterpolationSpeed(float moveSharpness, float rotationSharpness)
	{
		mBaseEntity.SwitchEntityViewLerp(viewIsNeedLerp: true, moveSharpness, rotationSharpness);
	}

	public void IsOpenAnimatorMovement(bool isOpen)
	{
		if (_rpgCharacterAnimator != null)
		{
			_isOpenAnimatorMovement = isOpen;
			_rpgCharacterAnimator.OpenAnimatorMovement(isOpen);
		}
	}

	public override void OnUpdate(float deltaTime)
	{
		if (mBaseEntity == null || _entityView == null || _vTsm == null || !_existVTsm)
		{
			return;
		}
		if (_existEntityView)
		{
			_entityView.OnUpdate(deltaTime);
		}
		if (!_isOpenAnimatorMovement && mBaseEntity.SyncPosition)
		{
			if (!mBaseEntity.ViewNeedLerp)
			{
				_vTsm.position = mBaseEntity.transform.position;
				_vTsm.rotation = mBaseEntity.transform.rotation;
			}
			else
			{
				float num = 4.6051702f / mBaseEntity.ViewMovementSharpness;
				Vector3 vector = (mBaseEntity.transform.position - _vTsm.position) * (1f - Mathf.Exp((0f - num) * deltaTime));
				_vTsm.position += vector;
				_vTsm.rotation = Quaternion.Slerp(_vTsm.rotation, mBaseEntity.transform.rotation, mBaseEntity.EntityGameSpeed * deltaTime / mBaseEntity.ViewRotationSharpness);
			}
			SetEntityScale();
		}
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		if (_existEntityView)
		{
			_entityView.OnFixedUpdate(updateType, deltaTime);
		}
	}

	public override void OnEntityRelease()
	{
		if (_vTsm != null)
		{
			_vTsm = null;
		}
		_existVTsm = false;
	}

	private bool DoDeadReleaseEffect()
	{
		if (mBaseEntity is EffectEntity)
		{
			if (mBaseEntity.Parent == null)
			{
				return true;
			}
			if (mBaseEntity.Parent.IsSurvival)
			{
				return false;
			}
			if (!mBaseEntity.Parent.IsDeadReleaseEffect())
			{
				return false;
			}
			return true;
		}
		return false;
	}

	public void ShowEntityView()
	{
		if (hideEntityViewGo != null)
		{
			hideEntityViewGo.SetActive(value: true);
		}
		else if (_existEntityView)
		{
			_entityView.gameObject.SetActive(value: true);
		}
	}

	public void HideEntityView()
	{
		if (hideEntityViewGo != null)
		{
			hideEntityViewGo.SetActive(value: false);
		}
		else if (_existEntityView)
		{
			_entityView.gameObject.SetActive(value: false);
		}
	}

	public void SetEntityTransform(Vector3 position, Quaternion rotation, Vector3 scale, bool immediately)
	{
		base.transform.position = position;
		base.transform.rotation = rotation;
		base.transform.localScale = scale;
		if (immediately && _existEntityView)
		{
			_entityView.transform.position = position;
			_entityView.transform.rotation = rotation;
			_entityView.transform.localScale = scale;
		}
	}

	public void SetEntityPosition(Vector3 position, bool immediately)
	{
		base.transform.position = position;
		if (immediately && _existEntityView)
		{
			_entityView.transform.position = position;
		}
	}

	public void SetEntityRotation(Quaternion rotation, bool immediately)
	{
		base.transform.rotation = rotation;
		if (immediately && _existEntityView)
		{
			_entityView.transform.rotation = rotation;
		}
	}

	public void SetEntityScale(Vector3 vector3)
	{
		base.transform.localScale = vector3;
	}

	protected void SetEntityScale()
	{
		if (!_existEntityView)
		{
			return;
		}
		if (mBaseEntity is EffectEntity effectEntity)
		{
			DREffect config = effectEntity.Config;
			if (config != null && config.ChangeScale)
			{
				CapsuleCollider bodyCollider = (mBaseEntity.Parent?.GetTypeOfComponent<ColllisionComponent>()).GetBodyCollider();
				if ((UnityEngine.Object)(object)bodyCollider != null)
				{
					Vector3 vector = base.transform.localScale * bodyCollider.radius;
					if (_entityView.transform.localScale != vector)
					{
						_entityView.transform.localScale = vector;
					}
				}
				return;
			}
		}
		if (_entityView.transform.localScale != base.transform.localScale)
		{
			_entityView.transform.localScale = base.transform.localScale;
		}
	}

	public void SetEntityScale(Vector3 vector3, string pointName)
	{
		if (!_existEntityView)
		{
			return;
		}
		if (string.IsNullOrEmpty(pointName))
		{
			SetEntityScale(vector3);
			return;
		}
		Transform boneRoot = mBaseEntity.GetComponent<EntityBoneComponent>().GetBoneRoot(pointName);
		if (!(boneRoot == null))
		{
			boneRoot.localScale = vector3;
		}
	}

	public override void OnDispose()
	{
		if (_entityView != null)
		{
			_entityView.OnDispose();
			if (DoDeadReleaseEffect())
			{
				_entityView.GetComponent<IPooledObject>()?.Release();
			}
			else
			{
				_entityView.GetComponent<IPooledObject>()?.Free();
			}
			_entityView = null;
		}
		_existEntityView = false;
		_rpgCharacterAnimator = null;
		if (_virtualObj != null)
		{
			UnityEngine.Object.DestroyImmediate(_virtualObj);
			_virtualObj = null;
		}
		base.OnDispose();
	}
}
