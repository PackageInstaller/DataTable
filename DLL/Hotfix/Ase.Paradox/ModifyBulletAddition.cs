using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("修改子弹加成", 0)]
[Category("✫ DragonLost/Bullet")]
[Description("修改子弹加成")]
public class ModifyBulletAddition : ActionTaskBase
{
	[Name("修改类型", 0)]
	public enum ModifyEnum
	{
		[Name("子弹标签", 0)]
		BulletTag,
		[Name("子弹ID", 0)]
		BulletID
	}

	[Name("修改类型", 0)]
	public ModifyEnum modifyEnum = ModifyEnum.BulletID;

	[Name("子弹配置ID", 0)]
	[ShowIf("modifyEnum", 1)]
	public List<int> bulletConfigIdList;

	[Name("子弹标签", 0)]
	[ShowIf("modifyEnum", 0)]
	public List<string> checkTagList;

	[Name("受影响的实体ID", 0)]
	public BBParameter<int> EntityId;

	[Name("修改的系数类型", 0)]
	public BulletAdditionEnum modifyAdditionEnum;

	[Name("修改类型", 0)]
	public ChangeType changeType;

	[Name("修改值", 0)]
	[HideIf("modifyAdditionEnum", 0)]
	public BBParameter<float> value;

	[Name("修改值", 0)]
	[ShowIf("modifyAdditionEnum", 0)]
	public BBParameter<List<float>> values;

	[Name("是否跟随行为树结束还原", 0)]
	public bool isFollowTreeDispose;

	private BulletChangeAdditionData data;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (modifyAdditionEnum == BulletAdditionEnum.DamageRadio && (values == null || values.value.IsNullOrEmpty()))
		{
			EndAction();
			return;
		}
		BulletSystem system = ownerEntity.GetSystem<BulletSystem>();
		if (system == null)
		{
			EndAction();
			return;
		}
		if (modifyEnum == ModifyEnum.BulletID)
		{
			if (bulletConfigIdList.IsNullOrEmpty())
			{
				EndAction();
				return;
			}
		}
		else if (modifyEnum == ModifyEnum.BulletTag && checkTagList.IsNullOrEmpty())
		{
			EndAction();
			return;
		}
		data = new BulletChangeAdditionData
		{
			entityId = EntityId.value,
			changeType = changeType,
			modifyAdditionEnum = modifyAdditionEnum
		};
		if (modifyEnum == ModifyEnum.BulletID)
		{
			data.checkConfigIdList = bulletConfigIdList;
		}
		else if (modifyEnum == ModifyEnum.BulletTag)
		{
			data.checkTagList = checkTagList;
		}
		if (modifyAdditionEnum == BulletAdditionEnum.DamageRadio)
		{
			data.modifyValues = values.value;
		}
		else
		{
			data.modifyValues = new List<float>(1);
			data.modifyValues.Add(value.value);
		}
		system.AddChangeAdditionData(EntityId.value, data);
		EndAction();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (isFollowTreeDispose && data != null)
		{
			BulletSystem system = ownerEntity.GetSystem<BulletSystem>();
			if (system == null)
			{
				EndAction();
			}
			else
			{
				system.RemoveChangeAdditionData(EntityId.value, data);
			}
		}
	}

	protected List<BulletEntity> GetBulletEntityList()
	{
		List<BulletEntity> list = new List<BulletEntity>();
		if (modifyEnum == ModifyEnum.BulletID)
		{
			foreach (int bulletConfigId in bulletConfigIdList)
			{
				if (ownerEntity.GetSystem<EntitySystem>().GetEntityByConfigId(bulletConfigId, isGetCache: true) is BulletEntity item)
				{
					list.Add(item);
				}
			}
		}
		else if (modifyEnum == ModifyEnum.BulletTag)
		{
			if (checkTagList.IsNullOrEmpty())
			{
				return list;
			}
			foreach (BulletEntity entity in ownerEntity.GetSystem<EntitySystem>().GetEntityList<BulletEntity>(isGetCache: true))
			{
				BulletRuntimeConfigData bulletRuntimeConfigData = entity.GetData<BulletData>("bulletData")?.extraData.runtimeConfigData;
				if (bulletRuntimeConfigData != null)
				{
					List<string> bulletLabel = bulletRuntimeConfigData.BulletLabel;
					if (bulletLabel == null || !bulletLabel.HasCommonWith(checkTagList))
					{
						list.Add(entity);
					}
				}
			}
		}
		return list;
	}
}
