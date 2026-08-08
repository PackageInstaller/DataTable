using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("抛掷物出界产生抛掷物", 0)]
[Category("Logic/抛掷物")]
[Description("当抛掷物出界时候，如果有配置产生的抛掷物ID，则会在出界的边界位置产生ID对应的抛掷物")]
public class ThrownOutRangeSpawnThrown : FlowControlNode
{
	private string _name = string.Empty;

	public override string name
	{
		get
		{
			if (!string.IsNullOrEmpty(_name))
			{
				return _name;
			}
			return base.name;
		}
	}

	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("out");
		ValueInput<int> thrownIDVar = AddValueInput<int>("抛掷物ID");
		ValueInput<Int3> spawnPositionVar = AddValueInput<Int3>("产生坐标");
		AddFlowInput("In", delegate(Flow f)
		{
			_name = $"抛掷物出界产生抛掷物_{thrownIDVar.value}";
			ThrownState thrownState = null;
			if (!ThrownProcessor.TryGetThrown(base.mSimContext, thrownIDVar.GetValue(), out thrownState))
			{
				output.Call(f);
			}
			else
			{
				Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(thrownState.mAbilityID);
				if (config != null && config.ThrownSpawnChildID != 0)
				{
					Int3 value = spawnPositionVar.GetValue();
					Int3 mForward = thrownState.mForward;
					ThrownProcessor.SpawnThrown(base.mSimContext, thrownState.mCasterID, 0, 0, value, mForward, config.ThrownSpawnChildID, useCommon: true, thrownState.mCreationIndex, thrownState.mCreatedRootTimelineID, thrownState.mAttributeID, out var _);
				}
				output.Call(f);
			}
		});
		AddValueOutput("抛掷物ID", () => thrownIDVar.value);
	}
}
