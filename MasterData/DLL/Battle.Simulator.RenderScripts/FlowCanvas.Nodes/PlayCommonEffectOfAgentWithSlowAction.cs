using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("添加跟随缓动(渲染)", 0)]
[Category("Render/函数")]
[Description("用于创建特效后给其添加跟随缓动脚本\nResource：连接创建特效节点的输出Resource；\n移动阻尼：该“跟随点”尝试保持 x ，y，z轴偏移的响应程度。小数字使“跟随点”更慢。数字越大，“跟随点”响应越快；\n旋转阻尼：该“跟随点”尝试保持角色朝向的响应程度。小数字使“跟随点”更慢。数字越大，“跟随点”响应越快(旋转阻尼不受DeadZone影响)；\nDeadZone：X秒内当移动的相对距离小于Y时，跟随点原地不动（位置）；大于等于Y时，跟随点将开始移动并最终到达缓动终点；\n")]
public class PlayCommonEffectOfAgentWithSlowAction : EffectCreateBaseNode
{
	protected override void RegisterPorts()
	{
		base.RegisterPorts();
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<GameObject> attachPointPathInput = AddValueInput<GameObject>("Resource");
		ValueInput<string> slowActionPointInput = AddValueInput<string>("缓动终点");
		ValueInput<bool> isUseXInput = AddValueInput<bool>("是否影响X轴");
		ValueInput<bool> isUseYInput = AddValueInput<bool>("是否影响Y轴");
		ValueInput<bool> isUseZInput = AddValueInput<bool>("是否影响Z轴");
		ValueInput<float> positionDampingXInput = AddValueInput<float>("移动阻尼X");
		ValueInput<float> positionDampingYInput = AddValueInput<float>("移动阻尼Y");
		ValueInput<float> positionDampingZInput = AddValueInput<float>("移动阻尼Z");
		ValueInput<float> rotationDampingInput = AddValueInput<float>("旋转阻尼");
		ValueInput<bool> isUseDeadZoneInput = AddValueInput<bool>("是否使用DeadZone");
		ValueInput<string> deadZoneCenterInput = AddValueInput<string>("DeadZone判定点");
		ValueInput<float> deadZoneTimeInput = AddValueInput<float>("DeadZone判定时间");
		ValueInput<float> deadZoneDistanceInput = AddValueInput<float>("DeadZone判定距离");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "error");
		AddFlowInput("", delegate(Flow f)
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(entityIDInput.value);
			if (agent == null)
			{
				error.Call(f);
			}
			else
			{
				FollowSlowAction followSlowAction = U3DUtil.Get<FollowSlowAction>(attachPointPathInput.value);
				followSlowAction.TposeAgent = agent;
				followSlowAction.TargetPrefab = agent.transform.Find(slowActionPointInput.value);
				followSlowAction.IsUseX = isUseXInput.value;
				followSlowAction.IsUseY = isUseYInput.value;
				followSlowAction.IsUseZ = isUseZInput.value;
				followSlowAction.PositionDampingX = positionDampingXInput.value;
				followSlowAction.PositionDampingY = positionDampingYInput.value;
				followSlowAction.PositionDampingZ = positionDampingZInput.value;
				followSlowAction.RotationDamping = rotationDampingInput.value;
				followSlowAction.IsUseDeadZone = isUseDeadZoneInput.value;
				followSlowAction.DeadZoneCenter = deadZoneCenterInput.value;
				followSlowAction.DeadZoneTime = deadZoneTimeInput.value;
				followSlowAction.DeadZoneDistance = deadZoneDistanceInput.value;
				output.Call(f);
			}
		});
	}
}
