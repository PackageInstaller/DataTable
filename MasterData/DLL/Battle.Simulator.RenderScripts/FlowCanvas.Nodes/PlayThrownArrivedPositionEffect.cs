using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("抛掷物到达目标点特效", 0)]
[Category("Render/抛掷物")]
[Description("抛掷物出界(离开行走区域)之后,播放出界特效")]
public class PlayThrownArrivedPositionEffect : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput successOut = AddFlowOutput("成功");
		FlowOutput abnormalOut = AddFlowOutput("异常");
		ValueInput<int> thrownIDVar = AddValueInput<int>("抛掷物ID");
		ValueInput<Int3> arrivedPosVar = AddValueInput<Int3>("目标点坐标");
		AddFlowInput("In", delegate(Flow f)
		{
			ThrownManager thrownManager = (NScene.GetCurrentScene() as BattleScene).GetBattleSimulatorSystem().ThrownManager;
			int timelineID = 0;
			if (!thrownManager.TryGetThrownTimelineID(thrownIDVar.value, out timelineID))
			{
				abnormalOut.Call(f);
			}
			else
			{
				TimelineInfo timelineInfo = (NScene.GetCurrentScene() as BattleScene).GetTimelineAndHitCache().Get(timelineID);
				if (timelineInfo == null)
				{
					abnormalOut.Call(f);
				}
				else
				{
					if (!string.IsNullOrEmpty(timelineInfo.ArrivedEffectPath))
					{
						GameObject gameObject = Asset.Instantiate(timelineInfo.ArrivedEffectPath);
						if (gameObject != null)
						{
							Vector3 position = Vector3.zero;
							Vector3 forward = Vector3.forward;
							thrownManager.TryGetThrownPosition(thrownIDVar.GetValue(), out position, out forward);
							if (arrivedPosVar.GetValue() != Int3.zero)
							{
								gameObject.transform.position = new Vector3((float)arrivedPosVar.GetValue().x / 1000f, position.y, (float)arrivedPosVar.GetValue().z / 1000f);
							}
							else
							{
								gameObject.transform.position = position;
							}
							gameObject.transform.forward = new Vector3(forward.x, 0f, forward.z);
							U3DUtil.Get<EffectController>(gameObject).Initialize(isLoop: false, 5f, 1f, BattleScene.MainPlayerQuality, null);
						}
					}
					successOut.Call(f);
				}
			}
		});
	}
}
