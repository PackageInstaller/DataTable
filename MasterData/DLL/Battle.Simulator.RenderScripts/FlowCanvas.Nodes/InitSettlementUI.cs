using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("初始化结算界面", 0)]
[Category("Render/UI")]
[Description("初始化结算界面")]
[ExposeAsDefinition]
public class InitSettlementUI : PureFunctionNode<GameObject, bool>
{
	public override GameObject Invoke(bool isVectory)
	{
		return null;
	}

	public void BackToMain()
	{
		NScene.Load("MainScene");
	}

	public void Continue()
	{
	}
}
