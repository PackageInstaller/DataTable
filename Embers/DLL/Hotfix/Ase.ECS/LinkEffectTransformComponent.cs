using UnityEngine;

namespace Ase.ECS;

public class LinkEffectTransformComponent : BaseComponent
{
	private LinkEffectEntity _entity;

	private Transform _startPoint;

	private Transform _endPoint;

	private Vector3 _startPointPosition;

	private Vector3 _endPointPosition;

	public override void OnAwake(object data = null)
	{
		base.OnAwake(data);
		_entity = mBaseEntity as LinkEffectEntity;
		if (_entity != null)
		{
			InitPoint();
			PlayLinkEffect();
		}
	}

	public override void OnUpdate(float deltaTime)
	{
		base.OnUpdate(deltaTime);
		PlayLinkEffect();
	}

	private void InitPoint()
	{
		switch (_entity.LinkEffectData.LinkEffectType)
		{
		case EffectPlayPositionType.PositionAndPosition:
			_startPointPosition = _entity.LinkEffectData.StartPosition;
			_endPointPosition = _entity.LinkEffectData.LinkPosition;
			break;
		case EffectPlayPositionType.BonePointAndBonePoint:
			_startPoint = _entity.LinkEffectData.OwnerEntity.GetComponent<EntityBoneComponent>().GetBoneRoot(_entity.LinkEffectData.StartKey);
			_endPoint = _entity.LinkEffectData.LinkEntity.GetComponent<EntityBoneComponent>().GetBoneRoot(_entity.LinkEffectData.LinkKey);
			break;
		case EffectPlayPositionType.EntityAndEntity:
			_startPoint = _entity.LinkEffectData.OwnerEntity.GetComponent<EntityViewComponent>().Transform;
			_endPoint = _entity.LinkEffectData.LinkEntity.GetComponent<EntityViewComponent>().Transform;
			break;
		case EffectPlayPositionType.PointAndEntity:
			_startPointPosition = _entity.LinkEffectData.StartPosition;
			_endPoint = _entity.LinkEffectData.LinkEntity.GetComponent<EntityViewComponent>().Transform;
			break;
		case EffectPlayPositionType.EntityAndPoint:
			_startPoint = _entity.LinkEffectData.OwnerEntity.GetComponent<EntityViewComponent>().Transform;
			_endPointPosition = _entity.LinkEffectData.LinkPosition;
			break;
		}
	}

	public override void OnDispose()
	{
		base.transform.localScale = Vector3.one;
		base.OnDispose();
		_startPoint = null;
		_endPoint = null;
		_startPointPosition = Vector3.zero;
		_endPointPosition = Vector3.zero;
	}

	private void PlayLinkEffect()
	{
		if (!(_startPoint == null) && !(_endPoint == null))
		{
			LinkTargetEntityReviseSize(_startPoint, _endPoint);
		}
	}

	private void LinkTargetEntityReviseSize(Transform startPoint, Transform endPoint)
	{
		Vector3 vector = _startPointPosition;
		if (startPoint != null)
		{
			vector = startPoint.position;
		}
		Vector3 vector2 = _endPointPosition;
		if (endPoint != null)
		{
			vector2 = endPoint.position;
		}
		Vector3 position = (vector + vector2) / 2f;
		Vector3 toDirection = vector - vector2;
		float z = Vector3.Distance(vector, vector2);
		float num = 1f;
		base.transform.localScale = new Vector3(num, num, z);
		Quaternion quaternion = Quaternion.FromToRotation(Vector3.forward, toDirection);
		base.transform.eulerAngles = quaternion.eulerAngles;
		base.transform.position = position;
	}
}
