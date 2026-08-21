using Ase.ECS;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("行为树参数是否设置完成", 0)]
[Category("✫ DragonLost/Entity")]
[Description("MapData加载实体之后行为树参数是否设置完成")]
public class MapDataNodeParadoxFinish : ConditionTaskBase
{
	protected override bool OnCheck()
	{
		base.OnCheck();
		BaseEntity baseEntity = GetOwnerEntity();
		if (baseEntity == null)
		{
			return false;
		}
		if (baseEntity.GetSystem<BattleSystem>().BattleMode != BattleWorldMode.LevelBattle)
		{
			return true;
		}
		BaseMapDataNode data = baseEntity.GetData<BaseMapDataNode>("MAPDATANODEKEY");
		if ((Object)(object)data == null)
		{
			return true;
		}
		return data.SetParadoxFinish;
	}
}
