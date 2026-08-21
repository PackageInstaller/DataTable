using Ase;
using Ase.ECS;
using UnityEngine;

public class FollowParentEntityTransformComponent : BaseComponent
{
	private BaseEntity _pareEntity;

	private Vector3 _offset;

	private bool _followFlag;

	private EffectType _effectType;

	private EffectData effectData;

	private Camera battleCamera;

	private Camera effectCamera;

	private int battleLayer = LayerMask.NameToLayer("Battle");

	private int effectLayer = LayerMask.NameToLayer("ScreenEffect");

	private int curLayer;

	private float marginX;

	private float marginY;

	private float outScreenLimitMinX;

	private float outScreenLimitMaxX;

	private float outScreenLimitMinY;

	private float outScreenLimitMaxY;

	public override void OnAwake(object data = null)
	{
		base.OnAwake(data);
		battleCamera = mBaseEntity.GetSystem<CameraSystem>()?.BattleCamera;
		effectCamera = mBaseEntity.GetSystem<CameraSystem>()?.EffectCamera;
		if (mBaseEntity is EffectEntity effectEntity)
		{
			effectData = effectEntity.EffectData;
		}
	}

	public override void OnStart(object data = null)
	{
		base.OnStart(data);
		_pareEntity = GetData<BaseEntity>("ParentEntity");
		_offset = GetData<Vector3>("Offset");
		_effectType = GetData<EffectType>("EffectType");
		StartFollow();
		EffectData obj = effectData;
		if (obj != null && obj.effectType == EffectType.FOLLOW_BONE_SCREEN_LIMIT)
		{
			BattleConfig battleConfig = mBaseEntity.GetWorld().BattleConfig;
			marginX = battleConfig.EffectScreenLimitX;
			marginY = battleConfig.EffectScreenLimitY;
			outScreenLimitMinX = battleConfig.EffectScreenOutScreenLimitMinX;
			outScreenLimitMaxX = battleConfig.EffectScreenOutScreenLimitMaxX;
			outScreenLimitMinY = battleConfig.EffectScreenOutScreenLimitMinY;
			outScreenLimitMaxY = battleConfig.EffectScreenOutScreenLimitMaxY;
			mBaseEntity.GetComponent<EntityViewComponent>()?.SetEntityObjectLayer(battleLayer);
			curLayer = battleLayer;
			ClampCenterWithViewportMargin(immediately: true);
		}
	}

	private void StartFollow()
	{
		_followFlag = true;
	}

	public void StopFollow()
	{
		if (_effectType == EffectType.FOLLOW_BONE)
		{
			mBaseEntity.GetComponent<EntityViewComponent>()?.ChangeParent(mBaseEntity.GetWorld().EntityRoot, isStayWorldPosition: true);
		}
		_followFlag = false;
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
	}

	public override void OnFixedUpdateAfter(WorldUpdateType updateType)
	{
		CalculatePosition();
	}

	public override void OnUpdate(float deltaTime)
	{
		if (_effectType == EffectType.FOLLOW_BONE_POSITION)
		{
			Vector3 centerPos = effectData.boneTsm?.position ?? _pareEntity.transform.position;
			base.transform.position = TSUtil.TransformPoint(centerPos, Vector3.zero, _pareEntity.transform.localScale, _offset);
			mBaseEntity.GetComponent<EntityViewComponent>()?.SetEntityPosition(base.transform.position, immediately: true);
		}
	}

	private void CalculatePosition()
	{
		if (!_followFlag)
		{
			return;
		}
		if (!_pareEntity.IsSurvival)
		{
			if (mBaseEntity is EffectEntity effectEntity)
			{
				effectEntity.IsSyncPosition = false;
			}
		}
		else if (_pareEntity?.transform != null)
		{
			if (_effectType == EffectType.FOLLOW_ENTITY || _effectType == EffectType.FOLLOW_EFFECTMOVE)
			{
				base.transform.position = TSUtil.TransformPoint(_pareEntity.transform.position, Vector3.zero, _pareEntity.transform.localScale, _offset);
			}
			else if (_effectType == EffectType.FOLLOW_BONE_SCREEN_LIMIT)
			{
				ClampCenterWithViewportMargin();
			}
		}
	}

	public void ClampCenterWithViewportMargin(bool immediately = false)
	{
		if (battleCamera == null || effectCamera == null || _pareEntity == null)
		{
			return;
		}
		EntityViewComponent component = mBaseEntity.GetComponent<EntityViewComponent>();
		if (component == null)
		{
			return;
		}
		Vector3 position = TSUtil.TransformPoint(effectData.boneTsm?.position ?? _pareEntity.transform.position, Vector3.zero, _pareEntity.transform.localScale, _offset);
		Vector3 vector = battleCamera.WorldToViewportPoint(position);
		bool flag = vector.x < 0f - outScreenLimitMinX || vector.x > 1f + outScreenLimitMaxX || vector.y < 0f - outScreenLimitMinY || vector.y > 1f + outScreenLimitMaxY;
		if ((!(vector.x < marginX) && !(vector.x > 1f - marginX) && !(vector.y < marginY) && !(vector.y > 1f - marginY)) | flag)
		{
			if (curLayer != battleLayer)
			{
				component.SetEntityObjectLayer(battleLayer);
				curLayer = battleLayer;
				component.SetEntityPosition(position, immediately: true);
			}
			else
			{
				component.SetEntityPosition(position, immediately: true);
			}
			return;
		}
		Vector3 position2 = battleCamera.WorldToScreenPoint(position);
		position2.x = Mathf.Clamp(position2.x, (float)Screen.width * marginX, (float)Screen.width * (1f - marginX));
		position2.y = Mathf.Clamp(position2.y, (float)Screen.height * marginY, (float)Screen.height * (1f - marginY));
		Vector3 position3 = effectCamera.ScreenToWorldPoint(position2);
		if (curLayer != effectLayer)
		{
			component.SetEntityObjectLayer(effectLayer);
			curLayer = effectLayer;
			component.SetEntityPosition(position3, immediately: true);
		}
		else
		{
			component.SetEntityPosition(position3, immediately);
		}
	}
}
