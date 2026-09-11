using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("拉起lua结算界面", 0)]
[Category("Render/UI")]
[Description("拉起lua结算界面")]
public class InitLuaSettlementUI : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			GameObject gameObject = GameObject.Find("UICamera/Canvas");
			if (!(gameObject == null))
			{
				CanvasGroup component = gameObject.GetComponent<CanvasGroup>();
				component.alpha = 1f;
				component.interactable = true;
				component.blocksRaycasts = true;
				LuaHelper.CallFunction("ShowSettlement");
				output.Call(f);
			}
		});
	}
}
