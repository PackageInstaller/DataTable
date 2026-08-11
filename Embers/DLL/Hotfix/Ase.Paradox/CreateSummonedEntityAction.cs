using Ase.ECS;
using GameFramework;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("创建召唤物实体", 0)]
[Category("✫ DragonLost/SummonedEntity")]
[Description("用于创建召唤物实体")]
public class CreateSummonedEntityAction : ActionTaskBase
{
	[Name("召唤物配置ID", 0)]
	public BBParameter<int> SummonedEntityConfigId;

	[Name("基于自身坐标创建", 0)]
	[Description("指示是否基于执行者的坐标来创建实体")]
	public bool UseSelfPoint = true;

	[Name("是否当帧创建", 0)]
	public bool IsCurTickCreate;

	[Name("初始位置偏移配置类型", 0)]
	[Description("指定初始位置偏移的配置类型")]
	public OffsetConfigurationType ConfigurationType;

	[ShowIf("UseSelfPoint", 1)]
	public BBParameter<Vector3> offset;

	[ShowIf("UseSelfPoint", 0)]
	public BBParameter<Vector3> position;

	[Name("自身朝向", 0)]
	[Description("指定新创建实体的初始朝向")]
	public BBParameter<float> rotation;

	[Name("是否同步召唤者指令", 0)]
	[Description("开启会同步英雄的指令")]
	public bool IsSyncHeroCommand;

	[Name("返回实体Id", 0)]
	[Description("用于存储新创建实体的ID")]
	public BBParameter<int> ReturnEntityId;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (SummonedEntityConfigId == null)
		{
			OnActionFinish();
			return;
		}
		if (ownerEntity == null || ownerEntity.GetEntityType() != EntityType.HERO)
		{
			OnActionFinish();
			return;
		}
		DRSummonedEntityConfig dataRow = GameEntry.DataTable.GetDataRow<DRSummonedEntityConfig>(SummonedEntityConfigId.value);
		if (dataRow == null)
		{
			OnActionFinish();
			return;
		}
		string summonedSkinPathByParentSkinConfig = ownerEntity.GetSummonedSkinPathByParentSkinConfig(dataRow.Id);
		GameObject gameObject = GetOwnerEntity().GetSystem<EntityViewCacheSystem>().LoadEntityView(dataRow.Id, string.IsNullOrEmpty(summonedSkinPathByParentSkinConfig) ? dataRow.AssetPath : summonedSkinPathByParentSkinConfig);
		EntityData entityData = ReferencePool.Acquire<EntityData>();
		entityData.logicType = ownerEntity.LogicType;
		entityData.updateType = EntityUpdateType.Local;
		EntityPositionData entityPositionData = ReferencePool.Acquire<EntityPositionData>();
		entityPositionData.rotation = new Vector3(0f, rotation.value, 0f);
		Vector3 vector = (UseSelfPoint ? ownerEntity.transform.position : position.value);
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
		entityData.campType = ownerEntity.GetEntityCampType();
		if ((bool)gameObject)
		{
			entityData.entityObject = gameObject;
			entityData.collisionLayer = gameObject.GetComponent<CollisionLayer>()?.Layer ?? CollisionSetting.CollisionLayer.Hero;
			entityData.collisionMass = gameObject.GetComponent<CollisionLayer>()?.Mass ?? 0;
		}
		else
		{
			entityData.collisionLayer = CollisionSetting.CollisionLayer.Hero | CollisionSetting.CollisionLayer.IgnoreBoss;
			entityData.collisionMass = 3;
		}
		SummonedEntity summonedEntity = ownerEntity.GetSystem<EntitySystem>().CreateEntity<SummonedEntity>(dataRow.Id, entityData, isSyncEntity: false, IsCurTickCreate);
		ReturnEntityId.value = summonedEntity.Id;
		ownerEntity.GetComponent<SummonedComponent>().RegisterSummonedEntity(summonedEntity, IsSyncHeroCommand);
		OnActionFinish();
	}
}
