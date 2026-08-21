using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("修改子弹标签", 0)]
[Category("✫ DragonLost/Bullet")]
[Description("修改子弹标签，不修改配置表")]
public class ModifyBulletTag : ActionTaskBase
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

	[Name("修改类型", 0)]
	public ChangeType changeType;

	[Name("修改的标签", 0)]
	public List<string> modifyTagList;

	[Name("是否跟随行为树结束还原", 0)]
	public bool isFollowTreeDispose;

	private BulletChangeTagData data;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (modifyTagList.IsNullOrEmpty())
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
		BulletSystem system = ownerEntity.GetSystem<BulletSystem>();
		if (system == null)
		{
			EndAction();
			return;
		}
		data = new BulletChangeTagData
		{
			entityId = EntityId.value,
			checkConfigIdList = bulletConfigIdList,
			checkTagList = checkTagList,
			changeType = changeType,
			modifyTagList = modifyTagList
		};
		system.AddChangeTagData(EntityId.value, data);
		EndAction();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (data != null)
		{
			BulletSystem system = ownerEntity.GetSystem<BulletSystem>();
			if (system == null)
			{
				EndAction();
			}
			else
			{
				system.RemoveChangeTagData(EntityId.value, data);
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
