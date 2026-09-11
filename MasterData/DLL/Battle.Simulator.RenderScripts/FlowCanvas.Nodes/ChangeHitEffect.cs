using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("修改受击特效(渲染+注意说明)", 0)]
[Category("Render/特效")]
[Description("用来接在【播放受击特效前处理(渲染)】的处理流【最后】,用以修改要播放的受击特效\n特效使用路径为【Effect/】开始,即【Effect/tongyong/fx_2020_death】")]
public class ChangeHitEffect : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentIDVar = AddValueInput<int>("受击者AgentID", "ChangeHitEffect_In_AgentID");
		ValueInput<string> effectPathVar = AddValueInput<string>("特效路径", "ChangeHitEffect_In_EffectPath");
		ValueInput<bool> isLockRotation = AddValueInput<bool>("锁住旋转", "ChangeHitEffect_In_IsLockRotation");
		AddFlowInput("In", delegate
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(agentIDVar.GetValue());
			if (agent == null)
			{
				Debug.LogError("=====>>>>> 无法找到传入的AgentID");
			}
			else
			{
				ComponentTimeline componentTimeline = agent.ComponentTimeline;
				if (componentTimeline == null)
				{
					Debug.LogError("=====>>>>> Agent 上无法找到 Timeline组件");
				}
				else
				{
					componentTimeline.ChangeHitEffectPathByFlowCanvas = effectPathVar.GetValue();
					componentTimeline.ChangeHitEffectLockRotationByFlowCanvas = isLockRotation.GetValue();
				}
			}
		}, "ChangeHitEffect_FlowIn_In");
	}
}
