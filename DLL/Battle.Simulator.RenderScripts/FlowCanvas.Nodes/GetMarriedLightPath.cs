using Config;
using Google.Protobuf.Collections;
using NetProcol;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到誓约戒指光效路径(渲染)", 0)]
[Category("Render/Config")]
[Description("得到誓约戒指光效路径")]
public class GetMarriedLightPath : FlowControlNode
{
	private string _path = string.Empty;

	protected override void RegisterPorts()
	{
		ValueInput<int> agentIDInput = AddValueInput<int>("实体ID", "agentID");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput falseOut = AddFlowOutput("不是誓约角色", "false");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			_path = string.Empty;
			MemberPosition memberPositionByAgentID = AgentManager.GetAgentManager().GetMemberPositionByAgentID(agentIDInput.value);
			RepeatedField<RoleDataForExchangeInfo> roleDataInLua = ((BattleScene)NScene.GetCurrentScene()).ready.SceneDataForExcehange.RoleDataInLua;
			if (memberPositionByAgentID == MemberPosition.None || roleDataInLua.Count <= (int)memberPositionByAgentID)
			{
				errorOut.Call(f);
			}
			else
			{
				RoleDataForExchangeInfo roleDataForExchangeInfo = roleDataInLua.get_Item((int)memberPositionByAgentID);
				Skin config;
				if (!roleDataForExchangeInfo.IsVow)
				{
					falseOut.Call(f);
				}
				else if (!ConfigHelper.GetInstance().TryGetConfig<Skin>(roleDataForExchangeInfo.ID, out config))
				{
					errorOut.Call(f);
				}
				else
				{
					_path = $"Effect/Married/fx_{config.Hero}_married_light";
					output.Call(f);
				}
			}
		});
		AddValueOutput("路径", "path", () => _path);
	}
}
