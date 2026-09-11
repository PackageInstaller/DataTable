using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("更改主控实体", 0)]
[Category("Logic/PosAndRot")]
[Description("切换本地玩家实体ID")]
public class ChangeLocalPlayer : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> m_entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<bool> m_morePlayerInput = AddValueInput<bool>("允许多个玩家Agent");
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("error");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(m_entityIDInput.value);
			if (entityWithEntityID == null)
			{
				errorOut.Call(f);
			}
			else
			{
				if (entityWithEntityID.hasEntityAIThink)
				{
					entityWithEntityID.RemoveEntityAIThink();
				}
				int mLocalPlayerID = CommonProcessor.GetWorldState().mLocalPlayerID;
				if (mLocalPlayerID == entityWithEntityID.creationIndex)
				{
					errorOut.Call(f);
				}
				else
				{
					CommonProcessor.GetWorldState().mLocalPlayerID = entityWithEntityID.creationIndex;
					base.mSimContext.PostEvent(PlayerChangeEvent.Claim(mLocalPlayerID, entityWithEntityID.creationIndex, m_morePlayerInput.value));
					output.Call(f);
				}
			}
		});
	}
}
