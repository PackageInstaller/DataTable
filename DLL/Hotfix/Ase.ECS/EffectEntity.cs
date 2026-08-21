using System;

namespace Ase.ECS;

public class EffectEntity : BaseEntity, IEffectHelper, IObserverHandler
{
	protected EffectData effectData;

	private DREffect _effect;

	protected float _duration;

	protected float delayDeadDuration;

	protected string delayDeadAnimationName;

	protected bool _isTimeDelayDispose;

	public bool IsSyncPosition;

	public bool IsTeamMetaEffect;

	public bool IsTeamMetaAttackEffect;

	public EffectData EffectData => effectData;

	public DREffect Config => _effect;

	public override string AssetPath => GetAssetPath(Config);

	public override bool SyncPosition => IsSyncPosition;

	public bool IsFrozenEffect => _effect.IsFrozenEffect;

	public int ConfigId => _effect.Id;

	public float StartToPerformTime => _effect.StartToPerformTime;

	public override void OnInit(object data = null)
	{
		base.OnInit(data);
		effectData = (EffectData)userData;
		if (effectData != null)
		{
			SetData("EffectType", effectData.effectType);
			SetData("ParentEntity", effectData.owner);
			SetData("Offset", effectData.offset);
			callbacks = new EntityCallbacks(EntityDead, null);
			_effect = effectData.effectData;
			_duration = _effect.Duration;
			SwitchEntityViewLerp(effectData.ViewIsNeedLerp, effectData.StableMovementSharpness, effectData.StableRotationSharpness);
			delayDeadDuration = _effect.DelayTime;
			delayDeadAnimationName = _effect.DefaultAnimation;
			_isTimeDelayDispose = _duration > 0f;
			ChangeUpdateType(EntityUpdateType.Local);
			EntitySystem system = this.GetSystem<EntitySystem>();
			if (system != null && system.GetEntityIsTeam(effectData.owner))
			{
				IsTeamMetaEffect = true;
				IsTeamMetaAttackEffect = effectData.IsAttackEffect;
			}
		}
	}

	public override void OnAwake(object data = null)
	{
		base.OnAwake(data);
		IsSyncPosition = effectData.effectType == EffectType.FOLLOW_ENTITY || effectData.effectType == EffectType.FOLLOW_EFFECTMOVE || effectData.effectType == EffectType.FOLLOW_BONE_SCREEN_LIMIT || effectData.effectType == EffectType.FOLLOW_BONE_POSITION;
		if (effectData.effectType == EffectType.FOLLOW_BONE)
		{
			GetComponent<EntityViewComponent>()?.ChangeParent(effectData.boneTsm);
		}
		SoundAttaching();
		this.GetSystem<BattleObserverSystem>().Attach(BattleObserverEventEnum.ChangeTeam, this);
	}

	public override void OnStart(object data = null)
	{
		base.OnStart(data);
		if (GetWorld().IsSoftPaused && !isFrozen)
		{
			OnPause();
		}
	}

	private void PlayDefaultAnimation()
	{
		if (!string.IsNullOrEmpty(delayDeadAnimationName))
		{
			GetComponent<AnimatorComponent>()?.PlayAnimation(delayDeadAnimationName);
		}
	}

	protected void SoundAttaching()
	{
		GetComponent<SoundComponent>()?.RegistSound(_effect, delayStartBaseFrozen: true, this, this);
		GetComponent<SoundComponent>()?.TryPlaySound();
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		base.OnFixedUpdate(updateType, deltaTime);
		if (effectData != null && effectData.owner != null && (base.IsSurvival || base.IsStandby))
		{
			if (effectData.owner.IsStandby && !base.IsStandby)
			{
				ChangeEntityStandby();
			}
			else if (effectData.owner.IsSurvival && base.IsStandby)
			{
				ReactivateEntity();
			}
			if (effectData.followDispose && !effectData.owner.IsSurvival && !effectData.owner.IsStandby)
			{
				DoEntityDead();
			}
			CheckEffectTimeDispose(deltaTime * frozenSpeed);
		}
	}

	private void EntityDead(BaseEntity baseEntity, bool isnormal)
	{
		if (parent != null)
		{
			parent.GetComponent<EffectControlComponent>()?.RemoveEffect(this);
		}
	}

	public void OnNotify(IObserverParams param)
	{
		if (param.ObserverEventType == BattleObserverEventEnum.ChangeTeam && !effectData.followDispose)
		{
			DoEntityDead();
		}
	}

	public override void OnDispose()
	{
		base.OnDispose();
		this.GetSystem<BattleObserverSystem>().Detach(BattleObserverEventEnum.ChangeTeam, this);
	}

	protected virtual void CheckEffectTimeDispose(float deltaTime)
	{
		if (!_isTimeDelayDispose)
		{
			return;
		}
		if (_duration > 0f)
		{
			_duration -= deltaTime;
			if (_duration <= 0f && delayDeadDuration > 0f)
			{
				PlayDefaultAnimation();
			}
			return;
		}
		if (delayDeadDuration > 0f)
		{
			delayDeadDuration -= deltaTime;
		}
		if (delayDeadDuration <= 0f)
		{
			DoEntityDead();
		}
	}

	public void SetTimeDelayDispose(bool dispose)
	{
		_isTimeDelayDispose = dispose;
	}

	public void SetDuration(float duration)
	{
		_duration = duration;
		if (duration <= 0f)
		{
			PlayDefaultAnimation();
		}
	}

	public override bool IgnoreTimeScale()
	{
		if (EffectData == null || EffectData.effectData == null)
		{
			return false;
		}
		return EffectData.effectData.IgnoreGlobalTimeScale;
	}

	public void SetDelayDeadAnimationName(string name)
	{
		delayDeadAnimationName = name;
	}

	public void SetDelayDeadDuration(float duration)
	{
		delayDeadDuration = duration;
	}

	public override void OnPause()
	{
		base.OnPause();
	}

	public override void OnResume()
	{
		base.OnResume();
	}

	public override void OnPauseBefore()
	{
		base.OnPauseBefore();
		if (!_effect.PauseDestroy)
		{
			DoEntityDead();
		}
	}

	public override void OnLevelFail()
	{
		base.OnLevelFail();
		if (!_effect.PauseDestroy)
		{
			DoEntityDead();
		}
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

	private string GetAssetPath(DREffect drEffect)
	{
		if (drEffect == null)
		{
			return null;
		}
		return this.GetSystem<EffectSystem>()?.GetEffectAssetPathByLevel(drEffect);
	}

	protected override Type[] GetEntityComps()
	{
		return new Type[6]
		{
			typeof(FollowParentEntityTransformComponent),
			typeof(EntityViewComponent),
			typeof(AnimatorComponent),
			typeof(EntityBoneComponent),
			typeof(TransformComponent),
			typeof(SoundComponent)
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
		return EffectData.owner;
	}
}
