using System.Collections.Generic;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取所有激活区域内的怪物", 0)]
[Description("获取所有激活区域内的怪物")]
[Category("✫ DragonLost/Target")]
public class GetAllActiveAreaMonster : ActionTaskBase
{
	[Name("返回的怪物实体ID列表", 0)]
	[Description("存储获取到的目标的列表。")]
	public BBParameter<List<int>> enemys;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (enemys.value == null)
		{
			enemys.value = new List<int>(10);
		}
		else
		{
			enemys.value.Clear();
		}
		GetOwnerEntity().GetSystem<SceneSystem>().GetAllActiveAreaMonsterEntity(enemys.value);
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId("获取所有激活区域内的怪物", ownerEntity);
		}
		EndAction();
	}
}
