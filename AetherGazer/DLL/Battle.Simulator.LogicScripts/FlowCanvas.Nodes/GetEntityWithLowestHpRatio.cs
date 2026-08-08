using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取生命值最低的实体(百分比)", 0)]
[Category("Logic/Attribute")]
[Description("获取剩余血量百分比,None则视为选择全阵营，在选定的阵容中获取生命值最低的一个实体并输出实体ID\n有可能返回0")]
public class GetEntityWithLowestHpRatio : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<RoleType> campInput = AddValueInput<RoleType>("阵营");
		AddValueOutput("实体ID", delegate
		{
			SimEntity[] entities = base.mSimContext.GetEntities();
			int result = 0;
			int num = 100;
			foreach (SimEntity simEntity in entities)
			{
				if (simEntity.hasEntityCamp && simEntity.hasEntityRemotePlayer)
				{
					RoleType value = campInput.value;
					if (value == RoleType.None || RoleCampProcessor.Is((uint)value, simEntity.entityCamp.mRoleTypeCamp))
					{
						long num2 = simEntity.entityBlackboard.var.mHP * 100;
						long mMaxHP = simEntity.entityBlackboard.var.mMaxHP;
						long num3 = num2 / mMaxHP;
						if (num3 < num)
						{
							num = (int)num3;
							result = simEntity.entityID.mID;
						}
					}
				}
			}
			return result;
		});
	}
}
