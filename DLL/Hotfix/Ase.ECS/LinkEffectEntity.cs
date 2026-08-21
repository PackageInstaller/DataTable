using System;

namespace Ase.ECS;

public class LinkEffectEntity : BaseEntity, IEffectHelper
{
	private LinkEffectData _data;

	private DREffect _effect;

	private float _duration;

	private bool _isTimeDelayDispose;

	public bool IsTeamMetaEffect;

	public bool IsTeamMetaAttackEffect;

	public LinkEffectData LinkEffectData => _data;

	public bool IsFrozenEffect => _effect.IsFrozenEffect;

	public int ConfigId => _effect.Id;

	public override void OnInit(object data = null)
	{
		base.OnInit(data);
		_data = (LinkEffectData)userData;
		if (_data != null)
		{
			_effect = _data.DrEffect;
			_duration = _effect.Duration;
			_isTimeDelayDispose = _duration > 0f;
			ChangeUpdateType(EntityUpdateType.Local);
			EntitySystem system = this.GetSystem<EntitySystem>();
			if (system != null && system.GetEntityIsTeam(_data.OwnerEntity))
			{
				IsTeamMetaEffect = true;
			}
		}
	}

	public override void OnAwake(object data = null)
	{
		base.OnAwake(data);
		SoundAttaching();
	}

	private void SoundAttaching()
	{
		GetComponent<SoundComponent>()?.RegistSound(_effect, delayStartBaseFrozen: true, this, this);
		GetComponent<SoundComponent>()?.TryPlaySound();
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		base.OnFixedUpdate(updateType, deltaTime);
		if (!base.IsSurvival && !base.IsStandby)
		{
			return;
		}
		if (_data.OwnerEntity.IsStandby && !base.IsStandby)
		{
			ChangeEntityStandby();
		}
		else if (_data.OwnerEntity.IsSurvival && base.IsStandby)
		{
			ReactivateEntity();
		}
		if ((!_data.OwnerEntity.IsSurvival && !_data.OwnerEntity.IsStandby) || (!_data.LinkEntity.IsSurvival && !_data.LinkEntity.IsStandby))
		{
			DoEntityDead();
		}
		if (_isTimeDelayDispose && _duration > 0f)
		{
			_duration -= deltaTime * frozenSpeed;
			if (_duration <= 0f)
			{
				DoEntityDead();
			}
		}
	}

	public override bool IgnoreTimeScale()
	{
		if (LinkEffectData == null || LinkEffectData.DrEffect == null)
		{
			return false;
		}
		return LinkEffectData.DrEffect.IgnoreGlobalTimeScale;
	}

	protected override void OnEntityStandby()
	{
		GetComponent<EntityViewComponent>().HideEntityView();
		GetComponent<TransformComponent>().HideEntityView();
	}

	protected override void OnReactivateEntity()
	{
		GetComponent<EntityViewComponent>().ShowEntityView();
		GetComponent<TransformComponent>().ShowEntityView();
	}

	protected override Type[] GetEntityComps()
	{
		return new Type[5]
		{
			typeof(EntityViewComponent),
			typeof(EntityBoneComponent),
			typeof(TransformComponent),
			typeof(SoundComponent),
			typeof(LinkEffectTransformComponent)
		};
	}

	public override Type GetEntityView()
	{
		return typeof(EffectView);
	}

	public override EntityType GetEntityType()
	{
		return EntityType.EFFECT;
	}

	public override CampType GetEntityCampType()
	{
		return CampType.Unknown;
	}

	public BaseEntity GetEffectOwner()
	{
		return _data.OwnerEntity;
	}
}
