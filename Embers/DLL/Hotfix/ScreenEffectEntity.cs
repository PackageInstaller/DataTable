using System;
using Ase;
using Ase.ECS;
using UnityEngine;

public class ScreenEffectEntity : EffectEntity, IEffectHelper
{
	protected Camera battleCamera;

	protected Camera effectCamera;

	public override void OnInit(object data = null)
	{
		base.OnInit(data);
		CameraSystem system = this.GetSystem<CameraSystem>();
		if (system != null && !(system.BattleCamera == null) && !(system.EffectCamera == null))
		{
			battleCamera = system.BattleCamera;
			effectCamera = system.EffectCamera;
			if (effectData.isFollowBone)
			{
				InternalUpdateScreenPosition();
			}
			else
			{
				base.transform.position = effectData.offset;
			}
		}
	}

	public override void OnAwake(object data = null)
	{
		base.OnAwake(data);
		IsSyncPosition = effectData.isFollowBone;
	}

	public override void OnUpdate(float deltaTime)
	{
		OnUpdateScreenPosition();
		base.OnUpdate(deltaTime);
	}

	protected void OnUpdateScreenPosition()
	{
		if (IsSyncPosition)
		{
			InternalUpdateScreenPosition();
		}
	}

	protected void InternalUpdateScreenPosition()
	{
		if (effectData.boneTsm != null && battleCamera != null && effectCamera != null)
		{
			Vector3 position = battleCamera.WorldToScreenPoint(effectData.boneTsm.position);
			Vector3 vector = effectCamera.ScreenToWorldPoint(position);
			base.transform.position = vector + effectData.offset;
		}
	}

	public override bool IgnoreTimeScale()
	{
		return base.IgnoreTimeScale();
	}

	protected override Type[] GetEntityComps()
	{
		return new Type[5]
		{
			typeof(EntityViewComponent),
			typeof(EntityBoneComponent),
			typeof(TransformComponent),
			typeof(SoundComponent),
			typeof(AnimatorComponent)
		};
	}

	public override Type GetEntityView()
	{
		return typeof(ScreenEffectView);
	}

	public override EntityType GetEntityType()
	{
		return EntityType.EFFECT;
	}

	public override CampType GetEntityCampType()
	{
		return CampType.Unknown;
	}
}
