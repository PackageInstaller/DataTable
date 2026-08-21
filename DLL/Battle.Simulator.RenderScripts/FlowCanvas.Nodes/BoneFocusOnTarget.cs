using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("瞄准目标", 0)]
[Category("Render/Anime")]
[Description("将指定的骨骼节点朝向目标")]
[ExposeAsDefinition]
public class BoneFocusOnTarget : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<bool> isFiring = AddValueInput<bool>("isFiring");
		ValueInput<int> entityId = AddValueInput<int>("entityId");
		ValueInput<int> targetId = AddValueInput<int>("targetId");
		ValueInput<Vector3> correction = AddValueInput<Vector3>("correction");
		ValueInput<string> pathToBoneNode = AddValueInput<string>("pathToBoneNode");
		FlowOutput flowOutput = AddFlowOutput(" ");
		ValueInput<Vector3> targetPos = AddValueInput<Vector3>("targetPos");
		AddFlowInput("In", delegate(Flow f)
		{
			if (targetId.value != 0)
			{
				Transform transform = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(entityId.value).transform.Find(pathToBoneNode.value);
				if (!isFiring.value)
				{
					NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(targetId.value);
					if (agent != null)
					{
						Transform transform2 = agent.transform;
						transform.LookAt(transform2);
						transform.Rotate(correction.value, Space.Self);
					}
				}
				else
				{
					transform.LookAt(targetPos.GetValue());
					transform.Rotate(correction.value, Space.Self);
				}
			}
			flowOutput.Call(f);
		});
	}
}
