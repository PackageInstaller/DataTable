using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取生命值最低的实体(绝对值)", 0)]
[Category("Logic/Attribute")]
[Description("获取剩余血量，None则视为选择全阵营，在选定的阵容中获取生命值最低的一个实体并输出实体ID\n有可能返回0")]
public class GetEntityWithLowestHp : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<RoleType> campInput = AddValueInput<RoleType>("阵营");
		AddValueOutput("实体ID", delegate
		{
			SimEntity[] entities = base.mSimContext.GetEntities();
			int result = 0;
			long num = long.MaxValue;
			foreach (SimEntity simEntity in entities)
			{
				if (simEntity.hasEntityCamp && simEntity.hasEntityRemotePlayer)
				{
					RoleType value = campInput.value;
					if (value == RoleType.None || RoleCampProcessor.Is((uint)value, simEntity.entityCamp.mRoleTypeCamp))
					{
						long mHP = simEntity.entityBlackboard.var.mHP;
						if (mHP < num)
						{
							num = mHP;
							result = simEntity.entityID.mID;
						}
					}
				}
			}
			return result;
		});
	}
}
