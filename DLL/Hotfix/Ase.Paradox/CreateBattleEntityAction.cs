using Ase.ECS;
using GameFramework;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("创建战斗实体", 0)]
[Category("✫ DragonLost/BattleEntity")]
[Description("用于创建战斗实体")]
public class CreateBattleEntityAction : ActionTaskBase
{
	public BBParameter<int> battleEntityConfigId;

	[Name("基于自身坐标创建", 0)]
	[Description("指示是否基于执行者的坐标来创建实体")]
	public bool useSelfPoint = true;

	[Name("初始位置偏移配置类型", 0)]
	[Description("指定初始位置偏移的配置类型")]
	public OffsetConfigurationType ConfigurationType;

	[ShowIf("useSelfPoint", 1)]
	public BBParameter<Vector3> offset;

	[ShowIf("useSelfPoint", 0)]
	public BBParameter<Vector3> position;

	[Name("自身朝向", 0)]
	[Description("指定新创建实体的初始朝向")]
	public BBParameter<float> rotation;

	[Name("返回实体Id", 0)]
	[Description("用于存储新创建实体的ID")]
	public BBParameter<int> returnEntityId;

	[Name("跟随行为树结束销毁", 0)]
	public bool isDisposeFollowTree;

	private BaseEntity entity;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (battleEntityConfigId == null)
		{
			OnActionFinish();
			return;
		}
		DRBattleEntityConfig dataRow = GameEntry.DataTable.GetDataRow<DRBattleEntityConfig>(battleEntityConfigId.value);
		if (dataRow == null)
		{
			OnActionFinish();
			return;
		}
		GameObject gameObject = null;
		if (ownerEntity.GetWorld().IsNeedExecuteViewSystem)
		{
			gameObject = ownerEntity.GetSystem<EntityViewCacheSystem>().LoadEntityView(dataRow.Id, dataRow.AssetPath);
		}
		EntityData entityData = ReferencePool.Acquire<EntityData>();
		entityData.logicType = ownerEntity.LogicType;
		entityData.updateType = EntityUpdateType.Local;
		EntityPositionData entityPositionData = ReferencePool.Acquire<EntityPositionData>();
		entityPositionData.rotation = new Vector3(0f, rotation.value, 0f);
		Vector3 vector = (useSelfPoint ? ownerEntity.transform.position : position.value);
		switch (ConfigurationType)
		{
		case OffsetConfigurationType.Offset:
			entityPositionData.position = vector + ownerEntity.transform.rotation * offset.value;
			break;
		case OffsetConfigurationType.Direct:
			entityPositionData.position = vector + offset.value;
			break;
		}
		entityData.pointData = entityPositionData;
		entityData.userData = dataRow;
		entityData.parent = ownerEntity;
		entityData.entityObject = gameObject;
		if ((bool)gameObject)
		{
			entityData.collisionLayer = gameObject.GetComponent<EntityCollisionLayer>()?.Layer ?? CollisionSetting.CollisionLayer.Hero;
			entityData.collisionMass = gameObject.GetComponent<EntityCollisionLayer>()?.Mass ?? 0;
		}
		entityData.campType = (CampType)dataRow.CampType;
		entity = ownerEntity.GetSystem<EntitySystem>().CreateEntity<BattleEntity>(dataRow.Id, entityData);
		returnEntityId.value = entity.Id;
		OnActionFinish();
	}

	protected override void OnGraphStop()
	{
		if (isDisposeFollowTree && entity != null)
		{
			entity.DoEntityDead();
		}
	}
}
