using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取所有角色ID", 0)]
[Description("获取指定实体所属队伍中所有角色的ID列表。")]
[Category("✫ DragonLost/Target")]
public class GetHeroTeamEntityId : ActionTaskBase
{
	[ShowIf("IsIncludeSelf", 0)]
	[Name("排除的ID", 0)]
	[Description("要排除的实体ID。")]
	public BBParameter<int> EntityId;

	[Name("是否包含所有", 0)]
	[Description("确定是否包含指定实体在内。")]
	public bool IsIncludeSelf;

	[Name("所有角色ID", 0)]
	[Description("存储获取到的所有角色的ID列表。")]
	public BBParameter<List<int>> TeamEntityId;

	protected override void OnExecute()
	{
		base.OnExecute();
		TeamEntityId.value = ownerEntity.GetSystem<EntitySystem>().GetTeamEntityId(EntityId.value, IsIncludeSelf, ownerEntity.LogicType);
		if (LockstepData.Instance != null)
		{
			string text = "";
			if (TeamEntityId.value != null)
			{
				foreach (int item in TeamEntityId.value)
				{
					text += $"ID {item}";
				}
			}
			LockstepData.Instance?.WriteAuthorityEntityId("获取所有角色ID " + text + " ", ownerEntity);
		}
		EndAction();
	}
}
