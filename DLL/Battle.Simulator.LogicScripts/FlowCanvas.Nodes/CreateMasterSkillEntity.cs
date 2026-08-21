using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("芯片技能创建管理员实体", 0)]
[Category("Logic/芯片技能")]
[Description("芯片技能创建管理员实体")]
public class CreateMasterSkillEntity : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> roleIDInput = AddValueInput<int>("角色ID");
		int res = 0;
		AddValueOutput("实体ID", () => res);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			res = 0;
			SimWorldState simWorldState = base.mSimContext.sEntityWorldState.status;
			if (simWorldState.mMasterSkillEntityID == 0)
			{
				res = simWorldState.mMasterSkillEntityID;
				f.Call(output);
			}
			else
			{
				SimEntity simEntity = base.mSimContext.CreateEntity();
				simEntity.AddEntityPositon(new Int3(0, 0, 0), new Int3(0, 0, 1), 0, new Int3(0, 1, 0), newIsTeleport: false);
				simEntity.AddEntityCamp(256u);
				int value = roleIDInput.value;
				simEntity.AddEntityConfig(ConfigHelper.GetInstance().GetConfig<RoleConfig>(value), value);
				simEntity.AddEntityRemotePlayer(0, 0, newMIsLocalPlayer: false);
				simEntity.AddEntityBlackboard(new SimBlackboard());
				EntityBlackboard entityBlackboard = simEntity.entityBlackboard;
				simEntity.entityBlackboard.var.mEntityID = simEntity.creationIndex;
				res = simEntity.creationIndex;
				int num = base.mSimContext.mService.mAttributeService.CreateAttribute(simEntity.creationIndex, out var _);
				simEntity.entityBlackboard.var.mAttributeID = num;
				simWorldState.mMasterSkillEntityID = simEntity.creationIndex;
				if (simWorldState.attribute != null)
				{
					Dictionary<int, long>.Enumerator enumerator = simWorldState.attribute.GetEnumerator();
					while (enumerator.MoveNext())
					{
						AttributeProcessor.SetAttributeWithIntName(num, enumerator.Current.Key, enumerator.Current.Value, 0L, 0L);
					}
				}
				entityBlackboard.var.mHP = 2147483647L;
				entityBlackboard.var.mMaxHP = 2147483647L;
				f.Call(output);
			}
		});
	}
}
