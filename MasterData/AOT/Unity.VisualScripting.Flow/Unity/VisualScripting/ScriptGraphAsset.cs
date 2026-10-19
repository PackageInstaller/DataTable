using UnityEngine;

namespace Unity.VisualScripting;

[HelpURL("https://docs.unity3d.com/Packages/com.unity.visualscripting@latest/index.html?subfolder=/manual/vs-script-graphs-intro.html")]
[CreateAssetMenu(menuName = "Visual Scripting/Script Graph", fileName = "New Script Graph", order = 81)]
[TypeIcon(typeof(FlowGraph))]
public sealed class ScriptGraphAsset : Macro<FlowGraph>
{
	[ContextMenu("Show Data...")]
	protected override void ShowData()
	{
		base.ShowData();
	}

	public override FlowGraph DefaultGraph()
	{
		return FlowGraph.WithInputOutput();
	}
}
