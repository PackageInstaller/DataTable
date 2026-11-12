using System.Collections.Generic;
using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/武器特性/阻挡子弹")]
[DisallowMultipleComponent]
public class WeaponFeatureBlockBullet : WeaponFeature
{
	public HitBox.Shape shape;

	public FP width = 1f;

	public FP length = 1f;

	public FP radius = 1f;

	public FP innerRadius = 0f;

	public FP angle = 45f;

	public FP rotation = 0f;

	public TSVector2 offset;

	public TargetType targetType = TargetType.Enemy;

	public GameObject finishPrefab;

	protected DeterministicShape _deterministicShape;

	protected List<DeterministicCollider> _bulletCollider;

	public override void OnActive()
	{
		base.OnActive();
		switch (shape)
		{
		case HitBox.Shape.Rectangle:
			_deterministicShape.shapeType = DeterministicShape.ShapeType.Rectangle;
			break;
		case HitBox.Shape.Circle:
			_deterministicShape.shapeType = DeterministicShape.ShapeType.Circle;
			break;
		case HitBox.Shape.Fan:
			_deterministicShape.shapeType = DeterministicShape.ShapeType.Fan;
			break;
		}
		_deterministicShape.position = attachedWeapon.tsTransform.Position + offset;
		_deterministicShape.rotation = attachedWeapon.tsTransform.Rotation + rotation;
		_deterministicShape.width = width * attachedWeapon.transform.localScale.x;
		_deterministicShape.length = length * attachedWeapon.transform.localScale.z;
		_deterministicShape.radius = radius * attachedWeapon.transform.localScale.x;
		_deterministicShape.innerRadius = innerRadius * attachedWeapon.transform.localScale.x;
		_deterministicShape.angle = angle;
	}

	public override void OnUpdate()
	{
		base.OnUpdate();
		GetAllBulletByArea();
		List<DeterministicCollider> bulletCollider = _bulletCollider;
		if (bulletCollider == null || bulletCollider.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < _bulletCollider.Count; i++)
		{
			if (_bulletCollider.get_Item(i).Entity is AdventureWeapon adventureWeapon && !(adventureWeapon == attachedWeapon) && adventureWeapon.canBeBlock && !(attachedWeapon.owner == null) && attachedWeapon.owner.CheckTarget(adventureWeapon.owner, targetType))
			{
				if (finishPrefab != null)
				{
					AdventureFXPlayer.PlayFX(finishPrefab, (float)attachedWeapon.owner.logicTimeScale, adventureWeapon.transform.position, adventureWeapon.transform.rotation, attachedWeapon.transform.localScale.x).Bind(attachedWeapon.gameObject);
				}
				adventureWeapon.Finish(cancel: true);
			}
		}
	}

	protected void GetAllBulletByArea()
	{
		if (_bulletCollider == null)
		{
			_bulletCollider = new List<DeterministicCollider>(16);
		}
		else
		{
			_bulletCollider.Clear();
		}
		bool drawGizmos = false;
		SceneSingleton<DeterministicCollisionManager>.Instance.GetTargetByShape(_bulletCollider, _deterministicShape, 33280, drawGizmos);
	}
}
