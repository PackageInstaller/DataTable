using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("开关视野组件", 0)]
[Category("Render/Agent")]
[Description("添加视野组件")]
public class SetComponentEnemyViewActive : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentIDInput = AddValueInput<int>("实体ID");
		ValueInput<float> degreeInput = AddValueInput<float>("范围角度").SetDefaultAndSerializedValue(100f);
		ValueInput<float> distanceInViewToFindStandCharInput = AddValueInput<float>("角度内站姿发现范围").SetDefaultAndSerializedValue(8f);
		ValueInput<float> distanceInViewToFindCrawlCharInput = AddValueInput<float>("角度内蹲姿发现范围").SetDefaultAndSerializedValue(5f);
		ValueInput<float> distanceOutViewToFindStandCharInput = AddValueInput<float>("角度外站姿发现范围").SetDefaultAndSerializedValue(3f);
		ValueInput<int> alertUpdateIntervalInput = AddValueInput<int>("更新间隔(帧数)").SetDefaultAndSerializedValue(100);
		ValueInput<float> alertMaxValueInput = AddValueInput<float>("警戒值最大值").SetDefaultAndSerializedValue(100f);
		ValueInput<float> alertUpdateAddValue = AddValueInput<float>("每次更新在范围内警戒值增加值").SetDefaultAndSerializedValue(1f);
		ValueInput<float> alertUpdateSubValue = AddValueInput<float>("每次更新在范围外警戒值减少值").SetDefaultAndSerializedValue(1f);
		ValueInput<string> attachPoint = AddValueInput<string>("特效挂点").SetDefaultAndSerializedValue("auto_top_point");
		ValueInput<string> effectPath = AddValueInput<string>("特效路径").SetDefaultAndSerializedValue("Effect/Battle/yujing/fx_warning");
		FlowOutput output = AddFlowOutput("out");
		FlowOutput errorOut = AddFlowOutput("error");
		AddFlowInput("激活", delegate(Flow f)
		{
			AgentManager agentManager = AgentManager.GetAgentManager();
			if (agentManager == null)
			{
				errorOut.Call(f);
			}
			else
			{
				NAgent agent = agentManager.GetAgent(agentIDInput.value);
				if (agent == null)
				{
					errorOut.Call(f);
				}
				else
				{
					ComponentEnemyView componentEnemyView = (agent as AgentHuman).ComponentEnemyView;
					if (componentEnemyView == null)
					{
						errorOut.Call(f);
					}
					else
					{
						componentEnemyView.mViewDegree = degreeInput.value;
						componentEnemyView.mDistanceInViewToFindStandChar = distanceInViewToFindStandCharInput.value;
						componentEnemyView.mDistanceInViewToFindCrawlChar = distanceInViewToFindCrawlCharInput.value;
						componentEnemyView.mDistanceOutViewToFindStandChar = distanceOutViewToFindStandCharInput.value;
						componentEnemyView.mAlertMaxValue = alertMaxValueInput.value;
						componentEnemyView.mAlertUpdateAddValue = alertUpdateAddValue.value;
						componentEnemyView.mAlertUpdateSubValue = alertUpdateSubValue.value;
						componentEnemyView.mAlertUpdateInterval = alertUpdateIntervalInput.value;
						componentEnemyView.mAttachPoint = attachPoint.value;
						componentEnemyView.mEffectPath = effectPath.value;
						componentEnemyView.ActiveComponent();
						output.Call(f);
					}
				}
			}
		});
		AddFlowInput("关闭", delegate(Flow f)
		{
			AgentManager agentManager = AgentManager.GetAgentManager();
			if (agentManager == null)
			{
				errorOut.Call(f);
			}
			else
			{
				NAgent agent = agentManager.GetAgent(agentIDInput.value);
				if (agent == null)
				{
					errorOut.Call(f);
				}
				else
				{
					ComponentEnemyView componentEnemyView = (agent as AgentHuman).ComponentEnemyView;
					if (componentEnemyView == null)
					{
						errorOut.Call(f);
					}
					else
					{
						componentEnemyView.ResetBehavior();
						output.Call(f);
					}
				}
			}
		});
	}
}
