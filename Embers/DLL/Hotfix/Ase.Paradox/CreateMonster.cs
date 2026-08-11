using System;
using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("创建怪物", 0)]
[Description("根据指定的怪物 ID 和等级在场景中创建怪物，并设置相关属性。")]
[Category("✫ DragonLost/Entity")]
public class CreateMonster : ActionTaskBase
{
	[Name("怪物阵营", 0)]
	[Description("设置怪物的阵营类型。")]
	public BBParameter<CampType> campType;

	[Name("怪物ID", 0)]
	[Description("生成的实体ID")]
	public BBParameter<int> monsterId;

	[Name("怪物Id", 0)]
	[Description("指定要创建的怪物的类型 ID。")]
	public BBParameter<int> monsterTypeId;

	[Name("怪物坐标", 0)]
	[Description("指定要创建的怪物的坐标。")]
	public BBParameter<Vector3> position;

	[Name("初始位置偏移配置类型", 0)]
	[Description("配置怪物初始位置偏移的类型,注意direct模式会忽略掉怪物坐标这个参数！")]
	public OffsetConfigurationType ConfigurationType;

	[Name("位置偏移量", 0)]
	[ShowIf("ConfigurationType", 0)]
	[Description("怪物的位置偏移量")]
	public BBParameter<Vector3> offset = Vector3.zero;

	[Name("水平距离", 0)]
	[ShowIf("ConfigurationType", 1)]
	[Description("子弹的水平距离")]
	public BBParameter<float> distance = 0f;

	[Name("水平角度", 0)]
	[ShowIf("ConfigurationType", 1)]
	[Description("子弹的水平角度")]
	public BBParameter<float> angle;

	[Name("高度偏移", 0)]
	[ShowIf("ConfigurationType", 1)]
	[Description("子弹的高度偏移")]
	public BBParameter<float> heightOffset = 0f;

	[Name("怪物角度", 0)]
	[Description("指定要创建的怪物的角度。")]
	public BBParameter<float> rotationY;

	[Name("生成的怪物ID组", 0)]
	[Description("存储生成的怪物 ID 的列表。")]
	public BBParameter<List<int>> monsterIds;

	protected override bool IsDisplayNode => false;

	protected override void OnExecute()
	{
		base.OnExecute();
		DRMonsterAttr dataRow = GameEntry.DataTable.GetDataRow<DRMonsterAttr>(monsterTypeId.value);
		if (dataRow == null)
		{
			EndAction(success: false);
			return;
		}
		DRMonster dataRow2 = GameEntry.DataTable.GetDataRow<DRMonster>(dataRow.MonsterType);
		if (dataRow2 == null)
		{
			EndAction(success: false);
			return;
		}
		Vector3 value = position.value;
		switch (ConfigurationType)
		{
		case OffsetConfigurationType.Offset:
			value += offset.value;
			break;
		case OffsetConfigurationType.Direct:
			value += new Vector3(distance.value * Mathf.Sin(angle.value * (MathF.PI / 180f)), heightOffset.value, distance.value * Mathf.Cos(angle.value * (MathF.PI / 180f)));
			break;
		}
		GameObject entityObject = ownerEntity.GetSystem<EntityViewCacheSystem>().LoadEntityView(dataRow2.Id, dataRow2.AssetPath);
		MonsterEntity monsterEntity = ownerEntity.GetSystem<EntitySystem>().CreateEntity<MonsterEntity>(dataRow2.Id, new EntityData
		{
			pointData = new EntityPositionData
			{
				position = value,
				scale = Vector3.one,
				rotation = new Vector3(0f, rotationY.value, 0f)
			},
			entityObject = entityObject,
			updateType = EntityUpdateType.Local,
			logicType = EntityLogicType.None,
			collisionLayer = CollisionSetting.CollisionLayer.Monster,
			collisionMass = 2,
			campType = campType.value,
			userData = dataRow2,
			userDataPam = dataRow
		});
		if (monsterEntity == null)
		{
			OnActionFail();
			return;
		}
		monsterId.value = monsterEntity.Id;
		if (monsterIds.value != null)
		{
			monsterIds.value.Add(monsterId.value);
		}
		if (GetOwnerEntity().GetWorld().IsStoryWorld)
		{
			MonsterNode data = GetOwnerEntity().GetData<MonsterNode>(MonsterGroup.MONSTERNODE_KEY);
			if ((UnityEngine.Object)(object)data != null)
			{
				data.AddCallMonster(monsterEntity.Id);
			}
		}
		OnActionFinish();
	}
}
