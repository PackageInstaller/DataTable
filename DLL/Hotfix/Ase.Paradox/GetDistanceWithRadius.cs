using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("获取双方碰撞距离", 0)]
[Description("获取当前实体与目标实体之间的碰撞距离。")]
[Category("✫ DragonLost/Target")]
public class GetDistanceWithRadius : ActionTaskBase
{
	[Name("返回的碰撞距离", 0)]
	[Description("存储获取到的碰撞距离。")]
	public BBParameter<float> distance;

	[Name("目标ID", 0)]
	[Description("指定目标实体的ID。")]
	public BBParameter<int> target;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = ownerEntity.GetSystem<EntitySystem>().GetEntity(target.value);
		if (entity != null)
		{
			HitColliderComponent typeOfComponent = ownerEntity.GetTypeOfComponent<HitColliderComponent>();
			if (typeOfComponent == null)
			{
				EndAction(success: false);
				return;
			}
			Vector3 position = ownerEntity.transform.position;
			Vector3 colliderParam = typeOfComponent.GetColliderParam();
			Vector3 position2 = entity.transform.position;
			Vector3 colliderParam2 = entity.GetTypeOfComponent<HitColliderComponent>().GetColliderParam();
			distance.value = (position.ToVector2() - position2.ToVector2()).magnitude - colliderParam.x - colliderParam2.x;
		}
		EndAction();
	}
}
