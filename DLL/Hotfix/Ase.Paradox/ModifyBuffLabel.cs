using System.Collections.Generic;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("修改Buff标签", 0)]
[Category("✫ DragonLost/Buff")]
[Description("修改Buff运行时标签，不修改配置表")]
public class ModifyBuffLabel : ActionTaskBase
{
	[Name("修改类型", 0)]
	public enum ModifyEnum
	{
		[Name("Buff标签", 0)]
		BuffLabel,
		[Name("BuffID", 0)]
		BuffID
	}

	[Name("修改类型", 0)]
	public ModifyEnum modifyEnum = ModifyEnum.BuffID;

	[Name("Buff配置ID", 0)]
	[ShowIf("modifyEnum", 1)]
	public List<int> buffConfigIdList;

	[Name("Buff标签", 0)]
	[ShowIf("modifyEnum", 0)]
	public List<string> checkLabelList;

	[Name("受影响的实体ID", 0)]
	public BBParameter<int> EntityId;

	[Name("修改类型", 0)]
	public ChangeType changeType;

	[Name("修改的标签", 0)]
	public List<string> modifyLabelList;

	[Name("是否跟随行为树结束还原", 0)]
	public bool isFollowTreeDispose;

	private BuffChangeLabelData data;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (modifyLabelList.IsNullOrEmpty())
		{
			EndAction();
			return;
		}
		if (modifyEnum == ModifyEnum.BuffID)
		{
			if (buffConfigIdList.IsNullOrEmpty())
			{
				EndAction();
				return;
			}
		}
		else if (modifyEnum == ModifyEnum.BuffLabel && checkLabelList.IsNullOrEmpty())
		{
			EndAction();
			return;
		}
		BuffSystem system = ownerEntity.GetSystem<BuffSystem>();
		if (system == null)
		{
			EndAction();
			return;
		}
		data = new BuffChangeLabelData
		{
			entityId = EntityId.value,
			checkConfigIdList = buffConfigIdList,
			checkLabelList = checkLabelList,
			changeType = changeType,
			modifyLabelList = modifyLabelList
		};
		system.AddChangeBuffLabelData(EntityId.value, data);
		EndAction();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (isFollowTreeDispose && data != null)
		{
			BuffSystem system = ownerEntity.GetSystem<BuffSystem>();
			if (system != null)
			{
				system.RemoveChangeBuffLabelData(EntityId.value, data);
				data = null;
			}
		}
	}
}
