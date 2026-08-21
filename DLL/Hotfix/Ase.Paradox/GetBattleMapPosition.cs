using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("获取战斗副本活动区域坐标", 0)]
[Category("✫ DragonLost/Entity")]
[Description("获取战斗副本活动区域坐标")]
public class GetBattleMapPosition : ActionTaskBase
{
	[Name("怪物组世界坐标", 0)]
	[Description("怪物组世界坐标")]
	public BBParameter<Vector3> MonsterGroupPos;

	protected override void OnExecute()
	{
		MonsterGroupPos.value = Vector3.zero;
		base.OnExecute();
		CreateCopyData mapData = GetOwnerEntity().GetWorld().GetMapData();
		if (mapData == null)
		{
			OnActionFinish();
			return;
		}
		if (!mapData.IsCopyMapData())
		{
			OnActionFinish();
			return;
		}
		MonsterGroupPos.value = mapData.GetBattleActiveAreaPos();
		OnActionFinish();
	}
}
