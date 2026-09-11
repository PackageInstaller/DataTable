using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("销毁所有抛掷物", 0)]
[Category("Logic/抛掷物")]
[Description("销毁所有抛掷物")]
public class DestroyAllThrown : FlowNode
{
	protected override void RegisterPorts()
	{
		AddFlowInput("", delegate
		{
			for (int i = 0; i < CommonProcessor.GetWorldState().mThrowns.Count; i++)
			{
				ThrownState thrownState = CommonProcessor.GetWorldState().mThrowns[i];
				CommonProcessor.GetWorldState().mDestoryThrowns.Add(thrownState.mCreationIndex);
				base.mSimContext.PostEvent(new DespawnThrownEntityEvent(thrownState.mCasterID, thrownState.mAbilityID, thrownState.mCreationIndex));
			}
		});
	}
}
