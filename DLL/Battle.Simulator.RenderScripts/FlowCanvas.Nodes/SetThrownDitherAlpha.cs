using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置抛掷物特效虚化", 0)]
[Category("Render/抛掷物")]
[Description("设置抛掷物特效虚化")]
public class SetThrownDitherAlpha : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("out");
		FlowOutput errorOut = AddFlowOutput("error");
		ValueInput<int> thrownIDInput = AddValueInput<int>("抛掷物ID");
		ValueInput<string> effectNameInput = AddValueInput<string>("特效名称");
		ValueInput<float> ditherAlphaInput = AddValueInput<float>("DitherAlpha值").SetDefaultAndSerializedValue(1f);
		AddValueOutput("抛掷物ID", () => thrownIDInput.value);
		AddValueOutput("特效名称", () => effectNameInput.value);
		AddFlowInput("in", delegate(Flow f)
		{
			(NScene.GetCurrentScene() as BattleScene).GetBattleSimulatorSystem().ThrownManager.TryGetThrownTimelinePlayer(thrownIDInput.value, out var player);
			if (player != null)
			{
				foreach (EffectController item in player.GetTargetTimeLineEffectByName(effectNameInput.value))
				{
					if (item != null)
					{
						CharacterEffect componentInChildren = item.transform.GetComponentInChildren<CharacterEffect>();
						if (componentInChildren != null)
						{
							componentInChildren.ditherAlpha = ditherAlphaInput.value;
						}
					}
				}
				output.Call(f);
			}
			else
			{
				errorOut.Call(f);
			}
		});
	}
}
