using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("抛掷物到达目标点产生抛掷物", 0)]
[Category("Logic/抛掷物")]
[Description("当抛掷物出界时候，如果有配置产生的抛掷物ID，则会在出界的边界位置产生ID对应的抛掷物")]
public class ThrownArrivedPositionSpawnThrown : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("out");
		ValueInput<int> thrownIDVar = AddValueInput<int>("抛掷物ID");
		ValueInput<Int3> spawnPositionVar = AddValueInput<Int3>("产生坐标");
		AddFlowInput("In", delegate(Flow f)
		{
			ThrownState thrownState = null;
			if (!ThrownProcessor.TryGetThrown(base.mSimContext, thrownIDVar.GetValue(), out thrownState))
			{
				output.Call(f);
			}
			else
			{
				Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(thrownState.mAbilityID);
				if (config != null && config.ArrivedCreateThrownTimelineID != 0)
				{
					Int3 value = spawnPositionVar.GetValue();
					Int3 mForward = thrownState.mForward;
					mForward.y = 0;
					ThrownProcessor.SpawnThrown(base.mSimContext, thrownState.mCasterID, 0, 0, value, mForward, config.ArrivedCreateThrownTimelineID, useCommon: true, thrownState.mCreationIndex, thrownState.mCreatedRootTimelineID, thrownState.mAttributeID, out var _);
				}
				output.Call(f);
			}
		});
		AddValueOutput("抛掷物ID", () => thrownIDVar.value);
	}
}
