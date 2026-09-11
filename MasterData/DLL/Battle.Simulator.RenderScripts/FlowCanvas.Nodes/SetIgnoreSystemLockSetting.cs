using NetProcol;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("忽略系统的锁定设置", 0)]
[Category("Render/Camera")]
[Description("忽略界面的设置系统的锁定设置")]
public class SetIgnoreSystemLockSetting : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<bool> ignoreInput = AddValueInput<bool>("是否忽略");
		ValueInput<LockType> valueToUse = AddValueInput<LockType>("忽略之后要用哪个");
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("error");
		AddFlowInput("", delegate(Flow f)
		{
			WorldStateManager worldStateManager = WorldStateManager.GetWorldStateManager();
			if (worldStateManager == null)
			{
				errorOut.Call(f);
			}
			else
			{
				if (ignoreInput.value)
				{
					worldStateManager.ignoreSystemLockSetting = true;
					if (worldStateManager.mPlayerAgentID != 0)
					{
						ChooseTargetCommand chooseTargetCommand = CommandFactory.Create(NetprotoOperationCode.CmdChooseTarget) as ChooseTargetCommand;
						chooseTargetCommand.SetData(worldStateManager.mPlayerAgentID, (int)valueToUse.value, -2);
						ClientSimulator.Instance.SendLocalCommand(chooseTargetCommand);
						worldStateManager.lockType = valueToUse.value;
					}
				}
				else
				{
					worldStateManager.ignoreSystemLockSetting = false;
					worldStateManager.UpdateSetting();
				}
				output.Call(f);
			}
		});
	}
}
