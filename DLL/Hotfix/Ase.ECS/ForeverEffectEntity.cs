using UnityEngine;

namespace Ase.ECS;

public class ForeverEffectEntity : EffectEntity
{
	public override bool IsSyncPhysicsEntity => true;

	protected override void CheckEffectTimeDispose(float deltaTime)
	{
	}

	public void RePlay(Vector3 position, Vector3 rotation, float scale, bool isClear)
	{
		GetComponent<EntityViewComponent>()?.SetEntityTransform(position, Quaternion.Euler(rotation), Vector3.one * scale, immediately: true);
		(BaseEntityView as EffectView)?.OnRePlay(isClear);
		GetComponent<SoundComponent>()?.TryPlaySound();
	}
}
